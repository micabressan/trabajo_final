import os
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.svm import LinearSVC
from sklearn.pipeline import make_pipeline
from sklearn.cross_validation import train_test_split
from sklearn.metrics import accuracy_score
from sklearn.linear_model import SGDClassifier
from sklearn.decomposition import TruncatedSVD


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

if __name__ == '__main__':
    X, y = load_data()

    pipe = make_pipeline(
        CountVectorizer(ngram_range=(1, 1),
                        token_pattern='(?u)\\b\\w\\w+\\b|\:|\;|\"|\'|#'),
        LinearSVC()
        # TruncatedSVD(),
        # SGDClassifier()
    )

    X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.2)
    pipe.fit(X_train, y_train)

    p = pipe.predict(X_val)

    print(accuracy_score(p, y_val))
