import os
from util import load_data
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.svm import LinearSVC
from sklearn.pipeline import make_pipeline
from sklearn.cross_validation import train_test_split
from sklearn.metrics import accuracy_score
import re
from sklearn.linear_model import SGDClassifier
from sklearn.decomposition import TruncatedSVD

def string(text):
    comment_characters = ['\'', '"']
    for character in comment_characters:
        regular_expresion = character + '.*'
        text = re.sub(regular_expresion, 'STRING', text)
    return text

def one_line_comment(text):
    #agregar todos los caracteres de comentario
    comment_characters = ['#', '//', '--', '\*', '%']
    for character in comment_characters:
        regular_expresion = character + '.*'
        text = re.sub(regular_expresion, 'COMMENT', text)
    return text

def multiline_comment(text):
    #agregar todos los pares de caracteres de comentario
    comment_characters = [('/\*', '\*/'),('<!--', '-->')]
    for begin, end in comment_characters:
        regular_expresion = begin + '([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*' + end
        print regular_expresion
        text = re.sub(regular_expresion, 'COMMENT', text)
    return text


def preprocessor(x):
    x = re.sub('\d+', 'NUMBER', x)
    return string(one_line_comment(multiline_comment(x)))
    '''
    x = re.sub('\d+', 'NUMBER', x)
    x = re.sub('\".*?\"', 'STRING', x)  # string with ""
    x = re.sub('\'.*?\'', 'STRING', x)  # string with ''
    x = re.sub('\#.*', 'COMMENT', x)    # comment with #
    x = re.sub('\//.*', 'COMMENT', x)   # comment with //
    x = re.sub('\--.*', 'COMMENT', x)   # comment with --
    x = re.sub('\/*.*', 'COMMENT', x)   # comment with /*
    x = re.sub('\;.*', 'COMMENT', x)    # comment with ;
    x = re.sub('\/+.*', 'COMMENT', x)   # comment with /+
    x = re.sub('\%.*', 'COMMENT', x)    # comment with %
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with <!-
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with (comment)
    x = re.sub('\""".*', 'COMMENT', x)  # comment with """ """
    x = re.sub('\'''.*', 'COMMENT', x)  # comment with ''' '''
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with ###
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with {- -}
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with --[[ ]]
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with =begin =cut
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with =begin =end
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with /***/
    return x
    '''
'''
def preprocessor(x):
    x = re.sub('\d+', 'NUMBER', x)
    x = re.sub('\".*?\"', '""' + 'STRING', x)  # string with ""
    x = re.sub('\'.*?\'', "''" + 'STRING', x)  # string with ''
    x = re.sub('\#.*', '#' + 'COMMENT', x)     # comment with #
    x = re.sub('\//.*', '//' + 'COMMENT', x)   # comment with //
    x = re.sub('\--.*', '--' + 'COMMENT', x)   # comment with --
    x = re.sub('\/*.*', '/*' + 'COMMENT', x)   # comment with /*
    x = re.sub('\;.*', ';' + 'COMMENT', x)     # comment with ;
    x = re.sub('\/+.*', 'COMMENT', x)   # comment with /+
    x = re.sub('\%.*', 'COMMENT', x)    # comment with %
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with <!-
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with (comment)
    x = re.sub('\""".*', 'COMMENT', x)  # comment with """ """
    x = re.sub('\'''.*', 'COMMENT', x)  # comment with ''' '''
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with ###
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with {- -}
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with --[[ ]]
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with =begin =cut
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with =begin =end
    x = re.sub('\<!-.*', 'COMMENT', x)  # comment with /***/
    return x
'''
if __name__ == '__main__':

    text = '''

    /*hola
    hola
    hola
    */

    fbdg

    <!--
    fdggh
    fdjfh
    djf
    -->

    con asterisco * f,nkgdsgn

    '''
    print multiline_comment(text)

    '''
    X, y = load_data()

    pipe = make_pipeline(
        CountVectorizer(#ngram_range=(1, 1),
                        #token_pattern='(?u)\\b\\w\\w+\\b|\:|\;|\"|\'|#|{|}|[|]',
                        #preprocessor=preprocessor
                        ),
        LinearSVC()
        # TruncatedSVD(),
        # SGDClassifier()
    )

    X_train, X_val, y_train, y_val = train_test_split(X, y, test_size=0.1)
    pipe.fit(X_train, y_train)

    p = pipe.predict(X_val)

    print(accuracy_score(p, y_val))
    '''
