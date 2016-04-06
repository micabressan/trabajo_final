  #--------------------------------------------------------------------------
  # ● New Method screen_x
  #--------------------------------------------------------------------------
  def screen_x
	if $game_party.battle_members.size == 1 
		if self.index == 0
			return 278
		end
	elsif $game_party.battle_members.size == 2
		if self.index == 0
			return 158
		elsif self.index == 1
			return 394
		end
	elsif $game_party.battle_members.size == 3 
		if self.index == 0
			return 118
		elsif self.index == 1
			return 274
		elsif self.index == 2
			return 430
		end
	elsif $game_party.battle_members.size == 4
		if self.index == 0
			return 98
		elsif self.index == 1
			return 214
		elsif self.index == 2
			return 330
		elsif self.index == 3
			return 446
		end
	end
    return Animated_Battlers::X_START + self.index * Animated_Battlers::X_OFFSET
  end