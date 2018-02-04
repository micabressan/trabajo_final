
module OUE
  class Controller
    attr_reader :wantsInput, :active
    attr_accessor :requestInputListener, :requestOutputListener

    def initialize
      @active = true
      @requestInputListener = @requestOutputListener = nil
      @thread = Thread.new {
        Thread.stop
        step while @active
      }
    end
    
    def step
      requestInput
      sleep until @queuedInput
      output @queuedInput + " is a word."
      if @queuedInput == "Quit"
        @active = false
      end
      @queuedInput = nil
      output "Give me another one, pls."
    end
    
    def start
      @thread.run
    end
    
    def input(msg)
      @queuedInput = msg
    end
    
    def output(msg)
      @requestOutputListener.call msg
    end
    
    def requestInput
      @requestInputListener.call
    end
  end
end