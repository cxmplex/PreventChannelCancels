local SPELL_LATENT_ARCANA = 296971

local function eventHandler(_, event, ...)
    local _, _, spellId = ...
    if spellId ~= SPELL_LATENT_ARCANA then return end
    if event == "UNIT_SPELLCAST_CHANNEL_START" then
        SetHackEnabled("freeze", true)
    elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
        SetHackEnabled("freeze", false)
    end
end

-- register frame and set event handler
local frame = CreateFrame("FRAME", "PccAddonFrame")
frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
frame:SetScript("OnEvent", eventHandler)
