local SPELL_LATENT_ARCANA = 296971
local shouldDiscard = false

-- original functions
local _orig_MoveForwardStart = MoveForwardStart
local _orig_MoveBackwardStart = MoveBackwardStart
local _orig_StrafeLeftStart = StrafeLeftStart
local _orig_StrafeRightStart = StrafeRightStart
local _orig_CameraOrSelectOrMoveStart = CameraOrSelectOrMoveStart

-- hooks
local function _discardForwardEvent(...)
    if shouldDiscard then return end
    return _orig_MoveForwardStart(...)
end

local function _discardBackwardEvent(...)
    if shouldDiscard then return end
    return _orig_MoveBackwardStart(...)
end

local function _discardLeftEvent(...)
    if shouldDiscard then return end
    return _orig_StrafeLeftStart(...)
end

local function _discardRightEvent(...)
    if shouldDiscard then return end
    return _orig_StrafeRightStart(...)
end

local function _discardCameraEvent(...)
    if shouldDiscard then return end
    return _orig_CameraOrSelectOrMoveStart(...)
end

-- set hooks
MoveForwardStart = _discardForwardEvent
MoveBackwardStart = _discardBackwardEvent
StrafeLeftStart = _discardLeftEvent
StrafeRightStart = _discardRightEvent
CameraOrSelectOrMoveStart = _discardCameraEvent

local function eventHandler(self, event, ...)
    _, _, spellId = ...
    if spellId ~= SPELL_LATENT_ARCANA then return end
    if event == "UNIT_SPELLCAST_CHANNEL_START" then
        shouldDiscard = true
    elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
        shouldDiscard = false
    end
end

-- register frame and set event handler
local frame = CreateFrame("FRAME", "PccAddonFrame")
frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
frame:SetScript("OnEvent", eventHandler)
