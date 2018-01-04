local tool_sprite, tool_delay, ScaleVar, RState = ...

local t = Def.ActorFrame{ 

    OnCommand=function(self)
        local random_states if RState == true then
            self:RunCommandsOnChildren( function(child) child:setstate(math.random(0,child:GetNumStates()-1)) end )
            end
        end,

}

local thonk for i=-4,0 do
local thonk2 for k=-4,0 do

t[#t+1] = Def.ActorFrame{
            GainFocusCommand=function(self)

 local A1 if i == k then
        self:xy(0,0):zoom(1):linear(8*2):Center():zoom(0):effectclock("beat"):set_tween_uses_effect_delta(true):queuecommand("GainFocus")
    end

local A2 if i == 0 and k == -2 or
            i == -1 and k == -3 or
            i == -2 and k == -4 then
        self:xy(-150,0):sleep(2):zoom(1):linear(8*2):Center():zoom(0):effectclock("beat"):set_tween_uses_effect_delta(true):queuecommand("GainFocus")
    end
end,


        Def.Sprite{
             Texture = tool_sprite, 
             GainFocusCommand=function(self)

 local a1 if i == k then

                self:rotationz(0)
                self:zoom(ScaleVar)
                :xy(SCREEN_CENTER_X-self:GetWidth()/2*ScaleVar-(-(math.abs(i)-1)*self:GetWidth()/2*ScaleVar),SCREEN_CENTER_Y-self:GetHeight()/2*ScaleVar-(-(math.abs(k)-1)*self:GetHeight()/2*ScaleVar))
                :SetAllStateDelays(tool_delay)
                self:sleep(1/(math.abs(i)+1)):linear(8):rotationz(360)
                :xy(self:GetX()-self:GetWidth()/4*(math.abs(i)+1),self:GetY()-self:GetHeight()/4*(math.abs(k)+1))
                :zoom(0):effectclock("beat"):set_tween_uses_effect_delta(true)
            end

local a2 if i == 0 and k == -2 or
            i == -1 and k == -3 or
            i == -2 and k == -4 then

                self:rotationz(360/2)
                self:zoom(ScaleVar)
                :xy(SCREEN_CENTER_X-self:GetWidth()/2*ScaleVar-(-(math.abs(i)-1)*self:GetWidth()/2*ScaleVar),SCREEN_CENTER_Y-self:GetHeight()/2*ScaleVar-(-(math.abs(k)-1)*self:GetHeight()/2*ScaleVar))
                :SetAllStateDelays(tool_delay)
                self:sleep(1/(math.abs(i)+1)):linear(8):rotationz(360)
                :xy(self:GetX()-self:GetWidth()/4*(math.abs(i)+1),self:GetY()-self:GetHeight()/4*(math.abs(k)+1))
                :zoom(0):effectclock("beat"):set_tween_uses_effect_delta(true)
            end
end,

        }
}

end
end

return t