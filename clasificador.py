from util import *
from sklearn.pipeline import Pipeline
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfTransformer
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn import metrics
from clasificadores import classifiers
from sklearn.base import TransformerMixin
from sklearn import preprocessing
from preprocessor import preprocessor



class DenseTransformer(TransformerMixin):

    def transform(self, X, y=None, **fit_params):
        return X.todense()

    def fit_transform(self, X, y=None, **fit_params):
        self.fit(X, y, **fit_params)
        return self.transform(X)

    def fit(self, X, y=None, **fit_params):
        return self


if __name__ == '__main__':

    X, y = load_data_folder('codes')

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

    #Grid Search
    #parameters = {

                #'vect__ngram_range': [(1, 2)],
                #'tfidf__use_idf': (True, False),
                # 'clf__loss' : ['log', 'hinge', 'modified_huber', 'squared_hinge',
                #         'perceptron', 'squared_loss', 'huber',
                #         'epsilon_insensitive', 'squared_epsilon_insensitive'],
                #'clf__penalty' : ['l2', 'l1', 'elasticnet'],
                #'clf__alpha': (1e-2, 1e-3),
                #'clf__l1_ratio' : ,
                #'clf__fit_intercept' : [False, True],
                #'clf__max_iter' : ,
                #'clf__tol' : ,
                #'clf__shuffle' : [False, True],
                #'clf__verbose' : ,
                #'clf__epsilon' : ,
                #'clf__n_jobs' : ,
                #'clf__random_state' : ,
                #'clf__learning_rate' : ['constant', 'optimal', 'invscaling'],
                #'clf__eta0' : ,
                #'clf__power_t' : ,
                #'clf__class_weight' : ,
                #'clf__warm_start' : [False, True],
                #'clf__average' : [False, True]
                #'clf__n_iter' :
                #}

    #Etiqueta con numeros los lenguajes
    #le = preprocessing.LabelEncoder()
    #le.fit(y_train)
    #y_train = le.transform(y_train)
    #y_test = le.transform(y_test)

    for model in classifiers:
        print model.__str__()
        text_clf = Pipeline(
            [
                ('vect', CountVectorizer(min_df=1, preprocessor=preprocessor, ngram_range=(1,2))),
                ('tfidf', TfidfTransformer(use_idf=True)),
                #('to_dense', DenseTransformer()),
                ('clf', model),])

        #Grid search
        # gs_clf = GridSearchCV(text_clf, parameters, n_jobs=-1)
        # gs_clf.fit(X_train, y_train)
        # predicted = gs_clf.predict(X_test)

        text_clf.fit(X_train, y_train)
        predicted = text_clf.predict(X_test)
        print(metrics.accuracy_score(predicted, y_test))

        #Grid search
        # print gs_clf.best_score_
        # for param_name in sorted(parameters.keys()):
        #     print("%s: %r" % (param_name, gs_clf.best_params_[param_name]))
