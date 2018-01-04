# -*- coding: utf-8 -*-

import os
from sklearn.feature_extraction.text import CountVectorizer
from keywords import *


path = '/home/mica/trabajo_final/codes/'
files_list = []
dir_list = os.walk(path)

for root, dirs, files in dir_list:
    for thing in files:
        (name, extension) = os.path.splitext(thing)
        files_list.append(name + extension)

content = []
languaje = []

for files in files_list:
    code = open('/home/mica/trabajo_final/codes/' + files, "r")
    languaje.append(files.split(".")[-1])
    content.append(code.read())


def my_tokenizer(content):

    character = list(set(Python + Java))
    letters = []
    for x in map(chr, range(97, 123)):
        letters.append(x)
    for y in map(chr, range(65, 91)):
        letters.append(y)

    for element in content:
        if element not in character:
            content.replace(letter, '')

    return content.split()


vectorizer = CountVectorizer(tokenizer=my_tokenizer)
vectorizer.fit_transform(content)
#print set(vectorizer.vocabulary_)

if __name__ == '__main__':
    character = list(set(Python + Java))
    print character
