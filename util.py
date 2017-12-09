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

def languages_file_frecuency(folder):
    for language in languages(folder):
        frecuency = len(fnmatch.filter(os.listdir(folder), '*.' + language))
        print language, frecuency

if __name__ == '__main__':
    print languages_file_frecuency('codes')

    print 'abstract assert boolean break byte case catch char class const continue default do double else enum extends final finally float for goto if implements import instanceof int interface long native new package private protected public return short static strictfp super switch synchronized this throw throws transient try void volatile while'.split(' ')
