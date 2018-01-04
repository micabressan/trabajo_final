=begin

- Target One Ally (Not the User) Scope - What a silly title! 
- Made by: Sixth

- Description

This script will let you make a new scope for your skills (kinda).
That scope will let the player target anyone from an ally except the user.

To make a skill use this scope, make sure to set it's database scope to
the "One Ally" type, and use this note-tag in it's note-box:

  <one_ally_no_user>

This will setup the new scope for the skill. It will work in the menu outside
the battles too, but only on skills.
Due to how the user is set for the items in the item menu (the member with the 
highest PHA stat will be the user every time you use an item), it wouldn't make
much sense to enable this new scope there (but if you still used the mentioned
note-tag on an item with the "One Ally" scope, it will function as expected 
during battles, so the user will not be able to use the item on him/herself.

As a necessary fix, I also made enemies not target the last troop member every
time they use a skill with the "One Ally" scope. Instead, they will now target 
random allies, but if the used skill got the <one_ally_no_user> note-tag, they
won't be able to target themselves with the skill.

This is tested without any custom battle scripts, so there is no guarantee that
it will work with those!
  
=end

class RPG::UsableItem < RPG::BaseItem

  attr_accessor :one_no_user
  
  def one_no_user
    init_one_no_user if @one_no_user.nil?
    return @one_no_user
  end
  
  def init_one_no_user
    @one_no_user = @note =~ /<one_ally_no_user>/i ? true : false
  end
  
end

class Game_Action

  alias check_no_user1232 targets_for_friends
  def item_target_candidates
    trgs = check_no_user1232
    trgs.delete(subject) if item.one_no_user && item.for_one?
    return trgs
  end
  
  alias check_no_user1132 targets_for_friends
  def targets_for_friends
    if subject.is_a?(Game_Enemy) && item.scope == 7
      ids = []
      friends_unit.alive_members.each_with_index do |mem,i|
        next if item.one_no_user && mem == subject
        ids << $game_troop.members.index(mem)
      end
      @target_index = ids.sample
    end
    trgs = check_no_user1132
    return trgs
  end

end

class Game_BattlerBase
  
  alias check_no_user7541 usable?
  def usable?(item)
    return false if item.one_no_user && friends_unit.alive_members.size <= 1
    check_no_user7541(item)
  end
  
end

class Game_Actor < Game_Battler
  
  alias check_no_user9265 item_test
  def item_test(user, item)
    return false if item.one_no_user && self == user
    check_no_user9265(user, item)
  end
  
end

class Window_BattleActor < Window_BattleStatus
 
  def draw_actor_name(actor, x, y, width = 112)
    if BattleManager.actor && BattleManager.actor.input.item.one_no_user &&
       actor == BattleManager.actor
      act_enable = false
    else
      act_enable = true
    end
    change_color(hp_color(actor),act_enable)
    draw_text(x, y, width, line_height, actor.name)
  end
 
  def current_item_enabled?
    if BattleManager.actor && BattleManager.actor.input.item.one_no_user &&
       $game_party.members[@index] == BattleManager.actor
      return false
    else
      super
    end
  end

end

class Scene_Skill < Scene_ItemBase

  alias check_no_user8826 use_item
  def use_item
    if item.one_no_user && user == $game_party.members[@actor_window.index]
      return Sound.play_buzzer
    end
    check_no_user8826
  end
  
end

class Scene_Battle < Scene_Base
  
  alias check_no_user5413 on_actor_ok
  def on_actor_ok
    if BattleManager.actor.input.item.one_no_user &&
       BattleManager.actor == $game_party.battle_members[@actor_window.index]
      return Sound.play_buzzer
    end
    check_no_user5413
  end  
  
end