import turtle
import time
import random
import os
import shutil
import urllib.request
from PIL import Image

# Safe path for all Windows users
folder = os.path.join(os.environ["LOCALAPPDATA"], "Images")

if not os.path.exists(folder):
    os.makedirs(folder)

url = "https://media.gq.com/photos/5fbd3397fff3e5e56de13fc1/16:9/w_2240,c_limit/Riz_Playlist.jpg"
image_path = os.path.join(folder, "Rock.png")

try:
    urllib.request.urlretrieve(url, image_path)
except:
    pass

img = Image.open(image_path).convert("RGBA")
w, h = img.size

screen = turtle.Screen()
canvas = screen.getcanvas()
root = canvas.winfo_toplevel()
root.overrideredirect(1)
screen.bgcolor("black")
screen.tracer(0, 0)

drawer = turtle.Turtle()
drawer.hideturtle()
drawer.penup()

REVEAL_TIME = 2.0
CHUNKS = 800
DELAY = REVEAL_TIME / CHUNKS
PATCH_SIZE = 120

coords = []
for _ in range(CHUNKS):
    x = random.randint(0, w - PATCH_SIZE)
    y = random.randint(0, h - PATCH_SIZE)
    coords.append((x, y))
random.shuffle(coords)

for i, (x, y) in enumerate(coords):
    patch = img.crop((x, y, x + PATCH_SIZE, y + PATCH_SIZE))
    filename = os.path.join(folder, f"_patch{i}.gif")
    patch.convert("P", palette=Image.ADAPTIVE).save(filename)
    try:
        screen.register_shape(filename)
    except:
        pass
    drawer.shape(filename)
    tx = x - w // 2
    ty = (h // 2) - y
    drawer.goto(tx, ty)
    drawer.stamp()
    screen.update()
    time.sleep(DELAY)

full_gif = os.path.join(folder, "_full.gif")
img.convert("P", palette=Image.ADAPTIVE).save(full_gif)
try:
    screen.register_shape(full_gif)
except:
    pass
drawer.shape(full_gif)
drawer.goto(0, 0)
drawer.hideturtle()
screen.update()

text_turtle = turtle.Turtle()
text_turtle.hideturtle()
text_turtle.penup()
text_turtle.pencolor("Grey")


text_turtle.goto(-460, 350)
text_turtle.write("You Have Been Hacked!", align="center", font=("Arial", 22, "bold"))

text_turtle.goto(460, 350)
text_turtle.write("- Colt 45's Studio's", align="center", font=("Arial", 22, "bold"))

screen.update()
time.sleep(5)

turtle.bye()

try:
    shutil.rmtree(folder)
except:
    pass
