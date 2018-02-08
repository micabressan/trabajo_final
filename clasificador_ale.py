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

    parameters = {'loss' : ['log', 'hinge', 'modified_huber', 'squared_hinge',
                        'perceptron', 'squared_loss', 'huber', #ver
                        'epsilon_insensitive', 'squared_epsilon_insensitive'],
                'penalty' : ['l2', 'l1', 'elasticnet'],
                'alpha' : ,
                'l1_ratio' : ,
                'fit_intercept' : [False, True],
                'max_iter' : ,
                'tol' : ,
                'shuffle' : ,
                'verbose' : ,
                'epsilon' : ,
                'n_jobs' : ,
                'random_state' : ,
                'learning_rate' : ,
                'eta0' : ,
                'power_t' : ,
                'class_weight' : ,
                'warm_start' : ,
                'average' : ,
                'n_iter' : }

    #descomentar para probar LabelPropagation y LabelSpreading
    #le = preprocessing.LabelEncoder()
    #le.fit(y_train)
    #y_train = le.transform(y_train)
    #y_test = le.transform(y_test)

    for model in classifiers:
        print model.__str__()
        text_clf = Pipeline(
            [
                ('vect', CountVectorizer(min_df=1, preprocessor=preprocessor)),
                ('tfidf', TfidfTransformer(use_idf=False)),
                #('to_dense', DenseTransformer()),
                ('clf', model),])

        text_clf.fit(X_train, y_train)
        predicted = text_clf.predict(X_test)
        print(metrics.accuracy_score(predicted, y_test))
        #print metrics.classification_report(y_test, predicted)
        #print metrics.confusion_matrix(y_test, predicted)
