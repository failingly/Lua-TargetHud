# Lua-TargetHud
lua targethud mainly for dh / dh customs but works in most (all if the game has no custom models) roblox games.

## for you skids here are the settings
```lua
getgenv().targethud = {
    enabled = false, -- Toggle HUD on/off
    maxDistance = 5, -- Maximum distance to detect targets
    defaultHealthColor = Color3.fromRGB(128, 0, 128), -- Default health bar color (purple)
    backgroundTransparency = 0.3, -- Transparency of the outer box
}
```
## heres the loadstring dingalingaling
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Lua-TargetHud/refs/heads/main/targethud.lua"))()
```
