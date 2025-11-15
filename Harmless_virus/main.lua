local ffi = require("ffi")

-- Windows API
ffi.cdef[[
typedef void* HWND;
HWND GetActiveWindow(void);
bool SetWindowPos(HWND hWnd, HWND hWndInsertAfter, int X, int Y, int cx, int cy, unsigned int uFlags);
]]

local HWND_TOPMOST = ffi.cast("HWND", -1)
local SWP_NOMOVE = 0x0002
local SWP_NOSIZE = 0x0001
local SWP_SHOWWINDOW = 0x0040

---------------------------------------------------

local x, y = 200, 200
local vx, vy = 250, 180

local hwnd 

function love.load()
    love.window.setTitle("Virus")
    love.window.setMode(800, 600, {
        resizable = false,
        borderless = true
    })

    hwnd = ffi.C.GetActiveWindow()

    font = love.graphics.newFont(30)
    love.graphics.setFont(font)

    image = {}
    image.sprite = love.graphics.newImage("sprites/pixilsmile.png")
end

function love.update(dt)
    x = x + vx * dt
    y = y + vy * dt

    local screenW, screenH = love.window.getDesktopDimensions()
    local winW, winH = love.graphics.getDimensions()

    if x < 0 then x = 0 vx = -vx end
    if y < 0 then y = 0 vy = -vy end
    if x + winW > screenW then x = screenW - winW vx = -vx end
    if y + winH > screenH then y = screenH - winH vy = -vy end

    love.window.setPosition(x, y)

    ffi.C.SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, 0, 0,
        bit.bor(SWP_NOMOVE, SWP_NOSIZE, SWP_SHOWWINDOW))
end

function love.draw()
    love.graphics.print("You are an Idiot.", 10, 10)
    love.graphics.draw(image.sprite, 0, 0, 0, 0.75, 0.75)
end