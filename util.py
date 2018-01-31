import os
import fnmatch
import re
import shutil
import uuid
import codecs


def load_data(folder, n):
    "returns a (X, y) readed from codes folder"
    X = []
    y = []
    
    q = {}

    for f in os.listdir(folder):
        text = unicode(open(os.path.join(folder, f)).read(), errors='ignore')
        syntax = f.split('.')[-1].lower()
        
        if syntax not in q.keys():
            q[syntax] = 0
            
        if q[syntax] < n:
            q[syntax] = q[syntax] + 1 
            X.append(text)
            y.append(syntax)

    return (X, y)

def load_data_language(folder, languages):
    "returns a (X, y) readed from codes folder"
    X = []
    y = []

    for f in os.listdir(folder):
        text = open(os.path.join(folder, f)).read()
        syntax = f.split('.')[-1]

        if syntax not in languages:
            continue

        X.append(text)
        y.append(syntax.lower())

    return (X, y)

def languages(folder):
    return set([file_name.split('.')[-1] for file_name in os.listdir(folder)])

def languages_file_frecuency(folder, language=None):
    if language:
        frecuency = len(fnmatch.filter(os.listdir(folder), '*.' + language))
        print language, frecuency
        return abs
    for language in languages(folder):
        frecuency = len(fnmatch.filter(os.listdir(folder), '*.' + language))
        print language, frecuency

def string(text):
    comment_characters = ['\'', '"']
    for character in comment_characters:
        regular_expresion = character + '.*'
        text = re.sub(regular_expresion, 'STRING', text)
    return text

def one_line_comment(text):
    #agregar todos los caracteres de comentario
    comment_characters = ['#', '//', '--', '\*', '%']
    for character in comment_characters:
        regular_expresion = character + '.*'
        text = re.sub(regular_expresion, 'COMMENT', text)
    return text

def multiline_comment(text):
    #agregar todos los pares de caracteres de comentario
    comment_characters = [('/\*', '\*/'),('<!--', '-->')]
    for begin, end in comment_characters:
        regular_expresion = begin + '([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*' + end
        text = re.sub(regular_expresion, 'COMMENT', text)
    return text


def move_files(origin_folder, destination_folder, language, extension):

    destination = os.path.join(destination_folder, language)
    if not os.path.exists(destination):
        os.makedirs(destination)

    dir_list = os.walk(origin_folder)

    files_to_move = [os.path.join(root,file) for root, dirs, files in dir_list for file in files if file.split('.')[-1]==extension]

    for origin in files_to_move:
        if os.stat(origin).st_size > 1024:
            file_name = uuid.uuid4().hex + '.' + language
            shutil.move(origin, os.path.join(destination,file_name))


if __name__ == '__main__':
    X, y = load_data('codes', 1)
    