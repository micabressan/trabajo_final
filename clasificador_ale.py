from util import load_data, load_data_language

from sklearn.pipeline import Pipeline

from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfTransformer

from sklearn.model_selection import train_test_split

from sklearn.naive_bayes import MultinomialNB
from sklearn.linear_model import SGDClassifier
from sklearn.decomposition import TruncatedSVD
from sklearn.svm import LinearSVC

from sklearn import metrics

import re
from keyword import kwlist

def tokenizer(text):
    r = []
    for i in text.split('\n'):
        for j in i.split(' '):
            r.append(j)
    rr = []
    for i in r:
        if i in kwlist:
            rr.append(i)
        else:
            rr.append('Null')

    return rr

def preprocessor(text):
    text = re.sub('\d+', 'NUMBER',
                  re.sub('\".*?\"', 'STRING',
                         re.sub('\'.*?\'', 'STRING', text)))
    text = re.sub('\#.*', 'COMMENT', text)
    text = re.sub('\//.*', 'COMMENT', text)

    return text

#http://scikit-learn.org/stable/modules/feature_extraction.html

if __name__ == '__main__':
    #X, y = load_data_language('codes', ['JavaScript', 'CoffeeScript'])
    X, y = load_data('codes')

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

    text_clf = Pipeline(
        [
            ('vect', CountVectorizer(preprocessor=preprocessor)),
            ('tfidf', TfidfTransformer(use_idf=False)),
            ('clf', SGDClassifier(
                loss='hinge',
                penalty='l2',
                alpha=1e-3,
                random_state=42,
                max_iter=5,
                tol=None)),])

    text_clf.fit(X_train, y_train)
    predicted = text_clf.predict(X_test)
    print(metrics.accuracy_score(predicted, y_test))
    print metrics.classification_report(y_test, predicted)
    print metrics.confusion_matrix(y_test, predicted)



    '''
    count_vect = CountVectorizer(tokenizer=tokenizer)

    #tfidf_transformer = TfidfTransformer()

    X_train_counts = count_vect.fit_transform(X_train)
    #X_train_tfidf = tfidf_transformer.fit_transform(X_train_counts)

    X_test_counts = count_vect.transform(X_test)
    #X_test_tfidf = tfidf_transformer.transform(X_test_counts)

    clf = MultinomialNB().fit(X_train_tfidf, y_train)
    predicted = clf.predict(X_test_tfidf)
    print(metrics.accuracy_score(predicted, y_test))

    clf = LinearSVC().fit(X_train_counts, y_train)
    predicted = clf.predict(X_test_counts)
    print(metrics.accuracy_score(predicted, y_test))

    #print metrics.classification_report(y_test, predicted)
    #print metrics.confusion_matrix(y_test, predicted)


    clf = SGDClassifier(
        loss='hinge', penalty='l2', alpha=1e-3, random_state=42, max_iter=5, tol=None
        ).fit(X_train_counts, y_train)

    predicted = clf.predict(X_test_counts)
    print(metrics.accuracy_score(predicted, y_test))

    #print metrics.classification_report(y_test, predicted)
    #print metrics.confusion_matrix(y_test, predicted)

    '''
