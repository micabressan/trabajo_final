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


classifiers = [
    # AdaBoostClassifier(), #Descartado en la 1er ejecucion
    # BaggingClassifier(),
    # BernoulliNB(), #Descartado en la 1er ejecucion
    # CalibratedClassifierCV(),
    # DecisionTreeClassifier(), #Descartad en la 1er ejecucion
    # ExtraTreesClassifier(),
    # GaussianNB(), #Descartad en la 1er ejecucion
    # ExtraTreeClassifier(), #Descartad en la 1er ejecucion
    # GradientBoostingClassifier(),
    # KNeighborsClassifier(), #Descartad en la 1er ejecucion
    # #LabelPropagation(), #Descartad en la 1er ejecucion
    # #LabelSpreading(), #Descartad en la 1er ejecucion
    # LinearDiscriminantAnalysis(), #Descartad en la 1er ejecucion
    # LinearSVC(),
    # LogisticRegression(), #Descartad en la 1er ejecucion
    # LogisticRegressionCV(),
    # MLPClassifier(),
    MultinomialNB(),
    # NearestCentroid(), #Descartad en la 1er ejecucion
    # NuSVC(nu=0.3), #Descartad en la 1er ejecucion
    # PassiveAggressiveClassifier(), #Descartad en la 1er ejecucion
    # Perceptron(), #Descartad en la 1er ejecucion
    # QuadraticDiscriminantAnalysis(), #Descartad en la 1er ejecucion
    # RadiusNeighborsClassifier(radius=1.1), #Descartad en la 1er ejecucion
    # RidgeClassifier(), #Descartad en la 1er ejecucion
    # RandomForestClassifier(),
    # RidgeClassifierCV(), #Descartad en la 1er ejecucion
    # SVC(), #Descartad en la 1er ejecucion
    SGDClassifier(penalty='l2')
    ]


if __name__ == "__main__":
    from sklearn.base import ClassifierMixin
    from sklearn.utils.testing import all_estimators
    for e in [est[1] for est in all_estimators() if issubclass(est[1], ClassifierMixin)]:
        print e
