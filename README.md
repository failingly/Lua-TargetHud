## Feel free to use this in a script.

## Settings
```lua
getgenv().targethud = {
    enabled = false, -- Toggle HUD on/off
    maxDistance = 5, -- Maximum distance to detect targets
    defaultHealthColor = Color3.fromRGB(128, 0, 128), -- Default health bar color (purple)
    backgroundTransparency = 0.3, -- Transparency of the outer box
}
```
## Load Target Hud
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Stratxgy/Lua-TargetHud/refs/heads/main/targethud.lua"))()
```
