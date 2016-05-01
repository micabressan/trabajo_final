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

content = []
languaje = []

for files in files_list:
    code = open('/home/mica/trabajo_final/codes/' + files, "r")
    languaje.append(files.split(".")[-1])
    content.append(code.read())

print content[1]
#print languaje[0]



def my_tokenizer(content):
    return content.split()


vectorizer = CountVectorizer(tokenizer=my_tokenizer)
vectorizer.fit_transform(content)
print vectorizer.vocabulary_




