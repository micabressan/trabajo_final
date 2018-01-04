
import corona.math: int2;

struct Path
{
    enum Command: int
    {
        End = 0,
        Line = 1,
        Move = 2,
    }

    this(int2 startingPoint)
    {
        _buffer = pathCommandPool.allocBuffer(startingPoint);
    }

    ref Path lineTo(int2 p2)
    {
        _buffer.put(Command.Line);
        _buffer.put(p2);
        return this;
    }

    ref Path lineTo(int x, int y)
    {
        return lineTo(int2(x, y));
    }

    ref Path moveTo(int2 newDest)
    {
        _buffer.put(Command.Move);
        _buffer.put(newDest);
        return this;
    }

    ref Path moveTo(int x, int y)
    {
        return moveTo(int2(x, y));
    }

    auto read()
    {
        return _buffer.reader;
    }

private:
    PathCommandBuffer _buffer;
}

unittest
{
    auto path = Path(int2(50, 50));
    path.lineTo(int2(50, 100));
    path.lineTo(int2(100, 100));
    path.lineTo(int2(75, 75));
    path.lineTo(int2(100, 50));
    path.lineTo(int2(50, 50));

    auto reader = path.read;
    assert(!reader.empty);
    assert(reader.getNext.line == Line(int2(50, 50), int2(50, 100)));
    assert(!reader.empty);
    assert(reader.getNext.line == Line(int2(50, 100), int2(100, 100)));
    assert(!reader.empty);
    assert(reader.getNext.line == Line(int2(100, 100), int2(75, 75)));
    assert(!reader.empty);
    assert(reader.getNext.line == Line(int2(75, 75), int2(100, 50)));
    assert(!reader.empty);
    assert(reader.getNext.line == Line(int2(100, 50), int2(50, 50)));
    assert(reader.empty);
}

private:

enum numInitChunks = 64;

static this()
{
    pathCommandPool = PathCommandPool(numInitChunks);
}

static PathCommandPool pathCommandPool;

struct PathCommandPool
{
    import std.experimental.allocator;

    enum chunkSize = 16;
    enum growSize = 10;

    struct Chunk
    {
        const size_t offset;
        Chunk* next;
    }

    this(size_t numInitialChunks)
    {
        if (numInitialChunks == 0)
            return;

        allocNewChunks(numInitialChunks);
    }

    @disable this(this);

    ~this()
    {
        while (freeList)
        {
            theAllocator.dispose(freeList);
            freeList = freeList.next;
        }
        theAllocator.dispose(data);
    }

    PathCommandBuffer allocBuffer(int2 initPosition)
    {
        return PathCommandBuffer(initPosition);
    }

    Chunk* getChunk()
    {
        if (!freeList)
            allocNewChunks(growSize);
   
        auto result = freeList;
        result.next = null;
        freeList = freeList.next;

        return result;
    }

    int[] getChunkData(Chunk* chunk)
    {
        assert(chunk !is null);
        assert(chunk.offset + chunkSize <= data.length);
        return data[chunk.offset .. chunk.offset + chunkSize];
    }

    void freeChunks(Chunk* chunk)
    {
        while (chunk)
        {
            auto c = chunk;
            chunk = chunk.next;
            addToFreeList(c);
        }
    }

private:
    void addToFreeList(Chunk* chunk)
    {
        chunk.next = freeList;
        freeList = chunk;
    }

    void allocNewChunks(size_t numChunks)
    {
        const startOffset = data.length;

        if (data.length == 0)
            data = theAllocator.makeArray!int(numChunks * chunkSize);
        else
            theAllocator.expandArray(data, numChunks * chunkSize);

        foreach(i; 0 .. numChunks)
        {
            const offset = startOffset + (i * chunkSize);
            assert(offset + chunkSize <= data.length);
            addToFreeList(theAllocator.make!Chunk(offset));
        }
    }

    Chunk* freeList;
    int[] data;
}

struct PathCommandBuffer
{
    import std.experimental.allocator;

    size_t* references;
    PathCommandPool.Chunk* buffer;
    PathCommandPool.Chunk* lastChunk;
    size_t currentPosition;

    this(int2 initPosition)
    {
        references = theAllocator.make!size_t();
        references++;
        buffer = lastChunk = pathCommandPool.getChunk();
        assert(buffer.next is null);
        put(initPosition);
    }

    this(this)
    {
        references++;
    }

    ~this()
    {
        references--;

        if (*references == 0)
            pathCommandPool.freeChunks(buffer);
    }

    void put(int2 vec)
    {
        put(vec.x);
        put(vec.y);
    }

    void put(int value)
    {
        auto chunk = getChunk(currentPosition);
        const residentIndex = currentPosition % pathCommandPool.chunkSize;
        chunk[residentIndex] = value;
        currentPosition++;
    }

    auto reader()
    {
        return PathCommandBufferRange(this);
    }

private:
    int[] growBuffer()
    {
        auto chunk = pathCommandPool.getChunk();
        lastChunk.next = chunk;
        lastChunk = chunk;
        return pathCommandPool.getChunkData(chunk);
    }

    int[] getChunk(size_t index)
    {
        auto result = buffer;

        //integer division truncates the fractional part
        const idx = index / pathCommandPool.chunkSize;

        //We want to run off the end of the buffer by 1 to
        //trigger the expansion of the buffer.
        foreach(i; 0 .. idx)
            result = buffer.next;

        if (result is null)
        {
            growBuffer();
            result = lastChunk;
        }

        assert(result !is null);
        return pathCommandPool.getChunkData(result);
    }
}

struct PathCommandBufferRange
{
    import corona.shapes: Line;

    alias Chunk = PathCommandPool.Chunk;
    PathCommandBuffer buffer;
    int2 p1;
    Chunk* currentChunk;
    size_t index = 0;

    this(ref PathCommandBuffer buffer)
    {
        this.buffer = buffer;
        currentChunk = buffer.buffer;
        p1 = next!int2;
    }

    bool empty()
    {
        return currentChunk is null || nextCommand == Path.Command.End;
    }

    Path.Command nextCommand()
    {
        return cast(Path.Command) chunkData[index];
    }

    auto getNext()
    {
        struct Result
        {
            Path.Command command;
            union
            {
                Line line;
                int2 position;
            }
        }

        if (empty)
            assert(false, "PathCommandBufferRange.getNext() must not be called when empty.");

        auto result = Result(next!(Path.Command));

        switch (result.command)
        {
        case Path.Command.Line:
            result.line = Line(p1, next!int2());
            p1 = result.line.p2;
            break;
        case Path.Command.Move:
            result.position = next!int2();
            p1 = result.position;
            break;
        case Path.Command.End:
            assert(false, "Path.Command.End should never appear here!");
        default:
            import std.stdio;
            writeln("Unknown command: ", result.command);
            writeln("Current path chunk: ", chunkData);
            assert(false);
        }

        return result;
    }

private:
    int[] chunkData() { return pathCommandPool.getChunkData(currentChunk); }

    T next(T: Path.Command)() { return cast(Path.Command) next!int; }

    T next(T: int2)() { return int2(next!int, next!int); }

    T next(T: int)()
    {
        if (index == pathCommandPool.chunkSize)
        {
            currentChunk = currentChunk.next;
            assert(currentChunk !is null);
            index = 0;
        }

        scope(exit) index++;
        return chunkData[index];
    }
}