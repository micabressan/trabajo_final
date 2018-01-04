package Paradygmaty_lab_list_9;

public class CPair<V, S>
{
    private V first;
    private S second;

    public CPair(V f, S s)
    {
        first = f;
        second = s;
    }

    public V getFirst()
    {
        return first;
    }

    public S getSecond()
    {
        return second;
    }

    @Override
    public String toString() {
        return first.toString();
    }
}