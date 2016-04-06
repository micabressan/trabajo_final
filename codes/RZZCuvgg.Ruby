class Socket
    CLS_socket = Win32API.new 'clsocket.dll', 'cls_socket', 'iii', 'i'
    CLS_connect = Win32API.new 'clsocket.dll', 'cls_connect', 'lpii', 'i'
    CLS_bind = Win32API.new 'clsocket.dll', 'cls_bind', 'lpi', 'i'
    CLS_listen = Win32API.new 'clsocket.dll', 'cls_listen', 'li', 'i'
    CLS_pending = Win32API.new 'clsocket.dll', 'cls_pending', 'li', 'i'
    CLS_accept = Win32API.new 'clsocket.dll', 'cls_accept', 'l', 'l'
    CLS_send = Win32API.new 'clsocket.dll', 'cls_send', 'lp', 'i'
    CLS_avaliable = Win32API.new 'clsocket.dll', 'cls_avaliable', 'l', 'i'
    CLS_receive = Win32API.new 'clsocket.dll', 'cls_receive', 'lpi', 'i'
    CLS_close = Win32API.new 'clsocket.dll', 'cls_close', 'l', 'i'
    CLS_gethostbyname = Win32API.new 'clsocket.dll', 'cls_gethostbyname', 'pp', 'i'

    def initialize(af, type, proto)
        if af != nil && type == nil && proto == nil
            @descriptor = af
        else
            @descriptor = CLS_socket.call af, type, proto
        end
        raise 'socket error' if @descriptor == 1
    end

    def connect(host, port, family = 2)
        conn = CLS_connect.call @descriptor, host, port, family
        raise 'connect error' if conn == 1
    end

    def bind(host, port)
        bind = CLS_bind.call @descriptor, host, port
        raise 'bind error' if bind == 1
    end

    def listen(backlog)
        listen = CLS_listen.call @descriptor, backlog
        raise 'listen error' if listen == 1
    end

    def pending(timeout)
        selc = CLS_pending.call @descriptor, timeout
        raise 'pending error' if selc == 1
        return selc == 0
    end

    def accept
        sck = CLS_accept.call @descriptor
        raise 'accept error' if sck == 1
        return Socket.new sck, nil, nil
    end

    def send(data)
        send = CLS_send.call @descriptor, data
        raise 'send error' if send == 1
    end

    def receive(len)
        buff = "\0" * len
        recv = CLS_receive.call @descriptor, buff, len
        raise 'receive error' if recv == 1
        return buff[0, len]
    end

    def avaliable
        av = CLS_avaliable.call @descriptor
        raise 'avaliable error' if av == -1
        return av
    end

    def close
        CLS_close.call @descriptor
    end

    def gethostbyname(name)
        buff = "\0" * 15
        ghbn = CLS_gethostbyname.call name, buff
        raise 'gethostbyname error' if ghbn == 1
        return buff.gsub "\000", ''
    end
end

class TcpSocket < Socket
    def initialize(host, port)
        super 2, 1, 6
        connect host, port
    end
end