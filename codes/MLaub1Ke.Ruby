class Poll
  include Cinch::Plugin

  #?poll "Question here in quotes" choice1 choice2 choice3
  match /poll (.+?") (.+)/
  listen_to :channel
  
  timer 1, method: :timed
  
  def initialize(*args)
    super
    @pollRunning = false
    @choices = {}
    @voted = Array.new
    @pollLength = 10
    @startTime
    @channel
  end
  
  def listen(m)
    if @pollRunning == true
     if @voted.include?(m.user)
       puts "#{m.user} already voted"
     else
      if @choices.has_key?(m.message)
        @choices[m.message] += 1
        @voted << m.user
        puts "#{@choices[m.user]} voted for #{m.message}"
      end
     end
    end
  end
  
  def timed()
    if @pollRunning
      if @startTime.nil? == false
        time = Time.now - @startTime
        if time > @pollLength
          @pollRunning = false
          results
        end
      end
    end
  end
  
  def results()
    temp = ""
    @choices.each_pair do |k,v|
      temp = "#{temp} #{k}: #{v},"
    end
        Channel(@channel).send "POLL RESULTS: #{temp}"
  end
  
  def execute(m, question, answers)
    @voted.clear
    @choices.clear
    
    @channel = m.channel
    
    answers.split.each do |choice|
      @choices[choice] = 0
    end
    @pollRunning = true
    
    @startTime = Time.now
    
    m.reply "POLL: #{question} Choices: #{answers}"
  end
end