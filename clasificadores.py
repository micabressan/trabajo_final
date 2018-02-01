from sklearn.utils.testing import all_estimators
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

classifiers = [
    SGDClassifier(),
    #RidgeClassifier(),
    #RidgeClassifierCV(),
    Perceptron(),
    PassiveAggressiveClassifier(),
    #GaussianProcessClassifier(1.0 * RBF(1.0)),
    DecisionTreeClassifier(),
    ExtraTreeClassifier(),
    ExtraTreesClassifier(),
    RandomForestClassifier(),
    #MLPClassifier(),
    #GaussianNB(),
    BernoulliNB(),
    #GaussianNB(),
    QuadraticDiscriminantAnalysis(),
    KNeighborsClassifier(),
    LabelPropagation(),
    LabelSpreading(),
    LinearDiscriminantAnalysis(),
    NearestCentroid(),
    RadiusNeighborsClassifier(),
    NuSVC(),
    SVC(),
    GradientBoostingClassifier()
    ]
