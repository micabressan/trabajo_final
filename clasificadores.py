from sklearn.ensemble.weight_boosting import AdaBoostClassifier
from sklearn.ensemble.bagging import BaggingClassifier
from sklearn.naive_bayes import BernoulliNB
from sklearn.calibration import CalibratedClassifierCV
from sklearn.tree.tree import DecisionTreeClassifier
from sklearn.ensemble.forest import ExtraTreesClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.tree.tree import ExtraTreeClassifier
from sklearn.gaussian_process.gpc import GaussianProcessClassifier
from sklearn.ensemble.gradient_boosting import GradientBoostingClassifier
from sklearn.neighbors.classification import KNeighborsClassifier
from sklearn.semi_supervised.label_propagation import LabelPropagation
from sklearn.semi_supervised.label_propagation import LabelSpreading
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.svm.classes import LinearSVC
from sklearn.linear_model.logistic import LogisticRegression
from sklearn.linear_model.logistic import LogisticRegressionCV
from sklearn.neural_network.multilayer_perceptron import MLPClassifier
from sklearn.naive_bayes import MultinomialNB
from sklearn.neighbors.nearest_centroid import NearestCentroid
from sklearn.svm.classes import NuSVC
from sklearn.linear_model.passive_aggressive import PassiveAggressiveClassifier
from sklearn.linear_model.perceptron import Perceptron
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis
from sklearn.neighbors.classification import RadiusNeighborsClassifier
from sklearn.linear_model.ridge import RidgeClassifier
from sklearn.ensemble.forest import RandomForestClassifier
from sklearn.linear_model.ridge import RidgeClassifierCV
from sklearn.svm.classes import SVC
from sklearn.linear_model.stochastic_gradient import SGDClassifier

'''
from sklearn.utils.testing import all_estimators
from sklearn.neural_network import MLPClassifier
from sklearn.neighbors import KNeighborsClassifier, NearestCentroid, RadiusNeighborsClassifier
from sklearn.svm import SVC, LinearSVC, NuSVC
from sklearn.gaussian_process import GaussianProcessClassifier
from sklearn.gaussian_process.kernels import RBF
from sklearn.tree import DecisionTreeClassifier, ExtraTreeClassifier
from sklearn.ensemble import RandomForestClassifier, ExtraTreesClassifier, GradientBoostingClassifier
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis, LinearDiscriminantAnalysis
from sklearn.naive_bayes import BernoulliNB, GaussianNB, MultinomialNB
from sklearn.semi_supervised import LabelSpreading, LabelPropagation
from sklearn.linear_model import LogisticRegression, LogisticRegressionCV, RidgeClassifier, RidgeClassifierCV, SGDClassifier, Perceptron, PassiveAggressiveClassifier

classifiers_old = [
    MultinomialNB()
    #SGDClassifier(),
    #RidgeClassifier(),
    #RidgeClassifierCV(),
    #Perceptron(),
    #PassiveAggressiveClassifier(),
    #GaussianProcessClassifier(1.0 * RBF(1.0)),
    #DecisionTreeClassifier(),
    #ExtraTreeClassifier(),
    #ExtraTreesClassifier(),
    #RandomForestClassifier(),
    #MLPClassifier(),
    #GaussianNB(),
    #BernoulliNB(),
    #GaussianNB(),
    #QuadraticDiscriminantAnalysis(),
    #KNeighborsClassifier(),
    #LabelPropagation(),
    #LabelSpreading(),
    #LinearDiscriminantAnalysis(),
    #NearestCentroid(),
    #RadiusNeighborsClassifier(),
    #NuSVC(),
    #SVC(),
    #GradientBoostingClassifier()
    ]
'''
classifiers = [
    AdaBoostClassifier(), #anda
    BaggingClassifier(), #anda
    BernoulliNB(), #anda
    CalibratedClassifierCV(), #anda
    DecisionTreeClassifier(), #anda
    ExtraTreesClassifier(), #anda
    GaussianNB(), #anda
    ExtraTreeClassifier(), #anda
    #GaussianProcessClassifier(n_jobs=-1), #andan pero tienen problemas con grandes volumenes
    #GradientBoostingClassifier(), #andan pero tienen problemas con grandes volumenes
    KNeighborsClassifier(), #anda
    #LabelPropagation(), #anda descomentar el codigo
    #LabelSpreading(), #anda descomentar el codigo
    LinearDiscriminantAnalysis(), #anda
    LinearSVC(), #anda
    LogisticRegression(), #anda
    LogisticRegressionCV(), #anda
    MLPClassifier(), #anda
    MultinomialNB(), #anda
    NearestCentroid(), #anda
    NuSVC(nu=0.3),#anda cambiando el parametro a 0.3
    PassiveAggressiveClassifier(), #anda
    Perceptron(),#anda
    QuadraticDiscriminantAnalysis(),#anda
    RadiusNeighborsClassifier(),
    RidgeClassifier(),#anda
    RandomForestClassifier(),#anda
    RidgeClassifierCV(),#anda
    SVC(),#anda
    SGDClassifier()#anda
    ]


if __name__ == "__main__":
    from sklearn.base import ClassifierMixin
    from sklearn.utils.testing import all_estimators
    for e in [est[1] for est in all_estimators() if issubclass(est[1], ClassifierMixin)]:
        print e
