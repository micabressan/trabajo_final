from util import load_data
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfTransformer

if __name__ == '__main__':
    X, y = load_data('codes_prueba')
    count_vec = CountVectorizer()

    data = count_vec.fit(X)
    id_dbo= data.vocabulary_['dbo']

    data = count_vec.fit_transform(X)
    print id_dbo, data[(0, id_dbo)],  data[(1, id_dbo)]

    data = count_vec.fit_transform(X)
    print data
    data = TfidfTransformer(use_idf=True).fit_transform(data)


    print data
