#==============================================================================
# ** Window_HCommand_WI Modified from Blizzard's Window_HCommand By Ryex
#------------------------------------------------------------------------------
#  This window deals with general command choices, but the display is
#  horizontal.
#==============================================================================

class Window_HCommand_WI_Battle < Window_Selectable
  
  attr_accessor :actor
  
  def setup_command_name
    if @actor != nil
      old_command = @commands[1][1]
      @commands[1][1] = case @actor.id
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# START Database
#
# Just like usual in all of my scripts and add-on the template is:
# when X then 'COMMAND'
# X - class ID on the database
# COMMAND - the unique skill command for the appropriate class
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      when 1 then 'Technic'
      when 2 then 'Lancetech'
      when 3 then 'Powers'
      when 4 then 'Skills'
      when 5 then 'Arrowmagic'
      when 6 then 'Ammo'
      when 7 then 'White Magic'
      when 8 then 'Magic'
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# END Database
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
      else
        @commands[1][1]
      end
      refresh if old_command != @commands[1][1]
    end
  end
  
end