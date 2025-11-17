local ffi = require("ffi")

-- Windows API Definitions
ffi.cdef[[
typedef void* HWND;
typedef struct {
    long left;
    long top;
    long right;
    long bottom;
} RECT;

HWND GetActiveWindow(void);
bool SetWindowPos(HWND hWnd, HWND hWndInsertAfter, int X, int Y, int cx, int cy, unsigned int uFlags);
// Function to get system metrics/info
bool SystemParametersInfoA(unsigned int uiAction, unsigned int uiParam, void* pvParam, unsigned int fWinIni);
]]

-- Constants
local HWND_TOPMOST = ffi.cast("HWND", -1)
local SWP_NOMOVE = 0x0002
local SWP_NOSIZE = 0x0001
local SWP_SHOWWINDOW = 0x0040
local SPI_GETWORKAREA = 0x0030

---------------------------------------------------

local x, y = 200, 200
local vx, vy = 250, 180
local hwnd
local workAreaW, workAreaH
local quitting = false 

function love.load()
    love.window.setTitle("Google")
    love.window.setMode(800, 600, {
        resizable = false,
        borderless = true
    })

    hwnd = ffi.C.GetActiveWindow()

    font = love.graphics.newFont(30)
    love.graphics.setFont(font)

    image = {}
    image.sprite = love.graphics.newImage("sprites/pixilsmile.png")
    image.sprite2 = love.graphics.newImage("sprites/pixilsmile2.png")

    local rect = ffi.new("RECT")
    ffi.C.SystemParametersInfoA(SPI_GETWORKAREA, 0, rect, 0)
    workAreaW = rect.right - rect.left
    workAreaH = rect.bottom - rect.top
end

function love.update(dt)
    x = x + vx * dt
    y = y + vy * dt
    local winW, winH = love.graphics.getDimensions()

    if x < 0 then x = 0 vx = -vx end
    if y < 0 then y = 0 vy = -vy end
    if x + winW > workAreaW then x = workAreaW - winW vx = -vx end
    if y + winH > workAreaH then y = workAreaH - winH vy = -vy end

    love.window.setPosition(x, y)

    ffi.C.SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, 0, 0,
        bit.bor(SWP_NOMOVE, SWP_NOSIZE, SWP_SHOWWINDOW))    
end


function love.draw()
    if quitting then
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("that was a", 10, 10)
        love.graphics.print("mistake.", 10, 40)
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(image.sprite2, 0, 0, 0, 0.75, 0.75)
    else
        love.graphics.print("You are an Idiot.", 10, 10)
        love.graphics.draw(image.sprite, 0, 0, 0, 0.75, 0.75)
    end
end

function love.quit()
    if not quitting then
        quitting = true
        return true 
    else
        return true 
    end
end