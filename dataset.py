# -*- coding: utf-8 -*-

import os, string
from sklearn.feature_extraction.text import CountVectorizer


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

    character = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
                'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
                'y', 'z', ',', '/', '=', '+', '<', '>', '{', '}', '(', ')',
                ';', '|', '"', '.', '[', ']', ':', "'", '!', '@', '#', '%',
                '&', '*']

    for letter in content:
        if letter not in character:
            content.replace(letter, '')

    return content.split()


vectorizer = CountVectorizer(tokenizer=my_tokenizer)
vectorizer.fit_transform(content)
print set(vectorizer.vocabulary_)
