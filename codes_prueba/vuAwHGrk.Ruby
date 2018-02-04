require 'socket'
require 'thread'
require 'documenttransferprotocol'

class DocumentTransferServerConn
  # Possiveis estados da conexao
  RECEIVING_REQ = 0
  SENDING_RESPONSE = 1
  RECEIVING_DOCUMENT = 2
  SENDING_RESPONSE_DATA = 3
  PROCESS = 4

  def initialize(server, socket)
    @server = server
    @socket = socket
    @state = RECEIVING_REQ
    @operation = -1
    @document_received_size = 0
    @document_size = 0
    @document_id = nil
    @document = ""
    @resp_status = REQ_OK
    @response_data_sent = 0
    @response_data_size = 0
    @response_data = ""
  end

  def run
    while true
      read_array = []
      write_array = []
      error_array = []

      error_array << @socket

      if @state == RECEIVING_REQ || @state == RECEIVING_DOCUMENT
        read_array << @socket
      elsif @state == SENDING_RESPONSE || @state == SENDING_RESPONSE_DATA
        write_array << @socket
      end

      result = select(read_array, write_array, error_array)

      next if result == nil

      for sock_read in result[0]
        if sock_read == @socket
          if @socket.eof?
            @server.conn_closed(self)
            return
          end

          puts "Socket desbloqueado para leitura"

          if !do_read_state
            @server.conn_closed(self)
            return
          end
        end
      end

      for sock_write in result[1]
        if sock_write == @socket
          if @socket.eof?
            @server.conn_closed(self)
            return
          end

          if !do_write_state
            @server.conn_closed(self)
            return
          end
        end
      end
    end   
  end

  def process
    @resp_status = RESP_OK
    @state = SENDING_RESPONSE
    return true
  end

  def do_read_state
    puts "Em do_read_state"
    case @state
    when RECEIVING_REQ
      puts "Case certo"
      receive_req
    when RECEIVING_DOCUMENT
      receive_document
    else
      return false
    end
    return true
  end

  def do_write_state
    case @state
    when SENDING_RESPONSE
      send_response
    when SENDING_RESPONSE
      send_response_data
    else
      return false
    end
    return true
  end

  def receive_document
    expected_size = @document_size - @document_received_size

    data = @socket.recv(expected_size)

    return false if data == nil

    if data.size != expected_size
      @document += data
      @document_received_size -= data.size
      return true
    end

    @document_received_size = 0
    @document += data
    @state = PROCESS

    return true
  end

  def receive_req
    str = "H" * ID_LENGTH

    array = [0]
    array.concat(str.split(""))
    array << 0

    expected_packed = array.pack("L" + str + "L")

    puts "Antes do recv" + expected_packed.size.to_s

    begin
      data = @socket.recv(expected_packed.size)
    rescue Exception => e
      puts "ERRO : " + e.message
      exit
    end

    #return false if data == nil
    if data == nil
      puts "Erro no recv"
      return false
    end

    #return false if data.size != expected_packed.size
    if data.size != expected_packed.size
      puts "Erro data.size != expected_packed.size"
      return false
    end

    puts "Antes do unpack"

    unpacked_data = data.unpack("L" + ("H" * ID_LENGTH) + "L")

    @operation = unpacked_data[0]

    puts "Req recebida"

    case @operation
    when GET_DOCUMENT
      @state = RECEIVING_ID_DOCUMENT
      @document_size = unpacked_data[ID_LENGTH + 1]
      @document_id = unpacked_data[1..-2].join
    when GET_ALL_DOCUMENTS
      @state = PROCESS
    when UPDATE_DOCUMENT
      @state = RECEIVING_ID_DOCUMENT
      @document_size = unpacked_data[ID_LENGTH + 1]
      @document_id = unpacked_data[1..-2].join
    when INSERT_DOCUMENT
      @state = RECEIVING_ID_DOCUMENT
      @document_size = unpacked_data[ID_LENGTH + 1]
      @document_id = unpacked_data[1..-2].join
    when REMOVE_DOCUMENT
      @state = RECEIVING_ID_DOCUMENT
      @document_size = unpacked_data[ID_LENGTH + 1]
      @document_id = unpacked_data[1..-2].join
    else
      return false
    end

    return true
  end

  def send_response
    packed = [@resp_status, @response_data_size].pack("LL")

    data = @socket.send(packed, 0)

    return false if data == nil

    return false if data.size != packed.size

    if @response_data_size != 0
      @state = SENDING_RESPONSE_DATA
    else
      @state = RECEIVING_REQ
    end

    return true
  end

  def send_response_data
    remaining_size = @response_data_size - @response_data_sent

    data = @socket.send(@response_data[@response_data_sent..-1], 0)

    return false if data == nil

    if data.size != remaining_size
      @response_data_sent += data.size
      return true
    end

    @response_data_sent = 0
    @state = RECEIVING_REQ
    return true
  end

  def close
    @socket.close
  end
end