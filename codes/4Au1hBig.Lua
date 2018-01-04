do
	local function printTarget(self, name, guid)
		self:TargetMessage(254926, name, "Attention", "Alert", nil, nil, true)
		if self:Me(guid) then
			self:Say(254926)
		end
	end

	function mod:ReverberatingStrike(args)
		self:GetBossTarget(printTarget, 0.5, args.sourceGUID)
		local cooldown = 30
		if nextApocalypseProtocol > GetTime() + cooldown then
			self:CDBar(args.spellId, cooldown, empStrike and L.empowered:format(args.spellName))
		end
	end
end