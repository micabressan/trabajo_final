from util import load_data
from sklearn.feature_extraction.text import TfidfTransformer
from sklearn.feature_extraction.text import CountVectorizer

from sklearn.model_selection import train_test_split
from sklearn import metrics

from clasificadores import classifiers

if __name__ == '__main__':

    print ('cargando datos ... ')

    X, y = load_data('codes', 500)
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

    print ('normalizando ... ')

    count_vect = CountVectorizer()

    X_train_counts = count_vect.fit_transform(X_train)
    X_train_tf = TfidfTransformer(use_idf=False).fit_transform(X_train_counts)

    for model in classifiers:

        print ('entremando ... ')
        print (model.__str__())
        clf = model.fit(X_train_tf, y_train)


        print ('normalizando pruebas ... ')
        X_test_counts = count_vect.transform(X_test)
        X_test_tf = TfidfTransformer(use_idf=False).transform(X_test_counts)

        print ('predicciones ... ')
        predicted = clf.predict(X_test_tf)
        print(metrics.accuracy_score(predicted, y_test))

        X_test_counts = None
        X_test_tf = None
        predicted = None
        model = None
