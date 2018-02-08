#!/usr/bin/python

import re


def string(text):
    comment_characters = ['\'', '"']
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
    comment_characters = [('/\*', '\*/'),('<!--', '-->'), ('/\+', '\+/'),
                        ('"""', '"""'), ('\'\'\'', '\'\'\''), ('{-', '-}'),
                        ('--\[\[', '\]\]'), ('###', '###'), ('\(comment', '\)'),
                        ('=begin', '=cut'), ('=begin', '=end')]
    for begin, end in comment_characters:
        regular_expresion = begin + '([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*' + end
        text = re.sub(regular_expresion, 'COMMENT', text)
    return text


def preprocessor(x):
    x = re.sub('\d+', 'NUMBER', x)
    return string(x)
