class Socket
{
        static void exception (immutable(char)[] msg)
        {
                throw new SocketException(msg);
        }
}