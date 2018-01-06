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

    words = list(set(Python + Java))
    letters = [x for x in map(chr, range(97, 123))] +
            [y for y in map(chr, range(65, 91))]

    new_content = ''
    for element in content:
        if element not in letters:
            new_content = new_content + ' '
        else:
            new_content = new_content + element

    return [w for w in new_content.split() if w in words]

vectorizer = CountVectorizer(tokenizer=my_tokenizer)
vectorizer.fit_transform(content)
#print set(vectorizer.vocabulary_)

if __name__ == '__main__':
    character = list(set(Python + Java))
    print character
