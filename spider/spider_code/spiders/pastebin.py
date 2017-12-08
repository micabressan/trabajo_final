from scrapy import Spider, Request
import urlparse


class TrabajoFinalSpider(Spider):
    name = 'TrabajoFinal'
    allowed_domains = ['pastebin.com']

    start_urls = [
        "https://pastebin.com/archive/c/",
        "https://pastebin.com/archive/cpp/",
        "https://pastebin.com/archive/csharp/",
        "https://pastebin.com/archive/clojure/",
        "https://pastebin.com/archive/coffeescript/",
        "https://pastebin.com/archive/css/",
        "https://pastebin.com/archive/d",
        "https://pastebin.com/archive/diff/",
        "https://pastebin.com/archive/erlang/",
        "https://pastebin.com/archive/go",
        "https://pastebin.com/archive/groovy",
        "https://pastebin.com/archive/haskell/",
        "https://pastebin.com/archive/java/",
        "https://pastebin.com/archive/javascript/",
        "https://pastebin.com/archive/json/",
        "https://pastebin.com/archive/lua/",
        "https://pastebin.com/archive/markdown",
        "https://pastebin.com/archive/nginx",
        "https://pastebin.com/archive/php/",
        "https://pastebin.com/archive/perl/",
        "https://pastebin.com/archive/python/",
        "https://pastebin.com/archive/ruby/",
        "https://pastebin.com/archive/rust/",
        "https://pastebin.com/archive/scala/",
        "https://pastebin.com/archive/smalltalk/",
        "https://pastebin.com/archive/sql/",
        "https://pastebin.com/archive/vbscript/",
        "https://pastebin.com/archive/xml/",
        "https://pastebin.com/archive/yaml",
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
