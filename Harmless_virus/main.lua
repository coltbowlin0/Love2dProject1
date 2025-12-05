local ffi = require("ffi")

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
bool SystemParametersInfoA(unsigned int uiAction, unsigned int uiParam, void* pvParam, unsigned int fWinIni);
]]

local HWND_TOPMOST = ffi.cast("HWND", -1)
local SWP_NOMOVE   = 0x0002
local SWP_NOSIZE   = 0x0001
local SWP_SHOWWINDOW = 0x0040
local SPI_GETWORKAREA = 0x0030

---------------------------------------------------

local x, y = 200, 200
local vx, vy = 250, 180
local hwnd
local workAreaW, workAreaH

local quitting = false
local quitTimer = 0

-- PLAYLIST
local playlist = {}
local currentIndex = 1

function love.load()
    love.window.setTitle("Google")
    love.window.setMode(800, 600, { resizable = false, borderless = true })

    hwnd = ffi.C.GetActiveWindow()

    font = love.graphics.newFont(30)
    love.graphics.setFont(font)

    image = {
        sprite = love.graphics.newImage("sprites/pixilsmile.png"),
        sprite2 = love.graphics.newImage("sprites/pixilsmile2.png")
    }

    -- Load the playlist
    playlist = {
        love.audio.newSource("audio/figureitout.mp3", "stream"),
        love.audio.newSource("audio/feelgoodinc.mp3", "stream"),
        love.audio.newSource("audio/CantStop.mp3", "stream")
    }

    -- Start first song
    playlist[currentIndex]:play()

    local rect = ffi.new("RECT")
    ffi.C.SystemParametersInfoA(SPI_GETWORKAREA, 0, rect, 0)
    workAreaW = rect.right - rect.left
    workAreaH = rect.bottom - rect.top
end

---------------------------------------------------

local function updateMusic()
    local current = playlist[currentIndex]

    -- If music finished, go to next
    if not current:isPlaying() then
        currentIndex = currentIndex + 1
        if currentIndex > #playlist then
            currentIndex = 1 -- loop back to start
        end

        playlist[currentIndex]:play()
    end
end

---------------------------------------------------

function love.update(dt)
    if quitting then
        quitTimer = quitTimer + dt

        -- stop all music on the first frame of quitting
        if quitTimer == dt then
            for i = 1, #playlist do
                playlist[i]:stop()
            end
        end

        if quitTimer >= 5 then
            love.event.quit()
        end
        return
    end

    updateMusic()

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

---------------------------------------------------

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

---------------------------------------------------

function love.quit()
    if not quitting then
        quitting = true
        quitTimer = 0
        return true
    end
end
