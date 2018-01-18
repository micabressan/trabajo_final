class Authentication < Sinatra::Base  
  def initialize(app=nil)
    @someClass = MyClass.new
  end
  
  get '/route1' do
    @someClass.get_message
  end
  
  get '/route2' do
    @someClass.get_message
  end  
end