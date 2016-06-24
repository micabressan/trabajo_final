import os
import numpy as np
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.linear_model import SGDClassifier
from sklearn.svm import LinearSVC
from sklearn.pipeline import make_pipeline, make_union
from sklearn.cross_validation import train_test_split
from sklearn.metrics import accuracy_score
from sklearn.cross_validation import cross_val_score
from random import shuffle


def load_data():
    "returns a (X, y) readed from codes folder"
    X = []
    y = []
    for f in os.listdir('codes'):
        text = open(os.path.join('codes', f)).read()
        syntax = f.split('.')[-1]
        X.append(text)
        y.append(syntax.lower())
    return (X, y)


def make_dataset(X, y, target_language):
    data = []
    no_targets = []
    for x, t in zip(X, y):
        if t == target_language:
            data.append((x, 1))
        else:
            no_targets.append((x, 0))
    shuffle(no_targets)
    data.extend(no_targets[:len(data)])
    shuffle(data)
    return list(zip(*data))


if __name__ == '__main__':
    _X, _y = load_data()
    X, y = make_dataset(_X, _y, 'python')

    pipe = make_pipeline(
        CountVectorizer(ngram_range=(1, 1),
                        token_pattern='(?u)\\b\\w\\w+\\b|\:|\;|\"|\'|#'),
        LinearSVC()
    )

    sc = cross_val_score(pipe, X, y, cv=8)
    print(sc)
    print(sum(sc)/len(sc))

    X_train, y_train, X_val, y_val = train_test_split(X, y, test_size=0.1)
    pipe.fit(X_train, y_train)

    p = pipe.predict(X_val)

    for x, y, p in zip(X_val, y_val, p):
        print ('='*80)
        print (y, p)
        print (x)

