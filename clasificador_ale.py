from util import load_data, load_data_language

from sklearn.pipeline import Pipeline
import numpy as np
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfTransformer
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.datasets import make_moons, make_circles, make_classification


from sklearn.neural_network import MLPClassifier
from sklearn.neighbors import KNeighborsClassifier, NearestCentroid, RadiusNeighborsClassifier
from sklearn.svm import SVC, LinearSVC, NuSVC
from sklearn.gaussian_process import GaussianProcessClassifier
from sklearn.gaussian_process.kernels import RBF
from sklearn.tree import DecisionTreeClassifier, ExtraTreeClassifier
from sklearn.ensemble import RandomForestClassifier, ExtraTreesClassifier, GradientBoostingClassifier
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis, LinearDiscriminantAnalysis
from sklearn.naive_bayes import BernoulliNB, GaussianNB
from sklearn.semi_supervised import LabelSpreading, LabelPropagation
from sklearn.linear_model import LogisticRegression, LogisticRegressionCV, RidgeClassifier, RidgeClassifierCV, SGDClassifier, Perceptron, PassiveAggressiveClassifier

from sklearn.model_selection import train_test_split

from sklearn.decomposition import TruncatedSVD

from sklearn import metrics

import re
from keyword import kwlist

from keywords import *

def my_tokenizer(content):

    words = list(set(Python + Java))
    letters = [x for x in map(chr, range(97, 123))] + [y for y in map(chr, range(65, 91))]


    new_content = ''
    for element in content:
        if element not in letters:
            new_content = new_content + ' '
        else:
            new_content = new_content + element

    return [w for w in new_content.split() if w in words]



'''
def string(text):
    comment_characters = ['\'', '"'] #Ver que se cierran esas comillas
    for character in comment_characters:
        regular_expresion = character + '.*?' + character
        text = re.sub(regular_expresion, 'STRING', text)
    return text

def one_line_comment(text):
    comment_characters = ['#', '//', '--', '\*', '%']
    for character in comment_characters:
        regular_expresion = character + '.*'
        text = re.sub(regular_expresion, 'COMMENT', text)
    return text

def multiline_comment(text):
    #agregar todos los pares de caracteres de comentario
    comment_characters = [('/\*', '\*/'),('<!--', '-->'), ('/\+', '\+/'), ('"""', '"""'), ('\'\'\'', '\'\'\''), ('{-', '-}'), ('--\[\[', '\]\]'), ('###', '###'), ('\(comment', '\)')]
    for begin, end in comment_characters:
        regular_expresion = begin + '([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*' + end
        text = re.sub(regular_expresion, 'COMMENT', text)
    return text

def preprocessor(text):
    text = re.sub('\d+', 'NUMBER', text)
    return string(one_line_comment(multiline_comment(text)))

    return text

#http://scikit-learn.org/stable/modules/feature_extraction.html
'''
if __name__ == '__main__':
    X, y = load_data_language('codes')
    #X, y = load_data('codes')

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

    classifiers = [
        SGDClassifier( loss='hinge', penalty='l2', alpha=1e-3),
        RidgeClassifier(),
        RidgeClassifierCV(),
        Perceptron(),
        PassiveAggressiveClassifier(),
        GaussianProcessClassifier(1.0 * RBF(1.0)),
        DecisionTreeClassifier(),
        ExtraTreeClassifier(),
        ExtraTreesClassifier(),
        RandomForestClassifier(),
        MLPClassifier(),
        GaussianNB(),
        BernoulliNB(),
        GaussianNB(),
        QuadraticDiscriminantAnalysis(),
        KNeighborsClassifier(),
        LabelPropagation(),
        LabelSpreading(),
        LinearDiscriminantAnalysis(),
        LinearSVC (setting multi_class=”crammer_singer”),
        LogisticRegression (setting multi_class=”multinomial”),
        LogisticRegressionCV (setting multi_class=”multinomial”),
        NearestCentroid(),
        RadiusNeighborsClassifier(),
        NuSVC(),
        SVC(),
        GradientBoostingClassifier(),
        LinearSVC (setting multi_class=”ovr”),
        LogisticRegression (setting multi_class=”ovr”),
        LogisticRegressionCV (setting multi_class=”ovr”)
        ]

    for c in classifiers:

        print c
        text_clf = Pipeline(
            [
                ('vect', CountVectorizer()),
                ('tfidf', TfidfTransformer(use_idf=False)),
                ('clf', c),])

        text_clf.fit(X_train, y_train)
        predicted = text_clf.predict(X_test)
        print(metrics.accuracy_score(predicted, y_test))
        #print metrics.classification_report(y_test, predicted)
        #print metrics.confusion_matrix(y_test, predicted)
