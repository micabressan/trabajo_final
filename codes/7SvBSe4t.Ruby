class Game_Followers

  def initialize(leader)
    @visible = $data_system.opt_followers
    @gathering = false                    # Gathering processing underway flag
    @data = []
    @data.push(Game_Follower.new(1, leader))
    (2...20).each do |index| 
      @data.push(Game_Follower.new(index, @data[-1]))
    end
  end
  
end