MemoryMapping mmap(IMemoryMappable mmappable, size_t size = size_t.max,
    size_t offset = 0, Protection prot = Protection.readWrite, void* addr = null)
{
    auto p = sys_mmap(addr, size, prot, MAP_SHARED, mmappable.handle, offset);
    if (p == cast(void*)-1)
        throw new SystemException("Memory mapping failed");
    return MemoryMapping(p);
}