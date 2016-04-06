function(e, time, event, ...)
    if not LEECH then LEECH = {} end
    if not LEECH_SOURCES then LEECH_SOURCES = {} end
    if e == "ENCOUNTER_START" or e == "XPLAYER_REGEN_DISABLED" then
        wipe(LEECH)
    elseif e == "ENCOUNTER_END" or e == "XPLAYER_REGEN_ENABLED" then
        for healer, amount in pairs(LEECH) do
            DEFAULT_CHAT_FRAME:AddMessage(healer .. ": " .. math.floor(amount).." healing", "RAID")
        end
    elseif event == "SPELL_HEAL" then
        local target, _, _, spell, name, _, amount, overhealing = select(7, ...)
        if spell ~= 143924 then return end
        local effective = amount - overhealing
        if effective < 10  then return end
        wipe(LEECH_SOURCES)
        local LEECH_TOTAL = 0
        for i=1, 40 do
            local name, _, _, _, _, _, _, source, _, _, aura, _, _, _, leech = UnitAura(target, i)
            if not name then
                break
            end
            if aura == 184671 then
                LEECH_SOURCES[UnitName(source)] = leech
                LEECH_TOTAL = LEECH_TOTAL + leech
            end
        end
        if LEECH_TOTAL == 0 then return end
        for source, score in pairs(LEECH_SOURCES) do
            if not LEECH[source] then
                LEECH[source] = 0
            end 
            LEECH[source] = LEECH[source] + (effective * (score / LEECH_TOTAL))
        end
    end
end