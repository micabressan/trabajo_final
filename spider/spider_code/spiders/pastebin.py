from scrapy import Spider, Request
import urlparse


class TrabajoFinalSpider(Spider):
    name = 'TrabajoFinal'
    allowed_domains = ['pastebin.com']

    start_urls = [
        "https://pastebin.com/archive/c/", # .c
        "https://pastebin.com/archive/cpp/", # .cpp
        "https://pastebin.com/archive/csharp/", # .cs
        "https://pastebin.com/archive/clojure/", # .clj
        "https://pastebin.com/archive/coffeescript/", # .coffee
        "https://pastebin.com/archive/css/", # .css
        "https://pastebin.com/archive/d", # .d
        "https://pastebin.com/archive/diff/",
        "https://pastebin.com/archive/erlang/", # .erl, .hrl
        "https://pastebin.com/archive/go", # .go
        "https://pastebin.com/archive/groovy", # .groovy
        "https://pastebin.com/archive/haskell/", # .hs
        "https://pastebin.com/archive/java/", # .java, .jar
        "https://pastebin.com/archive/javascript/", # .js
        "https://pastebin.com/archive/json/", # .json
        "https://pastebin.com/archive/lua/", # .lua
        "https://pastebin.com/archive/markdown", # .md
        "https://pastebin.com/archive/nginx",
        "https://pastebin.com/archive/php/", # .php
        "https://pastebin.com/archive/perl/", # .pl
        "https://pastebin.com/archive/python/", # .py
        "https://pastebin.com/archive/ruby/", # .rb
        "https://pastebin.com/archive/rust/", # .rs
        "https://pastebin.com/archive/scala/", # .scala, .sc
        "https://pastebin.com/archive/smalltalk/", # .st
        "https://pastebin.com/archive/sql/", # .sql
        "https://pastebin.com/archive/vbscript/", # .vbs
        "https://pastebin.com/archive/xml/", # .xml
        "https://pastebin.com/archive/yaml", # .yml
    ]

    def parse(self, response):
        to_parse = response.xpath(
            '//*[@id="content_left"]/div[7]/table/tr/td[1]/a/@href'
        ).extract()

        for x in to_parse:
            yield Request(urlparse.urljoin("http://pastebin.com", x),
                          callback=self.parse_code)

    def parse_code(self, response):
        code = response.xpath('//*[@id="paste_code"]/text()').extract()[0]
        random_string = response.url.split("/")[-1]
        language = response.xpath('//*[@id="code_buttons"]/span[2]/a/text()').extract()[0]
        filename = 'codes/' + random_string + '.' + language

        with open(filename, 'wb') as f:
            f.write(code.encode('UTF-8'))
