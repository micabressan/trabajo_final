# Skill Functions 2.3 by Mithran
# Please do not redistribute without asking.  At the very least, have the decency to include the instruction section.
#===============================================================================
#                             *CUSTOMIZATION*
#===============================================================================

=begin

Okay, here goes the explanation on user defined values.  If you have additional
scripts installed that support additional stats, you can use these for function
values as well.  Some setup is required.  Your note tag will be automatically
created for you as soon as you set up a value in FunctionDamageStats.


Default stat codes are as follows:
  # "hp" - hit points
  # "mp" - magic points
  # "atk" - attack
  # "spi" - spirit
  # "agi" - agility
  # "def" - defense
  # "hit" - Hit chance
  # "eva" - Evasion Chance
  # "cri" - Critical chance
  # "maxhp" - Maximum HP
  # "maxmp" - Maximum MP
  # "level" - Level, for actors ONLY (makes the formula 0 and gives an error
  message for enemies if in test mode)
  
I have added methods for four stat codes myself -
  # "hp_missing" - Amount of HP missing
  # "mp_missing" - Amount of MP missing
  # "hp_pct" - Percentage of HP remaining, expressed as an integer
    # between 0 and 100
  # "mp_pct" - Percentage of MP remaining, expressed as an integer
    # between 0 and 100

Other known values for other scripts:
  # "lck" - Enelvon's Ultimate Luck Script
  # "res" - Enelvon's Magic Resist Script

=end

module Mithran
  module SkillFunctions
    FunctionDamageStats = {  
#-------------------------------------------------------------------------------
    # These first few are the pre-defined for the script.  
    # You dont need to edit these
    # They are here for reference
    
    :hp => "hp", # The stat code used to calculate hp_f
    :mp => "mp", # The stat code used to calculate mp_f
    :agi => "agi", # The stat code used to calculate agi_f
    :def => "def", # The stat code used to calculate def_f
    :hpi => "hp_missing",# The stat code used to calculate hpi_f
    :mpi => "mp_missing", # The stat code used to calculate mpi_f
#------------------------------------------------------------------------------
    ## In this section you add additional function stats
    # The regular format is:
    # :TAG => "CODE" ,
    # Change CODE to the stat code you want to use.
    # Change TAG to the tag you want to use.
    # both the tag and the code should be lowercase
    # On the left side you put the symbol for the stat
    # (This is what the script reads from the note tag before) _f
    # On the right side, in quotes, you put the stat code
    # Dont forget the comma at the end!

    # For example, if you wanted a function value for Enelvon's resist,
    # you would type:  
    :res => "res",
    # The note tag for res would be <res_f ##>
    # You can use whatever combination of lowercase letters you wish for the tag
    # For example:
    # :mdef => "res",
    # would set the <mdef_f ##> note tag to use res as its stat
    # During playtesting, this will give an error message if res is undefined
    # During normal play, it will just be ignored

    # Some other examples include:
    :hit => "hit", #<= Dont forget the comma after each entry
    # To access it with the note tag, you would type <hit_f ##>
    # the following sets critical rate to a function value
    :cri => "cri",
    # To access it with the note tag, you would type <cri_f ##>
    :lvl => "level", # I wont assign a formula for this one
    # It will deal approx 4 damage per actor level per 100 lvl_f

        
    # Define additionals before here
#-------------------------------------------------------------------------------
    } # <= Do not move or change

#-------------------------------------------------------------------------------
    DEFAULT_DAMAGE_FORMULA = "stat * 4 * frate / 100"
    # The default damage formula  used.  stat is the statistic used, and frate
    # is the function value.  This is only used if the damage formula is not
    # rate is not defined below.
#-------------------------------------------------------------------------------
    
    FunctionDamageFormulas = {
#-------------------------------------------------------------------------------
    # This section sets the damage formulas for each value. Again, you dont need
    # to edit the first few, but they are here for reference
    :hp => "stat * 4 * frate / 1000" ,# The Formula used to calculate hp_f
    :mp => "stat * 2 * frate / 100" ,# The Formula used to calculate mp_f
    :agi => "stat * 2 * frate / 100" ,# The Formula used to calculate agi_f
    :def => "stat * 4 * frate / 100" ,# The Formula used to calculate def_f
    :hpi => "stat * 4 * frate / 1000" ,# The Formula used to calculate hpi_f
    :mpi => "stat * 2 * frate / 100" ,# The Formula used to calculate mpi_f
#-------------------------------------------------------------------------------
    # Define your own formulas in this section.
    # If you do not assign a formula to any given stat, the default formula
    # will be used.
    # The formula codes:
    # stat  the stat you defined earlier
    # frate  the function value set for any given skill
    # >>CODE  replace CODE with the code (in lowercase) for any stat to use
    # this stat in the formula.  This allows you to use stats outside the one
    # you have associated in the above section.
    # *  Multiplication
    # /  Division.  Be sure to put a space before the next value.
    # +  Addition.
    # -  Subtraction
    # ANY NUMBER - you can use any integer value in the calculation
    # To ensure the most accurate calculation due to integer calculation
    # rounding, division should go last.  Parenthesis can be used for grouping
    
    # if you want to use a stat other than the one defined above, use >> before
    # the stat code in the formula
     :hit => "stat * >>agi * 4 * frate / 100 / 100" , # < Dont forget the commas
     # yeilds 4 times agi at 100 frate and 100 hit
     :cri => "stat * >>atk * frate / 100" ,
     # yeilds attack times critical at 100 Frate

    
    # Define additionals before here
#-------------------------------------------------------------------------------
    }  # <= Do not move or change

#-------------------------------------------------------------------------------
    DEFAULT_DEFENSE_FORMULA = "stat * 2 * frate / 100"
    # The default defense formula used.  
    # This is only used if the rate is not defined below
#-------------------------------------------------------------------------------
    
    FunctionDefenseFormulas = {
#-------------------------------------------------------------------------------
    # This section allow you to edit the defending formulas for each value
    # Feel free to edit the defending stat to whatever you want
    # To get a balanced calculation, the defending stat should subtract
    # approxiamtely half as much as the attacking stat adds
#-------------------------------------------------------------------------------
    :hp => ">>def * 2 * frate / 100" ,# The Formula used to defend against hp_f
    :mp => ">>spi * 1 * frate / 100", # The Formula used to defend against mp_f
    :agi => "stat * 1 * frate / 100" ,# The Formula used to defend against agi_f
    :def => ">>def * 2 * frate / 100" ,# The Formula used to defend against def_f
    :hpi => ">>def * 2 * frate / 100" ,# The Formula used to defend against hpi_f
    :mpi => ">>spi * 1 * frate / 100" ,# The Formula used to defend against mpi_f    
#-------------------------------------------------------------------------------
    # Assign your own values past this point.  If not assigned, the default
    # formula above will be used
    :hit => ">>eva * >>eva * frate / 8 / 100" , # Evasion squared divided by 8
    # at 100 frate is used to defend
    :cri => "(stat + 1) * >>def * frate / 2 / 100" , # Critical plus one times
    # defense divided by 2 at 100 frate
    :lvl => "0", # Yes, you can also set the value to just an integer.  Setting
    # it to zero makes the defending value for the function also zero, which
    # means this value cant be defended against.


    
    # Add any other values above here
#-------------------------------------------------------------------------------
    }  # <= Do not move or change    
    
  end
end

#-------------------------------------------------------------------------------
# Editing the text values here just changes the message displayed.
# %s is the user's name.
module Vocab
  RecoilText      = "%s was hit by recoil!" # Displayed when taking recoil
  AbsorbPct      = "%s absorbed some energy!" # Displayed when absorbing by percent
  # The next two lines have no bearing on the script
  ActorDrain      = "%1$s was drained of %3$s %2$s!"
  EnemyDrain      = "%1$s was drained of %3$s %2$s!"
  # I changed the vocab for drain because the default sounds absoloutley
  # ridiculous.

end

#===============================================================================
#                             END CUSTOMIZATION
#===============================================================================

module Mithran
  module SkillFunctions
    IGNORE_GUARD_TAG = /<(ignore[\s_]?guard|No[\s_]?guard)>/i
    HPMP_SCALE_TAG = /<(hp|mp)[\s_]?scale[\s_]?(invert)?\s?(?:(\d+)\s?\-\s?(\d+))?>/i
    RECOIL_TAG = /<recoil (\d+)>/i
    DAMAGE_BOTH_TAG = /<(?:damage[\s_]?both|dmg[\s_]hpmp) (\d+)>/i
    ABSORB_PERCENT_TAG = /<absorb[\s_]pct (\d+)>/i
    HEAL_ON_USE_TAG = /<heal[\s_](hp|mp|both)[\s_]on[\s_]use (\d+)(%)?>/
    FVALUE_TAG = /(<[a-z]+_)f (\d+)>/i
    NONFATAL_TAG = /<non[\s_]?fatal>/i
    EXACT_DMG_TAG = /<exact[\s_]?dmg (\-?\d+)>/i
    FUNCTION_SIGN_TAG = /<skill[\s_]?function[\s_]?(pos|neg|\+|\-)(?:itive|ative)?>/i
  end
end

class Game_SkillFuncts
  attr_accessor :skill_damage_formulas
  attr_accessor :skill_defense_formulas
  def initialize
    damagestats = Mithran::SkillFunctions::FunctionDamageStats
    damageformulas = Mithran::SkillFunctions::FunctionDamageFormulas
    defenseformulas = Mithran::SkillFunctions::FunctionDefenseFormulas
    @skill_damage_formulas = {}
    @skill_defense_formulas = {}
    usablefuncts = {}
    damagestats.each_pair { |keyID, value|
      dmg_formula = ""
      def_formula = ""
      if damageformulas[keyID] == nil
        dmg_formula = Mithran::SkillFunctions::DEFAULT_DAMAGE_FORMULA
      else
        dmg_formula = damageformulas[keyID]
      end
      if defenseformulas[keyID] == nil
        def_formula = Mithran::SkillFunctions::DEFAULT_DEFENSE_FORMULA
      else
        def_formula = defenseformulas[keyID]
      end
      dmg_formula.gsub!(/stat/i, ('user.' + value))
      dmg_formula.gsub!(/>>/i, 'user.')
      dmg_formula.gsub!(/frate/i, ("obj.fvalue[:#{keyID}]"))
      def_formula.gsub!(/stat/i, ('self.' + value))
      def_formula.gsub!(/>>/i, 'self.')
      def_formula.gsub!(/frate/i, ("obj.fvalue[:#{keyID}]"))
      dmg_formula.downcase!
      def_formula.downcase!
      @skill_damage_formulas[keyID] = dmg_formula
      @skill_defense_formulas[keyID] = def_formula
    }
  end

end


class Scene_Title < Scene_Base
  alias load_database_orig_mith_SF load_database
  def load_database
    load_database_orig_mith_SF
    for skill in $data_skills.compact
      skill.make_skill_function_cache
    end
    for item in $data_items.compact
      item.clear_skill_function_cache
    end
    $game_skillfuncts = Game_SkillFuncts.new
  end
  
  alias load_bt_database_orig_mith_SF load_bt_database
  def load_bt_database
    load_bt_database_orig_mith_SF
    for skill in $data_skills.compact
      skill.make_skill_function_cache
    end
    for item in $data_items.compact
      item.clear_skill_function_cache
    end
    $game_skillfuncts = Game_SkillFuncts.new
  end
end

class RPG::BaseItem
  attr_accessor :ignore_guard
  attr_accessor :hp_scale
  attr_accessor :mp_scale
  attr_accessor :hp_scale_invert
  attr_accessor :mp_scale_invert
  attr_accessor :hp_scale_min
  attr_accessor :hp_scale_max
  attr_accessor :mp_scale_min
  attr_accessor :mp_scale_max
  attr_accessor :hpmp_damage_rate
  attr_accessor :use_advanced_formulas
  attr_accessor :recoil_rate
  attr_accessor :hpmpdmg_extra
  attr_accessor :absorb_pct
  attr_accessor :fvalue
  attr_accessor :nonfatal
  attr_accessor :exact_damage
  attr_accessor :function_sign
  attr_accessor :heal_on_use
  
  def clear_skill_function_cache
    @ignore_guard = false
    @hp_scale = false
    @mp_scale = false
    @hp_scale_invert = false
    @mp_scale_invert = false
    @hpmp_damage_rate = 0
    @use_advanced_formulas = false
    @recoil_rate = 0
    @hpmpdmg_extra = 0
    @hp_scale_min = 0
    @hp_scale_max = 100
    @mp_scale_min = 0
    @mp_scale_max = 100
    @absorb_pct = 0
    @fvalue = {}
    @nonfatal = false
    @exact_damage = nil
    @function_sign = self.base_damage
    @heal_on_use = []
  end
  
  def make_skill_function_cache
    clear_skill_function_cache
    @use_advanced_formulas = true
    self.note.split(/[\r\n]+/).each { |line|
      case line
      when Mithran::SkillFunctions::IGNORE_GUARD_TAG
        @ignore_guard = true
      when Mithran::SkillFunctions::HPMP_SCALE_TAG
        match = $~.clone
        case match[1]
        when /hp/i
          @hp_scale = true if match[2] == nil
          @hp_scale_invert = true unless match[2] == nil
          if match[3] == nil
            @hp_scale_min = 50
            @hp_scale_max = 150
          else
            @hp_scale_min = match[3].to_i
            @hp_scale_max = match[4].to_i
          end
        when /mp/i
          @mp_scale = true if match[2] == nil
          @mp_scale_invert = true unless match[2] == nil
          if match[3] == nil
            @mp_scale_min = 50
            @mp_scale_max = 150
          else
            @mp_scale_min = match[3].to_i
            @mp_scale_max = match[4].to_i
          end
        end
      when Mithran::SkillFunctions::RECOIL_TAG
        @recoil_rate = $1.to_i
      when Mithran::SkillFunctions::DAMAGE_BOTH_TAG
        @hpmpdmg_extra = $1.to_i
      when Mithran::SkillFunctions::ABSORB_PERCENT_TAG
        @absorb_pct = $1.to_i
      when Mithran::SkillFunctions::FVALUE_TAG
        match = $~.clone
        text = match[1]
        text.gsub!(/[<_]/ , "")
        eval("@fvalue[:#{text}] = #{match[2].to_i}")
      when Mithran::SkillFunctions::NONFATAL_TAG
        @nonfatal = true
      when Mithran::SkillFunctions::EXACT_DMG_TAG
        @exact_damage = $1.to_i
      when Mithran::SkillFunctions::FUNCTION_SIGN_TAG
        if $1 == "pos" or $1 == "+"
          @function_sign = 1
        elsif $1 == "neg" or $1 == "-"
          @function_sign = -1
        end
      when Mithran::SkillFunctions::HEAL_ON_USE_TAG
        @heal_on_use = [$1, $2.to_i, !$3.nil?]
      end
    }
  end
end

class Game_Actor < Game_Battler
  alias base_atk_orig_hpwpn base_atk
  def base_atk
    n = base_atk_orig_hpwpn
    for item in weapons.compact
      n += (self.hp * item.hpwpn) / 100
      n += (self.hp_missing * item.hpiwpn) / 100
    end
  return n
  end
end

class RPG::Weapon < RPG::BaseItem
  
  def hpwpn # Hit point to weapon attack percent
    return $1.to_i if self.note =~ /<hpwpn (\d+)>/i
    return 0
  end
  
  def hpiwpn # missing hit point to weapon attack percent
    return $1.to_i if self.note =~ /<hpiwpn (\d+)>/i
    return 0
  end
end  
  
class Game_Battler
  attr_accessor :recoil_damage_hp
  attr_accessor :recoil_damage_mp
  attr_accessor :recoil
  attr_accessor :absorbed_pct
  attr_accessor :absorbed_hp
  attr_accessor :absorbed_mp
  attr_accessor :heal_on_use
  
  alias make_obj_damage_value_orig_mith_SF make_obj_damage_value
  def make_obj_damage_value(user, obj)
    @sf_temp_ignore_guard = false
    @sf_temp_ignore_guard = true if obj.use_advanced_formulas && obj.ignore_guard    
    make_obj_damage_value_orig_mith_SF(user, obj)
    make_obj_damage_value_advanced_SF(user, obj) if obj.use_advanced_formulas
    @sf_temp_ignore_guard = false
  end
    
  def hp_missing
    @hp = [[hp, maxhp].min, 0].max
    return (self.maxhp - self.hp)
  end
  
  def mp_missing
    @mp = [[mp, maxmp].min, 0].max
    return (self.maxmp - self.mp)
  end
  
  def hp_pct
    @hp = [[hp, maxhp].min, 0].max
    return 0 if maxhp == 0
    return (self.hp * 100 / self.maxhp)
  end
  
  def mp_pct
    @mp = [[mp, maxmp].min, 0].max
    return 0 if maxmp == 0
    return (self.mp * 100 / self.maxmp)
  end
  
  def make_obj_damage_value_advanced_SF(user, obj)
    damage = 0
    if obj.function_sign > 0
      $game_skillfuncts.skill_damage_formulas.each_pair { |i, sdf|
      begin
        next if obj.fvalue[i] == nil
        damage += eval(sdf).to_i
      rescue
        print "Oops!  There seems to be an error with your damage formula.  The current formula is: \n" +
        sdf + "\n" if $TEST
      end
      }
      unless obj.ignore_defense
        $game_skillfuncts.skill_defense_formulas.each_pair { |i, sdf|
        begin
          next if obj.fvalue[i] == nil
          damage -= eval(sdf).to_i
        rescue
          print "Oops!  There seems to be an error with your defensive formula.  The current formula is: \n" +
          sdf + "\n" if $TEST
        end
        }
        damage = 0 if damage < 0
      end
    elsif obj.function_sign < 0
      $game_skillfuncts.skill_damage_formulas.each_pair { |i, sdf|
      begin
        next if obj.fvalue[i] == nil
        damage -= eval(sdf).to_i
      rescue
        print "Oops!  There seems to be an error with your recovery formula.  The current formula is: \n" +
        sdf + "\n" if $TEST
      end
      }
    end
    damage = (damage * elements_max_rate(obj.element_set)) / 100
    damage = apply_variance(damage, obj.variance)
    damage = apply_guard(damage)
    if obj.damage_to_mp
      damage += @mp_damage
    else
      damage += @hp_damage
    end
    damage = obj_hpmp_scaling(user, obj, damage)
    unless obj.exact_damage == nil
      damage = obj.exact_damage * elements_max_rate(obj.element_set) / 100
    end
    if obj.damage_to_mp
      @mp_damage = damage
      @hp_damage = damage * obj.hpmpdmg_extra / 100
    else
      @hp_damage = damage
      @mp_damage = damage * obj.hpmpdmg_extra / 100
    end
    if obj.nonfatal
      @hp_damage = @hp - 1 if @hp_damage >= @hp
    end
  end
  
  def obj_hpmp_scaling(user, obj, damage)
    if obj.hp_scale
      dmg = damage
      scale_min = obj.hp_scale_min
      scale_max = obj.hp_scale_max
      scale_range = scale_max - scale_min
      damage = dmg * user.hp * scale_range / user.maxhp / 100
      damage += dmg * scale_min / 100
    end
    if obj.mp_scale
      dmg = damage
      scale_min = obj.mp_scale_min
      scale_max = obj.mp_scale_max
      scale_range = scale_max - scale_min
      damage = dmg * user.mp * scale_range / user.maxmp / 100
      damage += dmg * scale_min / 100
    end
    if obj.hp_scale_invert
      dmg = damage
      scale_min = obj.hp_scale_min
      scale_max = obj.hp_scale_max
      scale_range = scale_max - scale_min
      damage = dmg * scale_range * (100 - (user.hp * 100 / user.maxhp)) / 100 / 100
      damage += dmg * scale_min / 100
    end
    if obj.mp_scale_invert
      dmg = damage
      scale_min = obj.mp_scale_min
      scale_max = obj.mp_scale_max
      scale_range = scale_max - scale_min
      damage = dmg * scale_range * (100 - (user.mp * 100 / user.maxmp)) / 100 / 100
      damage += dmg * scale_min / 100
    end
    return damage
  end
    
  alias make_obj_absorb_effect_orig_mith_SF make_obj_absorb_effect
  def make_obj_absorb_effect(user, obj)
    if obj.nonfatal
      @hp_damage = @hp - 1 if @hp_damage >= @hp
    end
    if obj.absorb_pct == 0
      make_obj_absorb_effect_orig_mith_SF(user, obj)
    end
  end
  
  def make_obj_absorb_pct_effect(user, obj)
    @absorbed_hp = @hp_damage * obj.absorb_pct / 100
    @absorbed_mp = @mp_damage * obj.absorb_pct / 100
    @absorbed_hp = [@absorbed_hp, (self.hp * obj.absorb_pct / 100) ].min
    @absorbed_mp = [@absorbed_mp, (self.mp * obj.absorb_pct / 100) ].min
    if @absorbed_hp > 0 or @absorbed_mp > 0
      @absorbed = false
      @absorbed_pct = true
    end
  end
    
  alias apply_guard_orig_mith_SF apply_guard
  def apply_guard(damage)
    return damage if @sf_temp_ignore_guard
    return apply_guard_orig_mith_SF(damage)
  end
  
  def make_obj_recoil_effect(user, obj)
    @recoil_damage_hp = @hp_damage * obj.recoil_rate / 100
    @recoil_damage_mp = @mp_damage * obj.recoil_rate / 100
    @recoil_damage_hp = [@recoil_damage_hp, (self.hp * obj.recoil_rate / 100) ].min
    @recoil_damage_mp = [@recoil_damage_mp, (self.mp * obj.recoil_rate / 100) ].min
    if @recoil_damage_hp > 0 or @recoil_damage_mp > 0
      @recoil = true
    else
      @recoil = false
    end
  end
  
  def make_obj_HOU_effect(user, obj)
    return if @sf_temp_obj.heal_on_use.empty?
    return if @sf_temp_obj.physical_attack && @hp_damage == 0 # physical no damage
    type = @sf_temp_obj.heal_on_use[0]
    amount = @sf_temp_obj.heal_on_use[1]
    rate = @sf_temp_obj.heal_on_use[2]
    case type
    when /both/i
      @absorbed_hp += rate ? amount * user.maxhp / 100 : amount
      @absorbed_mp += rate ? amount * user.maxmp / 100 : amount
    when /hp/i
      @absorbed_hp += rate ? amount * user.maxhp / 100 : amount
    when /mp/i
      @absorbed_mp += rate ? amount * user.maxmp / 100 : amount
    end
    @heal_on_use = true if @absorbed_hp > 0 or @absorbed_mp > 0
  end
  
  alias execute_damage_orig_mith_SF execute_damage
  def execute_damage(user)
    if @sf_temp_obj != nil && @sf_temp_obj.nonfatal
      @hp_damage = @hp - 1 if @hp_damage >= @hp
    end
    execute_damage_orig_mith_SF(user)
    make_obj_absorb_pct_effect(user, @sf_temp_obj) if @sf_temp_obj != nil
    make_obj_recoil_effect(user, @sf_temp_obj) if @sf_temp_obj != nil
    make_obj_HOU_effect(user, @sf_temp_obj) if @sf_temp_obj != nil
    if @absorbed_pct or @heal_on_use
      user.hp += @absorbed_hp
      user.mp += @absorbed_mp
    end
    if @recoil
      user.hp -= @recoil_damage_hp
      user.mp -= @recoil_damage_mp
    end
    if @recoil_damage_hp > 0
      user.remove_states_shock
    end
  end
  
  alias clear_action_results_orig_mith_SF clear_action_results
  def clear_action_results
    clear_action_results_orig_mith_SF
    @recoil = false
    @recoil_damage_hp = 0
    @recoil_damage_mp = 0
    @absorbed_pct = false
    @heal_on_use = false
    @absorbed_hp = 0
    @absorbed_mp = 0
  end
  
  alias skill_effect_orig_mith_SF skill_effect
  def skill_effect(user, skill)
    @sf_temp_obj = skill
    skill_effect_orig_mith_SF(user, skill)
    @sf_temp_obj = nil  
  end
  
  alias item_effect_orig_mith_SF item_effect
  def item_effect(user, item)
    @sf_temp_obj = item
    item_effect_orig_mith_SF(user, item)
    @sf_temp_obj = nil
  end
  
end

class Scene_Battle < Scene_Base
  alias display_damage_orig_mith_SF display_damage
  def display_damage(target, obj = nil)
    display_damage_orig_mith_SF(target, obj)
    if target.absorbed_pct or target.heal_on_use
      display_absorb_pct(target, obj)
    end
    if target.recoil
      display_recoil(target, obj)
    end
  end
  
  def display_absorb_pct(target, obj = nil)
    @message_window.add_instant_text(sprintf(Vocab::AbsorbPct, @active_battler.name)) if target.absorbed_pct
    wait(15)
    if target.absorbed_hp > 0
      fmt = @active_battler.actor? ? Vocab::ActorRecovery : Vocab::EnemyRecovery
      text = sprintf(fmt, @active_battler.name, Vocab::hp, target.absorbed_hp)
      Sound.play_recovery
      @message_window.add_instant_text(text)
      wait(15)
    end
    if target.absorbed_mp > 0
      fmt = target.actor? ? Vocab::ActorRecovery : Vocab::EnemyRecovery
      text = sprintf(fmt, @active_battler.name, Vocab::mp, target.absorbed_mp)
      Sound.play_recovery
      @message_window.add_instant_text(text)
      wait(15)
    end
    wait (30)
  end
  
  def display_recoil(target, obj = nil)
    @message_window.add_instant_text(sprintf(Vocab::RecoilText, @active_battler.name))
    wait(15)
    if target.recoil_damage_hp > 0
      if @active_battler.actor?
        text = sprintf(Vocab::ActorDamage, @active_battler.name, target.recoil_damage_hp)
        Sound.play_actor_damage
        $game_troop.screen.start_shake(5, 5, 10)
        @message_window.add_instant_text(text)
        wait(15)
      else
        text = sprintf(Vocab::EnemyDamage, @active_battler.name, target.recoil_damage_hp)
        Sound.play_enemy_damage
        @active_battler.blink = true
        @message_window.add_instant_text(text)
        wait(15)
      end
    end
    if target.recoil_damage_mp > 0
      fmt = @active_battler.actor? ? Vocab::ActorLoss : Vocab::EnemyLoss
      text = sprintf(fmt, @active_battler.name, Vocab::mp, target.recoil_damage_mp)
      @message_window.add_instant_text(text)
      wait(15)
    end
    wait(15)
  end
end

class Window_BattleMessage < Window_Message
  alias add_instant_text_orig_mith_SF add_instant_text
  def add_instant_text(text)
    while @lines.size >= MAX_LINE
      @lines.shift
    end
    add_instant_text_orig_mith_SF(text)
  end
end