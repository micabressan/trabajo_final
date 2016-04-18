# -*- coding: utf-8 -*-

import os
from sklearn.feature_extraction.text import CountVectorizer


path = '/home/mica/trabajo_final/codes/'
files_list = []
dir_list = os.walk(path)

for root, dirs, files in dir_list:
    for thing in files:
        (name, extension) = os.path.splitext(thing)
        files_list.append(name + extension)

dataset = []
separado = []

for files in files_list:
    code = open('/home/mica/trabajo_final/codes/' + files, "r")
    languaje = files.split(".")[-1]
    content = code.read()
    dataset.append([content, languaje])
    #ver desde aca
    lines = code.readline()
    temporal = []
    while lines != "":
        temporal.append(content)
        lines = code.readline()
print dataset[0][0]
print separado


vectorizer = CountVectorizer(dataset[0][0])
tf = vectorizer.fit_transform(separado).toarray()
lista = []
lista.append([separado[0], int(tf[0])])
print vectorizer.input
print tf
print lista




