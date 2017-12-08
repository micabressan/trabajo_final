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

def languajes(folder):
    return set([file_name.split('.')[-1] for file_name in os.listdir(folder)])

def languajes_file_frecuency(folder):
    for languaje in languajes(folder):
        frecuency = len(fnmatch.filter(os.listdir(folder), '*.' + languaje))
        print languaje, frecuency

if __name__ == '__main__':
    print languajes_file_frecuency('codes')
