#-*-coding: utf-8-*-

from scrapy import Spider, Request
import urlparse
#from spider.items import FinalWorkItems


class TrabajoFinalSpider(Spider):
    name = 'TrabajoFinal'
    allowed_domains = ['pastebin.com']

    start_urls = [
        "http://pastebin.com/archive/c/",
        "http://pastebin.com/archive/cpp/",
        "http://pastebin.com/archive/csharp/",
        "http://pastebin.com/archive/clojure/",
        "http://pastebin.com/archive/coffeescript/",
        "http://pastebin.com/archive/css/",
        "http://pastebin.com/archive/diff/",
        "http://pastebin.com/archive/erlang/",
        "http://pastebin.com/archive/haskell/",
        "http://pastebin.com/archive/java/",
        "http://pastebin.com/archive/javascript/",
        "http://pastebin.com/archive/json/",
        "http://pastebin.com/archive/lua/",
        "http://pastebin.com/archive/php/",
        "http://pastebin.com/archive/perl/",
        "http://pastebin.com/archive/python/",
        "http://pastebin.com/archive/ruby/",
        "http://pastebin.com/archive/rust/",
        "http://pastebin.com/archive/scala/",
        "http://pastebin.com/archive/smalltalk/",
        "http://pastebin.com/archive/sql/",
        "http://pastebin.com/archive/vbscript/",
        "http://pastebin.com/archive/xml/",
    ]

    def parse(self, response):
        to_parse = response.xpath(
            '//*[@id="content_left"]/div[4]/table/tr/td[1]/a/@href'
        ).extract()
        for x in to_parse:
            yield Request(urlparse.urljoin("http://pastebin.com", x),
                          callback=self.parse_code)

    def parse_code(self, response):
        syntax = response.xpath(
            '//*[@id="content_left"]/div[1]/div[3]/div[2]/a[contains(@href, "archive")]/text()'
        ).extract()[0]

        l = response.css('#paste_code::text').extract()
        assert len(l) == 1
        code = l[0]
        filename = 'codes/' + response.url.split("/")[-1] + '.' + syntax
        with open(filename, 'wb') as f:
            f.write(code.encode('UTF-8'))
