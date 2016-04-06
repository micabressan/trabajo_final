# -*- coding: utf-8 -*-

import os


path = '/home/mica/trabajo_final/codes/'
files_list = []
dir_list = os.walk(path)

for root, dirs, files in dir_list:
    for thing in files:
        (name, extension) = os.path.splitext(thing)
        files_list.append(name + extension)

dataset = []

for files in files_list:
    code = open(files, "r")
    languaje = files.split(".")[-1]
    content = code.read()
    dataset.append((content, languaje))
    print("contenido:", content)
    print("lenguaje:", languaje)


