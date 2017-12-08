from util import load_data

from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfTransformer

from sklearn.model_selection import train_test_split

from sklearn.naive_bayes import MultinomialNB
from sklearn.linear_model import SGDClassifier
from sklearn.decomposition import TruncatedSVD
from sklearn.svm import LinearSVC

from sklearn.metrics import accuracy_score

import numpy as np

if __name__ == '__main__':
    X, y = load_data('codes')

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

    count_vect = CountVectorizer()
    tfidf_transformer = TfidfTransformer()

    X_train_counts = count_vect.fit_transform(X_train)
    X_train_tfidf = tfidf_transformer.fit_transform(X_train_counts)

    X_test_counts = count_vect.transform(X_test)
    X_test_tfidf = tfidf_transformer.transform(X_test_counts)


    clf = MultinomialNB().fit(X_train_tfidf, y_train)
    predicted = clf.predict(X_test_tfidf)
    print np.mean(predicted == y_test)
    print(accuracy_score(predicted, y_test))

    clf = LinearSVC().fit(X_train_tfidf, y_train)
    predicted = clf.predict(X_test_tfidf)
    print np.mean(predicted == y_test)
    print(accuracy_score(predicted, y_test))

    clf = SGDClassifier(loss='hinge', penalty='l2', alpha=1e-3, random_state=42, max_iter=5, tol=None).fit(X_train_tfidf, y_train)
    predicted = clf.predict(X_test_tfidf)
    print(accuracy_score(predicted, y_test))
