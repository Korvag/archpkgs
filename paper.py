#!/usr/bin/python3

import time,os,shutil,subprocess

path = '/home/korvag/wallpapers/'
wall = []


for pat in os.listdir(path):
	if os.path.isfile(os.path.join(path,pat)):
		if pat != 'wallpaper.png':
			wall.append(pat)

while True:
	wallpaper = ''
	wallpaper = wall[0]

	wall.append(wall.pop(0))

	subprocess.call("~/paper.sh '%s'" % wallpaper, shell=True)

	time.sleep(10)
