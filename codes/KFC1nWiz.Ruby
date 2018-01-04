#==============================================================================
#                           Picture Bug Fix
#------------------------------------------------------------------------------
# Author : Raizen884
# Credits : JohnBolton, Gab!
# Community : www.centrorpgmaker.com
# This script corrects a bug in the default scripts in which pictures continued
# to be updated even after they were erased, which caused lag.
#------------------------------------------------------------------------------
# Place this script above all other scripts in the Materials section.
#==============================================================================
class Sprite_Picture < Sprite
    def update
        super
        if @picture.name != ""
            update_bitmap
            update_origin
            update_position
            update_zoom
            update_other
        else
            self.bitmap.dispose if self.bitmap != nil
        end
    end
end