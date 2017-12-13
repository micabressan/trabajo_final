import os
import fnmatch

def load_data(folder):
    "returns a (X, y) readed from codes folder"
    X = []
    y = []

    for f in os.listdir(folder):
        text = open(os.path.join(folder, f)).read()
        syntax = f.split('.')[-1]

        X.append(text)
        y.append(syntax.lower())

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

if __name__ == '__main__':
    languages_file_frecuency('codes')
