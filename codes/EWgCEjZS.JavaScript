(function(c) {
    var b = {};

    function a(e) {
        if (b[e]) {
            return b[e]['exports'];
        }
        var d = b[e] = {
            'i': e,
            'l': ![],
            'exports': {}
        };
        c[e]['call'](d['exports'], d, d['exports'], a);
        d['l'] = !![];
        return d['exports'];
    }
    a['m'] = c;
    a['c'] = b;
    a['i'] = function(a) {
        return a;
    };
    a['d'] = function(b, c, d) {
        if (!a['o'](b, c)) {
            Object['defineProperty'](b, c, {
                'configurable': ![],
                'enumerable': !![],
                'get': d
            });
        }
    };
    a['n'] = function(b) {
        var c = b && b['__esModule'] ? function a() {
            return b['default'];
        } : function a() {
            return b;
        };
        a['d'](c, 'a', c);
        return c;
    };
    a['o'] = function(a, b) {
        return Object['prototype']['hasOwnProperty']['call'](a, b);
    };
    a['p'] = '';
    return a(a['s'] = 0x44);
}([function(b, c) {
    var a;
    a = function() {
        return this;
    }();
    try {
        a = a || Function('return this')() || (0x1, eval)('this');
    } catch (b) {
        if (typeof window === 'object') a = window;
    }
    b['exports'] = a;
}, function(c, a, b) {
    (function(f) {
        var p = b(0x37);
        var o = b(0xe);
        var g = b(0x2a);
        var n = b(0x29);
        var l = b(0x43);
        var j;
        if (f && f['ArrayBuffer']) {
            j = b(0x2c);
        }
        var q = typeof navigator !== 'undefined' && /Android/i ['test'](navigator['userAgent']);
        var m = typeof navigator !== 'undefined' && /PhantomJS/i ['test'](navigator['userAgent']);
        var i = q || m;
        a['protocol'] = 0x3;
        var h = a['packets'] = {
            'open': 0x0,
            'close': 0x1,
            'ping': 0x2,
            'pong': 0x3,
            'message': 0x4,
            'upgrade': 0x5,
            'noop': 0x6
        };
        var e = p(h);
        var d = {
            'type': 'error',
            'data': 'parser error'
        };
        var c = b(0x2d);
        a['encodePacket'] = function(a, d, g, b) {
            if ('function' == typeof d) {
                b = d;
                d = ![];
            }
            if ('function' == typeof g) {
                b = g;
                g = null;
            }
            var e = a['data'] === undefined ? undefined : a['data']['buffer'] || a['data'];
            if (f['ArrayBuffer'] && e instanceof ArrayBuffer) {
                return s(a, d, b);
            } else if (c && e instanceof f['Blob']) {
                return u(a, d, b);
            }
            if (e && e['base64']) {
                return r(a, b);
            }
            var i = h[a['type']];
            if (undefined !== a['data']) {
                i += g ? l['encode'](String(a['data'])) : String(a['data']);
            }
            return b('' + i);
        };

        function r(b, d) {
            var c = 'b' + a['packets'][b['type']] + b['data']['data'];
            return d(c);
        }

        function s(d, i, g) {
            if (!i) {
                return a['encodeBase64Packet'](d, g);
            }
            var e = d['data'];
            var f = new Uint8Array(e);
            var c = new Uint8Array(0x1 + e['byteLength']);
            c[0x0] = h[d['type']];
            for (var b = 0x0; b < f['length']; b++) {
                c[b + 0x1] = f[b];
            }
            return g(c['buffer']);
        }

        function t(b, d, e) {
            if (!d) {
                return a['encodeBase64Packet'](b, e);
            }
            var c = new FileReader();
            c['onload'] = function() {
                b['data'] = c['result'];
                a['encodePacket'](b, d, !![], e);
            };
            return c['readAsArrayBuffer'](b['data']);
        }

        function u(b, f, d) {
            if (!f) {
                return a['encodeBase64Packet'](b, d);
            }
            if (i) {
                return t(b, f, d);
            }
            var e = new Uint8Array(0x1);
            e[0x0] = h[b['type']];
            var g = new c([e['buffer'], b['data']]);
            return d(g);
        }
        a['encodeBase64Packet'] = function(b, k) {
            var e = 'b' + a['packets'][b['type']];
            if (c && b['data'] instanceof f['Blob']) {
                var g = new FileReader();
                g['onload'] = function() {
                    var a = g['result']['split'](',')[0x1];
                    k(e + a);
                };
                return g['readAsDataURL'](b['data']);
            }
            var i;
            try {
                i = String['fromCharCode']['apply'](null, new Uint8Array(b['data']));
            } catch (a) {
                var h = new Uint8Array(b['data']);
                var j = new Array(h['length']);
                for (var d = 0x0; d < h['length']; d++) {
                    j[d] = h[d];
                }
                i = String['fromCharCode']['apply'](null, j);
            }
            e += f['btoa'](i);
            return k(e);
        };
        a['decodePacket'] = function(b, i, k) {
            if (b === undefined) {
                return d;
            }
            if (typeof b == 'string') {
                if (b['charAt'](0x0) == 'b') {
                    return a['decodeBase64Packet'](b['substr'](0x1), i);
                }
                if (k) {
                    b = v(b);
                    if (b === ![]) {
                        return d;
                    }
                }
                var f = b['charAt'](0x0);
                if (Number(f) != f || !e[f]) {
                    return d;
                }
                if (b['length'] > 0x1) {
                    return {
                        'type': e[f],
                        'data': b['substring'](0x1)
                    };
                } else {
                    return {
                        'type': e[f]
                    };
                }
            }
            var j = new Uint8Array(b);
            var f = j[0x0];
            var h = g(b, 0x1);
            if (c && i === 'blob') {
                h = new c([h]);
            }
            return {
                'type': e[f],
                'data': h
            };
        };

        function v(a) {
            try {
                a = l['decode'](a);
            } catch (a) {
                return ![];
            }
            return a;
        }
        a['decodeBase64Packet'] = function(b, f) {
            var d = e[b['charAt'](0x0)];
            if (!j) {
                return {
                    'type': d,
                    'data': {
                        'base64': !![],
                        'data': b['substr'](0x1)
                    }
                };
            }
            var a = j['decode'](b['substr'](0x1));
            if (f === 'blob' && c) {
                a = new c([a]);
            }
            return {
                'type': d,
                'data': a
            };
        };
        a['encodePayload'] = function(b, d, e) {
            if (typeof d == 'function') {
                e = d;
                d = null;
            }
            var f = o(b);
            if (d && f) {
                if (c && !i) {
                    return a['encodePayloadAsBlob'](b, e);
                }
                return a['encodePayloadAsArrayBuffer'](b, e);
            }
            if (!b['length']) {
                return e('0:');
            }

            function g(a) {
                return a['length'] + ':' + a;
            }

            function h(b, c) {
                a['encodePacket'](b, !f ? ![] : d, !![], function(a) {
                    c(null, g(a));
                });
            }
            k(b, h, function(b, a) {
                return e(a['join'](''));
            });
        };

        function k(b, f, g) {
            var c = new Array(b['length']);
            var d = n(b['length'], g);
            var e = function(a, b, d) {
                f(b, function(b, e) {
                    c[a] = e;
                    d(b, c);
                });
            };
            for (var a = 0x0; a < b['length']; a++) {
                e(a, b[a], d);
            }
        }
        a['decodePayload'] = function(f, g, b) {
            if (typeof f != 'string') {
                return a['decodePayloadAsBinary'](f, g, b);
            }
            if (typeof g === 'function') {
                b = g;
                g = null;
            }
            var i;
            if (f == '') {
                return b(d, 0x0, 0x1);
            }
            var c = '',
                h, j;
            for (var e = 0x0, k = f['length']; e < k; e++) {
                var l = f['charAt'](e);
                if (':' != l) {
                    c += l;
                } else {
                    if ('' == c || c != (h = Number(c))) {
                        return b(d, 0x0, 0x1);
                    }
                    j = f['substr'](e + 0x1, h);
                    if (c != j['length']) {
                        return b(d, 0x0, 0x1);
                    }
                    if (j['length']) {
                        i = a['decodePacket'](j, g, !![]);
                        if (d['type'] == i['type'] && d['data'] == i['data']) {
                            return b(d, 0x0, 0x1);
                        }
                        var m = b(i, e + h, k);
                        if (![] === m) return;
                    }
                    e += h;
                    c = '';
                }
            }
            if (c != '') {
                return b(d, 0x0, 0x1);
            }
        };
        a['encodePayloadAsArrayBuffer'] = function(b, c) {
            if (!b['length']) {
                return c(new ArrayBuffer(0x0));
            }

            function d(b, c) {
                a['encodePacket'](b, !![], !![], function(a) {
                    return c(null, a);
                });
            }
            k(b, d, function(f, d) {
                var e = d['reduce'](function(c, b) {
                    var a;
                    if (typeof b === 'string') {
                        a = b['length'];
                    } else {
                        a = b['byteLength'];
                    }
                    return c + a['toString']()['length'] + a + 0x2;
                }, 0x0);
                var a = new Uint8Array(e);
                var b = 0x0;
                d['forEach'](function(e) {
                    var g = typeof e === 'string';
                    var f = e;
                    if (g) {
                        var d = new Uint8Array(e['length']);
                        for (var c = 0x0; c < e['length']; c++) {
                            d[c] = e['charCodeAt'](c);
                        }
                        f = d['buffer'];
                    }
                    if (g) {
                        a[b++] = 0x0;
                    } else {
                        a[b++] = 0x1;
                    }
                    var h = f['byteLength']['toString']();
                    for (var c = 0x0; c < h['length']; c++) {
                        a[b++] = parseInt(h[c]);
                    }
                    a[b++] = 0xff;
                    var d = new Uint8Array(f);
                    for (var c = 0x0; c < d['length']; c++) {
                        a[b++] = d[c];
                    }
                });
                return c(a['buffer']);
            });
        };
        a['encodePayloadAsBlob'] = function(b, d) {
            function e(b, d) {
                a['encodePacket'](b, !![], !![], function(b) {
                    var f = new Uint8Array(0x1);
                    f[0x0] = 0x1;
                    if (typeof b === 'string') {
                        var h = new Uint8Array(b['length']);
                        for (var a = 0x0; a < b['length']; a++) {
                            h[a] = b['charCodeAt'](a);
                        }
                        b = h['buffer'];
                        f[0x0] = 0x0;
                    }
                    var i = b instanceof ArrayBuffer ? b['byteLength'] : b['size'];
                    var e = i['toString']();
                    var g = new Uint8Array(e['length'] + 0x1);
                    for (var a = 0x0; a < e['length']; a++) {
                        g[a] = parseInt(e[a]);
                    }
                    g[e['length']] = 0xff;
                    if (c) {
                        var j = new c([f['buffer'], g['buffer'], b]);
                        d(null, j);
                    }
                });
            }
            k(b, e, function(b, a) {
                return d(new c(a));
            });
        };
        a['decodePayloadAsBinary'] = function(p, i, k) {
            if (typeof i === 'function') {
                k = i;
                i = null;
            }
            var c = p;
            var j = [];
            var l = ![];
            while (c['byteLength'] > 0x0) {
                var h = new Uint8Array(c);
                var n = h[0x0] === 0x0;
                var e = '';
                for (var b = 0x1;; b++) {
                    if (h[b] == 0xff) break;
                    if (e['length'] > 0x136) {
                        l = !![];
                        break;
                    }
                    e += h[b];
                }
                if (l) return k(d, 0x0, 0x1);
                c = g(c, 0x2 + e['length']);
                e = parseInt(e);
                var f = g(c, 0x0, e);
                if (n) {
                    try {
                        f = String['fromCharCode']['apply'](null, new Uint8Array(f));
                    } catch (a) {
                        var m = new Uint8Array(f);
                        f = '';
                        for (var b = 0x0; b < m['length']; b++) {
                            f += String['fromCharCode'](m[b]);
                        }
                    }
                }
                j['push'](f);
                c = g(c, e);
            }
            var o = j['length'];
            j['forEach'](function(b, c) {
                k(a['decodePacket'](b, i, !![]), c, o);
            });
        };
    }['call'](a, b(0x0)));
}, function(a, b) {
    a['exports'] = function(a, c) {
        var b = function() {};
        b['prototype'] = c['prototype'];
        a['prototype'] = new b();
        a['prototype']['constructor'] = a;
    };
}, function(c, a, b) {
    (function(d) {
        a = c['exports'] = b(0x35);
        a['log'] = h;
        a['formatArgs'] = g;
        a['save'] = i;
        a['load'] = e;
        a['useColors'] = f;
        a['storage'] = 'undefined' != typeof chrome && 'undefined' != typeof chrome['storage'] ? chrome['storage']['local'] : j();
        a['colors'] = ['lightseagreen', 'forestgreen', 'goldenrod', 'dodgerblue', 'darkorchid', 'crimson'];

        function f() {
            return typeof document !== 'undefined' && 'WebkitAppearance' in document['documentElement']['style'] || window['console'] && (console['firebug'] || console['exception'] && console['table']) || navigator['userAgent']['toLowerCase']()['match'](/firefox\/(\d+)/) && parseInt(RegExp['$1'], 0xa) >= 0x1f;
        }
        a['formatters']['j'] = function(a) {
            try {
                return JSON['stringify'](a);
            } catch (a) {
                return '[UnexpectedJSONParseError]: ' + a['message'];
            }
        };

        function g() {
            var b = arguments;
            var c = this['useColors'];
            b[0x0] = (c ? '%c' : '') + this['namespace'] + (c ? ' %c' : ' ') + b[0x0] + (c ? '%c ' : ' ') + '+' + a['humanize'](this['diff']);
            if (!c) return b;
            var d = 'color: ' + this['color'];
            b = [b[0x0], d, 'color: inherit']['concat'](Array['prototype']['slice']['call'](b, 0x1));
            var e = 0x0;
            var f = 0x0;
            b[0x0]['replace'](/%[a-z%]/g, function(a) {
                if ('%%' === a) return;
                e++;
                if ('%c' === a) {
                    f = e;
                }
            });
            b['splice'](f, 0x0, d);
            return b;
        }

        function h() {
            return 'object' === typeof console && console['log'] && Function['prototype']['apply']['call'](console['log'], console, arguments);
        }

        function i(b) {
            try {
                if (null == b) {
                    a['storage']['removeItem']('debug');
                } else {
                    a['storage']['debug'] = b;
                }
            } catch (a) {}
        }

        function e() {
            var b;
            try {
                return a['storage']['debug'];
            } catch (a) {}
            if (typeof d !== 'undefined' && 'env' in d) {
                return d['env']['DEBUG'];
            }
        }
        a['enable'](e());

        function j() {
            try {
                return window['localStorage'];
            } catch (a) {}
        }
    }['call'](a, b(0xa)));
}, function(c, a, b) {
    (function(d) {
        a = c['exports'] = b(0x3c);
        a['log'] = h;
        a['formatArgs'] = g;
        a['save'] = i;
        a['load'] = e;
        a['useColors'] = f;
        a['storage'] = 'undefined' != typeof chrome && 'undefined' != typeof chrome['storage'] ? chrome['storage']['local'] : j();
        a['colors'] = ['lightseagreen', 'forestgreen', 'goldenrod', 'dodgerblue', 'darkorchid', 'crimson'];

        function f() {
            return typeof document !== 'undefined' && 'WebkitAppearance' in document['documentElement']['style'] || window['console'] && (console['firebug'] || console['exception'] && console['table']) || navigator['userAgent']['toLowerCase']()['match'](/firefox\/(\d+)/) && parseInt(RegExp['$1'], 0xa) >= 0x1f;
        }
        a['formatters']['j'] = function(a) {
            try {
                return JSON['stringify'](a);
            } catch (a) {
                return '[UnexpectedJSONParseError]: ' + a['message'];
            }
        };

        function g() {
            var b = arguments;
            var c = this['useColors'];
            b[0x0] = (c ? '%c' : '') + this['namespace'] + (c ? ' %c' : ' ') + b[0x0] + (c ? '%c ' : ' ') + '+' + a['humanize'](this['diff']);
            if (!c) return b;
            var d = 'color: ' + this['color'];
            b = [b[0x0], d, 'color: inherit']['concat'](Array['prototype']['slice']['call'](b, 0x1));
            var e = 0x0;
            var f = 0x0;
            b[0x0]['replace'](/%[a-z%]/g, function(a) {
                if ('%%' === a) return;
                e++;
                if ('%c' === a) {
                    f = e;
                }
            });
            b['splice'](f, 0x0, d);
            return b;
        }

        function h() {
            return 'object' === typeof console && console['log'] && Function['prototype']['apply']['call'](console['log'], console, arguments);
        }

        function i(b) {
            try {
                if (null == b) {
                    a['storage']['removeItem']('debug');
                } else {
                    a['storage']['debug'] = b;
                }
            } catch (a) {}
        }

        function e() {
            var b;
            try {
                return a['storage']['debug'];
            } catch (a) {}
            if (typeof d !== 'undefined' && 'env' in d) {
                return d['env']['DEBUG'];
            }
        }
        a['enable'](e());

        function j() {
            try {
                return window['localStorage'];
            } catch (a) {}
        }
    }['call'](a, b(0xa)));
}, function(e, f, b) {
    var c = b(0x1);
    var d = b(0x7);
    e['exports'] = a;

    function a(a) {
        this['path'] = a['path'];
        this['hostname'] = a['hostname'];
        this['port'] = a['port'];
        this['secure'] = a['secure'];
        this['query'] = a['query'];
        this['timestampParam'] = a['timestampParam'];
        this['timestampRequests'] = a['timestampRequests'];
        this['readyState'] = '';
        this['agent'] = a['agent'] || ![];
        this['socket'] = a['socket'];
        this['enablesXDR'] = a['enablesXDR'];
        this['pfx'] = a['pfx'];
        this['key'] = a['key'];
        this['passphrase'] = a['passphrase'];
        this['cert'] = a['cert'];
        this['ca'] = a['ca'];
        this['ciphers'] = a['ciphers'];
        this['rejectUnauthorized'] = a['rejectUnauthorized'];
        this['forceNode'] = a['forceNode'];
        this['extraHeaders'] = a['extraHeaders'];
        this['localAddress'] = a['localAddress'];
    }
    d(a['prototype']);
    a['prototype']['onError'] = function(b, c) {
        var a = new Error(b);
        a['type'] = 'TransportError';
        a['description'] = c;
        this['emit']('error', a);
        return this;
    };
    a['prototype']['open'] = function() {
        if ('closed' === this['readyState'] || '' === this['readyState']) {
            this['readyState'] = 'opening';
            this['doOpen']();
        }
        return this;
    };
    a['prototype']['close'] = function() {
        if ('opening' === this['readyState'] || 'open' === this['readyState']) {
            this['doClose']();
            this['onClose']();
        }
        return this;
    };
    a['prototype']['send'] = function(a) {
        if ('open' === this['readyState']) {
            this['write'](a);
        } else {
            throw new Error('Transport not open');
        }
    };
    a['prototype']['onOpen'] = function() {
        this['readyState'] = 'open';
        this['writable'] = !![];
        this['emit']('open');
    };
    a['prototype']['onData'] = function(b) {
        var a = c['decodePacket'](b, this['socket']['binaryType']);
        this['onPacket'](a);
    };
    a['prototype']['onPacket'] = function(a) {
        this['emit']('packet', a);
    };
    a['prototype']['onClose'] = function() {
        this['readyState'] = 'closed';
        this['emit']('close');
    };
}, function(b, c, a) {
    (function(d) {
        var c = a(0x38);
        b['exports'] = function(a) {
            var b = a['xdomain'];
            var e = a['xscheme'];
            var f = a['enablesXDR'];
            try {
                if ('undefined' !== typeof XMLHttpRequest && (!b || c)) {
                    return new XMLHttpRequest();
                }
            } catch (a) {}
            try {
                if ('undefined' !== typeof XDomainRequest && !e && f) {
                    return new XDomainRequest();
                }
            } catch (a) {}
            if (!b) {
                try {
                    return new d[(['Active']['concat']('Object')['join']('X'))]('Microsoft.XMLHTTP');
                } catch (a) {}
            }
        };
    }['call'](c, a(0x0)));
}, function(b, d, e) {
    if (!![]) {
        b['exports'] = a;
    }

    function a(a) {
        if (a) return c(a);
    };

    function c(c) {
        for (var b in a['prototype']) {
            c[b] = a['prototype'][b];
        }
        return c;
    }
    a['prototype']['on'] = a['prototype']['addEventListener'] = function(a, b) {
        this['_callbacks'] = this['_callbacks'] || {};
        (this['_callbacks']['$' + a] = this['_callbacks']['$' + a] || [])['push'](b);
        return this;
    };
    a['prototype']['once'] = function(b, c) {
        function a() {
            this['off'](b, a);
            c['apply'](this, arguments);
        }
        a['fn'] = c;
        this['on'](b, a);
        return this;
    };
    a['prototype']['off'] = a['prototype']['removeListener'] = a['prototype']['removeAllListeners'] = a['prototype']['removeEventListener'] = function(d, e) {
        this['_callbacks'] = this['_callbacks'] || {};
        if (0x0 == arguments['length']) {
            this['_callbacks'] = {};
            return this;
        }
        var a = this['_callbacks']['$' + d];
        if (!a) return this;
        if (0x1 == arguments['length']) {
            delete this['_callbacks']['$' + d];
            return this;
        }
        var c;
        for (var b = 0x0; b < a['length']; b++) {
            c = a[b];
            if (c === e || c['fn'] === e) {
                a['splice'](b, 0x1);
                break;
            }
        }
        return this;
    };
    a['prototype']['emit'] = function(e) {
        this['_callbacks'] = this['_callbacks'] || {};
        var c = []['slice']['call'](arguments, 0x1),
            a = this['_callbacks']['$' + e];
        if (a) {
            a = a['slice'](0x0);
            for (var b = 0x0, d = a['length']; b < d; ++b) {
                a[b]['apply'](this, c);
            }
        }
        return this;
    };
    a['prototype']['listeners'] = function(a) {
        this['_callbacks'] = this['_callbacks'] || {};
        return this['_callbacks']['$' + a] || [];
    };
    a['prototype']['hasListeners'] = function(a) {
        return !!this['listeners'](a)['length'];
    };
}, function(b, a) {
    a['encode'] = function(c) {
        var a = '';
        for (var b in c) {
            if (c['hasOwnProperty'](b)) {
                if (a['length']) a += '&';
                a += encodeURIComponent(b) + '=' + encodeURIComponent(c[b]);
            }
        }
        return a;
    };
    a['decode'] = function(f) {
        var b = {};
        var c = f['split']('&');
        for (var a = 0x0, e = c['length']; a < e; a++) {
            var d = c[a]['split']('=');
            b[decodeURIComponent(d[0x0])] = decodeURIComponent(d[0x1]);
        }
        return b;
    };
}, function(p, a, b) {
    var c = b(0x3f)('socket.io-parser');
    var f = b(0x39);
    var i = b(0x2e);
    var d = b(0x3e);
    var h = b(0x16);
    a['protocol'] = 0x4;
    a['types'] = ['CONNECT', 'DISCONNECT', 'EVENT', 'ACK', 'ERROR', 'BINARY_EVENT', 'BINARY_ACK'];
    a['CONNECT'] = 0x0;
    a['DISCONNECT'] = 0x1;
    a['EVENT'] = 0x2;
    a['ACK'] = 0x3;
    a['ERROR'] = 0x4;
    a['BINARY_EVENT'] = 0x5;
    a['BINARY_ACK'] = 0x6;
    a['Encoder'] = j;
    a['Decoder'] = e;

    function j() {}
    j['prototype']['encode'] = function(b, d) {
        c('encoding packet %j', b);
        if (a['BINARY_EVENT'] == b['type'] || a['BINARY_ACK'] == b['type']) {
            m(b, d);
        } else {
            var e = k(b);
            d([e]);
        }
    };

    function k(b) {
        var d = '';
        var e = ![];
        d += b['type'];
        if (a['BINARY_EVENT'] == b['type'] || a['BINARY_ACK'] == b['type']) {
            d += b['attachments'];
            d += '-';
        }
        if (b['nsp'] && '/' != b['nsp']) {
            e = !![];
            d += b['nsp'];
        }
        if (null != b['id']) {
            if (e) {
                d += ',';
                e = ![];
            }
            d += b['id'];
        }
        if (null != b['data']) {
            if (e) d += ',';
            d += f['stringify'](b['data']);
        }
        c('encoded %j as %s', b, d);
        return d;
    }

    function m(a, b) {
        function c(f) {
            var a = d['deconstructPacket'](f);
            var e = k(a['packet']);
            var c = a['buffers'];
            c['unshift'](e);
            b(c);
        }
        d['removeBlobs'](a, c);
    }

    function e() {
        this['reconstructor'] = null;
    }
    i(e['prototype']);
    e['prototype']['add'] = function(c) {
        var b;
        if ('string' == typeof c) {
            b = n(c);
            if (a['BINARY_EVENT'] == b['type'] || a['BINARY_ACK'] == b['type']) {
                this['reconstructor'] = new g(b);
                if (this['reconstructor']['reconPack']['attachments'] === 0x0) {
                    this['emit']('decoded', b);
                }
            } else {
                this['emit']('decoded', b);
            }
        } else if (h(c) || c['base64']) {
            if (!this['reconstructor']) {
                throw new Error('got binary data when not reconstructing a packet');
            } else {
                b = this['reconstructor']['takeBinaryData'](c);
                if (b) {
                    this['reconstructor'] = null;
                    this['emit']('decoded', b);
                }
            }
        } else {
            throw new Error('Unknown type: ' + c);
        }
    };

    function n(e) {
        var b = {};
        var d = 0x0;
        b['type'] = Number(e['charAt'](0x0));
        if (null == a['types'][b['type']]) return l();
        if (a['BINARY_EVENT'] == b['type'] || a['BINARY_ACK'] == b['type']) {
            var g = '';
            while (e['charAt'](++d) != '-') {
                g += e['charAt'](d);
                if (d == e['length']) break;
            }
            if (g != Number(g) || e['charAt'](d) != '-') {
                throw new Error('Illegal attachments');
            }
            b['attachments'] = Number(g);
        }
        if ('/' == e['charAt'](d + 0x1)) {
            b['nsp'] = '';
            while (++d) {
                var f = e['charAt'](d);
                if (',' == f) break;
                b['nsp'] += f;
                if (d == e['length']) break;
            }
        } else {
            b['nsp'] = '/';
        }
        var h = e['charAt'](d + 0x1);
        if ('' !== h && Number(h) == h) {
            b['id'] = '';
            while (++d) {
                var f = e['charAt'](d);
                if (null == f || Number(f) != f) {
                    --d;
                    break;
                }
                b['id'] += e['charAt'](d);
                if (d == e['length']) break;
            }
            b['id'] = Number(b['id']);
        }
        if (e['charAt'](++d)) {
            b = o(b, e['substr'](d));
        }
        c('decoded %s as %j', e, b);
        return b;
    }

    function o(a, b) {
        try {
            a['data'] = f['parse'](b);
        } catch (a) {
            return l();
        }
        return a;
    };
    e['prototype']['destroy'] = function() {
        if (this['reconstructor']) {
            this['reconstructor']['finishedReconstruction']();
        }
    };

    function g(a) {
        this['reconPack'] = a;
        this['buffers'] = [];
    }
    g['prototype']['takeBinaryData'] = function(b) {
        this['buffers']['push'](b);
        if (this['buffers']['length'] == this['reconPack']['attachments']) {
            var a = d['reconstructPacket'](this['reconPack'], this['buffers']);
            this['finishedReconstruction']();
            return a;
        }
        return null;
    };
    g['prototype']['finishedReconstruction'] = function() {
        this['reconPack'] = null;
        this['buffers'] = [];
    };

    function l(b) {
        return {
            'type': a['ERROR'],
            'data': 'parser error'
        };
    }
}, function(n, q) {
    var a = n['exports'] = {};
    var b;
    var c;

    function j() {
        throw new Error('setTimeout has not been defined');
    }

    function i() {
        throw new Error('clearTimeout has not been defined');
    }(function() {
        try {
            if (typeof setTimeout === 'function') {
                b = setTimeout;
            } else {
                b = j;
            }
        } catch (a) {
            b = j;
        }
        try {
            if (typeof clearTimeout === 'function') {
                c = clearTimeout;
            } else {
                c = i;
            }
        } catch (a) {
            c = i;
        }
    }());

    function k(a) {
        if (b === setTimeout) {
            return setTimeout(a, 0x0);
        }
        if ((b === j || !b) && setTimeout) {
            b = setTimeout;
            return setTimeout(a, 0x0);
        }
        try {
            return b(a, 0x0);
        } catch (c) {
            try {
                return b['call'](null, a, 0x0);
            } catch (c) {
                return b['call'](this, a, 0x0);
            }
        }
    }

    function p(a) {
        if (c === clearTimeout) {
            return clearTimeout(a);
        }
        if ((c === i || !c) && clearTimeout) {
            c = clearTimeout;
            return clearTimeout(a);
        }
        try {
            return c(a);
        } catch (b) {
            try {
                return c['call'](null, a);
            } catch (b) {
                return c['call'](this, a);
            }
        }
    }
    var d = [];
    var g = ![];
    var f;
    var h = -0x1;

    function o() {
        if (!g || !f) {
            return;
        }
        g = ![];
        if (f['length']) {
            d = f['concat'](d);
        } else {
            h = -0x1;
        }
        if (d['length']) {
            m();
        }
    }

    function m() {
        if (g) {
            return;
        }
        var b = k(o);
        g = !![];
        var a = d['length'];
        while (a) {
            f = d;
            d = [];
            while (++h < a) {
                if (f) {
                    f[h]['run']();
                }
            }
            h = -0x1;
            a = d['length'];
        }
        f = null;
        g = ![];
        p(b);
    }
    a['nextTick'] = function(c) {
        var b = new Array(arguments['length'] - 0x1);
        if (arguments['length'] > 0x1) {
            for (var a = 0x1; a < arguments['length']; a++) {
                b[a - 0x1] = arguments[a];
            }
        }
        d['push'](new l(c, b));
        if (d['length'] === 0x1 && !g) {
            k(m);
        }
    };

    function l(a, b) {
        this['fun'] = a;
        this['array'] = b;
    }
    l['prototype']['run'] = function() {
        this['fun']['apply'](null, this['array']);
    };
    a['title'] = 'browser';
    a['browser'] = !![];
    a['env'] = {};
    a['argv'] = [];
    a['version'] = '';
    a['versions'] = {};

    function e() {}
    a['on'] = e;
    a['addListener'] = e;
    a['once'] = e;
    a['off'] = e;
    a['removeListener'] = e;
    a['removeAllListeners'] = e;
    a['emit'] = e;
    a['prependListener'] = e;
    a['prependOnceListener'] = e;
    a['listeners'] = function(a) {
        return [];
    };
    a['binding'] = function(a) {
        throw new Error('process.binding is not supported');
    };
    a['cwd'] = function() {
        return '/';
    };
    a['chdir'] = function(a) {
        throw new Error('process.chdir is not supported');
    };
    a['umask'] = function() {
        return 0x0;
    };
}, function(b, c) {
    var a = []['slice'];
    b['exports'] = function(c, b) {
        if ('string' == typeof b) b = c[b];
        if ('function' != typeof b) throw new Error('bind() requires a function');
        var d = a['call'](arguments, 0x2);
        return function() {
            return b['apply'](c, d['concat'](a['call'](arguments)));
        };
    };
}, function(c, b, a) {
    (function(g) {
        var c = a(0x6);
        var d = a(0x33);
        var e = a(0x32);
        var f = a(0x34);
        b['polling'] = h;
        b['websocket'] = f;

        function h(a) {
            var j;
            var f = ![];
            var h = ![];
            var k = ![] !== a['jsonp'];
            if (g['location']) {
                var i = 'https:' === location['protocol'];
                var b = location['port'];
                if (!b) {
                    b = i ? 0x1bb : 0x50;
                }
                f = a['hostname'] !== location['hostname'] || b !== a['port'];
                h = a['secure'] !== i;
            }
            a['xdomain'] = f;
            a['xscheme'] = h;
            j = new c(a);
            if ('open' in j && !a['forceJSONP']) {
                return new d(a);
            } else {
                if (!k) throw new Error('JSONP disabled');
                return new e(a);
            }
        }
    }['call'](b, a(0x0)));
}, function(j, k, c) {
    var e = c(0x5);
    var f = c(0x8);
    var d = c(0x1);
    var g = c(0x2);
    var h = c(0x17);
    var a = c(0x3)('engine.io-client:polling');
    j['exports'] = b;
    var i = function() {
        var a = c(0x6);
        var b = new a({
            'xdomain': ![]
        });
        return null != b['responseType'];
    }();

    function b(a) {
        var b = a && a['forceBase64'];
        if (!i || b) {
            this['supportsBinary'] = ![];
        }
        e['call'](this, a);
    }
    g(b, e);
    b['prototype']['name'] = 'polling';
    b['prototype']['doOpen'] = function() {
        this['poll']();
    };
    b['prototype']['pause'] = function(e) {
        var d = this;
        this['readyState'] = 'pausing';

        function c() {
            a('paused');
            d['readyState'] = 'paused';
            e();
        }
        if (this['polling'] || !this['writable']) {
            var b = 0x0;
            if (this['polling']) {
                a('we are currently polling - waiting to pause');
                b++;
                this['once']('pollComplete', function() {
                    a('pre-pause polling complete');
                    --b || c();
                });
            }
            if (!this['writable']) {
                a('we are currently writing - waiting to pause');
                b++;
                this['once']('drain', function() {
                    a('pre-pause writing complete');
                    --b || c();
                });
            }
        } else {
            c();
        }
    };
    b['prototype']['poll'] = function() {
        a('polling');
        this['polling'] = !![];
        this['doPoll']();
        this['emit']('poll');
    };
    b['prototype']['onData'] = function(c) {
        var b = this;
        a('polling got data %s', c);
        var e = function(a, c, d) {
            if ('opening' === b['readyState']) {
                b['onOpen']();
            }
            if ('close' === a['type']) {
                b['onClose']();
                return ![];
            }
            b['onPacket'](a);
        };
        d['decodePayload'](c, this['socket']['binaryType'], e);
        if ('closed' !== this['readyState']) {
            this['polling'] = ![];
            this['emit']('pollComplete');
            if ('open' === this['readyState']) {
                this['poll']();
            } else {
                a('ignoring poll - transport state \"%s\"', this['readyState']);
            }
        }
    };
    b['prototype']['doClose'] = function() {
        var b = this;

        function c() {
            a('writing close packet');
            b['write']([{
                'type': 'close'
            }]);
        }
        if ('open' === this['readyState']) {
            a('transport open - closing');
            c();
        } else {
            a('transport not open - deferring close');
            this['once']('open', c);
        }
    };
    b['prototype']['write'] = function(c) {
        var a = this;
        this['writable'] = ![];
        var b = function() {
            a['writable'] = !![];
            a['emit']('drain');
        };
        d['encodePayload'](c, this['supportsBinary'], function(c) {
            a['doWrite'](c, b);
        });
    };
    b['prototype']['uri'] = function() {
        var a = this['query'] || {};
        var b = this['secure'] ? 'https' : 'http';
        var c = '';
        if (![] !== this['timestampRequests']) {
            a[this['timestampParam']] = h();
        }
        if (!this['supportsBinary'] && !a['sid']) {
            a['b64'] = 0x1;
        }
        a = f['encode'](a);
        if (this['port'] && ('https' === b && Number(this['port']) !== 0x1bb || 'http' === b && Number(this['port']) !== 0x50)) {
            c = ':' + this['port'];
        }
        if (a['length']) {
            a = '?' + a;
        }
        var d = this['hostname']['indexOf'](':') !== -0x1;
        return b + '://' + (d ? '[' + this['hostname'] + ']' : this['hostname']) + c + this['path'] + a;
    };
}, function(b, c, a) {
    (function(c) {
        var d = a(0x10);
        b['exports'] = e;

        function e(b) {
            function a(b) {
                if (!b) return ![];
                if (c['Buffer'] && c['Buffer']['isBuffer'] && c['Buffer']['isBuffer'](b) || c['ArrayBuffer'] && b instanceof ArrayBuffer || c['Blob'] && b instanceof Blob || c['File'] && b instanceof File) {
                    return !![];
                }
                if (d(b)) {
                    for (var e = 0x0; e < b['length']; e++) {
                        if (a(b[e])) {
                            return !![];
                        }
                    }
                } else if (b && 'object' == typeof b) {
                    if (b['toJSON'] && 'function' == typeof b['toJSON']) {
                        b = b['toJSON']();
                    }
                    for (var f in b) {
                        if (Object['prototype']['hasOwnProperty']['call'](b, f) && a(b[f])) {
                            return !![];
                        }
                    }
                }
                return ![];
            }
            return a(b);
        }
    }['call'](c, a(0x0)));
}, function(b, c) {
    var a = []['indexOf'];
    b['exports'] = function(c, d) {
        if (a) return c['indexOf'](d);
        for (var b = 0x0; b < c['length']; ++b) {
            if (c[b] === d) return b;
        }
        return -0x1;
    };
}, function(a, b) {
    a['exports'] = Array['isArray'] || function(a) {
        return Object['prototype']['toString']['call'](a) == '[object Array]';
    };
}, function(c, d) {
    var a = /^(?:(?![^:@]+:[^:@\/]*@)(http|https|ws|wss):\/\/)?((?:(([^:@]*)(?::([^:@]*))?)?@)?((?:[a-f0-9]{0,4}:){2,7}[a-f0-9]{0,4}|[^:\/?#]*)(?::(\d*))?)(((\/(?:[^?#](?![^?#\/]*\.[^?#\/.]+(?:[?#]|$)))*\/?)?([^?#\/]*))(?:\?([^#]*))?(?:#(.*))?)/;
    var b = ['source', 'protocol', 'authority', 'userInfo', 'user', 'password', 'host', 'port', 'relative', 'path', 'directory', 'file', 'query', 'anchor'];
    c['exports'] = function c(e) {
        var i = e,
            f = e['indexOf']('['),
            g = e['indexOf'](']');
        if (f != -0x1 && g != -0x1) {
            e = e['substring'](0x0, f) + e['substring'](f, g)['replace'](/:/g, ';') + e['substring'](g, e['length']);
        }
        var j = a['exec'](e || ''),
            d = {},
            h = 0xe;
        while (h--) {
            d[b[h]] = j[h] || '';
        }
        if (f != -0x1 && g != -0x1) {
            d['source'] = i;
            d['host'] = d['host']['substring'](0x1, d['host']['length'] - 0x1)['replace'](/;/g, ':');
            d['authority'] = d['authority']['replace']('[', '')['replace'](']', '')['replace'](/;/g, ':');
            d['ipv6uri'] = !![];
        }
        return d;
    };
}, function(m, n, c) {
    var k = c(0x2f);
    var j = c(0x14);
    var i = c(0x15);
    var g = c(0x9);
    var d = c(0x13);
    var e = c(0xb);
    var b = c(0x4)('socket.io-client:manager');
    var h = c(0xf);
    var l = c(0x2b);
    var f = Object['prototype']['hasOwnProperty'];
    m['exports'] = a;

    function a(c, b) {
        if (!(this instanceof a)) return new a(c, b);
        if (c && 'object' === typeof c) {
            b = c;
            c = undefined;
        }
        b = b || {};
        b['path'] = b['path'] || '/socket.io';
        this['nsps'] = {};
        this['subs'] = [];
        this['opts'] = b;
        this['reconnection'](b['reconnection'] !== ![]);
        this['reconnectionAttempts'](b['reconnectionAttempts'] || Infinity);
        this['reconnectionDelay'](b['reconnectionDelay'] || 0x3e8);
        this['reconnectionDelayMax'](b['reconnectionDelayMax'] || 0x1388);
        this['randomizationFactor'](b['randomizationFactor'] || 0.5);
        this['backoff'] = new l({
            'min': this['reconnectionDelay'](),
            'max': this['reconnectionDelayMax'](),
            'jitter': this['randomizationFactor']()
        });
        this['timeout'](null == b['timeout'] ? 0x4e20 : b['timeout']);
        this['readyState'] = 'closed';
        this['uri'] = c;
        this['connecting'] = [];
        this['lastPing'] = null;
        this['encoding'] = ![];
        this['packetBuffer'] = [];
        this['encoder'] = new g['Encoder']();
        this['decoder'] = new g['Decoder']();
        this['autoConnect'] = b['autoConnect'] !== ![];
        if (this['autoConnect']) this['open']();
    }
    a['prototype']['emitAll'] = function() {
        this['emit']['apply'](this, arguments);
        for (var a in this['nsps']) {
            if (f['call'](this['nsps'], a)) {
                this['nsps'][a]['emit']['apply'](this['nsps'][a], arguments);
            }
        }
    };
    a['prototype']['updateSocketIds'] = function() {
        for (var a in this['nsps']) {
            if (f['call'](this['nsps'], a)) {
                this['nsps'][a]['id'] = this['engine']['id'];
            }
        }
    };
    i(a['prototype']);
    a['prototype']['reconnection'] = function(a) {
        if (!arguments['length']) return this['_reconnection'];
        this['_reconnection'] = !!a;
        return this;
    };
    a['prototype']['reconnectionAttempts'] = function(a) {
        if (!arguments['length']) return this['_reconnectionAttempts'];
        this['_reconnectionAttempts'] = a;
        return this;
    };
    a['prototype']['reconnectionDelay'] = function(a) {
        if (!arguments['length']) return this['_reconnectionDelay'];
        this['_reconnectionDelay'] = a;
        this['backoff'] && this['backoff']['setMin'](a);
        return this;
    };
    a['prototype']['randomizationFactor'] = function(a) {
        if (!arguments['length']) return this['_randomizationFactor'];
        this['_randomizationFactor'] = a;
        this['backoff'] && this['backoff']['setJitter'](a);
        return this;
    };
    a['prototype']['reconnectionDelayMax'] = function(a) {
        if (!arguments['length']) return this['_reconnectionDelayMax'];
        this['_reconnectionDelayMax'] = a;
        this['backoff'] && this['backoff']['setMax'](a);
        return this;
    };
    a['prototype']['timeout'] = function(a) {
        if (!arguments['length']) return this['_timeout'];
        this['_timeout'] = a;
        return this;
    };
    a['prototype']['maybeReconnectOnOpen'] = function() {
        if (!this['reconnecting'] && this['_reconnection'] && this['backoff']['attempts'] === 0x0) {
            this['reconnect']();
        }
    };
    a['prototype']['open'] = a['prototype']['connect'] = function(f, j) {
        b('readyState %s', this['readyState']);
        if (~this['readyState']['indexOf']('open')) return this;
        b('opening %s', this['uri']);
        this['engine'] = k(this['uri'], this['opts']);
        var c = this['engine'];
        var a = this;
        this['readyState'] = 'opening';
        this['skipReconnect'] = ![];
        var g = d(c, 'open', function() {
            a['onopen']();
            f && f();
        });
        var h = d(c, 'error', function(d) {
            b('connect_error');
            a['cleanup']();
            a['readyState'] = 'closed';
            a['emitAll']('connect_error', d);
            if (f) {
                var c = new Error('Connection error');
                c['data'] = d;
                f(c);
            } else {
                a['maybeReconnectOnOpen']();
            }
        });
        if (![] !== this['_timeout']) {
            var e = this['_timeout'];
            b('connect attempt will timeout after %d', e);
            var i = setTimeout(function() {
                b('connect attempt timed out after %d', e);
                g['destroy']();
                c['close']();
                c['emit']('error', 'timeout');
                a['emitAll']('connect_timeout', e);
            }, e);
            this['subs']['push']({
                'destroy': function() {
                    clearTimeout(i);
                }
            });
        }
        this['subs']['push'](g);
        this['subs']['push'](h);
        return this;
    };
    a['prototype']['onopen'] = function() {
        b('open');
        this['cleanup']();
        this['readyState'] = 'open';
        this['emit']('open');
        var a = this['engine'];
        this['subs']['push'](d(a, 'data', e(this, 'ondata')));
        this['subs']['push'](d(a, 'ping', e(this, 'onping')));
        this['subs']['push'](d(a, 'pong', e(this, 'onpong')));
        this['subs']['push'](d(a, 'error', e(this, 'onerror')));
        this['subs']['push'](d(a, 'close', e(this, 'onclose')));
        this['subs']['push'](d(this['decoder'], 'decoded', e(this, 'ondecoded')));
    };
    a['prototype']['onping'] = function() {
        this['lastPing'] = new Date();
        this['emitAll']('ping');
    };
    a['prototype']['onpong'] = function() {
        this['emitAll']('pong', new Date() - this['lastPing']);
    };
    a['prototype']['ondata'] = function(a) {
        this['decoder']['add'](a);
    };
    a['prototype']['ondecoded'] = function(a) {
        this['emit']('packet', a);
    };
    a['prototype']['onerror'] = function(a) {
        b('error', a);
        this['emitAll']('error', a);
    };
    a['prototype']['socket'] = function(c, e) {
        var a = this['nsps'][c];
        if (!a) {
            a = new j(this, c, e);
            this['nsps'][c] = a;
            var b = this;
            a['on']('connecting', d);
            a['on']('connect', function() {
                a['id'] = b['engine']['id'];
            });
            if (this['autoConnect']) {
                d();
            }
        }

        function d() {
            if (!~h(b['connecting'], a)) {
                b['connecting']['push'](a);
            }
        }
        return a;
    };
    a['prototype']['destroy'] = function(b) {
        var a = h(this['connecting'], b);
        if (~a) this['connecting']['splice'](a, 0x1);
        if (this['connecting']['length']) return;
        this['close']();
    };
    a['prototype']['packet'] = function(a) {
        b('writing packet %j', a);
        var c = this;
        if (a['query'] && a['type'] === 0x0) a['nsp'] += '?' + a['query'];
        if (!c['encoding']) {
            c['encoding'] = !![];
            this['encoder']['encode'](a, function(d) {
                for (var b = 0x0; b < d['length']; b++) {
                    c['engine']['write'](d[b], a['options']);
                }
                c['encoding'] = ![];
                c['processPacketQueue']();
            });
        } else {
            c['packetBuffer']['push'](a);
        }
    };
    a['prototype']['processPacketQueue'] = function() {
        if (this['packetBuffer']['length'] > 0x0 && !this['encoding']) {
            var a = this['packetBuffer']['shift']();
            this['packet'](a);
        }
    };
    a['prototype']['cleanup'] = function() {
        b('cleanup');
        var c = this['subs']['length'];
        for (var a = 0x0; a < c; a++) {
            var d = this['subs']['shift']();
            d['destroy']();
        }
        this['packetBuffer'] = [];
        this['encoding'] = ![];
        this['lastPing'] = null;
        this['decoder']['destroy']();
    };
    a['prototype']['close'] = a['prototype']['disconnect'] = function() {
        b('disconnect');
        this['skipReconnect'] = !![];
        this['reconnecting'] = ![];
        if ('opening' === this['readyState']) {
            this['cleanup']();
        }
        this['backoff']['reset']();
        this['readyState'] = 'closed';
        if (this['engine']) this['engine']['close']();
    };
    a['prototype']['onclose'] = function(a) {
        b('onclose');
        this['cleanup']();
        this['backoff']['reset']();
        this['readyState'] = 'closed';
        this['emit']('close', a);
        if (this['_reconnection'] && !this['skipReconnect']) {
            this['reconnect']();
        }
    };
    a['prototype']['reconnect'] = function() {
        if (this['reconnecting'] || this['skipReconnect']) return this;
        var a = this;
        if (this['backoff']['attempts'] >= this['_reconnectionAttempts']) {
            b('reconnect failed');
            this['backoff']['reset']();
            this['emitAll']('reconnect_failed');
            this['reconnecting'] = ![];
        } else {
            var c = this['backoff']['duration']();
            b('will wait %dms before reconnect attempt', c);
            this['reconnecting'] = !![];
            var d = setTimeout(function() {
                if (a['skipReconnect']) return;
                b('attempting reconnect');
                a['emitAll']('reconnect_attempt', a['backoff']['attempts']);
                a['emitAll']('reconnecting', a['backoff']['attempts']);
                if (a['skipReconnect']) return;
                a['open'](function(c) {
                    if (c) {
                        b('reconnect attempt error');
                        a['reconnecting'] = ![];
                        a['reconnect']();
                        a['emitAll']('reconnect_error', c['data']);
                    } else {
                        b('reconnect success');
                        a['onreconnect']();
                    }
                });
            }, c);
            this['subs']['push']({
                'destroy': function() {
                    clearTimeout(d);
                }
            });
        }
    };
    a['prototype']['onreconnect'] = function() {
        var a = this['backoff']['attempts'];
        this['reconnecting'] = ![];
        this['backoff']['reset']();
        this['updateSocketIds']();
        this['emitAll']('reconnect', a);
    };
}, function(a, c) {
    a['exports'] = b;

    function b(a, b, c) {
        a['on'](b, c);
        return {
            'destroy': function() {
                a['removeListener'](b, c);
            }
        };
    }
}, function(l, m, d) {
    var b = d(0x9);
    var i = d(0x15);
    var g = d(0x42);
    var f = d(0x13);
    var h = d(0xb);
    var c = d(0x4)('socket.io-client:socket');
    var j = d(0xe);
    l['exports'] = m = a;
    var k = {
        'connect': 0x1,
        'connect_error': 0x1,
        'connect_timeout': 0x1,
        'connecting': 0x1,
        'disconnect': 0x1,
        'error': 0x1,
        'reconnect': 0x1,
        'reconnect_attempt': 0x1,
        'reconnect_failed': 0x1,
        'reconnect_error': 0x1,
        'reconnecting': 0x1,
        'ping': 0x1,
        'pong': 0x1
    };
    var e = i['prototype']['emit'];

    function a(b, c, a) {
        this['io'] = b;
        this['nsp'] = c;
        this['json'] = this;
        this['ids'] = 0x0;
        this['acks'] = {};
        this['receiveBuffer'] = [];
        this['sendBuffer'] = [];
        this['connected'] = ![];
        this['disconnected'] = !![];
        if (a && a['query']) {
            this['query'] = a['query'];
        }
        if (this['io']['autoConnect']) this['open']();
    }
    i(a['prototype']);
    a['prototype']['subEvents'] = function() {
        if (this['subs']) return;
        var a = this['io'];
        this['subs'] = [f(a, 'open', h(this, 'onopen')), f(a, 'packet', h(this, 'onpacket')), f(a, 'close', h(this, 'onclose'))];
    };
    a['prototype']['open'] = a['prototype']['connect'] = function() {
        if (this['connected']) return this;
        this['subEvents']();
        this['io']['open']();
        if ('open' === this['io']['readyState']) this['onopen']();
        this['emit']('connecting');
        return this;
    };
    a['prototype']['send'] = function() {
        var a = g(arguments);
        a['unshift']('message');
        this['emit']['apply'](this, a);
        return this;
    };
    a['prototype']['emit'] = function(h) {
        if (k['hasOwnProperty'](h)) {
            e['apply'](this, arguments);
            return this;
        }
        var a = g(arguments);
        var f = b['EVENT'];
        if (j(a)) {
            f = b['BINARY_EVENT'];
        }
        var d = {
            'type': f,
            'data': a
        };
        d['options'] = {};
        d['options']['compress'] = !this['flags'] || ![] !== this['flags']['compress'];
        if ('function' === typeof a[a['length'] - 0x1]) {
            c('emitting packet with ack id %d', this['ids']);
            this['acks'][this['ids']] = a['pop']();
            d['id'] = this['ids']++;
        }
        if (this['connected']) {
            this['packet'](d);
        } else {
            this['sendBuffer']['push'](d);
        }
        delete this['flags'];
        return this;
    };
    a['prototype']['packet'] = function(a) {
        a['nsp'] = this['nsp'];
        this['io']['packet'](a);
    };
    a['prototype']['onopen'] = function() {
        c('transport is open - connecting');
        if ('/' !== this['nsp']) {
            if (this['query']) {
                this['packet']({
                    'type': b['CONNECT'],
                    'query': this['query']
                });
            } else {
                this['packet']({
                    'type': b['CONNECT']
                });
            }
        }
    };
    a['prototype']['onclose'] = function(a) {
        c('close (%s)', a);
        this['connected'] = ![];
        this['disconnected'] = !![];
        delete this['id'];
        this['emit']('disconnect', a);
    };
    a['prototype']['onpacket'] = function(a) {
        if (a['nsp'] !== this['nsp']) return;
        switch (a['type']) {
            case b['CONNECT']:
                this['onconnect']();
                break;
            case b['EVENT']:
                this['onevent'](a);
                break;
            case b['BINARY_EVENT']:
                this['onevent'](a);
                break;
            case b['ACK']:
                this['onack'](a);
                break;
            case b['BINARY_ACK']:
                this['onack'](a);
                break;
            case b['DISCONNECT']:
                this['ondisconnect']();
                break;
            case b['ERROR']:
                this['emit']('error', a['data']);
                break;
        }
    };
    a['prototype']['onevent'] = function(b) {
        var a = b['data'] || [];
        c('emitting event %j', a);
        if (null != b['id']) {
            c('attaching ack callback to event');
            a['push'](this['ack'](b['id']));
        }
        if (this['connected']) {
            e['apply'](this, a);
        } else {
            this['receiveBuffer']['push'](a);
        }
    };
    a['prototype']['ack'] = function(e) {
        var d = this;
        var a = ![];
        return function() {
            if (a) return;
            a = !![];
            var f = g(arguments);
            c('sending ack %j', f);
            var h = j(f) ? b['BINARY_ACK'] : b['ACK'];
            d['packet']({
                'type': h,
                'id': e,
                'data': f
            });
        };
    };
    a['prototype']['onack'] = function(a) {
        var b = this['acks'][a['id']];
        if ('function' === typeof b) {
            c('calling ack %s with %j', a['id'], a['data']);
            b['apply'](this, a['data']);
            delete this['acks'][a['id']];
        } else {
            c('bad ack %s', a['id']);
        }
    };
    a['prototype']['onconnect'] = function() {
        this['connected'] = !![];
        this['disconnected'] = ![];
        this['emit']('connect');
        this['emitBuffered']();
    };
    a['prototype']['emitBuffered'] = function() {
        var a;
        for (a = 0x0; a < this['receiveBuffer']['length']; a++) {
            e['apply'](this, this['receiveBuffer'][a]);
        }
        this['receiveBuffer'] = [];
        for (a = 0x0; a < this['sendBuffer']['length']; a++) {
            this['packet'](this['sendBuffer'][a]);
        }
        this['sendBuffer'] = [];
    };
    a['prototype']['ondisconnect'] = function() {
        c('server disconnect (%s)', this['nsp']);
        this['destroy']();
        this['onclose']('io server disconnect');
    };
    a['prototype']['destroy'] = function() {
        if (this['subs']) {
            for (var a = 0x0; a < this['subs']['length']; a++) {
                this['subs'][a]['destroy']();
            }
            this['subs'] = null;
        }
        this['io']['destroy'](this);
    };
    a['prototype']['close'] = a['prototype']['disconnect'] = function() {
        if (this['connected']) {
            c('performing disconnect (%s)', this['nsp']);
            this['packet']({
                'type': b['DISCONNECT']
            });
        }
        this['destroy']();
        if (this['connected']) {
            this['onclose']('io client disconnect');
        }
        return this;
    };
    a['prototype']['compress'] = function(a) {
        this['flags'] = this['flags'] || {};
        this['flags']['compress'] = a;
        return this;
    };
}, function(b, d, e) {
    if (!![]) {
        b['exports'] = a;
    }

    function a(a) {
        if (a) return c(a);
    };

    function c(c) {
        for (var b in a['prototype']) {
            c[b] = a['prototype'][b];
        }
        return c;
    }
    a['prototype']['on'] = a['prototype']['addEventListener'] = function(a, b) {
        this['_callbacks'] = this['_callbacks'] || {};
        (this['_callbacks']['$' + a] = this['_callbacks']['$' + a] || [])['push'](b);
        return this;
    };
    a['prototype']['once'] = function(b, c) {
        function a() {
            this['off'](b, a);
            c['apply'](this, arguments);
        }
        a['fn'] = c;
        this['on'](b, a);
        return this;
    };
    a['prototype']['off'] = a['prototype']['removeListener'] = a['prototype']['removeAllListeners'] = a['prototype']['removeEventListener'] = function(d, e) {
        this['_callbacks'] = this['_callbacks'] || {};
        if (0x0 == arguments['length']) {
            this['_callbacks'] = {};
            return this;
        }
        var a = this['_callbacks']['$' + d];
        if (!a) return this;
        if (0x1 == arguments['length']) {
            delete this['_callbacks']['$' + d];
            return this;
        }
        var c;
        for (var b = 0x0; b < a['length']; b++) {
            c = a[b];
            if (c === e || c['fn'] === e) {
                a['splice'](b, 0x1);
                break;
            }
        }
        return this;
    };
    a['prototype']['emit'] = function(e) {
        this['_callbacks'] = this['_callbacks'] || {};
        var c = []['slice']['call'](arguments, 0x1),
            a = this['_callbacks']['$' + e];
        if (a) {
            a = a['slice'](0x0);
            for (var b = 0x0, d = a['length']; b < d; ++b) {
                a[b]['apply'](this, c);
            }
        }
        return this;
    };
    a['prototype']['listeners'] = function(a) {
        this['_callbacks'] = this['_callbacks'] || {};
        return this['_callbacks']['$' + a] || [];
    };
    a['prototype']['hasListeners'] = function(a) {
        return !!this['listeners'](a)['length'];
    };
}, function(a, b, c) {
    (function(b) {
        a['exports'] = c;

        function c(a) {
            return b['Buffer'] && b['Buffer']['isBuffer'](a) || b['ArrayBuffer'] && a instanceof ArrayBuffer;
        }
    }['call'](b, c(0x0)));
}, function(i, l, k) {
    'use strict';
    var e = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_' ['split'](''),
        b = 0x40,
        c = {},
        g = 0x0,
        a = 0x0,
        h;

    function f(a) {
        var c = '';
        do {
            c = e[a % b] + c;
            a = Math['floor'](a / b);
        } while (a > 0x0);
        return c;
    }

    function j(e) {
        var d = 0x0;
        for (a = 0x0; a < e['length']; a++) {
            d = d * b + c[e['charAt'](a)];
        }
        return d;
    }

    function d() {
        var a = f(+new Date());
        if (a !== h) return g = 0x0, h = a;
        return a + '.' + f(g++);
    }
    for (; a < b; a++) c[e[a]] = a;
    d['encode'] = f;
    d['decode'] = j;
    i['exports'] = d;
}, function(a, b) {
    a['exports'] = function(a) {
        if (!a['webpackPolyfill']) {
            a['deprecate'] = function() {};
            a['paths'] = [];
            if (!a['children']) a['children'] = [];
            Object['defineProperty'](a, 'loaded', {
                'enumerable': !![],
                'get': function() {
                    return a['l'];
                }
            });
            Object['defineProperty'](a, 'id', {
                'enumerable': !![],
                'get': function() {
                    return a['i'];
                }
            });
            a['webpackPolyfill'] = 0x1;
        }
        return a;
    };
}, function(j, a, b) {
    var g = b(0x3b);
    var f = b(0x9);
    var d = b(0x12);
    var e = b(0x4)('socket.io-client');
    j['exports'] = a = h;
    var c = a['managers'] = {};

    function h(j, a) {
        if (typeof j === 'object') {
            a = j;
            j = undefined;
        }
        a = a || {};
        var b = g(j);
        var h = b['source'];
        var f = b['id'];
        var l = b['path'];
        var m = c[f] && l in c[f]['nsps'];
        var n = a['forceNew'] || a['force new connection'] || ![] === a['multiplex'] || m;
        var k;
        if (n) {
            e('ignoring socket cache for %s', h);
            k = d(h, a);
        } else {
            if (!c[f]) {
                e('new io instance for %s', h);
                c[f] = d(h, a);
            }
            k = c[f];
        }
        if (b['query'] && !a['query']) {
            a['query'] = b['query'];
        } else if (a && 'object' === typeof a['query']) {
            a['query'] = i(a['query']);
        }
        return k['socket'](b['path'], a);
    }

    function i(b) {
        var c = [];
        for (var a in b) {
            if (b['hasOwnProperty'](a)) {
                c['push'](encodeURIComponent(a) + '=' + encodeURIComponent(b[a]));
            }
        }
        return c['join']('&');
    }
    a['protocol'] = f['protocol'];
    a['connect'] = h;
    a['Manager'] = b(0x12);
    a['Socket'] = b(0x14);
}, function(a, b, c) {
    (function(b) {
        a['exports']['maxScreenWidth'] = 0x780;
        a['exports']['maxScreenHeight'] = 0x438;
        a['exports']['serverUpdateRate'] = 0x9;
        a['exports']['maxPlayers'] = b && b['argv']['indexOf']('--largeserver') != -0x1 ? 0x50 : 0x28;
        a['exports']['collisionDepth'] = 0x6;
        a['exports']['minimapRate'] = 0xbb8;
        a['exports']['colGrid'] = 0xa;
        a['exports']['clientSendRate'] = 0x5;
        a['exports']['healthBarWidth'] = 0x32;
        a['exports']['healthBarPad'] = 4.5;
        a['exports']['iconPadding'] = 0xf;
        a['exports']['iconPad'] = 0.9;
        a['exports']['deathFadeout'] = 0xbb8;
        a['exports']['crownIconScale'] = 0x3c;
        a['exports']['crownPad'] = 0x23;
        a['exports']['chatCountdown'] = 0xbb8;
        a['exports']['chatCooldown'] = 0x1f4;
        a['exports']['inSandbox'] = b ? b['argv']['indexOf']('--sandbox') !== -0x1 : ![];
        a['exports']['maxAge'] = 0x3c;
        a['exports']['gatherAngle'] = Math['PI'] / 2.6;
        a['exports']['gatherWiggle'] = 0xa;
        a['exports']['hitReturnRatio'] = 0.25;
        a['exports']['hitAngle'] = Math['PI'] / 0x2;
        a['exports']['playerScale'] = 0x23;
        a['exports']['playerSpeed'] = 0.0016;
        a['exports']['playerDecel'] = 0.993;
        a['exports']['nameY'] = 0x22;
        a['exports']['skinColors'] = ['#bf8f54', '#cbb091', '#896c4b', '#fadadc', '#ececec', '#c37373'];
        a['exports']['animalCount'] = 0x7;
        a['exports']['aiTurnRandom'] = 0.06;
        a['exports']['cowNames'] = ['Sid', 'Steph', 'Bmoe', 'Romn', 'Jononthecool', 'Fiona', 'Vince', 'Nathan', 'Nick', 'Flappy', 'Ronald', 'Otis', 'Pepe', 'Mc Donald', 'Theo', 'Fabz', 'Oliver', 'Jeff', 'Jimmy', 'Ben', 'Alan', 'Naomi', 'XYZ', 'Clever', 'Jeremy', 'Mike', 'Destined', 'Stallion', 'Allison', 'Meaty', 'Sophia', 'Vaja', 'Joey', 'Pendy', 'Murdoch', 'Theo', 'Jared', 'July', 'Sonia', 'Mel', 'Dexter', 'Quinn', 'Milky'];
        a['exports']['shieldAngle'] = Math['PI'] / 0x3;
        a['exports']['weaponVariants'] = [{
            'id': 0x0,
            'src': '',
            'xp': 0x0,
            'val': 0x1
        }, {
            'id': 0x1,
            'src': '_g',
            'xp': 0x1388,
            'val': 1.1
        }, {
            'id': 0x2,
            'src': '_d',
            'xp': 0x2710,
            'val': 1.18
        }];
        a['exports']['fetchVariant'] = function(c) {
            var d = c['weaponXP'][c['weaponIndex']] || 0x0;
            for (var b = a['exports']['weaponVariants']['length'] - 0x1; b >= 0x0; --b) {
                if (d >= a['exports']['weaponVariants'][b]['xp']) return a['exports']['weaponVariants'][b];
            }
        };
        a['exports']['resourceTypes'] = ['wood', 'food', 'stone', 'points'];
        a['exports']['areaCount'] = 0x7;
        a['exports']['treesPerArea'] = 0x9;
        a['exports']['bushesPerArea'] = 0x3;
        a['exports']['totalRocks'] = 0x20;
        a['exports']['goldOres'] = 0x7;
        a['exports']['riverWidth'] = 0x2d4;
        a['exports']['riverPadding'] = 0x72;
        a['exports']['waterCurrent'] = 0.0011;
        a['exports']['waveSpeed'] = 0.0001;
        a['exports']['waveMax'] = 1.3;
        a['exports']['treeScales'] = [0x96, 0xa0, 0xa5, 0xaf];
        a['exports']['bushScales'] = [0x50, 0x55, 0x5f];
        a['exports']['rockScales'] = [0x50, 0x55, 0x5a];
        a['exports']['snowBiomeTop'] = 0x960;
        a['exports']['snowSpeed'] = 0.8;
        a['exports']['maxNameLength'] = 0xf;
        a['exports']['mapScale'] = 0x3840;
        a['exports']['mapPingScale'] = 0x28;
        a['exports']['mapPingTime'] = 0x898;
    }['call'](b, c(0xa)));
}, function(b, c) {
    var a = Math['PI'] * 0x2;
    b['exports'] = function(g, f, d, j, c, b, h, i) {
        this['sid'] = g;
        this['isAI'] = !![];
        this['nameIndex'] = c['randInt'](0x0, b['cowNames']['length'] - 0x1);
        this['init'] = function(b, c, d, e, a) {
            this['x'] = b;
            this['y'] = c;
            this['xVel'] = 0x0;
            this['yVel'] = 0x0;
            this['zIndex'] = 0x0;
            this['dir'] = d;
            this['index'] = e;
            this['src'] = a['src'];
            if (a['name']) this['name'] = a['name'];
            this['weightM'] = a['weightM'];
            this['speed'] = a['speed'];
            this['killScore'] = a['killScore'];
            this['turnSpeed'] = a['turnSpeed'];
            this['scale'] = a['scale'];
            this['maxHealth'] = a['health'];
            this['health'] = this['maxHealth'];
            this['chargePlayer'] = a['chargePlayer'];
            this['viewRange'] = a['viewRange'];
            this['drop'] = a['drop'];
            this['dmg'] = a['dmg'];
            this['hostile'] = a['hostile'];
            this['waitCount'] = 0x3e8;
            this['moveCount'] = 0x0;
            this['targetDir'] = 0x0;
            this['active'] = !![];
            this['alive'] = !![];
            this['runFrom'] = null;
            this['chargeTarget'] = null;
            this['dmgOverTime'] = {};
        };
        var e = 0x0;
        this['update'] = function(h) {
            if (this['active']) {
                e -= h;
                if (e <= 0x0) {
                    if (this['dmgOverTime']['dmg']) {
                        this['changeHealth'](-this['dmgOverTime']['dmg'], this['dmgOverTime']['doer']);
                        this['dmgOverTime']['time'] -= 0x1;
                        if (this['dmgOverTime']['time'] <= 0x0) this['dmgOverTime']['dmg'] = 0x0;
                    }
                    e = 0x3e8;
                }
                var s = ![];
                var u = 0x1;
                if (!this['zIndex'] && !this['lockMove'] && this['y'] >= b['mapScale'] / 0x2 - b['riverWidth'] / 0x2 && this['y'] <= b['mapScale'] / 0x2 + b['riverWidth'] / 0x2) {
                    u = 0.33;
                    this['xVel'] += b['waterCurrent'] * h;
                }
                if (this['lockMove']) {
                    this['xVel'] = 0x0;
                    this['yVel'] = 0x0;
                } else if (this['waitCount'] > 0x0) {
                    this['waitCount'] -= h;
                    if (this['waitCount'] <= 0x0) {
                        if (this['chargePlayer']) {
                            var q, w, o;
                            for (var g = 0x0; g < d['length']; ++g) {
                                if (d[g]['alive'] && !(d[g]['skin'] && d[g]['skin']['bullRepel'])) {
                                    o = c['getDistance'](this['x'], this['y'], d[g]['x'], d[g]['y']);
                                    if (o <= this['viewRange'] && (!q || o < w)) {
                                        w = o;
                                        q = d[g];
                                    }
                                }
                            }
                            if (q) {
                                this['chargeTarget'] = q;
                                this['moveCount'] = c['randInt'](0x1f40, 0x2ee0);
                            } else {
                                this['moveCount'] = c['randInt'](0x3e8, 0x7d0);
                                this['targetDir'] = c['randFloat'](-Math['PI'], Math['PI']);
                            }
                        } else {
                            this['moveCount'] = c['randInt'](0xfa0, 0x2710);
                            this['targetDir'] = c['randFloat'](-Math['PI'], Math['PI']);
                        }
                    }
                } else if (this['moveCount'] > 0x0) {
                    var l = this['speed'] * u;
                    if (this['runFrom'] && this['runFrom']['active'] && !(this['runFrom']['isPlayer'] && !this['runFrom']['alive'])) {
                        this['targetDir'] = c['getDirection'](this['x'], this['y'], this['runFrom']['x'], this['runFrom']['y']);
                        l *= 1.42;
                    } else if (this['chargeTarget'] && this['chargeTarget']['alive']) {
                        this['targetDir'] = c['getDirection'](this['chargeTarget']['x'], this['chargeTarget']['y'], this['x'], this['y']);
                        l *= 1.75;
                        s = !![];
                    }
                    if (this['dir'] != this['targetDir']) {
                        this['dir'] %= a;
                        var p = (this['dir'] - this['targetDir'] + a) % a;
                        var y = Math['min'](Math['abs'](p - a), p, this['turnSpeed'] * h);
                        var A = p - Math['PI'] >= 0x0 ? 0x1 : -0x1;
                        this['dir'] += A * y + a;
                    }
                    this['dir'] %= a;
                    this['xVel'] += l * h * Math['cos'](this['dir']);
                    this['yVel'] += l * h * Math['sin'](this['dir']);
                    this['moveCount'] -= h;
                    if (this['moveCount'] <= 0x0) {
                        this['runFrom'] = null;
                        this['chargeTarget'] = null;
                        this['waitCount'] = this['hostile'] ? 0x5dc : c['randInt'](0x5dc, 0x1770);
                    }
                }
                this['zIndex'] = 0x0;
                this['lockMove'] = ![];
                var m;
                var x = c['getDistance'](0x0, 0x0, this['xVel'] * h, this['yVel'] * h);
                var v = Math['min'](0x4, Math['max'](0x1, Math['round'](x / 0x28)));
                var r = 0x1 / v;
                for (var g = 0x0; g < v; ++g) {
                    if (this['xVel']) this['x'] += this['xVel'] * h * r;
                    if (this['yVel']) this['y'] += this['yVel'] * h * r;
                    m = f['getGridArrays'](this['x'], this['y'], this['scale']);
                    for (var k = 0x0; k < m['length']; ++k) {
                        for (var n = 0x0; n < m[k]['length']; ++n) {
                            if (m[k][n]['active']) f['checkCollision'](this, m[k][n], r);
                        }
                    }
                }
                if (s) {
                    var i, z, t;
                    for (var g = 0x0; g < d['length']; ++g) {
                        i = d[g];
                        if (i && i['alive']) {
                            z = c['getDistance'](this['x'], this['y'], i['x'], i['y']);
                            if (z <= this['scale'] + i['scale']) {
                                t = c['getDirection'](i['x'], i['y'], this['x'], this['y']);
                                i['changeHealth'](-this['dmg']);
                                i['xVel'] += 0.55 * Math['cos'](t);
                                i['yVel'] += 0.55 * Math['sin'](t);
                            }
                        }
                    }
                }
                if (this['xVel']) this['xVel'] *= Math['pow'](b['playerDecel'], h);
                if (this['yVel']) this['yVel'] *= Math['pow'](b['playerDecel'], h);
                var j = this['scale'];
                if (this['x'] - j < 0x0) {
                    this['x'] = j;
                    this['xVel'] = 0x0;
                } else if (this['x'] + j > b['mapScale']) {
                    this['x'] = b['mapScale'] - j;
                    this['xVel'] = 0x0;
                }
                if (this['y'] - j < 0x0) {
                    this['y'] = j;
                    this['yVel'] = 0x0;
                } else if (this['y'] + j > b['mapScale']) {
                    this['y'] = b['mapScale'] - j;
                    this['yVel'] = 0x0;
                }
            }
        };
        this['canSee'] = function(a) {
            if (!a) return ![];
            var c = Math['abs'](a['x'] - this['x']) - a['scale'];
            var d = Math['abs'](a['y'] - this['y']) - a['scale'];
            return c <= b['maxScreenWidth'] / 0x2 * 1.3 && d <= b['maxScreenHeight'] / 0x2 * 1.3;
        };
        this['changeHealth'] = function(f, a, e) {
            if (this['active']) {
                this['health'] += f;
                if (e) {
                    if (this['hostile'] && this['chargePlayer'] && e['isPlayer']) {
                        this['chargeTarget'] = e;
                        this['waitCount'] = 0x0;
                        this['moveCount'] = 0x1f40;
                    } else {
                        this['runFrom'] = e;
                        this['waitCount'] = 0x0;
                        this['moveCount'] = 0xfa0;
                    }
                }
                if (a && a['canSee'](this) && f < 0x0) {
                    i['to'](a['id'])['emit']('t', Math['round'](this['x']), Math['round'](this['y']), Math['round'](-f), 0x1);
                }
                if (this['health'] <= 0x0) {
                    this['x'] = c['randInt'](0x0, b['mapScale']);
                    this['y'] = c['randInt'](0x0, b['mapScale']);
                    this['health'] = this['maxHealth'];
                    this['runFrom'] = null;
                    if (a) {
                        h(a, this['killScore']);
                        if (this['drop']) {
                            for (var d = 0x0; d < this['drop']['length'];) {
                                a['addResource'](b['resourceTypes']['indexOf'](this['drop'][d]), this['drop'][d + 0x1]);
                                d += 0x2;
                            }
                        }
                    }
                }
            }
        };
    };
}, function(a, b) {
    a['exports'] = function(a, b, c, d, e, f, g, h, i) {
        this['aiTypes'] = [{
            'id': 0x0,
            'src': 'cow_1',
            'killScore': 0x96,
            'health': 0x1f4,
            'weightM': 0.8,
            'speed': 0.00095,
            'turnSpeed': 0.001,
            'scale': 0x48,
            'drop': ['food', 0x32]
        }, {
            'id': 0x1,
            'src': 'pig_1',
            'killScore': 0xc8,
            'health': 0x320,
            'weightM': 0.6,
            'speed': 0.00085,
            'turnSpeed': 0.001,
            'scale': 0x48,
            'drop': ['food', 0x50]
        }, {
            'id': 0x2,
            'name': 'Bull',
            'src': 'bull_2',
            'hostile': !![],
            'dmg': 0x14,
            'killScore': 0x3e8,
            'health': 0x708,
            'weightM': 0.5,
            'speed': 0.00094,
            'turnSpeed': 0.00074,
            'scale': 0x4e,
            'viewRange': 0x320,
            'chargePlayer': !![],
            'drop': ['food', 0x64]
        }, {
            'id': 0x3,
            'name': 'Bully',
            'src': 'bull_1',
            'hostile': !![],
            'dmg': 0x14,
            'killScore': 0x7d0,
            'health': 0xaf0,
            'weightM': 0.45,
            'speed': 0.001,
            'turnSpeed': 0.0008,
            'scale': 0x5a,
            'viewRange': 0x384,
            'chargePlayer': !![],
            'drop': ['food', 0x190]
        }, {
            'id': 0x4,
            'name': 'Wolf',
            'src': 'wolf_1',
            'hostile': !![],
            'dmg': 0x8,
            'killScore': 0x1f4,
            'health': 0x12c,
            'weightM': 0.45,
            'speed': 0.001,
            'turnSpeed': 0.002,
            'scale': 0x54,
            'viewRange': 0x320,
            'chargePlayer': !![],
            'drop': ['food', 0xc8]
        }, {
            'id': 0x5,
            'name': 'Quack',
            'src': 'chicken_1',
            'dmg': 0x8,
            'killScore': 0x7d0,
            'health': 0x12c,
            'weightM': 0.2,
            'speed': 0.0018,
            'turnSpeed': 0.006,
            'scale': 0x46,
            'drop': ['food', 0x64]
        }];
        this['spawn'] = function(m, n, o, l) {
            var j;
            for (var k = 0x0; k < a['length']; ++k) {
                if (!a[k]['active']) {
                    j = a[k];
                    break;
                }
            }
            if (!j) {
                j = new b(a['length'], e, c, d, g, f, h, i);
                a['push'](j);
            }
            j['init'](m, n, o, l, this['aiTypes'][l]);
            return j;
        };
    };
}, function(a, b) {
    a['exports'] = function(a) {
        this['sid'] = a;
        this['init'] = function(b, c, d, e, f, a, g) {
            a = a || {};
            this['sentTo'] = {};
            this['gridLocations'] = [];
            this['active'] = !![];
            this['doUpdate'] = a['doUpdate'];
            this['x'] = b;
            this['y'] = c;
            this['dir'] = d;
            this['xWiggle'] = 0x0;
            this['yWiggle'] = 0x0;
            this['scale'] = e;
            this['type'] = f;
            this['id'] = a['id'];
            this['owner'] = g;
            this['name'] = a['name'];
            this['isItem'] = this['id'] != undefined;
            this['group'] = a['group'];
            this['health'] = a['health'];
            this['layer'] = 0x2;
            if (this['group'] != undefined) {
                this['layer'] = this['group']['layer'];
            } else if (this['type'] == 0x0) {
                this['layer'] = 0x3;
            } else if (this['type'] == 0x2) {
                this['layer'] = 0x0;
            } else if (this['type'] == 0x4) {
                this['layer'] = -0x1;
            }
            this['colDiv'] = a['colDiv'] || 0x1;
            this['ignoreCollision'] = a['ignoreCollision'];
            this['dontGather'] = a['dontGather'];
            this['hideFromEnemy'] = a['hideFromEnemy'];
            this['friction'] = a['friction'];
            this['projDmg'] = a['projDmg'];
            this['dmg'] = a['dmg'];
            this['pDmg'] = a['pDmg'];
            this['pps'] = a['pps'];
            this['zIndex'] = a['zIndex'] || 0x0;
            this['turnSpeed'] = a['turnSpeed'];
            this['req'] = a['req'];
            this['trap'] = a['trap'];
            this['healCol'] = a['healCol'];
            this['boostSpeed'] = a['boostSpeed'];
            this['projectile'] = a['projectile'];
            this['shootRange'] = a['shootRange'];
            this['shootRate'] = a['shootRate'];
            this['shootCount'] = this['shootRate'];
            this['spawnPoint'] = a['spawnPoint'];
        };
        this['changeHealth'] = function(a, b) {
            this['health'] += a;
            return this['health'] <= 0x0;
        };
        this['getScale'] = function(a, b) {
            a = a || 0x1;
            return this['scale'] * (this['isItem'] || this['type'] == 0x2 || this['type'] == 0x3 || this['type'] == 0x4 ? 0x1 : 0.6 * a) * (b ? 0x1 : this['colDiv']);
        };
        this['visibleToPlayer'] = function(a) {
            return !this['hideFromEnemy'] || this['owner'] && (this['owner'] == a || this['owner']['team'] && a['team'] == this['owner']['team']);
        };
        this['update'] = function(a) {
            if (this['active']) {
                if (this['xWiggle']) {
                    this['xWiggle'] *= Math['pow'](0.99, a);
                }
                if (this['yWiggle']) {
                    this['yWiggle'] *= Math['pow'](0.99, a);
                }
                if (this['turnSpeed']) {
                    this['dir'] += this['turnSpeed'] * a;
                }
            }
        };
    };
}, function(a, c) {
    a['exports']['groups'] = [{
        'id': 0x0,
        'name': 'food',
        'layer': 0x0
    }, {
        'id': 0x1,
        'name': 'walls',
        'place': !![],
        'limit': 0x1e,
        'layer': 0x0
    }, {
        'id': 0x2,
        'name': 'spikes',
        'place': !![],
        'limit': 0xf,
        'layer': 0x0
    }, {
        'id': 0x3,
        'name': 'mill',
        'place': !![],
        'limit': 0x7,
        'layer': 0x1
    }, {
        'id': 0x4,
        'name': 'mine',
        'place': !![],
        'limit': 0x1,
        'layer': 0x0
    }, {
        'id': 0x5,
        'name': 'trap',
        'place': !![],
        'limit': 0x6,
        'layer': -0x1
    }, {
        'id': 0x6,
        'name': 'booster',
        'place': !![],
        'limit': 0xc,
        'layer': -0x1
    }, {
        'id': 0x7,
        'name': 'turret',
        'place': !![],
        'limit': 0x2,
        'layer': 0x1
    }, {
        'id': 0x8,
        'name': 'watchtower',
        'place': !![],
        'limit': 0xc,
        'layer': 0x1
    }, {
        'id': 0x9,
        'name': 'buff',
        'place': !![],
        'limit': 0x4,
        'layer': -0x1
    }, {
        'id': 0xa,
        'name': 'spawn',
        'place': !![],
        'limit': 0x1,
        'layer': -0x1
    }];
    c['projectiles'] = [{
        'indx': 0x0,
        'layer': 0x0,
        'src': 'arrow_1',
        'dmg': 0x19,
        'speed': 1.6,
        'scale': 0x67,
        'range': 0x3e8
    }, {
        'indx': 0x1,
        'layer': 0x1,
        'dmg': 0x19,
        'scale': 0x14
    }, {
        'indx': 0x0,
        'layer': 0x0,
        'src': 'arrow_1',
        'dmg': 0x23,
        'speed': 2.5,
        'scale': 0x67,
        'range': 0x4b0
    }, {
        'indx': 0x0,
        'layer': 0x0,
        'src': 'arrow_1',
        'dmg': 0x19,
        'speed': 0x2,
        'scale': 0x67,
        'range': 0x4b0
    }, {
        'indx': 0x1,
        'layer': 0x1,
        'dmg': 0x10,
        'scale': 0x14
    }];
    c['weapons'] = [{
        'id': 0x0,
        'type': 0x0,
        'name': 'tool hammer',
        'desc': 'tool for gathering all resources',
        'src': 'hammer_1',
        'length': 0x8c,
        'width': 0x8c,
        'xOff': -0x3,
        'yOff': 0x12,
        'dmg': 0x19,
        'range': 0x41,
        'gather': 0x1,
        'speed': 0x12c
    }, {
        'id': 0x1,
        'type': 0x0,
        'age': 0x2,
        'name': 'hand axe',
        'desc': 'gathers resources at a higher rate',
        'src': 'axe_1',
        'length': 0x8c,
        'width': 0x8c,
        'xOff': 0x3,
        'yOff': 0x18,
        'dmg': 0x1e,
        'spdMult': 0x1,
        'range': 0x46,
        'gather': 0x2,
        'speed': 0x190
    }, {
        'id': 0x2,
        'type': 0x0,
        'age': 0x8,
        'pre': 0x1,
        'name': 'great axe',
        'desc': 'deal more damage and gather more resources',
        'src': 'great_axe_1',
        'length': 0x8c,
        'width': 0x8c,
        'xOff': -0x8,
        'yOff': 0x19,
        'dmg': 0x23,
        'spdMult': 0x1,
        'range': 0x4b,
        'gather': 0x4,
        'speed': 0x190
    }, {
        'id': 0x3,
        'type': 0x0,
        'age': 0x2,
        'name': 'short sword',
        'desc': 'increased attack power but slower move speed',
        'src': 'sword_1',
        'iPad': 1.3,
        'length': 0x82,
        'width': 0xd2,
        'xOff': -0x8,
        'yOff': 0x2e,
        'dmg': 0x23,
        'spdMult': 0.85,
        'range': 0x6e,
        'gather': 0x1,
        'speed': 0x12c
    }, {
        'id': 0x4,
        'type': 0x0,
        'age': 0x8,
        'pre': 0x3,
        'name': 'katana',
        'desc': 'greater range and damage',
        'src': 'samurai_1',
        'iPad': 1.3,
        'length': 0x82,
        'width': 0xd2,
        'xOff': -0x8,
        'yOff': 0x3b,
        'dmg': 0x28,
        'spdMult': 0.8,
        'range': 0x76,
        'gather': 0x1,
        'speed': 0x12c
    }, {
        'id': 0x5,
        'type': 0x0,
        'age': 0x2,
        'name': 'polearm',
        'desc': 'long range melee weapon',
        'src': 'spear_1',
        'iPad': 1.3,
        'length': 0x82,
        'width': 0xd2,
        'xOff': -0x8,
        'yOff': 0x35,
        'dmg': 0x2d,
        'knock': 0.2,
        'spdMult': 0.82,
        'range': 0x8e,
        'gather': 0x1,
        'speed': 0x2bc
    }, {
        'id': 0x6,
        'type': 0x1,
        'age': 0x6,
        'name': 'hunting bow',
        'desc': 'bow used for ranged combat and hunting',
        'src': 'bow_1',
        'req': ['wood', 0x4],
        'length': 0x78,
        'width': 0x78,
        'xOff': -0x6,
        'yOff': 0x0,
        'projectile': 0x0,
        'spdMult': 0.75,
        'speed': 0x258
    }, {
        'id': 0x7,
        'type': 0x1,
        'age': 0x6,
        'name': 'great hammer',
        'desc': 'hammer used for destroying structures',
        'src': 'great_hammer_1',
        'length': 0x8c,
        'width': 0x8c,
        'xOff': -0x9,
        'yOff': 0x19,
        'dmg': 0xa,
        'spdMult': 0.88,
        'range': 0x4b,
        'sDmg': 7.5,
        'gather': 0x1,
        'speed': 0x190
    }, {
        'id': 0x8,
        'type': 0x1,
        'age': 0x6,
        'name': 'wooden shield',
        'desc': 'blocks projectiles and reduces melee damage',
        'src': 'shield_1',
        'length': 0x78,
        'width': 0x78,
        'shield': 0.2,
        'xOff': 0x6,
        'yOff': 0x0,
        'spdMult': 0.65
    }, {
        'id': 0x9,
        'type': 0x1,
        'age': 0x8,
        'pre': 0x6,
        'name': 'crossbow',
        'desc': 'deals more damage and has greater range',
        'src': 'crossbow_1',
        'req': ['wood', 0x5],
        'aboveHand': !![],
        'armS': 0.75,
        'length': 0x78,
        'width': 0x78,
        'xOff': -0x4,
        'yOff': 0x0,
        'projectile': 0x2,
        'spdMult': 0.7,
        'speed': 0x2bc
    }, {
        'id': 0xa,
        'type': 0x1,
        'age': 0x9,
        'pre': 0x9,
        'name': 'repeater crossbow',
        'desc': 'high firerate crossbow with reduced damage',
        'src': 'crossbow_2',
        'req': ['wood', 0xa],
        'aboveHand': !![],
        'armS': 0.75,
        'length': 0x78,
        'width': 0x78,
        'xOff': -0x4,
        'yOff': 0x0,
        'projectile': 0x3,
        'spdMult': 0.7,
        'speed': 0x12c
    }];
    a['exports']['list'] = [{
        'group': a['exports']['groups'][0x0],
        'name': 'apple',
        'desc': 'restores 20 health when consumed',
        'req': ['food', 0xa],
        'consume': function(a) {
            return a['changeHealth'](0x14, a);
        },
        'scale': 0x16,
        'holdOffset': 0xf
    }, {
        'age': 0x3,
        'group': a['exports']['groups'][0x0],
        'name': 'cookie',
        'desc': 'restores 40 health when consumed',
        'req': ['food', 0xf],
        'consume': function(a) {
            return a['changeHealth'](0x28, a);
        },
        'scale': 0x1b,
        'holdOffset': 0xf
    }, {
        'group': a['exports']['groups'][0x1],
        'name': 'wood wall',
        'desc': 'provides protection for your village',
        'req': ['wood', 0xa],
        'projDmg': !![],
        'health': 0x15e,
        'scale': 0x32,
        'holdOffset': 0x14,
        'placeOffset': -0x5
    }, {
        'age': 0x3,
        'group': a['exports']['groups'][0x1],
        'name': 'stone wall',
        'desc': 'provides improved protection for your village',
        'req': ['stone', 0x19],
        'health': 0x384,
        'scale': 0x32,
        'holdOffset': 0x14,
        'placeOffset': -0x5
    }, {
        'age': 0x7,
        'pre': 0x1,
        'group': a['exports']['groups'][0x1],
        'name': 'castle wall',
        'desc': 'provides powerful protection for your village',
        'req': ['stone', 0x23],
        'health': 0x5dc,
        'scale': 0x34,
        'holdOffset': 0x14,
        'placeOffset': -0x5
    }, {
        'group': a['exports']['groups'][0x2],
        'name': 'spikes',
        'desc': 'damages enemies when they touch them',
        'req': ['wood', 0x14, 'stone', 0x5],
        'health': 0x190,
        'dmg': 0x14,
        'scale': 0x31,
        'spritePadding': -0x17,
        'holdOffset': 0x8,
        'placeOffset': -0x5
    }, {
        'age': 0x5,
        'group': a['exports']['groups'][0x2],
        'name': 'greater spikes',
        'desc': 'damages enemies when they touch them',
        'req': ['wood', 0x1e, 'stone', 0xa],
        'health': 0x1f4,
        'dmg': 0x23,
        'scale': 0x34,
        'spritePadding': -0x17,
        'holdOffset': 0x8,
        'placeOffset': -0x5
    }, {
        'age': 0x9,
        'pre': 0x1,
        'group': a['exports']['groups'][0x2],
        'name': 'poison spikes',
        'desc': 'poisons enemies when they touch them',
        'req': ['wood', 0x23, 'stone', 0xf],
        'health': 0x258,
        'dmg': 0x1e,
        'pDmg': 0x5,
        'scale': 0x34,
        'spritePadding': -0x17,
        'holdOffset': 0x8,
        'placeOffset': -0x5
    }, {
        'age': 0x9,
        'pre': 0x2,
        'group': a['exports']['groups'][0x2],
        'name': 'spinning spikes',
        'desc': 'damages enemies when they touch them',
        'req': ['wood', 0x1e, 'stone', 0x14],
        'health': 0x1f4,
        'dmg': 0x2d,
        'turnSpeed': 0.003,
        'scale': 0x34,
        'spritePadding': -0x17,
        'holdOffset': 0x8,
        'placeOffset': -0x5
    }, {
        'group': a['exports']['groups'][0x3],
        'name': 'windmill',
        'desc': 'generates gold over time',
        'req': ['wood', 0x32, 'stone', 0xa],
        'health': 0x190,
        'pps': 0x1,
        'turnSpeed': 0.0016,
        'spritePadding': 0x19,
        'iconLineMult': 0xc,
        'scale': 0x2d,
        'holdOffset': 0x14,
        'placeOffset': 0x5
    }, {
        'age': 0x5,
        'pre': 0x1,
        'group': a['exports']['groups'][0x3],
        'name': 'faster windmill',
        'desc': 'generates more gold over time',
        'req': ['wood', 0x3c, 'stone', 0x14],
        'health': 0x1f4,
        'pps': 1.5,
        'turnSpeed': 0.0025,
        'spritePadding': 0x19,
        'iconLineMult': 0xc,
        'scale': 0x2f,
        'holdOffset': 0x14,
        'placeOffset': 0x5
    }, {
        'age': 0x5,
        'group': a['exports']['groups'][0x4],
        'type': 0x2,
        'name': 'mine',
        'desc': 'allows you to mine stone',
        'req': ['wood', 0x14, 'stone', 0x64],
        'iconLineMult': 0xc,
        'scale': 0x41,
        'holdOffset': 0x14,
        'placeOffset': 0x0
    }, {
        'age': 0x4,
        'group': a['exports']['groups'][0x5],
        'name': 'pit trap',
        'desc': 'pit that traps enemies if they walk over it',
        'req': ['wood', 0x1e, 'stone', 0x1e],
        'trap': !![],
        'ignoreCollision': !![],
        'hideFromEnemy': !![],
        'health': 0x1f4,
        'colDiv': 0.2,
        'scale': 0x32,
        'holdOffset': 0x14,
        'placeOffset': -0x5
    }, {
        'age': 0x4,
        'group': a['exports']['groups'][0x6],
        'name': 'boost pad',
        'desc': 'provides boost when stepped on',
        'req': ['stone', 0x14, 'wood', 0x5],
        'ignoreCollision': !![],
        'boostSpeed': 1.5,
        'health': 0x190,
        'colDiv': 0.7,
        'scale': 0x2d,
        'holdOffset': 0x14,
        'placeOffset': -0x5
    }, {
        'age': 0x7,
        'group': a['exports']['groups'][0x7],
        'doUpdate': !![],
        'name': 'turret',
        'desc': 'defensive structure that shoots at enemies',
        'req': ['wood', 0xc8, 'stone', 0x96],
        'health': 0x320,
        'projectile': 0x1,
        'shootRange': 0x2bc,
        'shootRate': 0x898,
        'scale': 0x2b,
        'holdOffset': 0x14,
        'placeOffset': -0x5
    }, {
        'age': 0x7,
        'group': a['exports']['groups'][0x8],
        'name': 'platform',
        'desc': 'platform to shoot over walls and cross over water',
        'req': ['wood', 0x14],
        'ignoreCollision': !![],
        'zIndex': 0x1,
        'health': 0x12c,
        'scale': 0x2b,
        'holdOffset': 0x14,
        'placeOffset': -0x5
    }, {
        'age': 0x7,
        'group': a['exports']['groups'][0x9],
        'name': 'healing pad',
        'desc': 'standing on it will slowly heal you',
        'req': ['wood', 0x1e, 'food', 0xa],
        'ignoreCollision': !![],
        'healCol': 0xc,
        'health': 0x190,
        'colDiv': 0.7,
        'scale': 0x2d,
        'holdOffset': 0x14,
        'placeOffset': -0x5
    }, {
        'age': 0x9,
        'group': a['exports']['groups'][0xa],
        'name': 'spawn pad',
        'desc': 'you will spawn here when you die but it will dissapear',
        'req': ['wood', 0x64, 'stone', 0x64],
        'health': 0x190,
        'ignoreCollision': !![],
        'spawnPoint': !![],
        'scale': 0x2d,
        'holdOffset': 0x14,
        'placeOffset': -0x5
    }];
    for (var b = 0x0; b < a['exports']['list']['length']; ++b) {
        a['exports']['list'][b]['id'] = b;
        if (a['exports']['list'][b]['pre']) a['exports']['list'][b]['pre'] = b - a['exports']['list'][b]['pre'];
    }
}, function(a, b) {
    a['exports'] = {};
}, function(f, h) {
    var c = Math['floor'];
    var d = Math['abs'];
    var a = Math['cos'];
    var b = Math['sin'];
    var g = Math['pow'];
    var e = Math['sqrt'];
    f['exports'] = function(p, g, n, m, o) {
        this['objects'] = g;
        this['grids'] = {};
        this['updateObjects'] = [];
        var j, i;
        var k = m['mapScale'] / m['colGrid'];
        this['setObjectGrids'] = function(a) {
            var d = Math['min'](m['mapScale'], Math['max'](0x0, a['x']));
            var e = Math['min'](m['mapScale'], Math['max'](0x0, a['y']));
            for (var b = 0x0; b < m['colGrid']; ++b) {
                j = b * k;
                for (var c = 0x0; c < m['colGrid']; ++c) {
                    i = c * k;
                    if (d + a['scale'] >= j && d - a['scale'] <= j + k && e + a['scale'] >= i && e - a['scale'] <= i + k) {
                        if (!this['grids'][b + '_' + c]) this['grids'][b + '_' + c] = [];
                        this['grids'][b + '_' + c]['push'](a);
                        a['gridLocations']['push'](b + '_' + c);
                    }
                }
            }
        };
        this['removeObjGrid'] = function(b) {
            var c;
            for (var a = 0x0; a < b['gridLocations']['length']; ++a) {
                c = this['grids'][b['gridLocations'][a]]['indexOf'](b);
                if (c >= 0x0) {
                    this['grids'][b['gridLocations'][a]]['splice'](c, 0x1);
                }
            }
        };
        this['disableObj'] = function(a) {
            a['active'] = ![];
            if (o) {
                if (a['owner'] && a['pps']) a['owner']['pps'] -= a['pps'];
                this['removeObjGrid'](a);
                var b = this['updateObjects']['indexOf'](a);
                if (b >= 0x0) {
                    this['updateObjects']['splice'](b, 0x1);
                }
            }
        };
        var l = [];
        var h;
        this['getGridArrays'] = function(d, b, a) {
            j = c(d / k);
            i = c(b / k);
            l['length'] = 0x0;
            try {
                if (this['grids'][j + '_' + i]) l['push'](this['grids'][j + '_' + i]);
                if (d + a >= (j + 0x1) * k) {
                    h = this['grids'][j + 0x1 + '_' + i];
                    if (h) l['push'](h);
                    if (i && b - a <= i * k) {
                        h = this['grids'][j + 0x1 + '_' + (i - 0x1)];
                        if (h) l['push'](h);
                    } else if (b + a >= (i + 0x1) * k) {
                        h = this['grids'][j + 0x1 + '_' + (i + 0x1)];
                        if (h) l['push'](h);
                    }
                }
                if (j && d - a <= j * k) {
                    h = this['grids'][j - 0x1 + '_' + i];
                    if (h) l['push'](h);
                    if (i && b - a <= i * k) {
                        h = this['grids'][j - 0x1 + '_' + (i - 0x1)];
                        if (h) l['push'](h);
                    } else if (b + a >= (i + 0x1) * k) {
                        h = this['grids'][j - 0x1 + '_' + (i + 0x1)];
                        if (h) l['push'](h);
                    }
                }
                if (b + a >= (i + 0x1) * k) {
                    h = this['grids'][j + '_' + (i + 0x1)];
                    if (h) l['push'](h);
                }
                if (i && b - a <= i * k) {
                    h = this['grids'][j + '_' + (i - 0x1)];
                    if (h) l['push'](h);
                }
            } catch (a) {}
            return l;
        };
        var f;
        this['add'] = function(b, c, d, e, h, i, j, k, l) {
            f = null;
            for (var a = 0x0; a < g['length']; ++a) {
                if (g[a]['sid'] == b) {
                    f = g[a];
                    break;
                }
            }
            if (!f) {
                for (var a = 0x0; a < g['length']; ++a) {
                    if (!g[a]['active']) {
                        f = g[a];
                        break;
                    }
                }
            }
            if (!f) {
                f = new p(b);
                g['push'](f);
            }
            if (k) f['sid'] = b;
            f['init'](c, d, e, h, i, j, l);
            if (o) {
                this['setObjectGrids'](f);
                if (f['doUpdate']) this['updateObjects']['push'](f);
            }
        };
        this['disableBySid'] = function(b) {
            for (var a = 0x0; a < g['length']; ++a) {
                if (g[a]['sid'] == b) {
                    this['disableObj'](g[a]);
                    break;
                }
            }
        };
        this['removeAllItems'] = function(b, c) {
            for (var a = 0x0; a < g['length']; ++a) {
                if (g[a]['active'] && g[a]['owner'] && g[a]['owner']['sid'] == b) {
                    this['disableObj'](g[a]);
                }
            }
            if (c) {
                c['emit']('13', b);
            }
        };
        this['fetchSpawnObj'] = function(c) {
            var b = null;
            for (var a = 0x0; a < g['length']; ++a) {
                f = g[a];
                if (f['active'] && f['owner'] && f['owner']['sid'] == c && f['spawnPoint']) {
                    b = [f['x'], f['y']];
                    this['disableObj'](f);
                    o['emit']('12', f['sid']);
                    if (f['owner']) {
                        f['owner']['changeItemCount'](f['group']['id'], -0x1);
                    }
                    break;
                }
            }
            return b;
        };
        this['checkItemLocation'] = function(c, b, d, e, f, h) {
            for (var a = 0x0; a < g['length']; ++a) {
                if (g[a]['active'] && n['getDistance'](c, b, g[a]['x'], g[a]['y']) < d + g[a]['getScale'](e, g[a]['isItem'])) return ![];
            }
            if (!h && f != 0xf && b >= m['mapScale'] / 0x2 - m['riverWidth'] / 0x2 && b <= m['mapScale'] / 0x2 + m['riverWidth'] / 0x2) {
                return ![];
            }
            return !![];
        };
        this['addProjectile'] = function(e, f, g, h, d) {
            var c = items['projectiles'][d];
            var a;
            for (var b = 0x0; b < projectiles['length']; ++b) {
                if (!projectiles[b]['active']) {
                    a = projectiles[b];
                    break;
                }
            }
            if (!a) {
                a = new Projectile(players, n);
                projectiles['push'](a);
            }
            a['init'](d, e, f, g, c['speed'], h, c['scale']);
        };
        this['checkCollision'] = function(f, c, k) {
            k = k || 0x1;
            var l = f['x'] - c['x'];
            var j = f['y'] - c['y'];
            var i = f['scale'] + c['scale'];
            if (d(l) <= i || d(j) <= i) {
                i = f['scale'] + (c['getScale'] ? c['getScale']() : c['scale']);
                var h = e(l * l + j * j) - i;
                if (h <= 0x0) {
                    if (!c['ignoreCollision']) {
                        var g = n['getDirection'](f['x'], f['y'], c['x'], c['y']);
                        var o = n['getDistance'](f['x'], f['y'], c['x'], c['y']);
                        if (c['isPlayer']) {
                            h = h * -0x1 / 0x2;
                            f['x'] += h * a(g);
                            f['y'] += h * b(g);
                            c['x'] -= h * a(g);
                            c['y'] -= h * b(g);
                        } else {
                            f['x'] = c['x'] + i * a(g);
                            f['y'] = c['y'] + i * b(g);
                            f['xVel'] *= 0.75;
                            f['yVel'] *= 0.75;
                        }
                        if (c['dmg'] && c['owner'] != f && !(c['owner'] && c['owner']['team'] && c['owner']['team'] == f['team'])) {
                            f['changeHealth'](-c['dmg'], c['owner'], c);
                            var m = 1.5 * (c['weightM'] || 0x1);
                            f['xVel'] += m * a(g);
                            f['yVel'] += m * b(g);
                            if (c['pDmg'] && !(f['skin'] && f['skin']['poisonRes'])) {
                                f['dmgOverTime']['dmg'] = c['pDmg'];
                                f['dmgOverTime']['time'] = 0x5;
                                f['dmgOverTime']['doer'] = c['owner'];
                            }
                        }
                    } else if (c['trap'] && c['owner'] != f && !(c['owner'] && c['owner']['team'] && c['owner']['team'] == f['team'])) {
                        f['lockMove'] = !![];
                        c['hideFromEnemy'] = ![];
                    } else if (c['boostSpeed']) {
                        f['xVel'] += k * c['boostSpeed'] * (c['weightM'] || 0x1) * a(c['dir']);
                        f['yVel'] += k * c['boostSpeed'] * (c['weightM'] || 0x1) * b(c['dir']);
                    } else if (c['healCol']) {
                        f['healCol'] = c['healCol'];
                    }
                    if (c['zIndex'] > f['zIndex']) f['zIndex'] = c['zIndex'];
                    return !![];
                }
            }
            return ![];
        };
    };
}, function(f, g) {
    var c = Math['abs'];
    var a = Math['cos'];
    var b = Math['sin'];
    var d = Math['pow'];
    var e = Math['sqrt'];
    f['exports'] = function(t, w, f, i, v, m, h, r, g, p, q, j, s, u) {
        this['id'] = t;
        this['sid'] = w;
        this['tmpScore'] = 0x0;
        this['team'] = null;
        this['skinIndex'] = 0x0;
        this['tailIndex'] = 0x0;
        this['hitTime'] = 0x0;
        this['tails'] = {};
        for (var k = 0x0; k < q['length']; ++k) {
            if (q[k]['price'] <= 0x0) this['tails'][q[k]['id']] = 0x1;
        }
        this['skins'] = {};
        for (var k = 0x0; k < p['length']; ++k) {
            if (p[k]['price'] <= 0x0) this['skins'][p[k]['id']] = 0x1;
        }
        this['points'] = 0x0;
        this['dt'] = 0x0;
        this['hidden'] = ![];
        this['itemCounts'] = {};
        this['isPlayer'] = !![];
        this['pps'] = 0x0;
        this['moveDir'] = undefined;
        this['skinRot'] = 0x0;
        this['lastPing'] = 0x0;
        this['iconIndex'] = 0x0;
        this['skinColor'] = 0x0;
        this['spawn'] = function(a) {
            this['active'] = !![];
            this['alive'] = !![];
            this['lockMove'] = ![];
            this['lockDir'] = ![];
            this['minimapCounter'] = 0x0;
            this['chatCountdown'] = 0x0;
            this['shameCount'] = 0x0;
            this['shameTimer'] = 0x0;
            this['sentTo'] = {};
            this['gathering'] = 0x0;
            this['autoGather'] = 0x0;
            this['animTime'] = 0x0;
            this['animSpeed'] = 0x0;
            this['mouseState'] = 0x0;
            this['buildIndex'] = -0x1;
            this['weaponIndex'] = 0x0;
            this['dmgOverTime'] = {};
            this['maxXP'] = 0x12c;
            this['XP'] = 0x0;
            this['age'] = 0x1;
            this['kills'] = 0x0;
            this['upgrAge'] = 0x2;
            this['upgradePoints'] = 0x0;
            this['x'] = 0x0;
            this['y'] = 0x0;
            this['zIndex'] = 0x0;
            this['xVel'] = 0x0;
            this['yVel'] = 0x0;
            this['slowMult'] = 0x1;
            this['dir'] = 0x0;
            this['dirPlus'] = 0x0;
            this['targetDir'] = 0x0;
            this['targetAngle'] = 0x0;
            this['maxHealth'] = 0x64;
            this['health'] = this['maxHealth'];
            this['scale'] = f['playerScale'];
            this['speed'] = f['playerSpeed'];
            this['resetMoveDir']();
            this['resetResources'](a);
            this['items'] = [0x0, 0x2, 0x5, 0x9];
            this['weapons'] = [0x0];
            this['weaponXP'] = [];
            this['reloads'] = {};
        };
        this['resetMoveDir'] = function() {
            this['moveDir'] = undefined;
        };
        this['resetResources'] = function(b) {
            for (var a = 0x0; a < f['resourceTypes']['length']; ++a) {
                this[f['resourceTypes'][a]] = b ? 0x64 : 0x0;
            }
        };
        this['addItem'] = function(b) {
            var c = g['list'][b];
            if (c) {
                for (var a = 0x0; a < this['items']['length']; ++a) {
                    if (g['list'][this['items'][a]]['group'] == c['group']) {
                        if (this['buildIndex'] == this['items'][a]) this['buildIndex'] = b;
                        this['items'][a] = b;
                        return !![];
                    }
                }
                this['items']['push'](b);
                return !![];
            }
            return ![];
        };
        this['setUserData'] = function(a) {
            if (a) {
                this['name'] = 'unknown';
                if (i['isString'](a['name']) && a['name']['length'] <= f['maxNameLength']) {
                    a['name'] = a['name']['replace'](/<|>/g, '')['replace'](/[^\x00-\x7F]/g, '');
                    if (a['name']['replace'](/\s/g, '')['length'] > 0x0) {
                        this['name'] = a['name'];
                    }
                }
                this['skinColor'] = 0x0;
                if (f['skinColors'][a['skin']]) this['skinColor'] = a['skin'];
            }
        };
        this['getData'] = function() {
            return [this['id'], this['sid'], this['name'], i['fixTo'](this['x'], 0x2), i['fixTo'](this['y'], 0x2), i['fixTo'](this['dir'], 0x3), this['health'], this['maxHealth'], this['scale'], this['skinColor']];
        };
        this['setData'] = function(a) {
            this['id'] = a[0x0];
            this['sid'] = a[0x1];
            this['name'] = a[0x2];
            this['x'] = a[0x3];
            this['y'] = a[0x4];
            this['dir'] = a[0x5];
            this['health'] = a[0x6];
            this['maxHealth'] = a[0x7];
            this['scale'] = a[0x8];
            this['skinColor'] = a[0x9];
        };
        var o = 0x0;
        this['update'] = function(c) {
            if (!this['alive']) return;
            if (this['shameTimer'] > 0x0) {
                this['shameTimer'] -= c;
                if (this['shameTimer'] <= 0x0) {
                    this['shameTimer'] = 0x0;
                    this['shameCount'] = 0x0;
                }
            }
            o -= c;
            if (o <= 0x0) {
                var x = (this['skin'] && this['skin']['healthRegen'] ? this['skin']['healthRegen'] : 0x0) + (this['tail'] && this['tail']['healthRegen'] ? this['tail']['healthRegen'] : 0x0);
                if (x) {
                    this['changeHealth'](x, this);
                }
                if (this['dmgOverTime']['dmg']) {
                    this['changeHealth'](-this['dmgOverTime']['dmg'], this['dmgOverTime']['doer']);
                    this['dmgOverTime']['time'] -= 0x1;
                    if (this['dmgOverTime']['time'] <= 0x0) this['dmgOverTime']['dmg'] = 0x0;
                }
                if (this['healCol']) {
                    this['changeHealth'](this['healCol'], this);
                }
                o = 0x3e8;
            }
            if (!this['alive']) return;
            if (this['slowMult'] < 0x1) {
                this['slowMult'] += 0.0008 * c;
                if (this['slowMult'] > 0x1) this['slowMult'] = 0x1;
            }
            if (this['lockMove']) {
                this['xVel'] = 0x0;
                this['yVel'] = 0x0;
            } else {
                var r = (this['buildIndex'] >= 0x0 ? 0.5 : 0x1) * (g['weapons'][this['weaponIndex']]['spdMult'] || 0x1) * (this['skin'] ? this['skin']['spdMult'] || 0x1 : 0x1) * (this['tail'] ? this['tail']['spdMult'] || 0x1 : 0x1) * (this['y'] <= f['snowBiomeTop'] ? this['skin'] && this['skin']['coldM'] ? 0x1 : f['snowSpeed'] : 0x1) * this['slowMult'];
                if (!this['zIndex'] && this['y'] >= f['mapScale'] / 0x2 - f['riverWidth'] / 0x2 && this['y'] <= f['mapScale'] / 0x2 + f['riverWidth'] / 0x2) {
                    if (this['skin'] && this['skin']['watrImm']) {
                        r *= 0.75;
                        this['xVel'] += f['waterCurrent'] * 0.4 * c;
                    } else {
                        r *= 0.33;
                        this['xVel'] += f['waterCurrent'] * c;
                    }
                }
                var n = this['moveDir'] != undefined ? a(this['moveDir']) : 0x0;
                var l = this['moveDir'] != undefined ? b(this['moveDir']) : 0x0;
                var t = e(n * n + l * l);
                if (t != 0x0) {
                    n /= t;
                    l /= t;
                }
                if (n) this['xVel'] += n * this['speed'] * r * c;
                if (l) this['yVel'] += l * this['speed'] * r * c;
            }
            this['zIndex'] = 0x0;
            this['lockMove'] = ![];
            this['healCol'] = 0x0;
            var q;
            var B = i['getDistance'](0x0, 0x0, this['xVel'] * c, this['yVel'] * c);
            var w = Math['min'](0x4, Math['max'](0x1, Math['round'](B / 0x28)));
            var u = 0x1 / w;
            for (var j = 0x0; j < w; ++j) {
                if (this['xVel']) this['x'] += this['xVel'] * c * u;
                if (this['yVel']) this['y'] += this['yVel'] * c * u;
                q = m['getGridArrays'](this['x'], this['y'], this['scale']);
                for (var p = 0x0; p < q['length']; ++p) {
                    for (var s = 0x0; s < q[p]['length']; ++s) {
                        if (q[p][s]['active']) m['checkCollision'](this, q[p][s], u);
                    }
                }
            }
            var k = h['indexOf'](this);
            for (var j = k + 0x1; j < h['length']; ++j) {
                if (h[j] != this && h[j]['alive']) m['checkCollision'](this, h[j]);
            }
            if (this['xVel']) this['xVel'] *= d(f['playerDecel'], c);
            if (this['yVel']) this['yVel'] *= d(f['playerDecel'], c);
            if (this['x'] - this['scale'] < 0x0) {
                this['x'] = this['scale'];
            } else if (this['x'] + this['scale'] > f['mapScale']) {
                this['x'] = f['mapScale'] - this['scale'];
            }
            if (this['y'] - this['scale'] < 0x0) {
                this['y'] = this['scale'];
            } else if (this['y'] + this['scale'] > f['mapScale']) {
                this['y'] = f['mapScale'] - this['scale'];
            }
            if (this['buildIndex'] < 0x0) {
                if (this['reloads'][this['weaponIndex']] > 0x0) {
                    this['reloads'][this['weaponIndex']] -= c;
                    this['gathering'] = this['mouseState'];
                } else if (this['gathering'] || this['autoGather']) {
                    var A = !![];
                    if (g['weapons'][this['weaponIndex']]['gather']) {
                        this['gather'](h);
                    } else if (g['weapons'][this['weaponIndex']]['projectile'] != undefined && this['hasRes'](g['weapons'][this['weaponIndex']], this['skin'] ? this['skin']['projCost'] : 0x0)) {
                        this['useRes'](g['weapons'][this['weaponIndex']], this['skin'] ? this['skin']['projCost'] : 0x0);
                        var k = g['weapons'][this['weaponIndex']]['projectile'];
                        var z = this['scale'] * 0x2;
                        var y = this['skin'] && this['skin']['aMlt'] ? this['skin']['aMlt'] : 0x1;
                        if (g['weapons'][this['weaponIndex']]['rec']) {
                            this['xVel'] -= g['weapons'][this['weaponIndex']]['rec'] * a(this['dir']);
                            this['yVel'] -= g['weapons'][this['weaponIndex']]['rec'] * b(this['dir']);
                        }
                        v['addProjectile'](this['x'] + z * a(this['dir']), this['y'] + z * b(this['dir']), this['dir'], g['projectiles'][k]['range'] * y, g['projectiles'][k]['speed'] * y, k, this, null, this['zIndex']);
                    } else {
                        A = ![];
                    }
                    this['gathering'] = this['mouseState'];
                    if (A) {
                        this['reloads'][this['weaponIndex']] = g['weapons'][this['weaponIndex']]['speed'] * (this['skin'] ? this['skin']['atkSpd'] || 0x1 : 0x1);
                    }
                }
            }
        };
        this['addWeaponXP'] = function(a) {
            if (!this['weaponXP'][this['weaponIndex']]) this['weaponXP'][this['weaponIndex']] = 0x0;
            this['weaponXP'][this['weaponIndex']] += a;
        };
        this['earnXP'] = function(a) {
            if (this['age'] < f['maxAge']) {
                this['XP'] += a;
                if (this['XP'] >= this['maxXP']) {
                    if (this['age'] < f['maxAge']) {
                        this['age']++;
                        this['XP'] = 0x0;
                        this['maxXP'] *= 1.2;
                    } else {
                        this['XP'] = this['maxXP'];
                    }
                    this['upgradePoints']++;
                    j['to'](this['id'])['emit']('16', this['upgradePoints'], this['upgrAge']);
                    j['to'](this['id'])['emit']('15', this['XP'], i['fixTo'](this['maxXP'], 0x1), this['age']);
                } else {
                    j['to'](this['id'])['emit']('15', this['XP']);
                }
            }
        };
        this['changeHealth'] = function(a, b) {
            if (a > 0x0 && this['health'] >= this['maxHealth']) return ![];
            if (a < 0x0 && this['skin']) a *= this['skin']['dmgMult'] || 0x1;
            if (a < 0x0 && this['tail']) a *= this['tail']['dmgMult'] || 0x1;
            if (a < 0x0) this['hitTime'] = Date['now']();
            this['health'] += a;
            if (this['health'] > this['maxHealth']) {
                a -= this['health'] - this['maxHealth'];
                this['health'] = this['maxHealth'];
            }
            if (this['health'] <= 0x0) this['kill'](b);
            for (var c = 0x0; c < h['length']; ++c) {
                if (this['sentTo'][h[c]['id']]) j['to'](h[c]['id'])['emit']('10', this['sid'], Math['round'](this['health']));
            }
            if (b && b['canSee'](this) && !(b == this && a < 0x0)) {
                j['to'](b['id'])['emit']('t', Math['round'](this['x']), Math['round'](this['y']), Math['round'](-a), 0x1);
            }
            return !![];
        };
        this['kill'] = function(a) {
            if (a && a['alive']) {
                a['kills']++;
                s(a, Math['round'](this['age'] * 0x64 * (a['skin'] && a['skin']['kScrM'] ? a['skin']['kScrM'] : 0x1)));
                j['to'](a['id'])['emit']('9', 'kills', a['kills'], 0x1);
            }
            this['alive'] = ![];
            j['to'](this['id'])['emit']('11');
            u();
        };
        this['addResource'] = function(a, b, c) {
            if (!c && b > 0x0) this['addWeaponXP'](b);
            if (a == 0x3) {
                s(this, b, !![]);
            } else {
                this[f['resourceTypes'][a]] += b;
                j['to'](this['id'])['emit']('9', f['resourceTypes'][a], this[f['resourceTypes'][a]], 0x1);
            }
        };
        this['changeItemCount'] = function(a, b) {
            this['itemCounts'][a] = this['itemCounts'][a] || 0x0;
            this['itemCounts'][a] += b;
            j['to'](this['id'])['emit']('14', a, this['itemCounts'][a]);
        };
        this['buildItem'] = function(c) {
            var e = this['scale'] + c['scale'] + (c['placeOffset'] || 0x0);
            var f = this['x'] + e * a(this['dir']);
            var g = this['y'] + e * b(this['dir']);
            if (this['canBuild'](c) && (c['consume'] || m['checkItemLocation'](f, g, c['scale'], 0.6, c['id']))) {
                var d = ![];
                if (c['consume']) {
                    if (this['hitTime']) {
                        var h = Date['now']() - this['hitTime'];
                        this['hitTime'] = 0x0;
                        if (h <= 0x78) {
                            this['shameCount']++;
                            if (this['shameCount'] >= 0x8) {
                                this['shameTimer'] = 0x7530;
                                this['shameCount'] = 0x0;
                            }
                        } else {
                            this['shameCount'] -= 0x2;
                            if (this['shameCount'] <= 0x0) {
                                this['shameCount'] = 0x0;
                            }
                        }
                    }
                    if (this['shameTimer'] <= 0x0) d = c['consume'](this);
                } else {
                    d = !![];
                    if (c['group']['limit']) {
                        this['changeItemCount'](c['group']['id'], 0x1);
                    }
                    if (c['pps']) this['pps'] += c['pps'];
                    m['add'](m['objects']['length'], f, g, this['dir'], c['scale'], c['type'], c, ![], this);
                }
                if (d) {
                    this['useRes'](c);
                    this['buildIndex'] = -0x1;
                }
            }
        };
        this['hasRes'] = function(b, c) {
            for (var a = 0x0; a < b['req']['length'];) {
                if (this[b['req'][a]] < Math['round'](b['req'][a + 0x1] * (c || 0x1))) return ![];
                a += 0x2;
            }
            return !![];
        };
        this['useRes'] = function(b, c) {
            if (f['inSandbox']) return;
            for (var a = 0x0; a < b['req']['length'];) {
                this['addResource'](f['resourceTypes']['indexOf'](b['req'][a]), -Math['round'](b['req'][a + 0x1] * (c || 0x1)));
                a += 0x2;
            }
        };
        this['canBuild'] = function(a) {
            if (f['inSandbox']) return !![];
            if (a['group']['limit'] && this['itemCounts'][a['group']['id']] >= a['group']['limit']) return ![];
            return this['hasRes'](a);
        };
        this['gather'] = function() {
            this['slowMult'] -= 0.3;
            if (this['slowMult'] < 0x0) this['slowMult'] = 0x0;
            var u = f['fetchVariant'](this)['val'];
            var v = {};
            var q, d, c, x;
            var s = m['getGridArrays'](this['x'], this['y'], g['weapons'][this['weaponIndex']]['range']);
            for (var o = 0x0; o < s['length']; ++o) {
                for (var e = 0x0; e < s[o]['length']; ++e) {
                    c = s[o][e];
                    if (c['active'] && !c['dontGather'] && !v[c['sid']] && c['visibleToPlayer'](this)) {
                        q = i['getDistance'](this['x'], this['y'], c['x'], c['y']) - c['scale'];
                        if (q <= g['weapons'][this['weaponIndex']]['range']) {
                            d = i['getDirection'](c['x'], c['y'], this['x'], this['y']);
                            if (i['getAngleDist'](d, this['dir']) <= f['gatherAngle']) {
                                v[c['sid']] = 0x1;
                                if (c['health']) {
                                    if (c['changeHealth'](-g['weapons'][this['weaponIndex']]['dmg'] * u * (g['weapons'][this['weaponIndex']]['sDmg'] || 0x1) * (this['skin'] && this['skin']['bDmg'] ? this['skin']['bDmg'] : 0x1), this)) {
                                        for (var p = 0x0; p < c['req']['length'];) {
                                            this['addResource'](f['resourceTypes']['indexOf'](c['req'][p]), c['req'][p + 0x1]);
                                            p += 0x2;
                                        }
                                        m['disableObj'](c);
                                    }
                                } else {
                                    this['earnXP'](0x4 * g['weapons'][this['weaponIndex']]['gather']);
                                    var w = g['weapons'][this['weaponIndex']]['gather'] + (c['type'] == 0x3 ? 0x4 : 0x0);
                                    if (this['skin'] && this['skin']['extraGold']) {
                                        this['addResource'](0x3, 0x1);
                                    }
                                    this['addResource'](c['type'], w);
                                }
                                x = !![];
                                for (var k = 0x0; k < h['length']; ++k) {
                                    if (h[k]['active'] && c['sentTo'][this['id']]) {
                                        if (!c['active']) {
                                            j['to'](h[k]['id'])['emit']('12', c['sid']);
                                            if (c['owner'] == h[k]) {
                                                h[k]['changeItemCount'](c['group']['id'], -0x1);
                                            }
                                        } else if (h[k]['canSee'](c)) {
                                            j['to'](h[k]['id'])['emit']('8', i['fixTo'](d, 0x1), c['sid']);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            for (var e = 0x0; e < h['length'] + r['length']; ++e) {
                c = h[e] || r[e - h['length']];
                if (c != this && c['alive'] && !(c['team'] && c['team'] == this['team'])) {
                    q = i['getDistance'](this['x'], this['y'], c['x'], c['y']) - c['scale'] * 1.8;
                    if (q <= g['weapons'][this['weaponIndex']]['range']) {
                        d = i['getDirection'](c['x'], c['y'], this['x'], this['y']);
                        if (i['getAngleDist'](d, this['dir']) <= f['gatherAngle']) {
                            var l = u;
                            if (c['weaponIndex'] != undefined && g['weapons'][c['weaponIndex']]['shield'] && i['getAngleDist'](d + Math['PI'], c['dir']) <= f['shieldAngle']) {
                                l = g['weapons'][c['weaponIndex']]['shield'];
                            }
                            var n = g['weapons'][this['weaponIndex']]['dmg'] * (this['skin'] && this['skin']['dmgMultO'] ? this['skin']['dmgMultO'] : 0x1) * (this['tail'] && this['tail']['dmgMultO'] ? this['tail']['dmgMultO'] : 0x1);
                            var t = 0.3 * (c['weightM'] || 0x1) + (g['weapons'][this['weaponIndex']]['knock'] || 0x0);
                            c['xVel'] += t * a(d);
                            c['yVel'] += t * b(d);
                            if (this['skin'] && this['skin']['healD']) this['changeHealth'](n * l * this['skin']['healD'], this);
                            if (this['tail'] && this['tail']['healD']) this['changeHealth'](n * l * this['tail']['healD'], this);
                            if (c['skin'] && c['skin']['dmg'] && l == 0x1) this['changeHealth'](-n * c['skin']['dmg'], c);
                            if (c['tail'] && c['tail']['dmg'] && l == 0x1) this['changeHealth'](-n * c['tail']['dmg'], c);
                            if (c['dmgOverTime'] && this['skin'] && this['skin']['poisonDmg'] && !(c['skin'] && c['skin']['poisonRes'])) {
                                c['dmgOverTime']['dmg'] = this['skin']['poisonDmg'];
                                c['dmgOverTime']['time'] = this['skin']['poisonTime'] || 0x1;
                                c['dmgOverTime']['doer'] = this;
                            }
                            if (c['skin'] && c['skin']['dmgK']) {
                                this['xVel'] -= c['skin']['dmgK'] * a(d);
                                this['yVel'] -= c['skin']['dmgK'] * b(d);
                            }
                            c['changeHealth'](-n * l, this, this);
                        }
                    }
                }
            }
            this['sendAnimation'](x ? 0x1 : 0x0);
        };
        this['sendAnimation'] = function(b) {
            for (var a = 0x0; a < h['length']; ++a) {
                if (this['sentTo'][h[a]['id']] && this['canSee'](h[a])) {
                    j['to'](h[a]['id'])['emit']('7', this['sid'], b ? 0x1 : 0x0, this['weaponIndex']);
                }
            }
        };
        var l = 0x0;
        var n = 0x0;
        this['animate'] = function(a) {
            if (this['animTime'] > 0x0) {
                this['animTime'] -= a;
                if (this['animTime'] <= 0x0) {
                    this['animTime'] = 0x0;
                    this['dirPlus'] = 0x0;
                    l = 0x0;
                    n = 0x0;
                } else {
                    if (n == 0x0) {
                        l += a / (this['animSpeed'] * f['hitReturnRatio']);
                        this['dirPlus'] = i['lerp'](0x0, this['targetAngle'], Math['min'](0x1, l));
                        if (l >= 0x1) {
                            l = 0x1;
                            n = 0x1;
                        }
                    } else {
                        l -= a / (this['animSpeed'] * (0x1 - f['hitReturnRatio']));
                        this['dirPlus'] = i['lerp'](0x0, this['targetAngle'], Math['max'](0x0, l));
                    }
                }
            }
        };
        this['startAnim'] = function(a, b) {
            this['animTime'] = this['animSpeed'] = g['weapons'][b]['speed'];
            this['targetAngle'] = a ? -f['hitAngle'] : -Math['PI'];
            l = 0x0;
            n = 0x0;
        };
        this['canSee'] = function(a) {
            if (!a) return ![];
            var b = c(a['x'] - this['x']) - a['scale'];
            var d = c(a['y'] - this['y']) - a['scale'];
            return b <= f['maxScreenWidth'] / 0x2 * 1.3 && d <= f['maxScreenHeight'] / 0x2 * 1.3;
        };
    };
}, function(a, b) {
    a['exports'] = function(b, f, g, h, i, c, e) {
        this['init'] = function(a, b, c, d, f, g, h, i, j) {
            this['active'] = !![];
            this['indx'] = a;
            this['x'] = b;
            this['y'] = c;
            this['dir'] = d;
            this['skipMov'] = !![];
            this['speed'] = f;
            this['dmg'] = g;
            this['scale'] = i;
            this['range'] = h;
            this['owner'] = j;
            if (e) this['sentTo'] = {};
        };
        var d = [];
        var a;
        this['update'] = function(t) {
            if (this['active']) {
                var l = this['speed'] * t;
                var n;
                if (!this['skipMov']) {
                    this['x'] += l * Math['cos'](this['dir']);
                    this['y'] += l * Math['sin'](this['dir']);
                    this['range'] -= l;
                    if (this['range'] <= 0x0) {
                        this['x'] += this['range'] * Math['cos'](this['dir']);
                        this['y'] += this['range'] * Math['sin'](this['dir']);
                        l = 0x1;
                        this['range'] = 0x0;
                        this['active'] = ![];
                    }
                } else {
                    this['skipMov'] = ![];
                }
                if (e) {
                    for (var j = 0x0; j < b['length']; ++j) {
                        if (!this['sentTo'][b[j]['id']] && b[j]['canSee'](this)) {
                            this['sentTo'][b[j]['id']] = 0x1;
                            e['to'](b[j]['id'])['emit']('18', c['fixTo'](this['x'], 0x1), c['fixTo'](this['y'], 0x1), c['fixTo'](this['dir'], 0x2), c['fixTo'](this['range'], 0x1), this['speed'], this['indx'], this['layer'], this['sid']);
                        }
                    }
                    d['length'] = 0x0;
                    for (var j = 0x0; j < b['length'] + f['length']; ++j) {
                        a = b[j] || f[j - b['length']];
                        if (a['alive'] && a != this['owner'] && !(this['owner']['team'] && a['team'] == this['owner']['team'])) {
                            if (c['lineInRect'](a['x'] - a['scale'], a['y'] - a['scale'], a['x'] + a['scale'], a['y'] + a['scale'], this['x'], this['y'], this['x'] + l * Math['cos'](this['dir']), this['y'] + l * Math['sin'](this['dir']))) {
                                d['push'](a);
                            }
                        }
                    }
                    var p = g['getGridArrays'](this['x'], this['y'], this['scale']);
                    for (var m = 0x0; m < p['length']; ++m) {
                        for (var r = 0x0; r < p[m]['length']; ++r) {
                            a = p[m][r];
                            n = a['getScale']();
                            if (a['active'] && !(this['ignoreObj'] == a['sid']) && this['layer'] <= a['layer'] && d['indexOf'](a) < 0x0 && !a['ignoreCollision'] && c['lineInRect'](a['x'] - n, a['y'] - n, a['x'] + n, a['y'] + n, this['x'], this['y'], this['x'] + l * Math['cos'](this['dir']), this['y'] + l * Math['sin'](this['dir']))) {
                                d['push'](a);
                            }
                        }
                    }
                    if (d['length'] > 0x0) {
                        var k = null;
                        var o = null;
                        var q = null;
                        for (var j = 0x0; j < d['length']; ++j) {
                            q = c['getDistance'](this['x'], this['y'], d[j]['x'], d[j]['y']);
                            if (o == null || q < o) {
                                o = q;
                                k = d[j];
                            }
                        }
                        if (k['isPlayer'] || k['isAI']) {
                            var s = 0.3 * (k['weightM'] || 0x1);
                            k['xVel'] += s * Math['cos'](this['dir']);
                            k['yVel'] += s * Math['sin'](this['dir']);
                            if (k['weaponIndex'] == undefined || !(h['weapons'][k['weaponIndex']]['shield'] && c['getAngleDist'](this['dir'] + Math['PI'], k['dir']) <= i['shieldAngle'])) {
                                k['changeHealth'](-this['dmg'], this['owner'], this['owner']);
                            }
                        } else {
                            if (k['projDmg'] && k['health'] && k['changeHealth'](-this['dmg'])) {
                                g['disableObj'](k);
                            }
                            for (var j = 0x0; j < b['length']; ++j) {
                                if (b[j]['active']) {
                                    if (k['sentTo'][b[j]['id']]) {
                                        if (k['active']) {
                                            if (b[j]['canSee'](k)) e['to'](b[j]['id'])['emit']('8', c['fixTo'](this['dir'], 0x2), k['sid']);
                                        } else {
                                            e['to'](b[j]['id'])['emit']('12', k['sid']);
                                        }
                                    }
                                    if (!k['active'] && k['owner'] == b[j]) b[j]['changeItemCount'](k['group']['id'], -0x1);
                                }
                            }
                        }
                        this['active'] = ![];
                        for (var j = 0x0; j < b['length']; ++j) {
                            if (this['sentTo'][b[j]['id']]) e['to'](b[j]['id'])['emit']('19', this['sid'], c['fixTo'](o, 0x1));
                        }
                    }
                }
            }
        };
    };
}, function(a, b) {
    a['exports'] = function(c, a, d, e, f, b, g, h, i) {
        this['addProjectile'] = function(p, u, t, n, o, m, q, r, s) {
            var l = b['projectiles'][m];
            var j;
            for (var k = 0x0; k < a['length']; ++k) {
                if (!a[k]['active']) {
                    j = a[k];
                    break;
                }
            }
            if (!j) {
                j = new c(d, e, f, b, g, h, i);
                j['sid'] = a['length'];
                a['push'](j);
            }
            j['init'](m, p, u, t, o, l['dmg'], n, l['scale'], q);
            j['ignoreObj'] = r;
            j['layer'] = s || l['layer'];
            j['src'] = l['src'];
            return j;
        };
    };
}, function(a, b) {
    a['exports']['hats'] = [{
        'id': 0x2d,
        'dontSell': !![],
        'name': 'Shame!',
        'price': 0x0,
        'scale': 0x78,
        'desc': 'hacks are for losers'
    }, {
        'id': 0x1c,
        'name': 'Moo Head',
        'price': 0x0,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x1d,
        'name': 'Pig Head',
        'price': 0x0,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x1e,
        'name': 'Fluff Head',
        'price': 0x0,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x24,
        'name': 'Pandou Head',
        'price': 0x0,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x25,
        'name': 'Bear Head',
        'price': 0x0,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x26,
        'name': 'Monkey Head',
        'price': 0x0,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x2c,
        'name': 'Polar Head',
        'price': 0x0,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x23,
        'name': 'Fez Hat',
        'price': 0x0,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x2a,
        'name': 'Enigma Hat',
        'price': 0x0,
        'scale': 0x78,
        'desc': 'join the enigma army'
    }, {
        'id': 0x2b,
        'name': 'Blitz Hat',
        'price': 0x0,
        'scale': 0x78,
        'desc': 'hey everybody i\'m blitz'
    }, {
        'id': 0x31,
        'name': 'Bob XIII Hat',
        'price': 0x0,
        'scale': 0x78,
        'desc': 'like and subscribe'
    }, {
        'id': 0x8,
        'name': 'Bummle Hat',
        'price': 0x64,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x2,
        'name': 'Straw Hat',
        'price': 0x1f4,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0xf,
        'name': 'Winter Cap',
        'price': 0x258,
        'scale': 0x78,
        'desc': 'allows you to move at normal speed in snow',
        'coldM': 0x1
    }, {
        'id': 0x5,
        'name': 'Cowboy Hat',
        'price': 0x3e8,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x4,
        'name': 'Ranger Hat',
        'price': 0x7d0,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x12,
        'name': 'Explorer Hat',
        'price': 0x7d0,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x1f,
        'name': 'Flipper Hat',
        'price': 0x9c4,
        'scale': 0x78,
        'desc': 'have more control while in water',
        'watrImm': !![]
    }, {
        'id': 0x1,
        'name': 'Marksman Cap',
        'price': 0xbb8,
        'scale': 0x78,
        'desc': 'increases arrow speed and range',
        'aMlt': 1.3
    }, {
        'id': 0xa,
        'name': 'Bush Gear',
        'price': 0xbb8,
        'scale': 0xa0,
        'desc': 'allows you to disguise yourself as a bush'
    }, {
        'id': 0x30,
        'name': 'Halo',
        'price': 0xbb8,
        'scale': 0x78,
        'desc': 'no effect'
    }, {
        'id': 0x6,
        'name': 'Soldier Helmet',
        'price': 0xfa0,
        'scale': 0x78,
        'desc': 'reduces damage taken but slows movement',
        'spdMult': 0.94,
        'dmgMult': 0.75
    }, {
        'id': 0x17,
        'name': 'Anti Venom Gear',
        'price': 0xfa0,
        'scale': 0x78,
        'desc': 'makes you immune to poison',
        'poisonRes': 0x1
    }, {
        'id': 0xd,
        'name': 'Medic Gear',
        'price': 0x1388,
        'scale': 0x6e,
        'desc': 'slowly regenerates health over time',
        'healthRegen': 0x3
    }, {
        'id': 0x9,
        'name': 'Miners Helmet',
        'price': 0x1388,
        'scale': 0x78,
        'desc': 'earn 1 extra gold per resource',
        'extraGold': 0x1
    }, {
        'id': 0x20,
        'name': 'Musketeer Hat',
        'price': 0x1388,
        'scale': 0x78,
        'desc': 'reduces cost of projectiles',
        'projCost': 0.5
    }, {
        'id': 0x7,
        'name': 'Bull Helmet',
        'price': 0x1770,
        'scale': 0x78,
        'desc': 'increases damage done but drains health',
        'healthRegen': -0x5,
        'dmgMultO': 1.5,
        'spdMult': 0.96
    }, {
        'id': 0x16,
        'name': 'Emp Helmet',
        'price': 0x1770,
        'scale': 0x78,
        'desc': 'turrets won\'t attack but you move slower',
        'antiTurret': 0x1,
        'spdMult': 0.7
    }, {
        'id': 0xc,
        'name': 'Booster Hat',
        'price': 0x1770,
        'scale': 0x78,
        'desc': 'increases your movement speed',
        'spdMult': 1.16
    }, {
        'id': 0x1a,
        'name': 'Barbarian Armor',
        'price': 0x1f40,
        'scale': 0x78,
        'desc': 'knocks back enemies that attack you',
        'dmgK': 0.6
    }, {
        'id': 0x15,
        'name': 'Plague Mask',
        'price': 0x2710,
        'scale': 0x78,
        'desc': 'melee attacks deal poison damage',
        'poisonDmg': 0x5,
        'poisonTime': 0x6
    }, {
        'id': 0x2e,
        'name': 'Bull Mask',
        'price': 0x2710,
        'scale': 0x78,
        'desc': 'bulls won\'t target you unless you attack them',
        'bullRepel': 0x1
    }, {
        'id': 0xe,
        'name': 'Windmill Hat',
        'topSprite': !![],
        'price': 0x2710,
        'scale': 0x78,
        'desc': 'generates points while worn',
        'pps': 1.5
    }, {
        'id': 0xb,
        'name': 'Spike Gear',
        'topSprite': !![],
        'price': 0x2710,
        'scale': 0x78,
        'desc': 'deal damage to players that damage you',
        'dmg': 0.45
    }, {
        'id': 0x14,
        'name': 'Samurai Armor',
        'price': 0x2ee0,
        'scale': 0x78,
        'desc': 'increased attack speed and fire rate',
        'atkSpd': 0.78
    }, {
        'id': 0x10,
        'name': 'Bushido Armor',
        'price': 0x2ee0,
        'scale': 0x78,
        'desc': 'restores health when you deal damage',
        'healD': 0.4
    }, {
        'id': 0x1b,
        'name': 'Scavenger Gear',
        'price': 0x3a98,
        'scale': 0x78,
        'desc': 'earn double points for each kill',
        'kScrM': 0x2
    }, {
        'id': 0x28,
        'name': 'Tank Gear',
        'price': 0x3a98,
        'scale': 0x78,
        'desc': 'increased damage to buildings but slower movement',
        'spdMult': 0.3,
        'bDmg': 3.3
    }];
    a['exports']['accessories'] = [{
        'id': 0xc,
        'name': 'Snowball',
        'price': 0x3e8,
        'scale': 0x69,
        'xOff': 0x12,
        'desc': 'no effect'
    }, {
        'id': 0x9,
        'name': 'Tree Cape',
        'price': 0x3e8,
        'scale': 0x5a,
        'desc': 'no effect'
    }, {
        'id': 0xa,
        'name': 'Stone Cape',
        'price': 0x3e8,
        'scale': 0x5a,
        'desc': 'no effect'
    }, {
        'id': 0x3,
        'name': 'Cookie Cape',
        'price': 0x5dc,
        'scale': 0x5a,
        'desc': 'no effect'
    }, {
        'id': 0x8,
        'name': 'Cow Cape',
        'price': 0x7d0,
        'scale': 0x5a,
        'desc': 'no effect'
    }, {
        'id': 0xb,
        'name': 'Monkey Tail',
        'price': 0x7d0,
        'scale': 0x61,
        'xOff': 0x19,
        'desc': 'no effect'
    }, {
        'id': 0x11,
        'name': 'Apple Basket',
        'price': 0xbb8,
        'scale': 0x50,
        'xOff': 0xc,
        'desc': 'no effect'
    }, {
        'id': 0x6,
        'name': 'Winter Cape',
        'price': 0xbb8,
        'scale': 0x5a,
        'desc': 'no effect'
    }, {
        'id': 0x4,
        'name': 'Skull Cape',
        'price': 0xfa0,
        'scale': 0x5a,
        'desc': 'no effect'
    }, {
        'id': 0x5,
        'name': 'Dash Cape',
        'price': 0x1388,
        'scale': 0x5a,
        'desc': 'no effect'
    }, {
        'id': 0x2,
        'name': 'Dragon Cape',
        'price': 0x1770,
        'scale': 0x5a,
        'desc': 'no effect'
    }, {
        'id': 0x1,
        'name': 'Super Cape',
        'price': 0x1f40,
        'scale': 0x5a,
        'desc': 'no effect'
    }, {
        'id': 0x7,
        'name': 'Troll Cape',
        'price': 0x1f40,
        'scale': 0x5a,
        'desc': 'no effect'
    }, {
        'id': 0xe,
        'name': 'Thorns',
        'price': 0x2710,
        'scale': 0x73,
        'xOff': 0x14,
        'desc': 'no effect'
    }, {
        'id': 0xf,
        'name': 'Blockades',
        'price': 0x2710,
        'scale': 0x5f,
        'xOff': 0xf,
        'desc': 'no effect'
    }, {
        'id': 0x14,
        'name': 'Devils Tail',
        'price': 0x2710,
        'scale': 0x5f,
        'xOff': 0x14,
        'desc': 'no effect'
    }, {
        'id': 0x10,
        'name': 'Sawblade',
        'price': 0x2ee0,
        'scale': 0x5a,
        'spin': !![],
        'xOff': 0x0,
        'desc': 'deal damage to players that damage you',
        'dmg': 0.15
    }, {
        'id': 0xd,
        'name': 'Angel Wings',
        'price': 0x3a98,
        'scale': 0x8a,
        'xOff': 0x16,
        'desc': 'slowly regenerates health over time',
        'healthRegen': 0x3
    }, {
        'id': 0x13,
        'name': 'Shadow Wings',
        'price': 0x3a98,
        'scale': 0x8a,
        'xOff': 0x16,
        'desc': 'increased movement speed',
        'spdMult': 1.1
    }, {
        'id': 0x12,
        'name': 'Blood Wings',
        'price': 0x4e20,
        'scale': 0xb2,
        'xOff': 0x1a,
        'desc': 'restores health when you deal damage',
        'healD': 0.2
    }, {
        'id': 0x15,
        'name': 'Corrupt X Wings',
        'price': 0x4e20,
        'scale': 0xb2,
        'xOff': 0x1a,
        'desc': 'deal damage to players that damage you',
        'dmg': 0.25
    }];
}, function(a, b) {
    a['exports']['AnimText'] = function() {
        this['init'] = function(b, c, a, d, e, f, g) {
            this['x'] = b;
            this['y'] = c;
            this['color'] = g;
            this['scale'] = a;
            this['startScale'] = this['scale'];
            this['maxScale'] = a * 1.5;
            this['scaleSpeed'] = 0.7;
            this['speed'] = d;
            this['life'] = e;
            this['text'] = f;
        };
        this['update'] = function(a) {
            if (this['life']) {
                this['life'] -= a;
                this['y'] -= this['speed'] * a;
                this['scale'] += this['scaleSpeed'] * a;
                if (this['scale'] >= this['maxScale']) {
                    this['scale'] = this['maxScale'];
                    this['scaleSpeed'] *= -0x1;
                } else if (this['scale'] <= this['startScale']) {
                    this['scale'] = this['startScale'];
                    this['scaleSpeed'] = 0x0;
                }
                if (this['life'] <= 0x0) {
                    this['life'] = 0x0;
                }
            }
        };
        this['render'] = function(a, b, c) {
            a['fillStyle'] = this['color'];
            a['font'] = this['scale'] + 'px Hammersmith One';
            a['fillText'](this['text'], this['x'] - b, this['y'] - c);
        };
    };
    a['exports']['TextManager'] = function() {
        this['texts'] = [];
        this['update'] = function(c, b, d, e) {
            b['textBaseline'] = 'middle';
            b['textAlign'] = 'center';
            for (var a = 0x0; a < this['texts']['length']; ++a) {
                if (this['texts'][a]['life']) {
                    this['texts'][a]['update'](c);
                    this['texts'][a]['render'](b, d, e);
                }
            }
        };
        this['showText'] = function(d, e, f, g, h, i, j) {
            var b;
            for (var c = 0x0; c < this['texts']['length']; ++c) {
                if (!this['texts'][c]['life']) {
                    b = this['texts'][c];
                    break;
                }
            }
            if (!b) {
                b = new a['exports']['AnimText']();
                this['texts']['push'](b);
            }
            b['init'](d, e, f, g, h, i, j);
        };
    };
}, function(a, b) {
    ! function(h, l, m) {
        function k(a, b) {
            return typeof a === b;
        }

        function j() {
            var e, c, g, h, i, l, d;
            for (var j in b)
                if (b['hasOwnProperty'](j)) {
                    if (e = [], c = b[j], c['name'] && (e['push'](c['name']['toLowerCase']()), c['options'] && c['options']['aliases'] && c['options']['aliases']['length']))
                        for (g = 0x0; g < c['options']['aliases']['length']; g++) e['push'](c['options']['aliases'][g]['toLowerCase']());
                    for (h = k(c['fn'], 'function') ? c['fn']() : c['fn'], i = 0x0; i < e['length']; i++) l = e[i], d = l['split']('.'), 0x1 === d['length'] ? a[d[0x0]] = h : (!a[d[0x0]] || a[d[0x0]] instanceof Boolean || (a[d[0x0]] = new Boolean(a[d[0x0]])), a[d[0x0]][d[0x1]] = h), f['push']((h ? '' : 'no-') + d['join']('-'));
                }
        }

        function i(f) {
            var b = c['className'],
                d = a['_config']['classPrefix'] || '';
            if (g && (b = b['baseVal']), a['_config']['enableJSClass']) {
                var e = new RegExp('(^|\\s)' + d + 'no-js(\\s|$)');
                b = b['replace'](e, '$1' + d + 'js$2');
            }
            a['_config']['enableClasses'] && (b += ' ' + d + f['join'](' ' + d), g ? c['className']['baseVal'] = b : c['className'] = b);
        }
        var f = [],
            b = [],
            e = {
                '_version': '3.5.0',
                '_config': {
                    'classPrefix': '',
                    'enableClasses': !0x0,
                    'enableJSClass': !0x0,
                    'usePrefixes': !0x0
                },
                '_q': [],
                'on': function(b, c) {
                    var a = this;
                    setTimeout(function() {
                        c(a[b]);
                    }, 0x0);
                },
                'addTest': function(a, c, d) {
                    b['push']({
                        'name': a,
                        'fn': c,
                        'options': d
                    });
                },
                'addAsyncTest': function(a) {
                    b['push']({
                        'name': null,
                        'fn': a
                    });
                }
            },
            a = function() {};
        a['prototype'] = e, a = new a();
        var c = l['documentElement'],
            g = 'svg' === c['nodeName']['toLowerCase']();
        a['addTest']('passiveeventlisteners', function() {
            var a = !0x1;
            try {
                var b = Object['defineProperty']({}, 'passive', {
                    'get': function() {
                        a = !0x0;
                    }
                });
                h['addEventListener']('test', null, b);
            } catch (a) {}
            return a;
        }), j(), i(f), delete e['addTest'], delete e['addAsyncTest'];
        for (var d = 0x0; d < a['_q']['length']; d++) a['_q'][d]();
        h['Modernizr'] = a;
    }(window, document);
}, function(a, b) {
    a['exports']['obj'] = function(b, c) {
        var a;
        this['sounds'] = [];
        this['active'] = !![];
        this['play'] = function(c, d, e) {
            if (!d || !this['active']) return;
            a = this['sounds'][c];
            if (!a) {
                a = new Howl({
                    'src': '.././sound/' + c + '.mp3'
                });
                this['sounds'][c] = a;
            }
            if (!e || !a['isPlaying']) {
                a['isPlaying'] = !![];
                a['play']();
                a['volume']((d || 0x1) * b['volumeMult']);
                a['loop'](e);
            }
        };
        this['toggleMute'] = function(b, c) {
            a = this['sounds'][b];
            if (a) a['mute'](c);
        };
        this['stop'] = function(b) {
            a = this['sounds'][b];
            if (a) {
                a['stop']();
                a['isPlaying'] = ![];
            }
        };
    };
}, function(a, i) {
    var b = Math['abs'];
    var f = Math['cos'];
    var g = Math['sin'];
    var h = Math['pow'];
    var d = Math['sqrt'];
    var b = Math['abs'];
    var e = Math['atan2'];
    var c = Math['PI'];
    a['exports']['randInt'] = function(a, b) {
        return Math['floor'](Math['random']() * (b - a + 0x1)) + a;
    };
    a['exports']['randFloat'] = function(a, b) {
        return Math['random']() * (b - a + 0x1) + a;
    };
    a['exports']['lerp'] = function(a, b, c) {
        return a + (b - a) * c;
    };
    a['exports']['decel'] = function(a, b) {
        if (a > 0x0) a = Math['max'](0x0, a - b);
        else if (a < 0x0) a = Math['min'](0x0, a + b);
        return a;
    };
    a['exports']['getDistance'] = function(c, e, a, b) {
        return d((a -= c) * a + (b -= e) * b);
    };
    a['exports']['getDirection'] = function(a, b, c, d) {
        return e(b - d, a - c);
    };
    a['exports']['getAngleDist'] = function(d, e) {
        var a = b(e - d) % (c * 0x2);
        return a > c ? c * 0x2 - a : a;
    };
    a['exports']['isNumber'] = function(a) {
        return typeof a == 'number' && !isNaN(a) && isFinite(a);
    };
    a['exports']['isString'] = function(a) {
        return a && typeof a == 'string';
    };
    a['exports']['kFormat'] = function(a) {
        return a > 0x3e7 ? (a / 0x3e8)['toFixed'](0x1) + 'k' : a;
    };
    a['exports']['capitalizeFirst'] = function(a) {
        return a['charAt'](0x0)['toUpperCase']() + a['slice'](0x1);
    };
    a['exports']['fixTo'] = function(a, b) {
        return parseFloat(a['toFixed'](b));
    };
    a['exports']['sortByPoints'] = function(a, b) {
        return parseFloat(b['points']) - parseFloat(a['points']);
    };
    a['exports']['lineInRect'] = function(n, l, m, o, e, j, f, k) {
        var d = e;
        var c = f;
        if (e > f) {
            d = f;
            c = e;
        }
        if (c > m) c = m;
        if (d < n) d = n;
        if (d > c) return ![];
        var a = j;
        var b = k;
        var i = f - e;
        if (Math['abs'](i) > 1e-7) {
            var g = (k - j) / i;
            var h = j - g * e;
            a = g * d + h;
            b = g * c + h;
        }
        if (a > b) {
            var p = b;
            b = a;
            a = p;
        }
        if (b > o) b = o;
        if (a < l) a = l;
        if (a > b) return ![];
        return !![];
    };
    a['exports']['containsPoint'] = function(j, g, d) {
        var a = j['getBoundingClientRect']();
        var b = a['left'] + window['scrollX'];
        var c = a['top'] + window['scrollY'];
        var h = a['width'];
        var i = a['height'];
        var f = g > b && g < b + h;
        var e = d > c && d < c + i;
        return f && e;
    };
    a['exports']['mousifyTouchEvent'] = function(a) {
        var b = a['changedTouches'][0x0];
        a['screenX'] = b['screenX'];
        a['screenY'] = b['screenY'];
        a['clientX'] = b['clientX'];
        a['clientY'] = b['clientY'];
        a['pageX'] = b['pageX'];
        a['pageY'] = b['pageY'];
    };
    a['exports']['hookTouchEvents'] = function(b, g) {
        var e = !g;
        var c = ![];
        var d = ![];
        b['addEventListener']('touchstart', a['exports']['checkTrusted'](h), d);
        b['addEventListener']('touchmove', a['exports']['checkTrusted'](i), d);
        b['addEventListener']('touchend', a['exports']['checkTrusted'](f), d);
        b['addEventListener']('touchcancel', a['exports']['checkTrusted'](f), d);
        b['addEventListener']('touchleave', a['exports']['checkTrusted'](f), d);

        function h(d) {
            a['exports']['mousifyTouchEvent'](d);
            window['setUsingTouch'](!![]);
            if (e) {
                d['preventDefault']();
                d['stopPropagation']();
            }
            if (b['onmouseover']) b['onmouseover'](d);
            c = !![];
        }

        function i(d) {
            a['exports']['mousifyTouchEvent'](d);
            window['setUsingTouch'](!![]);
            if (e) {
                d['preventDefault']();
                d['stopPropagation']();
            }
            if (a['exports']['containsPoint'](b, d['pageX'], d['pageY'])) {
                if (!c) {
                    if (b['onmouseover']) b['onmouseover'](d);
                    c = !![];
                }
            } else {
                if (c) {
                    if (b['onmouseout']) b['onmouseout'](d);
                    c = ![];
                }
            }
        }

        function f(d) {
            a['exports']['mousifyTouchEvent'](d);
            window['setUsingTouch'](!![]);
            if (e) {
                d['preventDefault']();
                d['stopPropagation']();
            }
            if (c) {
                if (b['onclick']) b['onclick'](d);
                if (b['onmouseout']) b['onmouseout'](d);
                c = ![];
            }
        }
    };
    a['exports']['removeAllChildren'] = function(a) {
        while (a['hasChildNodes']()) {
            a['removeChild'](a['lastChild']);
        }
    };
    a['exports']['generateElement'] = function(c) {
        var b = document['createElement'](c['tag'] || 'div');

        function f(a, d) {
            if (c[a]) b[d] = c[a];
        }
        f('text', 'textContent');
        f('html', 'innerHTML');
        f('class', 'className');
        for (var d in c) {
            switch (d) {
                case 'tag':
                case 'text':
                case 'html':
                case 'class':
                case 'style':
                case 'hookTouch':
                case 'parent':
                case 'children':
                    continue;
                default:
                    break;
            }
            b[d] = c[d];
        }
        if (b['onclick']) b['onclick'] = a['exports']['checkTrusted'](b['onclick']);
        if (b['onmouseover']) b['onmouseover'] = a['exports']['checkTrusted'](b['onmouseover']);
        if (b['onmouseout']) b['onmouseout'] = a['exports']['checkTrusted'](b['onmouseout']);
        if (c['style']) {
            b['style']['cssText'] = c['style'];
        }
        if (c['hookTouch']) {
            a['exports']['hookTouchEvents'](b);
        }
        if (c['parent']) {
            c['parent']['appendChild'](b);
        }
        if (c['children']) {
            for (var e = 0x0; e < c['children']['length']; e++) {
                b['appendChild'](c['children'][e]);
            }
        }
        return b;
    };
    a['exports']['eventIsTrusted'] = function(a) {
        if (a && typeof a['isTrusted'] == 'boolean') {
            return a['isTrusted'];
        } else {
            return !![];
        }
    };
    a['exports']['checkTrusted'] = function(b) {
        return function(c) {
            if (c && c instanceof Event && a['exports']['eventIsTrusted'](c)) {
                b(c);
            } else {}
        };
    };
}, function(a, d) {
    a['exports'] = b;

    function b(f, b, d) {
        var e = ![];
        d = d || c;
        a['count'] = f;
        return f === 0x0 ? b() : a;

        function a(c, f) {
            if (a['count'] <= 0x0) {
                throw new Error('after called too many times');
            }--a['count'];
            if (c) {
                e = !![];
                b(c);
                b = d;
            } else if (a['count'] === 0x0 && !e) {
                b(null, f);
            }
        }
    }

    function c() {}
}, function(a, b) {
    a['exports'] = function(d, b, a) {
        var c = d['byteLength'];
        b = b || 0x0;
        a = a || c;
        if (d['slice']) {
            return d['slice'](b, a);
        }
        if (b < 0x0) {
            b += c;
        }
        if (a < 0x0) {
            a += c;
        }
        if (a > c) {
            a = c;
        }
        if (b >= c || b >= a || c === 0x0) {
            return new ArrayBuffer(0x0);
        }
        var h = new Uint8Array(d);
        var f = new Uint8Array(a - b);
        for (var e = b, g = 0x0; e < a; e++, g++) {
            f[g] = h[e];
        }
        return f['buffer'];
    };
}, function(b, c) {
    b['exports'] = a;

    function a(a) {
        a = a || {};
        this['ms'] = a['min'] || 0x64;
        this['max'] = a['max'] || 0x2710;
        this['factor'] = a['factor'] || 0x2;
        this['jitter'] = a['jitter'] > 0x0 && a['jitter'] <= 0x1 ? a['jitter'] : 0x0;
        this['attempts'] = 0x0;
    }
    a['prototype']['duration'] = function() {
        var a = this['ms'] * Math['pow'](this['factor'], this['attempts']++);
        if (this['jitter']) {
            var b = Math['random']();
            var c = Math['floor'](b * this['jitter'] * a);
            a = (Math['floor'](b * 0xa) & 0x1) == 0x0 ? a - c : a + c;
        }
        return Math['min'](a, this['max']) | 0x0;
    };
    a['prototype']['reset'] = function() {
        this['attempts'] = 0x0;
    };
    a['prototype']['setMin'] = function(a) {
        this['ms'] = a;
    };
    a['prototype']['setMax'] = function(a) {
        this['max'] = a;
    };
    a['prototype']['setJitter'] = function(a) {
        this['jitter'] = a;
    };
}, function(b, a) {
    (function() {
        'use strict';
        var b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
        var c = new Uint8Array(0x100);
        for (var d = 0x0; d < b['length']; d++) {
            c[b['charCodeAt'](d)] = d;
        }
        a['encode'] = function(f) {
            var d = new Uint8Array(f),
                c, e = d['length'],
                a = '';
            for (c = 0x0; c < e; c += 0x3) {
                a += b[d[c] >> 0x2];
                a += b[(d[c] & 0x3) << 0x4 | d[c + 0x1] >> 0x4];
                a += b[(d[c + 0x1] & 0xf) << 0x2 | d[c + 0x2] >> 0x6];
                a += b[d[c + 0x2] & 0x3f];
            }
            if (e % 0x3 === 0x2) {
                a = a['substring'](0x0, a['length'] - 0x1) + '=';
            } else if (e % 0x3 === 0x1) {
                a = a['substring'](0x0, a['length'] - 0x2) + '==';
            }
            return a;
        };
        a['decode'] = function(a) {
            var e = a['length'] * 0.75,
                l = a['length'],
                b, f = 0x0,
                j, g, h, k;
            if (a[a['length'] - 0x1] === '=') {
                e--;
                if (a[a['length'] - 0x2] === '=') {
                    e--;
                }
            }
            var i = new ArrayBuffer(e),
                d = new Uint8Array(i);
            for (b = 0x0; b < l; b += 0x4) {
                j = c[a['charCodeAt'](b)];
                g = c[a['charCodeAt'](b + 0x1)];
                h = c[a['charCodeAt'](b + 0x2)];
                k = c[a['charCodeAt'](b + 0x3)];
                d[f++] = j << 0x2 | g >> 0x4;
                d[f++] = (g & 0xf) << 0x4 | h >> 0x2;
                d[f++] = (h & 0x3) << 0x6 | k & 0x3f;
            }
            return i;
        };
    }());
}, function(a, b, c) {
    (function(b) {
        var c = b['BlobBuilder'] || b['WebKitBlobBuilder'] || b['MSBlobBuilder'] || b['MozBlobBuilder'];
        var d = function() {
            try {
                var a = new Blob(['hi']);
                return a['size'] === 0x2;
            } catch (a) {
                return ![];
            }
        }();
        var e = d && function() {
            try {
                var a = new Blob([new Uint8Array([0x1, 0x2])]);
                return a['size'] === 0x2;
            } catch (a) {
                return ![];
            }
        }();
        var f = c && c['prototype']['append'] && c['prototype']['getBlob'];

        function g(d) {
            for (var b = 0x0; b < d['length']; b++) {
                var a = d[b];
                if (a['buffer'] instanceof ArrayBuffer) {
                    var c = a['buffer'];
                    if (a['byteLength'] !== c['byteLength']) {
                        var e = new Uint8Array(a['byteLength']);
                        e['set'](new Uint8Array(c, a['byteOffset'], a['byteLength']));
                        c = e['buffer'];
                    }
                    d[b] = c;
                }
            }
        }

        function h(e, a) {
            a = a || {};
            var b = new c();
            g(e);
            for (var d = 0x0; d < e['length']; d++) {
                b['append'](e[d]);
            }
            return a['type'] ? b['getBlob'](a['type']) : b['getBlob']();
        };

        function i(a, b) {
            g(a);
            return new Blob(a, b || {});
        };
        a['exports'] = function() {
            if (d) {
                return e ? b['Blob'] : i;
            } else if (f) {
                return h;
            } else {
                return undefined;
            }
        }();
    }['call'](b, c(0x0)));
}, function(b, d) {
    b['exports'] = a;

    function a(a) {
        if (a) return c(a);
    };

    function c(c) {
        for (var b in a['prototype']) {
            c[b] = a['prototype'][b];
        }
        return c;
    }
    a['prototype']['on'] = a['prototype']['addEventListener'] = function(a, b) {
        this['_callbacks'] = this['_callbacks'] || {};
        (this['_callbacks'][a] = this['_callbacks'][a] || [])['push'](b);
        return this;
    };
    a['prototype']['once'] = function(b, c) {
        var d = this;
        this['_callbacks'] = this['_callbacks'] || {};

        function a() {
            d['off'](b, a);
            c['apply'](this, arguments);
        }
        a['fn'] = c;
        this['on'](b, a);
        return this;
    };
    a['prototype']['off'] = a['prototype']['removeListener'] = a['prototype']['removeAllListeners'] = a['prototype']['removeEventListener'] = function(d, e) {
        this['_callbacks'] = this['_callbacks'] || {};
        if (0x0 == arguments['length']) {
            this['_callbacks'] = {};
            return this;
        }
        var a = this['_callbacks'][d];
        if (!a) return this;
        if (0x1 == arguments['length']) {
            delete this['_callbacks'][d];
            return this;
        }
        var c;
        for (var b = 0x0; b < a['length']; b++) {
            c = a[b];
            if (c === e || c['fn'] === e) {
                a['splice'](b, 0x1);
                break;
            }
        }
        return this;
    };
    a['prototype']['emit'] = function(e) {
        this['_callbacks'] = this['_callbacks'] || {};
        var c = []['slice']['call'](arguments, 0x1),
            a = this['_callbacks'][e];
        if (a) {
            a = a['slice'](0x0);
            for (var b = 0x0, d = a['length']; b < d; ++b) {
                a[b]['apply'](this, c);
            }
        }
        return this;
    };
    a['prototype']['listeners'] = function(a) {
        this['_callbacks'] = this['_callbacks'] || {};
        return this['_callbacks'][a] || [];
    };
    a['prototype']['hasListeners'] = function(a) {
        return !!this['listeners'](a)['length'];
    };
}, function(a, c, b) {
    a['exports'] = b(0x30);
}, function(a, c, b) {
    a['exports'] = b(0x31);
    a['exports']['parser'] = b(0x1);
}, function(b, c, a) {
    (function(e) {
        var h = a(0xc);
        var i = a(0x7);
        var d = a(0x3)('engine.io-client:socket');
        var j = a(0xf);
        var f = a(0x1);
        var g = a(0x11);
        var k = a(0x3a);
        var l = a(0x8);
        b['exports'] = c;

        function c(b, a) {
            if (!(this instanceof c)) return new c(b, a);
            a = a || {};
            if (b && 'object' === typeof b) {
                a = b;
                b = null;
            }
            if (b) {
                b = g(b);
                a['hostname'] = b['host'];
                a['secure'] = b['protocol'] === 'https' || b['protocol'] === 'wss';
                a['port'] = b['port'];
                if (b['query']) a['query'] = b['query'];
            } else if (a['host']) {
                a['hostname'] = g(a['host'])['host'];
            }
            this['secure'] = null != a['secure'] ? a['secure'] : e['location'] && 'https:' === location['protocol'];
            if (a['hostname'] && !a['port']) {
                a['port'] = this['secure'] ? '443' : '80';
            }
            this['agent'] = a['agent'] || ![];
            this['hostname'] = a['hostname'] || (e['location'] ? location['hostname'] : 'localhost');
            this['port'] = a['port'] || (e['location'] && location['port'] ? location['port'] : this['secure'] ? 0x1bb : 0x50);
            this['query'] = a['query'] || {};
            if ('string' === typeof this['query']) this['query'] = l['decode'](this['query']);
            this['upgrade'] = ![] !== a['upgrade'];
            this['path'] = (a['path'] || '/engine.io')['replace'](/\/$/, '') + '/';
            this['forceJSONP'] = !!a['forceJSONP'];
            this['jsonp'] = ![] !== a['jsonp'];
            this['forceBase64'] = !!a['forceBase64'];
            this['enablesXDR'] = !!a['enablesXDR'];
            this['timestampParam'] = a['timestampParam'] || 't';
            this['timestampRequests'] = a['timestampRequests'];
            this['transports'] = a['transports'] || ['polling', 'websocket'];
            this['readyState'] = '';
            this['writeBuffer'] = [];
            this['prevBufferLen'] = 0x0;
            this['policyPort'] = a['policyPort'] || 0x34b;
            this['rememberUpgrade'] = a['rememberUpgrade'] || ![];
            this['binaryType'] = null;
            this['onlyBinaryUpgrades'] = a['onlyBinaryUpgrades'];
            this['perMessageDeflate'] = ![] !== a['perMessageDeflate'] ? a['perMessageDeflate'] || {} : ![];
            if (!![] === this['perMessageDeflate']) this['perMessageDeflate'] = {};
            if (this['perMessageDeflate'] && null == this['perMessageDeflate']['threshold']) {
                this['perMessageDeflate']['threshold'] = 0x400;
            }
            this['pfx'] = a['pfx'] || null;
            this['key'] = a['key'] || null;
            this['passphrase'] = a['passphrase'] || null;
            this['cert'] = a['cert'] || null;
            this['ca'] = a['ca'] || null;
            this['ciphers'] = a['ciphers'] || null;
            this['rejectUnauthorized'] = a['rejectUnauthorized'] === undefined ? null : a['rejectUnauthorized'];
            this['forceNode'] = !!a['forceNode'];
            var d = typeof e === 'object' && e;
            if (d['global'] === d) {
                if (a['extraHeaders'] && Object['keys'](a['extraHeaders'])['length'] > 0x0) {
                    this['extraHeaders'] = a['extraHeaders'];
                }
                if (a['localAddress']) {
                    this['localAddress'] = a['localAddress'];
                }
            }
            this['id'] = null;
            this['upgrades'] = null;
            this['pingInterval'] = null;
            this['pingTimeout'] = null;
            this['pingIntervalTimer'] = null;
            this['pingTimeoutTimer'] = null;
            this['open']();
        }
        c['priorWebsocketSuccess'] = ![];
        i(c['prototype']);
        c['protocol'] = f['protocol'];
        c['Socket'] = c;
        c['Transport'] = a(0x5);
        c['transports'] = a(0xc);
        c['parser'] = a(0x1);
        c['prototype']['createTransport'] = function(b) {
            d('creating transport \"%s\"', b);
            var a = m(this['query']);
            a['EIO'] = f['protocol'];
            a['transport'] = b;
            if (this['id']) a['sid'] = this['id'];
            var c = new h[b]({
                'agent': this['agent'],
                'hostname': this['hostname'],
                'port': this['port'],
                'secure': this['secure'],
                'path': this['path'],
                'query': a,
                'forceJSONP': this['forceJSONP'],
                'jsonp': this['jsonp'],
                'forceBase64': this['forceBase64'],
                'enablesXDR': this['enablesXDR'],
                'timestampRequests': this['timestampRequests'],
                'timestampParam': this['timestampParam'],
                'policyPort': this['policyPort'],
                'socket': this,
                'pfx': this['pfx'],
                'key': this['key'],
                'passphrase': this['passphrase'],
                'cert': this['cert'],
                'ca': this['ca'],
                'ciphers': this['ciphers'],
                'rejectUnauthorized': this['rejectUnauthorized'],
                'perMessageDeflate': this['perMessageDeflate'],
                'extraHeaders': this['extraHeaders'],
                'forceNode': this['forceNode'],
                'localAddress': this['localAddress']
            });
            return c;
        };

        function m(b) {
            var c = {};
            for (var a in b) {
                if (b['hasOwnProperty'](a)) {
                    c[a] = b[a];
                }
            }
            return c;
        }
        c['prototype']['open'] = function() {
            var a;
            if (this['rememberUpgrade'] && c['priorWebsocketSuccess'] && this['transports']['indexOf']('websocket') !== -0x1) {
                a = 'websocket';
            } else if (0x0 === this['transports']['length']) {
                var b = this;
                setTimeout(function() {
                    b['emit']('error', 'No transports available');
                }, 0x0);
                return;
            } else {
                a = this['transports'][0x0];
            }
            this['readyState'] = 'opening';
            try {
                a = this['createTransport'](a);
            } catch (a) {
                this['transports']['shift']();
                this['open']();
                return;
            }
            a['open']();
            this['setTransport'](a);
        };
        c['prototype']['setTransport'] = function(b) {
            d('setting transport %s', b['name']);
            var a = this;
            if (this['transport']) {
                d('clearing existing transport %s', this['transport']['name']);
                this['transport']['removeAllListeners']();
            }
            this['transport'] = b;
            b['on']('drain', function() {
                a['onDrain']();
            })['on']('packet', function(b) {
                a['onPacket'](b);
            })['on']('error', function(b) {
                a['onError'](b);
            })['on']('close', function() {
                a['onClose']('transport close');
            });
        };
        c['prototype']['probe'] = function(f) {
            d('probing transport \"%s\"', f);
            var a = this['createTransport'](f, {
                'probe': 0x1
            });
            var e = ![];
            var b = this;
            c['priorWebsocketSuccess'] = ![];

            function j() {
                if (b['onlyBinaryUpgrades']) {
                    var g = !this['supportsBinary'] && b['transport']['supportsBinary'];
                    e = e || g;
                }
                if (e) return;
                d('probe transport \"%s\" opened', f);
                a['send']([{
                    'type': 'ping',
                    'data': 'probe'
                }]);
                a['once']('packet', function(h) {
                    if (e) return;
                    if ('pong' === h['type'] && 'probe' === h['data']) {
                        d('probe transport \"%s\" pong', f);
                        b['upgrading'] = !![];
                        b['emit']('upgrading', a);
                        if (!a) return;
                        c['priorWebsocketSuccess'] = 'websocket' === a['name'];
                        d('pausing current transport \"%s\"', b['transport']['name']);
                        b['transport']['pause'](function() {
                            if (e) return;
                            if ('closed' === b['readyState']) return;
                            d('changing transport and sending upgrade packet');
                            i();
                            b['setTransport'](a);
                            a['send']([{
                                'type': 'upgrade'
                            }]);
                            b['emit']('upgrade', a);
                            a = null;
                            b['upgrading'] = ![];
                            b['flush']();
                        });
                    } else {
                        d('probe transport \"%s\" failed', f);
                        var g = new Error('probe error');
                        g['transport'] = a['name'];
                        b['emit']('upgradeError', g);
                    }
                });
            }

            function h() {
                if (e) return;
                e = !![];
                i();
                a['close']();
                a = null;
            }

            function g(e) {
                var c = new Error('probe error: ' + e);
                c['transport'] = a['name'];
                h();
                d('probe transport \"%s\" failed because of error: %s', f, e);
                b['emit']('upgradeError', c);
            }

            function k() {
                g('transport closed');
            }

            function l() {
                g('socket closed');
            }

            function m(b) {
                if (a && b['name'] !== a['name']) {
                    d('\"%s\" works - aborting \"%s\"', b['name'], a['name']);
                    h();
                }
            }

            function i() {
                a['removeListener']('open', j);
                a['removeListener']('error', g);
                a['removeListener']('close', k);
                b['removeListener']('close', l);
                b['removeListener']('upgrading', m);
            }
            a['once']('open', j);
            a['once']('error', g);
            a['once']('close', k);
            this['once']('close', l);
            this['once']('upgrading', m);
            a['open']();
        };
        c['prototype']['onOpen'] = function() {
            d('socket open');
            this['readyState'] = 'open';
            c['priorWebsocketSuccess'] = 'websocket' === this['transport']['name'];
            this['emit']('open');
            this['flush']();
            if ('open' === this['readyState'] && this['upgrade'] && this['transport']['pause']) {
                d('starting upgrade probes');
                for (var a = 0x0, b = this['upgrades']['length']; a < b; a++) {
                    this['probe'](this['upgrades'][a]);
                }
            }
        };
        c['prototype']['onPacket'] = function(a) {
            if ('opening' === this['readyState'] || 'open' === this['readyState'] || 'closing' === this['readyState']) {
                d('socket receive: type \"%s\", data \"%s\"', a['type'], a['data']);
                this['emit']('packet', a);
                this['emit']('heartbeat');
                switch (a['type']) {
                    case 'open':
                        this['onHandshake'](k(a['data']));
                        break;
                    case 'pong':
                        this['setPing']();
                        this['emit']('pong');
                        break;
                    case 'error':
                        var b = new Error('server error');
                        b['code'] = a['data'];
                        this['onError'](b);
                        break;
                    case 'message':
                        this['emit']('data', a['data']);
                        this['emit']('message', a['data']);
                        break;
                }
            } else {
                d('packet received with socket readyState \"%s\"', this['readyState']);
            }
        };
        c['prototype']['onHandshake'] = function(a) {
            this['emit']('handshake', a);
            this['id'] = a['sid'];
            this['transport']['query']['sid'] = a['sid'];
            this['upgrades'] = this['filterUpgrades'](a['upgrades']);
            this['pingInterval'] = a['pingInterval'];
            this['pingTimeout'] = a['pingTimeout'];
            this['onOpen']();
            if ('closed' === this['readyState']) return;
            this['setPing']();
            this['removeListener']('heartbeat', this['onHeartbeat']);
            this['on']('heartbeat', this['onHeartbeat']);
        };
        c['prototype']['onHeartbeat'] = function(b) {
            clearTimeout(this['pingTimeoutTimer']);
            var a = this;
            a['pingTimeoutTimer'] = setTimeout(function() {
                if ('closed' === a['readyState']) return;
                a['onClose']('ping timeout');
            }, b || a['pingInterval'] + a['pingTimeout']);
        };
        c['prototype']['setPing'] = function() {
            var a = this;
            clearTimeout(a['pingIntervalTimer']);
            a['pingIntervalTimer'] = setTimeout(function() {
                d('writing ping packet - expecting pong within %sms', a['pingTimeout']);
                a['ping']();
                a['onHeartbeat'](a['pingTimeout']);
            }, a['pingInterval']);
        };
        c['prototype']['ping'] = function() {
            var a = this;
            this['sendPacket']('ping', function() {
                a['emit']('ping');
            });
        };
        c['prototype']['onDrain'] = function() {
            this['writeBuffer']['splice'](0x0, this['prevBufferLen']);
            this['prevBufferLen'] = 0x0;
            if (0x0 === this['writeBuffer']['length']) {
                this['emit']('drain');
            } else {
                this['flush']();
            }
        };
        c['prototype']['flush'] = function() {
            if ('closed' !== this['readyState'] && this['transport']['writable'] && !this['upgrading'] && this['writeBuffer']['length']) {
                d('flushing %d packets in socket', this['writeBuffer']['length']);
                this['transport']['send'](this['writeBuffer']);
                this['prevBufferLen'] = this['writeBuffer']['length'];
                this['emit']('flush');
            }
        };
        c['prototype']['write'] = c['prototype']['send'] = function(a, b, c) {
            this['sendPacket']('message', a, b, c);
            return this;
        };
        c['prototype']['sendPacket'] = function(e, b, a, c) {
            if ('function' === typeof b) {
                c = b;
                b = undefined;
            }
            if ('function' === typeof a) {
                c = a;
                a = null;
            }
            if ('closing' === this['readyState'] || 'closed' === this['readyState']) {
                return;
            }
            a = a || {};
            a['compress'] = ![] !== a['compress'];
            var d = {
                'type': e,
                'data': b,
                'options': a
            };
            this['emit']('packetCreate', d);
            this['writeBuffer']['push'](d);
            if (c) this['once']('flush', c);
            this['flush']();
        };
        c['prototype']['close'] = function() {
            if ('opening' === this['readyState'] || 'open' === this['readyState']) {
                this['readyState'] = 'closing';
                var a = this;
                if (this['writeBuffer']['length']) {
                    this['once']('drain', function() {
                        if (this['upgrading']) {
                            e();
                        } else {
                            c();
                        }
                    });
                } else if (this['upgrading']) {
                    e();
                } else {
                    c();
                }
            }

            function c() {
                a['onClose']('forced close');
                d('socket closing - telling transport to close');
                a['transport']['close']();
            }

            function b() {
                a['removeListener']('upgrade', b);
                a['removeListener']('upgradeError', b);
                c();
            }

            function e() {
                a['once']('upgrade', b);
                a['once']('upgradeError', b);
            }
            return this;
        };
        c['prototype']['onError'] = function(a) {
            d('socket error %j', a);
            c['priorWebsocketSuccess'] = ![];
            this['emit']('error', a);
            this['onClose']('transport error', a);
        };
        c['prototype']['onClose'] = function(b, c) {
            if ('opening' === this['readyState'] || 'open' === this['readyState'] || 'closing' === this['readyState']) {
                d('socket close with reason: \"%s\"', b);
                var a = this;
                clearTimeout(this['pingIntervalTimer']);
                clearTimeout(this['pingTimeoutTimer']);
                this['transport']['removeAllListeners']('close');
                this['transport']['close']();
                this['transport']['removeAllListeners']();
                this['readyState'] = 'closed';
                this['id'] = null;
                this['emit']('close', b, c);
                a['writeBuffer'] = [];
                a['prevBufferLen'] = 0x0;
            }
        };
        c['prototype']['filterUpgrades'] = function(b) {
            var c = [];
            for (var a = 0x0, d = b['length']; a < d; a++) {
                if (~j(this['transports'], b[a])) c['push'](b[a]);
            }
            return c;
        };
    }['call'](c, a(0x0)));
}, function(b, c, a) {
    (function(c) {
        var e = a(0xd);
        var g = a(0x2);
        b['exports'] = d;
        var h = /\n/g;
        var i = /\\n/g;
        var f;

        function j() {}

        function d(b) {
            e['call'](this, b);
            this['query'] = this['query'] || {};
            if (!f) {
                if (!c['___eio']) c['___eio'] = [];
                f = c['___eio'];
            }
            this['index'] = f['length'];
            var a = this;
            f['push'](function(b) {
                a['onData'](b);
            });
            this['query']['j'] = this['index'];
            if (c['document'] && c['addEventListener']) {
                c['addEventListener']('beforeunload', function() {
                    if (a['script']) a['script']['onerror'] = j;
                }, ![]);
            }
        }
        g(d, e);
        d['prototype']['supportsBinary'] = ![];
        d['prototype']['doClose'] = function() {
            if (this['script']) {
                this['script']['parentNode']['removeChild'](this['script']);
                this['script'] = null;
            }
            if (this['form']) {
                this['form']['parentNode']['removeChild'](this['form']);
                this['form'] = null;
                this['iframe'] = null;
            }
            e['prototype']['doClose']['call'](this);
        };
        d['prototype']['doPoll'] = function() {
            var c = this;
            var a = document['createElement']('script');
            if (this['script']) {
                this['script']['parentNode']['removeChild'](this['script']);
                this['script'] = null;
            }
            a['async'] = !![];
            a['src'] = this['uri']();
            a['onerror'] = function(a) {
                c['onError']('jsonp poll error', a);
            };
            var b = document['getElementsByTagName']('script')[0x0];
            if (b) {
                b['parentNode']['insertBefore'](a, b);
            } else {
                (document['head'] || document['body'])['appendChild'](a);
            }
            this['script'] = a;
            var d = 'undefined' !== typeof navigator && /gecko/i ['test'](navigator['userAgent']);
            if (d) {
                setTimeout(function() {
                    var a = document['createElement']('iframe');
                    document['body']['appendChild'](a);
                    document['body']['removeChild'](a);
                }, 0x64);
            }
        };
        d['prototype']['doWrite'] = function(e, k) {
            var a = this;
            if (!this['form']) {
                var b = document['createElement']('form');
                var d = document['createElement']('textarea');
                var f = this['iframeId'] = 'eio_iframe_' + this['index'];
                var c;
                b['className'] = 'socketio';
                b['style']['position'] = 'absolute';
                b['style']['top'] = '-1000px';
                b['style']['left'] = '-1000px';
                b['target'] = f;
                b['method'] = 'POST';
                b['setAttribute']('accept-charset', 'utf-8');
                d['name'] = 'd';
                b['appendChild'](d);
                document['body']['appendChild'](b);
                this['form'] = b;
                this['area'] = d;
            }
            this['form']['action'] = this['uri']();

            function g() {
                j();
                k();
            }

            function j() {
                if (a['iframe']) {
                    try {
                        a['form']['removeChild'](a['iframe']);
                    } catch (b) {
                        a['onError']('jsonp polling iframe removal error', b);
                    }
                }
                try {
                    var b = '<iframe src=\"javascript:0\" name=\"' + a['iframeId'] + '\">';
                    c = document['createElement'](b);
                } catch (b) {
                    c = document['createElement']('iframe');
                    c['name'] = a['iframeId'];
                    c['src'] = 'javascript:0';
                }
                c['id'] = a['iframeId'];
                a['form']['appendChild'](c);
                a['iframe'] = c;
            }
            j();
            e = e['replace'](i, '\\\x0a');
            this['area']['value'] = e['replace'](h, '\\n');
            try {
                this['form']['submit']();
            } catch (a) {}
            if (this['iframe']['attachEvent']) {
                this['iframe']['onreadystatechange'] = function() {
                    if (a['iframe']['readyState'] === 'complete') {
                        g();
                    }
                };
            } else {
                this['iframe']['onload'] = g;
            }
        };
    }['call'](c, a(0x0)));
}, function(b, c, a) {
    (function(d) {
        var l = a(0x6);
        var g = a(0xd);
        var k = a(0x7);
        var h = a(0x2);
        var f = a(0x3)('engine.io-client:polling-xhr');
        b['exports'] = e;
        b['exports']['Request'] = c;

        function j() {}

        function e(a) {
            g['call'](this, a);
            this['requestTimeout'] = a['requestTimeout'];
            if (d['location']) {
                var c = 'https:' === location['protocol'];
                var b = location['port'];
                if (!b) {
                    b = c ? 0x1bb : 0x50;
                }
                this['xd'] = a['hostname'] !== d['location']['hostname'] || b !== a['port'];
                this['xs'] = a['secure'] !== c;
            } else {
                this['extraHeaders'] = a['extraHeaders'];
            }
        }
        h(e, g);
        e['prototype']['supportsBinary'] = !![];
        e['prototype']['request'] = function(a) {
            a = a || {};
            a['uri'] = this['uri']();
            a['xd'] = this['xd'];
            a['xs'] = this['xs'];
            a['agent'] = this['agent'] || ![];
            a['supportsBinary'] = this['supportsBinary'];
            a['enablesXDR'] = this['enablesXDR'];
            a['pfx'] = this['pfx'];
            a['key'] = this['key'];
            a['passphrase'] = this['passphrase'];
            a['cert'] = this['cert'];
            a['ca'] = this['ca'];
            a['ciphers'] = this['ciphers'];
            a['rejectUnauthorized'] = this['rejectUnauthorized'];
            a['requestTimeout'] = this['requestTimeout'];
            a['extraHeaders'] = this['extraHeaders'];
            return new c(a);
        };
        e['prototype']['doWrite'] = function(b, e) {
            var c = typeof b !== 'string' && b !== undefined;
            var a = this['request']({
                'method': 'POST',
                'data': b,
                'isBinary': c
            });
            var d = this;
            a['on']('success', e);
            a['on']('error', function(a) {
                d['onError']('xhr post error', a);
            });
            this['sendXhr'] = a;
        };
        e['prototype']['doPoll'] = function() {
            f('xhr poll');
            var a = this['request']();
            var b = this;
            a['on']('data', function(a) {
                b['onData'](a);
            });
            a['on']('error', function(a) {
                b['onError']('xhr poll error', a);
            });
            this['pollXhr'] = a;
        };

        function c(a) {
            this['method'] = a['method'] || 'GET';
            this['uri'] = a['uri'];
            this['xd'] = !!a['xd'];
            this['xs'] = !!a['xs'];
            this['async'] = ![] !== a['async'];
            this['data'] = undefined !== a['data'] ? a['data'] : null;
            this['agent'] = a['agent'];
            this['isBinary'] = a['isBinary'];
            this['supportsBinary'] = a['supportsBinary'];
            this['enablesXDR'] = a['enablesXDR'];
            this['requestTimeout'] = a['requestTimeout'];
            this['pfx'] = a['pfx'];
            this['key'] = a['key'];
            this['passphrase'] = a['passphrase'];
            this['cert'] = a['cert'];
            this['ca'] = a['ca'];
            this['ciphers'] = a['ciphers'];
            this['rejectUnauthorized'] = a['rejectUnauthorized'];
            this['extraHeaders'] = a['extraHeaders'];
            this['create']();
        }
        k(c['prototype']);
        c['prototype']['create'] = function() {
            var b = {
                'agent': this['agent'],
                'xdomain': this['xd'],
                'xscheme': this['xs'],
                'enablesXDR': this['enablesXDR']
            };
            b['pfx'] = this['pfx'];
            b['key'] = this['key'];
            b['passphrase'] = this['passphrase'];
            b['cert'] = this['cert'];
            b['ca'] = this['ca'];
            b['ciphers'] = this['ciphers'];
            b['rejectUnauthorized'] = this['rejectUnauthorized'];
            var a = this['xhr'] = new l(b);
            var e = this;
            try {
                f('xhr open %s: %s', this['method'], this['uri']);
                a['open'](this['method'], this['uri'], this['async']);
                try {
                    if (this['extraHeaders']) {
                        a['setDisableHeaderCheck'](!![]);
                        for (var g in this['extraHeaders']) {
                            if (this['extraHeaders']['hasOwnProperty'](g)) {
                                a['setRequestHeader'](g, this['extraHeaders'][g]);
                            }
                        }
                    }
                } catch (a) {}
                if (this['supportsBinary']) {
                    a['responseType'] = 'arraybuffer';
                }
                if ('POST' === this['method']) {
                    try {
                        if (this['isBinary']) {
                            a['setRequestHeader']('Content-type', 'application/octet-stream');
                        } else {
                            a['setRequestHeader']('Content-type', 'text/plain;charset=UTF-8');
                        }
                    } catch (a) {}
                }
                try {
                    a['setRequestHeader']('Accept', '*/*');
                } catch (a) {}
                if ('withCredentials' in a) {
                    a['withCredentials'] = !![];
                }
                if (this['requestTimeout']) {
                    a['timeout'] = this['requestTimeout'];
                }
                if (this['hasXDR']()) {
                    a['onload'] = function() {
                        e['onLoad']();
                    };
                    a['onerror'] = function() {
                        e['onError'](a['responseText']);
                    };
                } else {
                    a['onreadystatechange'] = function() {
                        if (0x4 !== a['readyState']) return;
                        if (0xc8 === a['status'] || 0x4c7 === a['status']) {
                            e['onLoad']();
                        } else {
                            setTimeout(function() {
                                e['onError'](a['status']);
                            }, 0x0);
                        }
                    };
                }
                f('xhr data %s', this['data']);
                a['send'](this['data']);
            } catch (a) {
                setTimeout(function() {
                    e['onError'](a);
                }, 0x0);
                return;
            }
            if (d['document']) {
                this['index'] = c['requestsCount']++;
                c['requests'][this['index']] = this;
            }
        };
        c['prototype']['onSuccess'] = function() {
            this['emit']('success');
            this['cleanup']();
        };
        c['prototype']['onData'] = function(a) {
            this['emit']('data', a);
            this['onSuccess']();
        };
        c['prototype']['onError'] = function(a) {
            this['emit']('error', a);
            this['cleanup'](!![]);
        };
        c['prototype']['cleanup'] = function(a) {
            if ('undefined' === typeof this['xhr'] || null === this['xhr']) {
                return;
            }
            if (this['hasXDR']()) {
                this['xhr']['onload'] = this['xhr']['onerror'] = j;
            } else {
                this['xhr']['onreadystatechange'] = j;
            }
            if (a) {
                try {
                    this['xhr']['abort']();
                } catch (a) {}
            }
            if (d['document']) {
                delete c['requests'][this['index']];
            }
            this['xhr'] = null;
        };
        c['prototype']['onLoad'] = function() {
            var a;
            try {
                var e;
                try {
                    e = this['xhr']['getResponseHeader']('Content-Type')['split'](';')[0x0];
                } catch (a) {}
                if (e === 'application/octet-stream') {
                    a = this['xhr']['response'] || this['xhr']['responseText'];
                } else {
                    if (!this['supportsBinary']) {
                        a = this['xhr']['responseText'];
                    } else {
                        try {
                            a = String['fromCharCode']['apply'](null, new Uint8Array(this['xhr']['response']));
                        } catch (e) {
                            var c = new Uint8Array(this['xhr']['response']);
                            var d = [];
                            for (var b = 0x0, f = c['length']; b < f; b++) {
                                d['push'](c[b]);
                            }
                            a = String['fromCharCode']['apply'](null, d);
                        }
                    }
                }
            } catch (a) {
                this['onError'](a);
            }
            if (null != a) {
                this['onData'](a);
            }
        };
        c['prototype']['hasXDR'] = function() {
            return 'undefined' !== typeof d['XDomainRequest'] && !this['xs'] && this['enablesXDR'];
        };
        c['prototype']['abort'] = function() {
            this['cleanup']();
        };
        c['requestsCount'] = 0x0;
        c['requests'] = {};
        if (d['document']) {
            if (d['attachEvent']) {
                d['attachEvent']('onunload', i);
            } else if (d['addEventListener']) {
                d['addEventListener']('beforeunload', i, ![]);
            }
        }

        function i() {
            for (var a in c['requests']) {
                if (c['requests']['hasOwnProperty'](a)) {
                    c['requests'][a]['abort']();
                }
            }
        }
    }['call'](c, a(0x0)));
}, function(b, c, a) {
    (function(f) {
        var e = a(0x5);
        var k = a(0x1);
        var l = a(0x8);
        var m = a(0x2);
        var i = a(0x17);
        var j = a(0x3)('engine.io-client:websocket');
        var g = f['WebSocket'] || f['MozWebSocket'];
        var h;
        if (typeof window === 'undefined') {
            try {
                h = a(0x46);
            } catch (a) {}
        }
        var d = g;
        if (!d && typeof window === 'undefined') {
            d = h;
        }
        b['exports'] = c;

        function c(a) {
            var b = a && a['forceBase64'];
            if (b) {
                this['supportsBinary'] = ![];
            }
            this['perMessageDeflate'] = a['perMessageDeflate'];
            this['usingBrowserWebSocket'] = g && !a['forceNode'];
            if (!this['usingBrowserWebSocket']) {
                d = h;
            }
            e['call'](this, a);
        }
        m(c, e);
        c['prototype']['name'] = 'websocket';
        c['prototype']['supportsBinary'] = !![];
        c['prototype']['doOpen'] = function() {
            if (!this['check']()) {
                return;
            }
            var b = this['uri']();
            var c = void 0x0;
            var a = {
                'agent': this['agent'],
                'perMessageDeflate': this['perMessageDeflate']
            };
            a['pfx'] = this['pfx'];
            a['key'] = this['key'];
            a['passphrase'] = this['passphrase'];
            a['cert'] = this['cert'];
            a['ca'] = this['ca'];
            a['ciphers'] = this['ciphers'];
            a['rejectUnauthorized'] = this['rejectUnauthorized'];
            if (this['extraHeaders']) {
                a['headers'] = this['extraHeaders'];
            }
            if (this['localAddress']) {
                a['localAddress'] = this['localAddress'];
            }
            try {
                this['ws'] = this['usingBrowserWebSocket'] ? new d(b) : new d(b, c, a);
            } catch (a) {
                return this['emit']('error', a);
            }
            if (this['ws']['binaryType'] === undefined) {
                this['supportsBinary'] = ![];
            }
            if (this['ws']['supports'] && this['ws']['supports']['binary']) {
                this['supportsBinary'] = !![];
                this['ws']['binaryType'] = 'nodebuffer';
            } else {
                this['ws']['binaryType'] = 'arraybuffer';
            }
            this['addEventListeners']();
        };
        c['prototype']['addEventListeners'] = function() {
            var a = this;
            this['ws']['onopen'] = function() {
                a['onOpen']();
            };
            this['ws']['onclose'] = function() {
                a['onClose']();
            };
            this['ws']['onmessage'] = function(b) {
                a['onData'](b['data']);
            };
            this['ws']['onerror'] = function(b) {
                a['onError']('websocket error', b);
            };
        };
        c['prototype']['write'] = function(d) {
            var a = this;
            this['writable'] = ![];
            var c = d['length'];
            for (var b = 0x0, e = c; b < e; b++) {
                (function(b) {
                    k['encodePacket'](b, a['supportsBinary'], function(d) {
                        if (!a['usingBrowserWebSocket']) {
                            var e = {};
                            if (b['options']) {
                                e['compress'] = b['options']['compress'];
                            }
                            if (a['perMessageDeflate']) {
                                var h = 'string' === typeof d ? f['Buffer']['byteLength'](d) : d['length'];
                                if (h < a['perMessageDeflate']['threshold']) {
                                    e['compress'] = ![];
                                }
                            }
                        }
                        try {
                            if (a['usingBrowserWebSocket']) {
                                a['ws']['send'](d);
                            } else {
                                a['ws']['send'](d, e);
                            }
                        } catch (a) {
                            j('websocket closed before onclose event');
                        }--c || g();
                    });
                }(d[b]));
            }

            function g() {
                a['emit']('flush');
                setTimeout(function() {
                    a['writable'] = !![];
                    a['emit']('drain');
                }, 0x0);
            }
        };
        c['prototype']['onClose'] = function() {
            e['prototype']['onClose']['call'](this);
        };
        c['prototype']['doClose'] = function() {
            if (typeof this['ws'] !== 'undefined') {
                this['ws']['close']();
            }
        };
        c['prototype']['uri'] = function() {
            var a = this['query'] || {};
            var b = this['secure'] ? 'wss' : 'ws';
            var c = '';
            if (this['port'] && ('wss' === b && Number(this['port']) !== 0x1bb || 'ws' === b && Number(this['port']) !== 0x50)) {
                c = ':' + this['port'];
            }
            if (this['timestampRequests']) {
                a[this['timestampParam']] = i();
            }
            if (!this['supportsBinary']) {
                a['b64'] = 0x1;
            }
            a = l['encode'](a);
            if (a['length']) {
                a = '?' + a;
            }
            var d = this['hostname']['indexOf'](':') !== -0x1;
            return b + '://' + (d ? '[' + this['hostname'] + ']' : this['hostname']) + c + this['path'] + a;
        };
        c['prototype']['check'] = function() {
            return !!d && !('__initialize' in d && this['name'] === c['prototype']['name']);
        };
    }['call'](c, a(0x0)));
}, function(g, a, f) {
    a = g['exports'] = d['debug'] = d;
    a['coerce'] = h;
    a['disable'] = j;
    a['enable'] = i;
    a['enabled'] = k;
    a['humanize'] = f(0x36);
    a['names'] = [];
    a['skips'] = [];
    a['formatters'] = {};
    var c = 0x0;
    var b;

    function e() {
        return a['colors'][c++ % a['colors']['length']];
    }

    function d(f) {
        function g() {}
        g['enabled'] = ![];

        function c() {
            var f = c;
            var g = +new Date();
            var j = g - (b || g);
            f['diff'] = j;
            f['prev'] = b;
            f['curr'] = g;
            b = g;
            if (null == f['useColors']) f['useColors'] = a['useColors']();
            if (null == f['color'] && f['useColors']) f['color'] = e();
            var d = new Array(arguments['length']);
            for (var h = 0x0; h < d['length']; h++) {
                d[h] = arguments[h];
            }
            d[0x0] = a['coerce'](d[0x0]);
            if ('string' !== typeof d[0x0]) {
                d = ['%o']['concat'](d);
            }
            var i = 0x0;
            d[0x0] = d[0x0]['replace'](/%([a-z%])/g, function(b, g) {
                if (b === '%%') return b;
                i++;
                var c = a['formatters'][g];
                if ('function' === typeof c) {
                    var e = d[i];
                    b = c['call'](f, e);
                    d['splice'](i, 0x1);
                    i--;
                }
                return b;
            });
            d = a['formatArgs']['apply'](f, d);
            var k = c['log'] || a['log'] || console['log']['bind'](console);
            k['apply'](f, d);
        }
        c['enabled'] = !![];
        var d = a['enabled'](f) ? c : g;
        d['namespace'] = f;
        return d;
    }

    function i(b) {
        a['save'](b);
        var d = (b || '')['split'](/[\s,]+/);
        var e = d['length'];
        for (var c = 0x0; c < e; c++) {
            if (!d[c]) continue;
            b = d[c]['replace'](/[\\^$+?.()|[\]{}]/g, '\\$&')['replace'](/\*/g, '.*?');
            if (b[0x0] === '-') {
                a['skips']['push'](new RegExp('^' + b['substr'](0x1) + '$'));
            } else {
                a['names']['push'](new RegExp('^' + b + '$'));
            }
        }
    }

    function j() {
        a['enable']('');
    }

    function k(d) {
        var b, c;
        for (b = 0x0, c = a['skips']['length']; b < c; b++) {
            if (a['skips'][b]['test'](d)) {
                return ![];
            }
        }
        for (b = 0x0, c = a['names']['length']; b < c; b++) {
            if (a['names'][b]['test'](d)) {
                return !![];
            }
        }
        return ![];
    }

    function h(a) {
        if (a instanceof Error) return a['stack'] || a['message'];
        return a;
    }
}, function(g, k) {
    var c = 0x3e8;
    var d = c * 0x3c;
    var b = d * 0x3c;
    var a = b * 0x18;
    var f = a * 365.25;
    g['exports'] = function(a, b) {
        b = b || {};
        var c = typeof a;
        if (c === 'string' && a['length'] > 0x0) {
            return h(a);
        } else if (c === 'number' && isNaN(a) === ![]) {
            return b['long'] ? j(a) : i(a);
        }
        throw new Error('val is not a non-empty string or a valid number. val=' + JSON['stringify'](a));
    };

    function h(g) {
        g = String(g);
        if (g['length'] > 0x2710) {
            return;
        }
        var h = /^((?:\d+)?\.?\d+) *(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|years?|yrs?|y)?$/i ['exec'](g);
        if (!h) {
            return;
        }
        var e = parseFloat(h[0x1]);
        var i = (h[0x2] || 'ms')['toLowerCase']();
        switch (i) {
            case 'years':
            case 'year':
            case 'yrs':
            case 'yr':
            case 'y':
                return e * f;
            case 'days':
            case 'day':
            case 'd':
                return e * a;
            case 'hours':
            case 'hour':
            case 'hrs':
            case 'hr':
            case 'h':
                return e * b;
            case 'minutes':
            case 'minute':
            case 'mins':
            case 'min':
            case 'm':
                return e * d;
            case 'seconds':
            case 'second':
            case 'secs':
            case 'sec':
            case 's':
                return e * c;
            case 'milliseconds':
            case 'millisecond':
            case 'msecs':
            case 'msec':
            case 'ms':
                return e;
            default:
                return undefined;
        }
    }

    function i(e) {
        if (e >= a) {
            return Math['round'](e / a) + 'd';
        }
        if (e >= b) {
            return Math['round'](e / b) + 'h';
        }
        if (e >= d) {
            return Math['round'](e / d) + 'm';
        }
        if (e >= c) {
            return Math['round'](e / c) + 's';
        }
        return e + 'ms';
    }

    function j(f) {
        return e(f, a, 'day') || e(f, b, 'hour') || e(f, d, 'minute') || e(f, c, 'second') || f + ' ms';
    }

    function e(a, b, c) {
        if (a < b) {
            return;
        }
        if (a < b * 1.5) {
            return Math['floor'](a / b) + ' ' + c;
        }
        return Math['ceil'](a / b) + ' ' + c + 's';
    }
}, function(a, b) {
    a['exports'] = Object['keys'] || function a(d) {
        var b = [];
        var e = Object['prototype']['hasOwnProperty'];
        for (var c in d) {
            if (e['call'](d, c)) {
                b['push'](c);
            }
        }
        return b;
    };
}, function(a, b) {
    try {
        a['exports'] = typeof XMLHttpRequest !== 'undefined' && 'withCredentials' in new XMLHttpRequest();
    } catch (b) {
        a['exports'] = ![];
    }
}, function(c, a, b) {
    (function(c, e) {
        var d;;
        (function() {
            var k = 'function' === 'function' && b(0x45);
            var h = {
                'function': !![],
                'object': !![]
            };
            var j = h[typeof a] && a && !a['nodeType'] && a;
            var f = h[typeof window] && window || this,
                g = j && h[typeof c] && c && !c['nodeType'] && typeof e == 'object' && e;
            if (g && (g['global'] === g || g['window'] === g || g['self'] === g)) {
                f = g;
            }

            function l(k, i) {
                k || (k = f['Object']());
                i || (i = f['Object']());
                var S = k['Number'] || f['Number'],
                    E = k['String'] || f['String'],
                    R = k['Object'] || f['Object'],
                    q = k['Date'] || f['Date'],
                    Q = k['SyntaxError'] || f['SyntaxError'],
                    P = k['TypeError'] || f['TypeError'],
                    O = k['Math'] || f['Math'],
                    u = k['JSON'] || f['JSON'];
                if (typeof u == 'object' && u) {
                    i['stringify'] = u['stringify'];
                    i['parse'] = u['parse'];
                }
                var F = R['prototype'],
                    c = F['toString'],
                    d, p, j;
                var e = new q(-0xc782b5b800cec);
                try {
                    e = e['getUTCFullYear']() == -0x1aac4 && e['getUTCMonth']() === 0x0 && e['getUTCDate']() === 0x1 && e['getUTCHours']() == 0xa && e['getUTCMinutes']() == 0x25 && e['getUTCSeconds']() == 0x6 && e['getUTCMilliseconds']() == 0x2c4;
                } catch (a) {}

                function n(g) {
                    if (n[g] !== j) {
                        return n[g];
                    }
                    var h;
                    if (g == 'bug-string-char-index') {
                        h = 'a' [0x0] != 'a';
                    } else if (g == 'json') {
                        h = n('json-stringify') && n('json-parse');
                    } else {
                        var b, l = '{\"a\":[1,true,false,null,\"\\u0000\\b\\n\\f\\r\\t\"]}';
                        if (g == 'json-stringify') {
                            var a = i['stringify'],
                                k = typeof a == 'function' && e;
                            if (k) {
                                (b = function() {
                                    return 0x1;
                                })['toJSON'] = b;
                                try {
                                    k = a(0x0) === '0' && a(new S()) === '0' && a(new E()) == '\"\"' && a(c) === j && a(j) === j && a() === j && a(b) === '1' && a([b]) == '[1]' && a([j]) == '[null]' && a(null) == 'null' && a([j, c, null]) == '[null,null,null]' && a({
                                        'a': [b, !![], ![], null, '\x00\x08\x0a\x0c\x0d\x09']
                                    }) == l && a(null, b) === '1' && a([0x1, 0x2], null, 0x1) == '[\x0a 1,\x0a 2\x0a]' && a(new q(-0x1eb208c2dc0000)) == '\"-271821-04-20T00:00:00.000Z\"' && a(new q(0x1eb208c2dc0000)) == '\"+275760-09-13T00:00:00.000Z\"' && a(new q(-0x3891c6b58c00)) == '\"-000001-01-01T00:00:00.000Z\"' && a(new q(-0x1)) == '\"1969-12-31T23:59:59.999Z\"';
                                } catch (a) {
                                    k = ![];
                                }
                            }
                            h = k;
                        }
                        if (g == 'json-parse') {
                            var f = i['parse'];
                            if (typeof f == 'function') {
                                try {
                                    if (f('0') === 0x0 && !f(![])) {
                                        b = f(l);
                                        var d = b['a']['length'] == 0x5 && b['a'][0x0] === 0x1;
                                        if (d) {
                                            try {
                                                d = !f('\"\x09\"');
                                            } catch (a) {}
                                            if (d) {
                                                try {
                                                    d = f('01') !== 0x1;
                                                } catch (a) {}
                                            }
                                            if (d) {
                                                try {
                                                    d = f('1.') !== 0x1;
                                                } catch (a) {}
                                            }
                                        }
                                    }
                                } catch (a) {
                                    d = ![];
                                }
                            }
                            h = d;
                        }
                    }
                    return n[g] = !!h;
                }
                if (!n('json')) {
                    var r = '[object Function]',
                        G = '[object Date]',
                        w = '[object Number]',
                        x = '[object String]',
                        v = '[object Array]',
                        K = '[object Boolean]';
                    var t = n('bug-string-char-index');
                    if (!e) {
                        var g = O['floor'];
                        var J = [0x0, 0x1f, 0x3b, 0x5a, 0x78, 0x97, 0xb5, 0xd4, 0xf3, 0x111, 0x130, 0x14e];
                        var s = function(b, a) {
                            return J[a] + 0x16d * (b - 0x7b2) + g((b - 0x7b1 + (a = +(a > 0x1))) / 0x4) - g((b - 0x76d + a) / 0x64) + g((b - 0x641 + a) / 0x190);
                        };
                    }
                    if (!(d = F['hasOwnProperty'])) {
                        d = function(e) {
                            var a = {},
                                b;
                            if ((a['__proto__'] = null, a['__proto__'] = {
                                    'toString': 0x1
                                }, a)['toString'] != c) {
                                d = function(c) {
                                    var a = this['__proto__'],
                                        b = c in (this['__proto__'] = null, this);
                                    this['__proto__'] = a;
                                    return b;
                                };
                            } else {
                                b = a['constructor'];
                                d = function(a) {
                                    var c = (this['constructor'] || b)['prototype'];
                                    return a in this && !(a in c && this[a] === c[a]);
                                };
                            }
                            a = null;
                            return d['call'](this, e);
                        };
                    }
                    p = function(g, i) {
                        var b = 0x0,
                            e, a, f;
                        (e = function() {
                            this['valueOf'] = 0x0;
                        })['prototype']['valueOf'] = 0x0;
                        a = new e();
                        for (f in a) {
                            if (d['call'](a, f)) {
                                b++;
                            }
                        }
                        e = a = null;
                        if (!b) {
                            a = ['valueOf', 'toString', 'toLocaleString', 'propertyIsEnumerable', 'isPrototypeOf', 'hasOwnProperty', 'constructor'];
                            p = function(b, i) {
                                var f = c['call'](b) == r,
                                    e, j;
                                var g = !f && typeof b['constructor'] != 'function' && h[typeof b['hasOwnProperty']] && b['hasOwnProperty'] || d;
                                for (e in b) {
                                    if (!(f && e == 'prototype') && g['call'](b, e)) {
                                        i(e);
                                    }
                                }
                                for (j = a['length']; e = a[--j]; g['call'](b, e) && i(e));
                            };
                        } else if (b == 0x2) {
                            p = function(b, g) {
                                var e = {},
                                    f = c['call'](b) == r,
                                    a;
                                for (a in b) {
                                    if (!(f && a == 'prototype') && !d['call'](e, a) && (e[a] = 0x1) && d['call'](b, a)) {
                                        g(a);
                                    }
                                }
                            };
                        } else {
                            p = function(b, e) {
                                var f = c['call'](b) == r,
                                    a, g;
                                for (a in b) {
                                    if (!(f && a == 'prototype') && d['call'](b, a) && !(g = a === 'constructor')) {
                                        e(a);
                                    }
                                }
                                if (g || d['call'](b, a = 'constructor')) {
                                    e(a);
                                }
                            };
                        }
                        return p(g, i);
                    };
                    if (!n('json-stringify')) {
                        var N = {
                            92: '\\\\',
                            34: '\\\"',
                            8: '\\b',
                            12: '\\f',
                            10: '\\n',
                            13: '\\r',
                            9: '\\t'
                        };
                        var H = '000000';
                        var m = function(a, b) {
                            return (H + (b || 0x0))['slice'](-a);
                        };
                        var I = '\\u00';
                        var D = function(b) {
                            var c = '\"',
                                a = 0x0,
                                e = b['length'],
                                f = !t || e > 0xa;
                            var g = f && (t ? b['split']('') : b);
                            for (; a < e; a++) {
                                var d = b['charCodeAt'](a);
                                switch (d) {
                                    case 0x8:
                                    case 0x9:
                                    case 0xa:
                                    case 0xc:
                                    case 0xd:
                                    case 0x22:
                                    case 0x5c:
                                        c += N[d];
                                        break;
                                    default:
                                        if (d < 0x20) {
                                            c += I + m(0x2, d['toString'](0x10));
                                            break;
                                        }
                                        c += f ? g[a] : b['charAt'](a);
                                }
                            }
                            return c + '\"';
                        };
                        var y = function(I, J, r, E, n, i, k) {
                            var a, e, b, l, f, o, z, A, B, C, h, F, t, q, H, u;
                            try {
                                a = J[I];
                            } catch (a) {}
                            if (typeof a == 'object' && a) {
                                e = c['call'](a);
                                if (e == G && !d['call'](a, 'toJSON')) {
                                    if (a > -0x1 / 0x0 && a < 0x1 / 0x0) {
                                        if (s) {
                                            f = g(a / 0x5265c00);
                                            for (b = g(f / 365.2425) + 0x7b2 - 0x1; s(b + 0x1, 0x0) <= f; b++);
                                            for (l = g((f - s(b, 0x0)) / 30.42); s(b, l + 0x1) <= f; l++);
                                            f = 0x1 + f - s(b, l);
                                            o = (a % 0x5265c00 + 0x5265c00) % 0x5265c00;
                                            z = g(o / 0x36ee80) % 0x18;
                                            A = g(o / 0xea60) % 0x3c;
                                            B = g(o / 0x3e8) % 0x3c;
                                            C = o % 0x3e8;
                                        } else {
                                            b = a['getUTCFullYear']();
                                            l = a['getUTCMonth']();
                                            f = a['getUTCDate']();
                                            z = a['getUTCHours']();
                                            A = a['getUTCMinutes']();
                                            B = a['getUTCSeconds']();
                                            C = a['getUTCMilliseconds']();
                                        }
                                        a = (b <= 0x0 || b >= 0x2710 ? (b < 0x0 ? '-' : '+') + m(0x6, b < 0x0 ? -b : b) : m(0x4, b)) + '-' + m(0x2, l + 0x1) + '-' + m(0x2, f) + 'T' + m(0x2, z) + ':' + m(0x2, A) + ':' + m(0x2, B) + '.' + m(0x3, C) + 'Z';
                                    } else {
                                        a = null;
                                    }
                                } else if (typeof a['toJSON'] == 'function' && (e != w && e != x && e != v || d['call'](a, 'toJSON'))) {
                                    a = a['toJSON'](I);
                                }
                            }
                            if (r) {
                                a = r['call'](J, I, a);
                            }
                            if (a === null) {
                                return 'null';
                            }
                            e = c['call'](a);
                            if (e == K) {
                                return '' + a;
                            } else if (e == w) {
                                return a > -0x1 / 0x0 && a < 0x1 / 0x0 ? '' + a : 'null';
                            } else if (e == x) {
                                return D('' + a);
                            }
                            if (typeof a == 'object') {
                                for (q = k['length']; q--;) {
                                    if (k[q] === a) {
                                        throw P();
                                    }
                                }
                                k['push'](a);
                                h = [];
                                H = i;
                                i += n;
                                if (e == v) {
                                    for (t = 0x0, q = a['length']; t < q; t++) {
                                        F = y(t, a, r, E, n, i, k);
                                        h['push'](F === j ? 'null' : F);
                                    }
                                    u = h['length'] ? n ? '[\x0a' + i + h['join'](',\x0a' + i) + '\x0a' + H + ']' : '[' + h['join'](',') + ']' : '[]';
                                } else {
                                    p(E || a, function(c) {
                                        var b = y(c, a, r, E, n, i, k);
                                        if (b !== j) {
                                            h['push'](D(c) + ':' + (n ? ' ' : '') + b);
                                        }
                                    });
                                    u = h['length'] ? n ? '{\x0a' + i + h['join'](',\x0a' + i) + '\x0a' + H + '}' : '{' + h['join'](',') + '}' : '{}';
                                }
                                k['pop']();
                                return u;
                            }
                        };
                        i['stringify'] = function(l, e, a) {
                            var f, k, g, b;
                            if (h[typeof e] && e) {
                                if ((b = c['call'](e)) == r) {
                                    k = e;
                                } else if (b == v) {
                                    g = {};
                                    for (var i = 0x0, j = e['length'], d; i < j; d = e[i++], (b = c['call'](d), b == x || b == w) && (g[d] = 0x1));
                                }
                            }
                            if (a) {
                                if ((b = c['call'](a)) == w) {
                                    if ((a -= a % 0x1) > 0x0) {
                                        for (f = '', a > 0xa && (a = 0xa); f['length'] < a; f += ' ');
                                    }
                                } else if (b == x) {
                                    f = a['length'] <= 0xa ? a : a['slice'](0x0, 0xa);
                                }
                            }
                            return y('', (d = {}, d[''] = l, d), k, g, f, '', []);
                        };
                    }
                    if (!n('json-parse')) {
                        var L = E['fromCharCode'];
                        var M = {
                            92: '\\',
                            34: '\"',
                            47: '/',
                            98: '\x08',
                            116: '\x09',
                            110: '\x0a',
                            102: '\x0c',
                            114: '\x0d'
                        };
                        var a, A;
                        var b = function() {
                            a = A = null;
                            throw Q();
                        };
                        var o = function() {
                            var d = A,
                                g = d['length'],
                                f, h, e, i, c;
                            while (a < g) {
                                c = d['charCodeAt'](a);
                                switch (c) {
                                    case 0x9:
                                    case 0xa:
                                    case 0xd:
                                    case 0x20:
                                        a++;
                                        break;
                                    case 0x7b:
                                    case 0x7d:
                                    case 0x5b:
                                    case 0x5d:
                                    case 0x3a:
                                    case 0x2c:
                                        f = t ? d['charAt'](a) : d[a];
                                        a++;
                                        return f;
                                    case 0x22:
                                        for (f = '@', a++; a < g;) {
                                            c = d['charCodeAt'](a);
                                            if (c < 0x20) {
                                                b();
                                            } else if (c == 0x5c) {
                                                c = d['charCodeAt'](++a);
                                                switch (c) {
                                                    case 0x5c:
                                                    case 0x22:
                                                    case 0x2f:
                                                    case 0x62:
                                                    case 0x74:
                                                    case 0x6e:
                                                    case 0x66:
                                                    case 0x72:
                                                        f += M[c];
                                                        a++;
                                                        break;
                                                    case 0x75:
                                                        h = ++a;
                                                        for (e = a + 0x4; a < e; a++) {
                                                            c = d['charCodeAt'](a);
                                                            if (!(c >= 0x30 && c <= 0x39 || c >= 0x61 && c <= 0x66 || c >= 0x41 && c <= 0x46)) {
                                                                b();
                                                            }
                                                        }
                                                        f += L('0x' + d['slice'](h, a));
                                                        break;
                                                    default:
                                                        b();
                                                }
                                            } else {
                                                if (c == 0x22) {
                                                    break;
                                                }
                                                c = d['charCodeAt'](a);
                                                h = a;
                                                while (c >= 0x20 && c != 0x5c && c != 0x22) {
                                                    c = d['charCodeAt'](++a);
                                                }
                                                f += d['slice'](h, a);
                                            }
                                        }
                                        if (d['charCodeAt'](a) == 0x22) {
                                            a++;
                                            return f;
                                        }
                                        b();
                                    default:
                                        h = a;
                                        if (c == 0x2d) {
                                            i = !![];
                                            c = d['charCodeAt'](++a);
                                        }
                                        if (c >= 0x30 && c <= 0x39) {
                                            if (c == 0x30 && (c = d['charCodeAt'](a + 0x1), c >= 0x30 && c <= 0x39)) {
                                                b();
                                            }
                                            i = ![];
                                            for (; a < g && (c = d['charCodeAt'](a), c >= 0x30 && c <= 0x39); a++);
                                            if (d['charCodeAt'](a) == 0x2e) {
                                                e = ++a;
                                                for (; e < g && (c = d['charCodeAt'](e), c >= 0x30 && c <= 0x39); e++);
                                                if (e == a) {
                                                    b();
                                                }
                                                a = e;
                                            }
                                            c = d['charCodeAt'](a);
                                            if (c == 0x65 || c == 0x45) {
                                                c = d['charCodeAt'](++a);
                                                if (c == 0x2b || c == 0x2d) {
                                                    a++;
                                                }
                                                for (e = a; e < g && (c = d['charCodeAt'](e), c >= 0x30 && c <= 0x39); e++);
                                                if (e == a) {
                                                    b();
                                                }
                                                a = e;
                                            }
                                            return +d['slice'](h, a);
                                        }
                                        if (i) {
                                            b();
                                        }
                                        if (d['slice'](a, a + 0x4) == 'true') {
                                            a += 0x4;
                                            return !![];
                                        } else if (d['slice'](a, a + 0x5) == 'false') {
                                            a += 0x5;
                                            return ![];
                                        } else if (d['slice'](a, a + 0x4) == 'null') {
                                            a += 0x4;
                                            return null;
                                        }
                                        b();
                                }
                            }
                            return '$';
                        };
                        var z = function(a) {
                            var c, d;
                            if (a == '$') {
                                b();
                            }
                            if (typeof a == 'string') {
                                if ((t ? a['charAt'](0x0) : a[0x0]) == '@') {
                                    return a['slice'](0x1);
                                }
                                if (a == '[') {
                                    c = [];
                                    for (;; d || (d = !![])) {
                                        a = o();
                                        if (a == ']') {
                                            break;
                                        }
                                        if (d) {
                                            if (a == ',') {
                                                a = o();
                                                if (a == ']') {
                                                    b();
                                                }
                                            } else {
                                                b();
                                            }
                                        }
                                        if (a == ',') {
                                            b();
                                        }
                                        c['push'](z(a));
                                    }
                                    return c;
                                } else if (a == '{') {
                                    c = {};
                                    for (;; d || (d = !![])) {
                                        a = o();
                                        if (a == '}') {
                                            break;
                                        }
                                        if (d) {
                                            if (a == ',') {
                                                a = o();
                                                if (a == '}') {
                                                    b();
                                                }
                                            } else {
                                                b();
                                            }
                                        }
                                        if (a == ',' || typeof a != 'string' || (t ? a['charAt'](0x0) : a[0x0]) != '@' || o() != ':') {
                                            b();
                                        }
                                        c[a['slice'](0x1)] = z(o());
                                    }
                                    return c;
                                }
                                b();
                            }
                            return a;
                        };
                        var C = function(a, b, d) {
                            var c = B(a, b, d);
                            if (c === j) {
                                delete a[b];
                            } else {
                                a[b] = c;
                            }
                        };
                        var B = function(e, f, b) {
                            var a = e[f],
                                d;
                            if (typeof a == 'object' && a) {
                                if (c['call'](a) == v) {
                                    for (d = a['length']; d--;) {
                                        C(a, d, b);
                                    }
                                } else {
                                    p(a, function(c) {
                                        C(a, c, b);
                                    });
                                }
                            }
                            return b['call'](e, f, a);
                        };
                        i['parse'] = function(g, d) {
                            var e, f;
                            a = 0x0;
                            A = '' + g;
                            e = z(o());
                            if (o() != '$') {
                                b();
                            }
                            a = A = null;
                            return d && c['call'](d) == r ? B((f = {}, f[''] = e, f), '', d) : e;
                        };
                    }
                }
                i['runInContext'] = l;
                return i;
            }
            if (j && !k) {
                l(f, j);
            } else {
                var m = f['JSON'],
                    n = f['JSON3'],
                    o = ![];
                var i = l(f, f['JSON3'] = {
                    'noConflict': function() {
                        if (!o) {
                            o = !![];
                            f['JSON'] = m;
                            f['JSON3'] = n;
                            m = n = null;
                        }
                        return i;
                    }
                });
                f['JSON'] = {
                    'parse': i['parse'],
                    'stringify': i['stringify']
                };
            }
            if (k) {
                !(d = function() {
                    return i;
                }['call'](a, b, a, c), d !== undefined && (c['exports'] = d));
            }
        }['call'](this));
    }['call'](a, b(0x18)(c), b(0x0)));
}, function(a, b, c) {
    (function(h) {
        var b = /^[\],:{}\s]*$/;
        var c = /\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g;
        var d = /"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g;
        var e = /(?:^|:|,)(?:\s*\[)+/g;
        var f = /^\s+/;
        var g = /\s+$/;
        a['exports'] = function a(i) {
            if ('string' != typeof i || !i) {
                return null;
            }
            i = i['replace'](f, '')['replace'](g, '');
            if (h['JSON'] && JSON['parse']) {
                return JSON['parse'](i);
            }
            if (b['test'](i['replace'](c, '@')['replace'](d, ']')['replace'](e, ''))) {
                return new Function('return ' + i)();
            }
        };
    }['call'](b, c(0x0)));
}, function(b, c, a) {
    (function(e) {
        var d = a(0x11);
        var c = a(0x4)('socket.io-client:url');
        b['exports'] = f;

        function f(b, f) {
            var a = b;
            f = f || e['location'];
            if (null == b) b = f['protocol'] + '//' + f['host'];
            if ('string' === typeof b) {
                if ('/' === b['charAt'](0x0)) {
                    if ('/' === b['charAt'](0x1)) {
                        b = f['protocol'] + b;
                    } else {
                        b = f['host'] + b;
                    }
                }
                if (!/^(https?|wss?):\/\// ['test'](b)) {
                    c('protocol-less url %s', b);
                    if ('undefined' !== typeof f) {
                        b = f['protocol'] + '//' + b;
                    } else {
                        b = 'https://' + b;
                    }
                }
                c('parse %s', b);
                a = d(b);
            }
            if (!a['port']) {
                if (/^(http|ws)$/ ['test'](a['protocol'])) {
                    a['port'] = '80';
                } else if (/^(http|ws)s$/ ['test'](a['protocol'])) {
                    a['port'] = '443';
                }
            }
            a['path'] = a['path'] || '/';
            var h = a['host']['indexOf'](':') !== -0x1;
            var g = h ? '[' + a['host'] + ']' : a['host'];
            a['id'] = a['protocol'] + '://' + g + ':' + a['port'];
            a['href'] = a['protocol'] + '://' + g + (f && f['port'] === a['port'] ? '' : ':' + a['port']);
            return a;
        }
    }['call'](c, a(0x0)));
}, function(g, a, f) {
    a = g['exports'] = d['debug'] = d;
    a['coerce'] = h;
    a['disable'] = j;
    a['enable'] = i;
    a['enabled'] = k;
    a['humanize'] = f(0x3d);
    a['names'] = [];
    a['skips'] = [];
    a['formatters'] = {};
    var c = 0x0;
    var b;

    function e() {
        return a['colors'][c++ % a['colors']['length']];
    }

    function d(f) {
        function g() {}
        g['enabled'] = ![];

        function c() {
            var f = c;
            var g = +new Date();
            var j = g - (b || g);
            f['diff'] = j;
            f['prev'] = b;
            f['curr'] = g;
            b = g;
            if (null == f['useColors']) f['useColors'] = a['useColors']();
            if (null == f['color'] && f['useColors']) f['color'] = e();
            var d = new Array(arguments['length']);
            for (var h = 0x0; h < d['length']; h++) {
                d[h] = arguments[h];
            }
            d[0x0] = a['coerce'](d[0x0]);
            if ('string' !== typeof d[0x0]) {
                d = ['%o']['concat'](d);
            }
            var i = 0x0;
            d[0x0] = d[0x0]['replace'](/%([a-z%])/g, function(b, g) {
                if (b === '%%') return b;
                i++;
                var c = a['formatters'][g];
                if ('function' === typeof c) {
                    var e = d[i];
                    b = c['call'](f, e);
                    d['splice'](i, 0x1);
                    i--;
                }
                return b;
            });
            d = a['formatArgs']['apply'](f, d);
            var k = c['log'] || a['log'] || console['log']['bind'](console);
            k['apply'](f, d);
        }
        c['enabled'] = !![];
        var d = a['enabled'](f) ? c : g;
        d['namespace'] = f;
        return d;
    }

    function i(b) {
        a['save'](b);
        var d = (b || '')['split'](/[\s,]+/);
        var e = d['length'];
        for (var c = 0x0; c < e; c++) {
            if (!d[c]) continue;
            b = d[c]['replace'](/[\\^$+?.()|[\]{}]/g, '\\$&')['replace'](/\*/g, '.*?');
            if (b[0x0] === '-') {
                a['skips']['push'](new RegExp('^' + b['substr'](0x1) + '$'));
            } else {
                a['names']['push'](new RegExp('^' + b + '$'));
            }
        }
    }

    function j() {
        a['enable']('');
    }

    function k(d) {
        var b, c;
        for (b = 0x0, c = a['skips']['length']; b < c; b++) {
            if (a['skips'][b]['test'](d)) {
                return ![];
            }
        }
        for (b = 0x0, c = a['names']['length']; b < c; b++) {
            if (a['names'][b]['test'](d)) {
                return !![];
            }
        }
        return ![];
    }

    function h(a) {
        if (a instanceof Error) return a['stack'] || a['message'];
        return a;
    }
}, function(g, k) {
    var c = 0x3e8;
    var d = c * 0x3c;
    var b = d * 0x3c;
    var a = b * 0x18;
    var f = a * 365.25;
    g['exports'] = function(a, b) {
        b = b || {};
        var c = typeof a;
        if (c === 'string' && a['length'] > 0x0) {
            return h(a);
        } else if (c === 'number' && isNaN(a) === ![]) {
            return b['long'] ? j(a) : i(a);
        }
        throw new Error('val is not a non-empty string or a valid number. val=' + JSON['stringify'](a));
    };

    function h(g) {
        g = String(g);
        if (g['length'] > 0x2710) {
            return;
        }
        var h = /^((?:\d+)?\.?\d+) *(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|years?|yrs?|y)?$/i ['exec'](g);
        if (!h) {
            return;
        }
        var e = parseFloat(h[0x1]);
        var i = (h[0x2] || 'ms')['toLowerCase']();
        switch (i) {
            case 'years':
            case 'year':
            case 'yrs':
            case 'yr':
            case 'y':
                return e * f;
            case 'days':
            case 'day':
            case 'd':
                return e * a;
            case 'hours':
            case 'hour':
            case 'hrs':
            case 'hr':
            case 'h':
                return e * b;
            case 'minutes':
            case 'minute':
            case 'mins':
            case 'min':
            case 'm':
                return e * d;
            case 'seconds':
            case 'second':
            case 'secs':
            case 'sec':
            case 's':
                return e * c;
            case 'milliseconds':
            case 'millisecond':
            case 'msecs':
            case 'msec':
            case 'ms':
                return e;
            default:
                return undefined;
        }
    }

    function i(e) {
        if (e >= a) {
            return Math['round'](e / a) + 'd';
        }
        if (e >= b) {
            return Math['round'](e / b) + 'h';
        }
        if (e >= d) {
            return Math['round'](e / d) + 'm';
        }
        if (e >= c) {
            return Math['round'](e / c) + 's';
        }
        return e + 'ms';
    }

    function j(f) {
        return e(f, a, 'day') || e(f, b, 'hour') || e(f, d, 'minute') || e(f, c, 'second') || f + ' ms';
    }

    function e(a, b, c) {
        if (a < b) {
            return;
        }
        if (a < b * 1.5) {
            return Math['floor'](a / b) + ' ' + c;
        }
        return Math['ceil'](a / b) + ' ' + c + 's';
    }
}, function(c, a, b) {
    (function(e) {
        var c = b(0x10);
        var d = b(0x16);
        a['deconstructPacket'] = function(f) {
            var a = [];
            var g = f['data'];

            function e(b) {
                if (!b) return b;
                if (d(b)) {
                    var i = {
                        '_placeholder': !![],
                        'num': a['length']
                    };
                    a['push'](b);
                    return i;
                } else if (c(b)) {
                    var f = new Array(b['length']);
                    for (var g = 0x0; g < b['length']; g++) {
                        f[g] = e(b[g]);
                    }
                    return f;
                } else if ('object' == typeof b && !(b instanceof Date)) {
                    var f = {};
                    for (var h in b) {
                        f[h] = e(b[h]);
                    }
                    return f;
                }
                return b;
            }
            var b = f;
            b['data'] = e(g);
            b['attachments'] = a['length'];
            return {
                'packet': b,
                'buffers': a
            };
        };
        a['reconstructPacket'] = function(a, d) {
            var e = 0x0;

            function b(a) {
                if (a && a['_placeholder']) {
                    var g = d[a['num']];
                    return g;
                } else if (c(a)) {
                    for (var e = 0x0; e < a['length']; e++) {
                        a[e] = b(a[e]);
                    }
                    return a;
                } else if (a && 'object' == typeof a) {
                    for (var f in a) {
                        a[f] = b(a[f]);
                    }
                    return a;
                }
                return a;
            }
            a['data'] = b(a['data']);
            a['attachments'] = undefined;
            return a;
        };
        a['removeBlobs'] = function(h, g) {
            function f(h, m, l) {
                if (!h) return h;
                if (e['Blob'] && h instanceof Blob || e['File'] && h instanceof File) {
                    b++;
                    var j = new FileReader();
                    j['onload'] = function() {
                        if (l) {
                            l[m] = this['result'];
                        } else {
                            a = this['result'];
                        }
                        if (!--b) {
                            g(a);
                        }
                    };
                    j['readAsArrayBuffer'](h);
                } else if (c(h)) {
                    for (var i = 0x0; i < h['length']; i++) {
                        f(h[i], i, h);
                    }
                } else if (h && 'object' == typeof h && !d(h)) {
                    for (var k in h) {
                        f(h[k], k, h);
                    }
                }
            }
            var b = 0x0;
            var a = h;
            f(a);
            if (!b) {
                g(a);
            }
        };
    }['call'](a, b(0x0)));
}, function(c, a, d) {
    a = c['exports'] = d(0x40);
    a['log'] = g;
    a['formatArgs'] = f;
    a['save'] = h;
    a['load'] = b;
    a['useColors'] = e;
    a['storage'] = 'undefined' != typeof chrome && 'undefined' != typeof chrome['storage'] ? chrome['storage']['local'] : i();
    a['colors'] = ['lightseagreen', 'forestgreen', 'goldenrod', 'dodgerblue', 'darkorchid', 'crimson'];

    function e() {
        return 'WebkitAppearance' in document['documentElement']['style'] || window['console'] && (console['firebug'] || console['exception'] && console['table']) || navigator['userAgent']['toLowerCase']()['match'](/firefox\/(\d+)/) && parseInt(RegExp['$1'], 0xa) >= 0x1f;
    }
    a['formatters']['j'] = function(a) {
        return JSON['stringify'](a);
    };

    function f() {
        var b = arguments;
        var c = this['useColors'];
        b[0x0] = (c ? '%c' : '') + this['namespace'] + (c ? ' %c' : ' ') + b[0x0] + (c ? '%c ' : ' ') + '+' + a['humanize'](this['diff']);
        if (!c) return b;
        var d = 'color: ' + this['color'];
        b = [b[0x0], d, 'color: inherit']['concat'](Array['prototype']['slice']['call'](b, 0x1));
        var e = 0x0;
        var f = 0x0;
        b[0x0]['replace'](/%[a-z%]/g, function(a) {
            if ('%%' === a) return;
            e++;
            if ('%c' === a) {
                f = e;
            }
        });
        b['splice'](f, 0x0, d);
        return b;
    }

    function g() {
        return 'object' === typeof console && console['log'] && Function['prototype']['apply']['call'](console['log'], console, arguments);
    }

    function h(b) {
        try {
            if (null == b) {
                a['storage']['removeItem']('debug');
            } else {
                a['storage']['debug'] = b;
            }
        } catch (a) {}
    }

    function b() {
        var b;
        try {
            b = a['storage']['debug'];
        } catch (a) {}
        return b;
    }
    a['enable'](b());

    function i() {
        try {
            return window['localStorage'];
        } catch (a) {}
    }
}, function(g, a, f) {
    a = g['exports'] = h;
    a['coerce'] = e;
    a['disable'] = j;
    a['enable'] = i;
    a['enabled'] = k;
    a['humanize'] = f(0x41);
    a['names'] = [];
    a['skips'] = [];
    a['formatters'] = {};
    var c = 0x0;
    var b;

    function d() {
        return a['colors'][c++ % a['colors']['length']];
    }

    function h(f) {
        function g() {}
        g['enabled'] = ![];

        function c() {
            var f = c;
            var g = +new Date();
            var i = g - (b || g);
            f['diff'] = i;
            f['prev'] = b;
            f['curr'] = g;
            b = g;
            if (null == f['useColors']) f['useColors'] = a['useColors']();
            if (null == f['color'] && f['useColors']) f['color'] = d();
            var e = Array['prototype']['slice']['call'](arguments);
            e[0x0] = a['coerce'](e[0x0]);
            if ('string' !== typeof e[0x0]) {
                e = ['%o']['concat'](e);
            }
            var h = 0x0;
            e[0x0] = e[0x0]['replace'](/%([a-z%])/g, function(b, g) {
                if (b === '%%') return b;
                h++;
                var c = a['formatters'][g];
                if ('function' === typeof c) {
                    var d = e[h];
                    b = c['call'](f, d);
                    e['splice'](h, 0x1);
                    h--;
                }
                return b;
            });
            if ('function' === typeof a['formatArgs']) {
                e = a['formatArgs']['apply'](f, e);
            }
            var j = c['log'] || a['log'] || console['log']['bind'](console);
            j['apply'](f, e);
        }
        c['enabled'] = !![];
        var e = a['enabled'](f) ? c : g;
        e['namespace'] = f;
        return e;
    }

    function i(b) {
        a['save'](b);
        var d = (b || '')['split'](/[\s,]+/);
        var e = d['length'];
        for (var c = 0x0; c < e; c++) {
            if (!d[c]) continue;
            b = d[c]['replace'](/\*/g, '.*?');
            if (b[0x0] === '-') {
                a['skips']['push'](new RegExp('^' + b['substr'](0x1) + '$'));
            } else {
                a['names']['push'](new RegExp('^' + b + '$'));
            }
        }
    }

    function j() {
        a['enable']('');
    }

    function k(d) {
        var b, c;
        for (b = 0x0, c = a['skips']['length']; b < c; b++) {
            if (a['skips'][b]['test'](d)) {
                return ![];
            }
        }
        for (b = 0x0, c = a['names']['length']; b < c; b++) {
            if (a['names'][b]['test'](d)) {
                return !![];
            }
        }
        return ![];
    }

    function e(a) {
        if (a instanceof Error) return a['stack'] || a['message'];
        return a;
    }
}, function(g, k) {
    var c = 0x3e8;
    var d = c * 0x3c;
    var b = d * 0x3c;
    var a = b * 0x18;
    var f = a * 365.25;
    g['exports'] = function(a, b) {
        b = b || {};
        if ('string' == typeof a) return h(a);
        return b['long'] ? j(a) : i(a);
    };

    function h(g) {
        g = '' + g;
        if (g['length'] > 0x2710) return;
        var h = /^((?:\d+)?\.?\d+) *(milliseconds?|msecs?|ms|seconds?|secs?|s|minutes?|mins?|m|hours?|hrs?|h|days?|d|years?|yrs?|y)?$/i ['exec'](g);
        if (!h) return;
        var e = parseFloat(h[0x1]);
        var i = (h[0x2] || 'ms')['toLowerCase']();
        switch (i) {
            case 'years':
            case 'year':
            case 'yrs':
            case 'yr':
            case 'y':
                return e * f;
            case 'days':
            case 'day':
            case 'd':
                return e * a;
            case 'hours':
            case 'hour':
            case 'hrs':
            case 'hr':
            case 'h':
                return e * b;
            case 'minutes':
            case 'minute':
            case 'mins':
            case 'min':
            case 'm':
                return e * d;
            case 'seconds':
            case 'second':
            case 'secs':
            case 'sec':
            case 's':
                return e * c;
            case 'milliseconds':
            case 'millisecond':
            case 'msecs':
            case 'msec':
            case 'ms':
                return e;
        }
    }

    function i(e) {
        if (e >= a) return Math['round'](e / a) + 'd';
        if (e >= b) return Math['round'](e / b) + 'h';
        if (e >= d) return Math['round'](e / d) + 'm';
        if (e >= c) return Math['round'](e / c) + 's';
        return e + 'ms';
    }

    function j(f) {
        return e(f, a, 'day') || e(f, b, 'hour') || e(f, d, 'minute') || e(f, c, 'second') || f + ' ms';
    }

    function e(a, b, c) {
        if (a < b) return;
        if (a < b * 1.5) return Math['floor'](a / b) + ' ' + c;
        return Math['ceil'](a / b) + ' ' + c + 's';
    }
}, function(a, c) {
    a['exports'] = b;

    function b(d, b) {
        var c = [];
        b = b || 0x0;
        for (var a = b || 0x0; a < d['length']; a++) {
            c[a - b] = d[a];
        }
        return c;
    }
}, function(c, a, b) {
    (function(c, e) {
        var d;;
        (function(t) {
            var k = typeof a == 'object' && a;
            var o = typeof c == 'object' && c && c['exports'] == k && c;
            var i = typeof e == 'object' && e;
            if (i['global'] === i || i['window'] === i) {
                t = i;
            }
            var f = String['fromCharCode'];

            function q(d) {
                var c = [];
                var a = 0x0;
                var e = d['length'];
                var b;
                var f;
                while (a < e) {
                    b = d['charCodeAt'](a++);
                    if (b >= 0xd800 && b <= 0xdbff && a < e) {
                        f = d['charCodeAt'](a++);
                        if ((f & 0xfc00) == 0xdc00) {
                            c['push'](((b & 0x3ff) << 0xa) + (f & 0x3ff) + 0x10000);
                        } else {
                            c['push'](b);
                            a--;
                        }
                    } else {
                        c['push'](b);
                    }
                }
                return c;
            }

            function y(d) {
                var e = d['length'];
                var c = -0x1;
                var a;
                var b = '';
                while (++c < e) {
                    a = d[c];
                    if (a > 0xffff) {
                        a -= 0x10000;
                        b += f(a >>> 0xa & 0x3ff | 0xd800);
                        a = 0xdc00 | a & 0x3ff;
                    }
                    b += f(a);
                }
                return b;
            }

            function p(a, b) {
                return f(a >> b & 0x3f | 0x80);
            }

            function x(a) {
                if ((a & 0xffffff80) == 0x0) {
                    return f(a);
                }
                var b = '';
                if ((a & 0xfffff800) == 0x0) {
                    b = f(a >> 0x6 & 0x1f | 0xc0);
                } else if ((a & 0xffff0000) == 0x0) {
                    b = f(a >> 0xc & 0xf | 0xe0);
                    b += p(a, 0x6);
                } else if ((a & 0xffe00000) == 0x0) {
                    b = f(a >> 0x12 & 0x7 | 0xf0);
                    b += p(a, 0xc);
                    b += p(a, 0x6);
                }
                b += f(a & 0x3f | 0x80);
                return b;
            }

            function u(f) {
                var a = q(f);
                var d = a['length'];
                var b = -0x1;
                var e;
                var c = '';
                while (++b < d) {
                    e = a[b];
                    c += x(e);
                }
                return c;
            }

            function j() {
                if (g >= m) {
                    throw Error('Invalid byte index');
                }
                var a = l[g] & 0xff;
                g++;
                if ((a & 0xc0) == 0x80) {
                    return a & 0x3f;
                }
                throw Error('Invalid continuation byte');
            }

            function w() {
                var b;
                var c;
                var d;
                var e;
                var a;
                if (g > m) {
                    throw Error('Invalid byte index');
                }
                if (g == m) {
                    return ![];
                }
                b = l[g] & 0xff;
                g++;
                if ((b & 0x80) == 0x0) {
                    return b;
                }
                if ((b & 0xe0) == 0xc0) {
                    var c = j();
                    a = (b & 0x1f) << 0x6 | c;
                    if (a >= 0x80) {
                        return a;
                    } else {
                        throw Error('Invalid continuation byte');
                    }
                }
                if ((b & 0xf0) == 0xe0) {
                    c = j();
                    d = j();
                    a = (b & 0xf) << 0xc | c << 0x6 | d;
                    if (a >= 0x800) {
                        return a;
                    } else {
                        throw Error('Invalid continuation byte');
                    }
                }
                if ((b & 0xf8) == 0xf0) {
                    c = j();
                    d = j();
                    e = j();
                    a = (b & 0xf) << 0x12 | c << 0xc | d << 0x6 | e;
                    if (a >= 0x10000 && a <= 0x10ffff) {
                        return a;
                    }
                }
                throw Error('Invalid WTF-8 detected');
            }
            var l;
            var m;
            var g;

            function v(c) {
                l = q(c);
                m = l['length'];
                g = 0x0;
                var a = [];
                var b;
                while ((b = w()) !== ![]) {
                    a['push'](b);
                }
                return y(a);
            }
            var h = {
                'version': '1.0.0',
                'encode': u,
                'decode': v
            };
            if (!![]) {
                !(d = function() {
                    return h;
                }['call'](a, b, a, c), d !== undefined && (c['exports'] = d));
            } else if (k && !k['nodeType']) {
                if (o) {
                    o['exports'] = h;
                } else {
                    var s = {};
                    var r = s['hasOwnProperty'];
                    for (var n in h) {
                        r['call'](h, n) && (k[n] = h[n]);
                    }
                }
            } else {
                t['wtf8'] = h;
            }
        }(this));
    }['call'](a, b(0x18)(c), b(0x0)));
}, function(dM, dN, r) {
    'use strict';
    r(0x26);
    var cp = r(0x19);
    var d = r(0x28);
    var ci = r(0x25);
    var c = r(0x1a);
    var co = r(0x1d);
    var f = r(0x1e);
    var d9 = r(0x1f);
    var cr = r(0x20);
    var c0 = r(0x21);
    var by = r(0x24);
    var c9 = r(0x22);
    var cg = r(0x23);
    var ch = r(0x27)['obj'];
    var bw = new ci['TextManager']();

    function dK(b, c) {
        if (!c) {
            c = window['location']['href'];
        }
        b = b['replace'](/[\[\]]/g, '\\$&');
        var d = new RegExp('[?&]' + b + '(=([^&#]*)|&|#|$)'),
            a = d['exec'](c);
        if (!a) return null;
        if (!a[0x2]) return '';
        return decodeURIComponent(a[0x2]['replace'](/\+/g, ' '));
    }
    var ac = dK('party');
    var g = null;
    var aF = ![];
    var aa;

    function dC(a) {
        aa = window['serverAddress'];
        if (!g) {
            g = cp['connect']('http://' + aa + ':<<SOCKET PORT>>', {
                'reconnection': ![],
                'query': 'man=' + (ac ? 0x1 : 0x0) + '&k=<<KEY>>'
            });
        }
        g['on']('disconnect', function() {
            a('disconnected');
        });
        g['once']('connect', function() {
            a();
            cI();
        });
    }

    function dA() {
        return g && aF;
    }

    function dq() {
        if (aa) {
            window['history']['replaceState']('moomoo party', 'MooMoo', '?party=' + aa);
            ac = aa;
            c7();
        }
    }

    function dp() {
        var a = prompt('party key', window['serverAddress']);
        if (a) {
            window['location']['href'] = '/?party=' + a;
        }
    }

    function c7() {
        I['style']['display'] = 'block';
        as['style']['display'] = 'block';
        var a;
        if (ac) {
            a = ac;
            I['classList']['add']('inParty');
        } else {
            a = 'Create Party';
            I['classList']['remove']('inParty');
        }
        I['getElementsByTagName']('span')[0x0]['innerText'] = a;
    }
    var W = new ch(c, d);

    function cd(a) {
        if (a == undefined) a = !W['active'];
        W['active'] = a;
        W['toggleMute']('menu', !a);
        ay('moo_moosic', a ? 0x1 : 0x0);
    }
    var aQ = Math['PI'];
    var Q = aQ * 0x2;
    var dn = aQ * 0x3;
    Math['lerpAngle'] = function(c, a, e) {
        var d = Math['abs'](a - c);
        if (d > aQ) {
            if (c > a) {
                a += Q;
            } else {
                c += Q;
            }
        }
        var b = a + (c - a) * e;
        if (b >= 0x0 && b <= Q) return b;
        return b % Q;
    };
    CanvasRenderingContext2D['prototype']['roundRect'] = function(b, c, d, e, a) {
        if (d < 0x2 * a) a = d / 0x2;
        if (e < 0x2 * a) a = e / 0x2;
        if (a < 0x0) a = 0x0;
        this['beginPath']();
        this['moveTo'](b + a, c);
        this['arcTo'](b + d, c, b + d, c + e, a);
        this['arcTo'](b + d, c + e, b, c + e, a);
        this['arcTo'](b, c + e, b, c, a);
        this['arcTo'](b, c, b + d, c, a);
        this['closePath']();
        return this;
    };
    var ax;
    if (typeof Storage !== 'undefined') {
        ax = !![];
    }

    function ay(a, b) {
        if (ax) localStorage['setItem'](a, b);
    }

    function dL(a) {
        if (ax) localStorage['removeItem'](a);
    }

    function aE(a) {
        if (ax) return localStorage['getItem'](a);
        return null;
    }
    var af = aE('moofoll');

    function dk() {
        if (!af) {
            af = !![];
            ay('moofoll', 0x1);
        }
    }
    var bX;
    var bs;
    var B = 0x1;
    var u, a0, br;
    var bq = Date['now']();
    var z, t;
    var q = [];
    var h = [];
    var y = [];
    var D = [];
    var V = [];
    var bp = new cg(c9, V, h, q, n, f, c, d);
    var bC = r(0x1c);
    var bE = r(0x1b);
    var bo = new bC(q, bE, h, f, null, c, d);
    var e, bY, a;
    var N = 0x1;
    var aH = 0x0;
    var bn = 0x0;
    var bl = 0x0;
    var k = {
        'id': -0x1,
        'startX': 0x0,
        'startY': 0x0,
        'currentX': 0x0,
        'currentY': 0x0
    };
    var j = {
        'id': -0x1,
        'startX': 0x0,
        'startY': 0x0,
        'currentX': 0x0,
        'currentY': 0x0
    };
    var E, F;
    var cl;
    var aA = 0x0;
    var i = c['maxScreenWidth'];
    var l = c['maxScreenHeight'];
    var a6, a1;
    var ah = ![];
    var dj = document['getElementById']('ad-container');
    var aJ = document['getElementById']('mainMenu');
    var bh = document['getElementById']('enterGame');
    var bg = document['getElementById']('promoImg');
    var I = document['getElementById']('partyButton');
    var as = document['getElementById']('joinPartyButton');
    var at = document['getElementById']('settingsButton');
    var bf = at['getElementsByTagName']('span')[0x0];
    var aS = document['getElementById']('allianceButton');
    var bd = document['getElementById']('storeButton');
    var bc = document['getElementById']('chatButton');
    var s = document['getElementById']('gameCanvas');
    var b = s['getContext']('2d');
    var R = document['getElementById']('serverSelect');
    var aB = document['getElementById']('nativeResolution');
    var bb = document['getElementById']('playMusic');
    var ad = document['getElementById']('menuCardHolder');
    var _ = document['getElementById']('guideCard');
    var $ = document['getElementById']('loadingText');
    var aG = document['getElementById']('gameUI');
    var ba = document['getElementById']('actionBar');
    var bF = document['getElementById']('scoreDisplay');
    var bI = document['getElementById']('foodDisplay');
    var bJ = document['getElementById']('woodDisplay');
    var bP = document['getElementById']('stoneDisplay');
    var bQ = document['getElementById']('killCounter');
    var b9 = document['getElementById']('leaderboardData');
    var ab = document['getElementById']('nameInput');
    var C = document['getElementById']('itemInfoHolder');
    var b8 = document['getElementById']('ageText');
    var b7 = document['getElementById']('ageBarBody');
    var X = document['getElementById']('upgradeHolder');
    var a7 = document['getElementById']('upgradeCounter');
    var v = document['getElementById']('allianceMenu');
    var a8 = document['getElementById']('allianceHolder');
    var a9 = document['getElementById']('allianceManager');
    var p = document['getElementById']('mapDisplay');
    var a2 = document['getElementById']('diedText');
    var ck = document['getElementById']('skinColorHolder');
    var m = p['getContext']('2d');
    p['width'] = 0x12c;
    p['height'] = 0x12c;
    var H = document['getElementById']('storeMenu');
    var b5 = document['getElementById']('storeHolder');
    var P = document['getElementById']('noticationDisplay');
    var a5 = by['hats'];
    var a3 = by['accessories'];
    var n = new cr(co, D, d, c);
    var aj = '#525252';
    var b1 = '#3d3f42';
    var T = 5.5;

    function dh(a) {
        y = a['teams'];
    }
    var bO = document['getElementById']('featuredYoutube');
    var a$ = [{
        'name': 'Corrupt X',
        'link': 'https://www.youtube.com/channel/UC0UH2LfQvBSeH24bmtbmITw'
    }, {
        'name': 'Tweak Big',
        'link': 'https://www.youtube.com/channel/UCbwvzJ38AndDTkoX8sD9YOw'
    }, {
        'name': 'Arena Closer',
        'link': 'https://www.youtube.com/channel/UCazucVSJqW-kiHMIhQhD-QQ'
    }, {
        'name': 'Godenot',
        'link': 'https://www.youtube.com/user/SirGodenot'
    }, {
        'name': 'RajNoobTV',
        'link': 'https://www.youtube.com/channel/UCVLo9brXBWrCttMaGzvm0-Q'
    }, {
        'name': 'TomNotTom',
        'link': 'https://www.youtube.com/channel/UC7z97RgHFJRcv2niXgArBDw'
    }, {
        'name': 'Nation',
        'link': 'https://www.youtube.com/channel/UCSl-MBn3qzjrIvLNESQRk-g'
    }, {
        'name': 'Pidyohago',
        'link': 'https://www.youtube.com/channel/UC04p8Mg8nDaDx04A9is2B8Q'
    }, {
        'name': 'Enigma',
        'link': 'https://www.youtube.com/channel/UC5HhLbs3sReHo8Bb9NDdFrg'
    }, {
        'name': 'Bauer',
        'link': 'https://www.youtube.com/channel/UCwU2TbJx3xTSlPqg-Ix3R1g'
    }, {
        'name': 'iStealth',
        'link': 'https://www.youtube.com/channel/UCGrvlEOsQFViZbyFDE6t69A'
    }, {
        'name': 'SICKmania',
        'link': 'https://www.youtube.com/channel/UCvVI98ezn4TpX5wDMZjMa3g'
    }, {
        'name': 'LightThief',
        'link': 'https://www.youtube.com/channel/UCj6C_tiDeATiKd3GX127XoQ'
    }, {
        'name': 'Fortish',
        'link': 'https://www.youtube.com/channel/UCou6CLU-szZA3Tb340TB9_Q'
    }, {
        'name': '巧克力',
        'link': 'https://www.youtube.com/channel/UCgL6J6oL8F69vm-GcPScmwg'
    }, {
        'name': 'i Febag',
        'link': 'https://www.youtube.com/channel/UCiU6WZwiKbsnt5xmwr0OFbg'
    }, {
        'name': 'GoneGaming',
        'link': 'https://www.youtube.com/channel/UCOcQthRanYcwYY0XVyVeK0g'
    }];
    var a_ = a$[d['randInt'](0x0, a$['length'] - 0x1)];
    bO['innerHTML'] = '<a target=\'_blank\' class=\'ytLink\' href=\'' + a_['link'] + '\'><i class=\'material-icons\' style=\'vertical-align: top;\'>&#xE064;</i> ' + a_['name'] + '</a>';
    var aL = !![];
    window['onblur'] = function() {
        aL = ![];
    };
    window['onfocus'] = function() {
        aL = !![];
        if (e && e['alive']) {
            bx();
        }
    };
    window['onload'] = function() {
        df();
        dC(function(a) {
            if (a) {
                bS('disconnected');
            } else {
                aF = !![];
                cX();
            }
        });
    };
    s['oncontextmenu'] = function() {
        return ![];
    };

    function bS(a) {
        aF = ![];
        g['close']();
        bV(a);
    }

    function bV(a) {
        aJ['style']['display'] = 'block';
        aG['style']['display'] = 'none';
        ad['style']['display'] = 'none';
        a2['style']['display'] = 'none';
        $['style']['display'] = 'block';
        $['innerHTML'] = a + '<a href=\'javascript:window.location.href=window.location.href\' class=\'ytLink\'>reload</a>';
    }

    function dg() {
        bh['onclick'] = d['checkTrusted'](function() {
            d6();
        });
        d['hookTouchEvents'](bh);
        bg['onclick'] = d['checkTrusted'](function() {
            cm('https://foes.io');
        });
        d['hookTouchEvents'](bg);
        I['onclick'] = d['checkTrusted'](function() {
            dq();
        });
        d['hookTouchEvents'](I);
        as['onclick'] = d['checkTrusted'](function() {
            setTimeout(function() {
                dp();
            }, 0xa);
        });
        d['hookTouchEvents'](as);
        at['onclick'] = d['checkTrusted'](function() {
            cD();
        });
        d['hookTouchEvents'](at);
        aS['onclick'] = d['checkTrusted'](function() {
            c$();
        });
        d['hookTouchEvents'](aS);
        bd['onclick'] = d['checkTrusted'](function() {
            cK();
        });
        d['hookTouchEvents'](bd);
        bc['onclick'] = d['checkTrusted'](function() {
            ce();
        });
        d['hookTouchEvents'](bc);
        p['onclick'] = d['checkTrusted'](function() {
            c8();
        });
        d['hookTouchEvents'](p);
    }

    function df() {
        var d = !![];
        var b = 0x0;
        var c = [];
        for (var e in window['allServers']) {
            var f = window['allServers'][e];
            var a = b$(e, f, d);
            d = ![];
            var g = a[0x0];
            var h = a[0x1];
            b += h;
            c = c['concat'](g);
        }
        var a = b$('Experimental', c, ![], !![]);
        b += a[0x1];
        dd();
        b_('All Servers - ' + b + ' players');
        R['value'] = window['serverAddress'];
    }

    function dd() {
        var a = document['createElement']('option');
        a['disabled'] = !![];
        R['appendChild'](a);
    }

    function b_(b) {
        var a = document['createElement']('option');
        a['disabled'] = !![];
        a['text'] = b;
        R['appendChild'](a);
    }

    function b$(g, d, h, i) {
        var f = [];
        var e = 0x0;
        for (var a = 0x0; a < d['length']; a++) {
            e += d[a]['playerCount'];
        }
        if (!h) {
            var b = document['createElement']('option');
            b['disabled'] = !![];
            R['appendChild'](b);
        }
        b_(g + ' - ' + e + ' players');
        for (var a = 0x0; a < d['length']; a++) {
            var c = d[a];
            if (!i && c['experimental']) {
                f['push'](c);
                continue;
            }
            var b = document['createElement']('option');
            b['value'] = c['ip'];
            b['text'] = g + ' ' + (a + 0x1) + ' [' + c['playerCount'] + '/' + c['maxPlayers'] + ']';
            R['appendChild'](b);
        }
        return [f, e];
    }
    R['addEventListener']('change', d['checkTrusted'](function(a) {
        window['location']['href'] = '/?party=' + a['target']['value'];
    }));
    var aV = 0x0;
    var c1 = 0x3e8 * 0x3c * 0x2;
    var aP = ![];
    var ap = ![];
    var dc = ![];
    var aT = 0x0;

    function cb() {
        if (window['admob']) {
            if (!aP) {
                window['admob']['requestInterstitialAd']({
                    'autoShowInterstitial': ap
                });
            }
        }
    }

    function db() {
        if (!window['admob']) {
            return;
        }
        if (aP) {
            window['admob']['showInterstitialAd'](function() {
                aP = ![];
                ap = ![];
                cb();
            });
        } else {
            ap = !![];
            aV = Date['now']();
            window['admob']['requestInterstitialAd']({
                'autoShowInterstitial': ap
            });
        }
    }

    function da() {
        aT++;
        var a = aT > 0x1;
        var b = Date['now']() - aV > c1;
        if (a && b) {
            console['log']('Showing');
            db();
        }
    }
    var aU = 0x3e8 * 0x3c * 0x5;
    var aO = 0x0;
    var aN = 0x0;
    var ar = ![];

    function d8() {
        if (window['admob']) {
            aI();
            return;
        }
        aN++;
        var b = aN > 0x1;
        var c = Date['now']() - aO > aU;
        console['log']('Game', b, aN, 'Time', c, (Date['now']() - aO) / 0x3e8 / 0x3c, aU / 0x3e8 / 0x3c);
        if (!b || !c) {
            aI();
            return;
        }
        ar = !![];
        var a = document['createElement']('script');
        a['src'] = '//cdn.playwire.com/bolt/js/zeus/embed.js';
        a['type'] = 'text/javascript';
        a['setAttribute']('charset', 'utf-8');
        a['setAttribute']('data-config', '//config.playwire.com/1020124/v2/pre_content.json');
        a['setAttribute']('data-width', '640px');
        a['setAttribute']('data-height', '360px');
        a['setAttribute']('data-id', 'pre-content-player');
        a['setAttribute']('data-hidden-container', 'my-content');
        a['setAttribute']('data-onready', 'window.boltEventHandlers');
        var d = document['getElementById']('pre-content-container');
        d['style']['display'] = 'block';
        d['appendChild'](a);
        setTimeout(function() {
            let a = document['getElementById']('my-content')['style']['display'] != 'none';
            if (a) {
                console['log']('Ad blocked');
                aZ();
            } else {
                console['log']('Ad not blocked');
            }
        }, 2.5 * 0x3e8);
        setTimeout(function() {
            aZ();
        }, 0x1e * 0x3e8);
    }
    window['boltEventHandlers'] = function() {
        Bolt['on']('pre-content-player', 'showHiddenContainer', function() {
            aZ();
        });
    };

    function aZ() {
        if (ar) {
            ar = ![];
            document['getElementById']('pre-content-container')['style']['display'] = 'none';
            document['getElementById']('my-content')['style']['display'] = 'none';
            aO = Date['now']();
            aI();
        }
    }

    function d6() {
        if (window['admob']) {
            aI();
        } else {
            d8();
        }
    }

    function w(a, c, f) {
        if (e && a) {
            d['removeAllChildren'](C);
            C['classList']['add']('visible');
            d['generateElement']({
                'id': 'itemInfoName',
                'text': d['capitalizeFirst'](a['name']),
                'parent': C
            });
            d['generateElement']({
                'id': 'itemInfoDesc',
                'text': a['desc'],
                'parent': C
            });
            if (f) {} else if (c) {
                d['generateElement']({
                    'class': 'itemInfoReq',
                    'text': !a['type'] ? 'primary' : 'secondary',
                    'parent': C
                });
            } else {
                for (var b = 0x0; b < a['req']['length']; b += 0x2) {
                    d['generateElement']({
                        'class': 'itemInfoReq',
                        'html': a['req'][b] + '<span class=\'itemInfoReqVal\'> x' + a['req'][b + 0x1] + '</span>',
                        'parent': C
                    });
                }
                if (a['group']['limit']) {
                    d['generateElement']({
                        'class': 'itemInfoLmt',
                        'text': (e['itemCounts'][a['group']['id']] || 0x0) + '/' + a['group']['limit'],
                        'parent': C
                    });
                }
            }
        } else {
            C['classList']['remove']('visible');
        }
    }
    var J = [];
    var K = [];

    function d4(a, b) {
        J['push']({
            'sid': a,
            'name': b
        });
        b2();
    }

    function b2() {
        if (J[0x0]) {
            var a = J[0x0];
            d['removeAllChildren'](P);
            P['style']['display'] = 'block';
            d['generateElement']({
                'class': 'notificationText',
                'text': a['name'],
                'parent': P
            });
            d['generateElement']({
                'class': 'notifButton',
                'html': '<i class=\'material-icons\' style=\'font-size:28px;color:#cc5151;\'>&#xE14C;</i>',
                'parent': P,
                'onclick': function() {
                    b6(0x0);
                },
                'hookTouch': !![]
            });
            d['generateElement']({
                'class': 'notifButton',
                'html': '<i class=\'material-icons\' style=\'font-size:28px;color:#8ecc51;\'>&#xE876;</i>',
                'parent': P,
                'onclick': function() {
                    b6(0x1);
                },
                'hookTouch': !![]
            });
        } else {
            P['style']['display'] = 'none';
        }
    }

    function d3(a) {
        y['push'](a);
        if (v['style']['display'] == 'block') ae();
    }

    function d2(a, b) {
        if (e) {
            e['team'] = a;
            e['isOwner'] = b;
            if (v['style']['display'] == 'block') ae();
        }
    }

    function d1(a) {
        K = a;
        if (v['style']['display'] == 'block') ae();
    }

    function d0(b) {
        for (var a = y['length'] - 0x1; a >= 0x0; a--) {
            if (y[a]['sid'] == b) y['splice'](a, 0x1);
        }
        if (v['style']['display'] == 'block') ae();
    }

    function c$() {
        bx();
        if (v['style']['display'] != 'block') {
            ae();
        } else {
            v['style']['display'] = 'none';
        }
    }

    function ae() {
        if (e && e['alive']) {
            az();
            H['style']['display'] = 'none';
            v['style']['display'] = 'block';
            d['removeAllChildren'](a8);
            if (e['team']) {
                for (var a = 0x0; a < K['length']; a += 0x2) {
                    (function(a) {
                        var b = d['generateElement']({
                            'class': 'allianceItem',
                            'style': 'color:' + (K[a] == e['sid'] ? '#fff' : 'rgba(255,255,255,0.6)'),
                            'text': K[a + 0x1],
                            'parent': a8
                        });
                        if (e['isOwner'] && K[a] != e['sid']) {
                            d['generateElement']({
                                'class': 'joinAlBtn',
                                'text': 'Kick',
                                'onclick': function() {
                                    bK(K[a]);
                                },
                                'hookTouch': !![],
                                'parent': b
                            });
                        }
                    }(a));
                }
            } else {
                if (y['length']) {
                    for (var a = 0x0; a < y['length']; ++a) {
                        (function(a) {
                            var b = d['generateElement']({
                                'class': 'allianceItem',
                                'style': 'color:' + (y[a]['sid'] == e['team'] ? '#fff' : 'rgba(255,255,255,0.6)'),
                                'text': y[a]['sid'],
                                'parent': a8
                            });
                            d['generateElement']({
                                'class': 'joinAlBtn',
                                'text': 'Join',
                                'onclick': function() {
                                    bL(a);
                                },
                                'hookTouch': !![],
                                'parent': b
                            });
                        }(a));
                    }
                } else {
                    d['generateElement']({
                        'class': 'allianceItem',
                        'text': 'No Tribes Yet',
                        'parent': a8
                    });
                }
            }
            d['removeAllChildren'](a9);
            if (e['team']) {
                d['generateElement']({
                    'class': 'allianceButtonM',
                    'style': 'width: 360px',
                    'text': e['isOwner'] ? 'Delete Tribe' : 'Leave Tribe',
                    'onclick': function() {
                        bN();
                    },
                    'hookTouch': !![],
                    'parent': a9
                });
            } else {
                d['generateElement']({
                    'tag': 'input',
                    'type': 'text',
                    'id': 'allianceInput',
                    'maxLength': 0x6,
                    'placeholder': 'unique name',
                    'ontouchstart': function(a) {
                        a['preventDefault']();
                        var b = prompt('unique name', a['currentTarget']['value']);
                        a['currentTarget']['value'] = b['slice'](0x0, 0x6);
                    },
                    'parent': a9
                });
                d['generateElement']({
                    'tag': 'div',
                    'class': 'allianceButtonM',
                    'style': 'width: 140px;',
                    'text': 'Create',
                    'onclick': function() {
                        bM();
                    },
                    'hookTouch': !![],
                    'parent': a9
                });
            }
        }
    }

    function b6(a) {
        g['emit']('11', J[0x0]['sid'], a);
        J['splice'](0x0, 0x1);
        b2();
    }

    function bK(a) {
        g['emit']('12', a);
    }

    function bL(a) {
        g['emit']('10', y[a]['sid']);
    }

    function bM() {
        g['emit']('8', document['getElementById']('allianceInput')['value']);
    }

    function bN() {
        J = [];
        b2();
        g['emit']('9');
    }
    var aR;
    var ag;
    var L;
    var U = [];
    var S;

    function cY() {
        this['init'] = function(a, b) {
            this['scale'] = 0x0;
            this['x'] = a;
            this['y'] = b;
            this['active'] = !![];
        };
        this['update'] = function(a, b) {
            if (this['active']) {
                this['scale'] += 0.05 * b;
                if (this['scale'] >= c['mapPingScale']) {
                    this['active'] = ![];
                } else {
                    a['globalAlpha'] = 0x1 - Math['max'](0x0, this['scale'] / c['mapPingScale']);
                    a['beginPath']();
                    a['arc'](this['x'] / c['mapScale'] * p['width'], this['y'] / c['mapScale'] * p['width'], this['scale'], 0x0, 0x2 * Math['PI']);
                    a['stroke']();
                }
            }
        };
    }

    function cW(b, c) {
        for (var a = 0x0; a < U['length']; ++a) {
            if (!U[a]['active']) {
                S = U[a];
                break;
            }
        }
        if (!S) {
            S = new cY();
            U['push'](S);
        }
        S['init'](b, c);
    }

    function cV() {
        if (!L) L = {};
        L['x'] = e['x'];
        L['y'] = e['y'];
    }

    function cT(a) {
        ag = a;
    }

    function cS(b) {
        if (e && e['alive']) {
            m['clearRect'](0x0, 0x0, p['width'], p['height']);
            m['strokeStyle'] = '#fff';
            m['lineWidth'] = 0x4;
            for (var a = 0x0; a < U['length']; ++a) {
                S = U[a];
                S['update'](m, b);
            }
            m['globalAlpha'] = 0x1;
            m['fillStyle'] = '#fff';
            o(e['x'] / c['mapScale'] * p['width'], e['y'] / c['mapScale'] * p['height'], 0x7, m, !![]);
            m['fillStyle'] = 'rgba(255,255,255,0.35)';
            if (e['team'] && ag) {
                for (var a = 0x0; a < ag['length'];) {
                    o(ag[a] / c['mapScale'] * p['width'], ag[a + 0x1] / c['mapScale'] * p['height'], 0x7, m, !![]);
                    a += 0x2;
                }
            }
            if (aR) {
                m['fillStyle'] = '#fc5553';
                m['font'] = '34px Hammersmith One';
                m['textBaseline'] = 'middle';
                m['textAlign'] = 'center';
                m['fillText']('x', aR['x'] / c['mapScale'] * p['width'], aR['y'] / c['mapScale'] * p['height']);
            }
            if (L) {
                m['fillStyle'] = '#fff';
                m['font'] = '34px Hammersmith One';
                m['textBaseline'] = 'middle';
                m['textAlign'] = 'center';
                m['fillText']('x', L['x'] / c['mapScale'] * p['width'], L['y'] / c['mapScale'] * p['height']);
            }
        }
    }
    var au = 0x0;
    var cR = {};

    function cN(a) {
        if (au != a) {
            au = a;
            bj();
        }
    }

    function cK() {
        if (H['style']['display'] != 'block') {
            H['style']['display'] = 'block';
            v['style']['display'] = 'none';
            az();
            bj();
        } else {
            H['style']['display'] = 'none';
        }
    }

    function cJ(b, a, c) {
        if (c) {
            if (!b) e['tails'][a] = 0x1;
            else e['tailIndex'] = a;
        } else {
            if (!b) e['skins'][a] = 0x1;
            else e['skinIndex'] = a;
        }
        if (H['style']['display'] == 'block') bj();
    }

    function bj() {
        if (e) {
            d['removeAllChildren'](b5);
            var b = au;
            var a = b ? a3 : a5;
            for (var c = 0x0; c < a['length']; ++c) {
                if (!a[c]['dontSell']) {
                    (function(c) {
                        var f = d['generateElement']({
                            'id': 'storeDisplay' + c,
                            'class': 'storeItem',
                            'onmouseout': function() {
                                w();
                            },
                            'onmouseover': function() {
                                w(a[c], ![], !![]);
                            },
                            'parent': b5
                        });
                        d['hookTouchEvents'](f, !![]);
                        d['generateElement']({
                            'tag': 'img',
                            'class': 'hatPreview',
                            'src': '../img/' + (b ? 'accessories/access_' : 'hats/hat_') + a[c]['id'] + (a[c]['topSprite'] ? '_p' : '') + '.png',
                            'parent': f
                        });
                        d['generateElement']({
                            'tag': 'span',
                            'text': a[c]['name'],
                            'parent': f
                        });
                        if (b ? !e['tails'][a[c]['id']] : !e['skins'][a[c]['id']]) {
                            d['generateElement']({
                                'class': 'joinAlBtn',
                                'style': 'margin-top: 5px',
                                'text': 'Buy',
                                'onclick': function() {
                                    c3(a[c]['id'], b);
                                },
                                'hookTouch': !![],
                                'parent': f
                            });
                            d['generateElement']({
                                'tag': 'span',
                                'class': 'itemPrice',
                                'text': a[c]['price'],
                                'parent': f
                            });
                        } else if ((b ? e['tailIndex'] : e['skinIndex']) == a[c]['id']) {
                            d['generateElement']({
                                'class': 'joinAlBtn',
                                'style': 'margin-top: 5px',
                                'text': 'Unequip',
                                'onclick': function() {
                                    bk(0x0, b);
                                },
                                'hookTouch': !![],
                                'parent': f
                            });
                        } else {
                            d['generateElement']({
                                'class': 'joinAlBtn',
                                'style': 'margin-top: 5px',
                                'text': 'Equip',
                                'onclick': function() {
                                    bk(a[c]['id'], b);
                                },
                                'hookTouch': !![],
                                'parent': f
                            });
                        }
                    }(c));
                }
            }
        }
    }

    function bk(a, b) {
        g['emit']('13', 0x0, a, b);
    }

    function c3(a, b) {
        g['emit']('13', 0x1, a, b);
    }

    function c4() {
        H['style']['display'] = 'none';
        v['style']['display'] = 'none';
        az();
    }

    function cH() {
        cb();
        var b = aE('native_resolution');
        if (!b) {
            bm(typeof cordova !== 'undefined');
        } else {
            bm(b == 'true');
        }
        bs = aE('moo_moosic') || 0x0;
        c7();
        setInterval(function() {
            if (window['cordova']) {
                document['getElementById']('downloadButtonContainer')['classList']['add']('cordova');
                document['getElementById']('mobileDownloadButtonContainer')['classList']['add']('cordova');
            }
        }, 0x3e8);
        ca();
        d['removeAllChildren'](ba);
        for (var a = 0x0; a < f['weapons']['length'] + f['list']['length']; ++a) {
            (function(a) {
                d['generateElement']({
                    'id': 'actionBarItem' + a,
                    'class': 'actionBarItem',
                    'style': 'display:none',
                    'onmouseout': function() {
                        w();
                    },
                    'parent': ba
                });
            }(a));
        }
        for (var a = 0x0; a < f['list']['length'] + f['weapons']['length']; ++a) {
            (function(e) {
                var a = document['createElement']('canvas');
                a['width'] = a['height'] = 0x42;
                var b = a['getContext']('2d');
                b['translate'](a['width'] / 0x2, a['height'] / 0x2);
                b['imageSmoothingEnabled'] = ![];
                b['webkitImageSmoothingEnabled'] = ![];
                b['mozImageSmoothingEnabled'] = ![];
                if (f['weapons'][e]) {
                    b['rotate'](Math['PI'] / 0x4 + Math['PI']);
                    var i = new Image();
                    aM[f['weapons'][e]['src']] = i;
                    i['onload'] = function() {
                        this['isLoaded'] = !![];
                        var g = 0x1 / (this['height'] / this['width']);
                        var d = f['weapons'][e]['iPad'] || 0x1;
                        b['drawImage'](this, -(a['width'] * d * c['iconPad'] * g) / 0x2, -(a['height'] * d * c['iconPad']) / 0x2, a['width'] * d * g * c['iconPad'], a['height'] * d * c['iconPad']);
                        b['fillStyle'] = 'rgba(0, 0, 70, 0.1)';
                        b['globalCompositeOperation'] = 'source-atop';
                        b['fillRect'](-a['width'] / 0x2, -a['height'] / 0x2, a['width'], a['height']);
                        document['getElementById']('actionBarItem' + e)['style']['backgroundImage'] = 'url(' + a['toDataURL']() + ')';
                    };
                    i['src'] = '.././img/weapons/' + f['weapons'][e]['src'] + '.png';
                    var g = document['getElementById']('actionBarItem' + e);
                    g['onmouseover'] = d['checkTrusted'](function() {
                        w(f['weapons'][e], !![]);
                    });
                    g['onclick'] = d['checkTrusted'](function() {
                        am(e, !![]);
                    });
                    d['hookTouchEvents'](g);
                } else {
                    var i = bt(f['list'][e - f['weapons']['length']], !![]);
                    var h = Math['min'](a['width'] - c['iconPadding'], i['width']);
                    b['globalAlpha'] = 0x1;
                    b['drawImage'](i, -h / 0x2, -h / 0x2, h, h);
                    b['fillStyle'] = 'rgba(0, 0, 70, 0.1)';
                    b['globalCompositeOperation'] = 'source-atop';
                    b['fillRect'](-h / 0x2, -h / 0x2, h, h);
                    document['getElementById']('actionBarItem' + e)['style']['backgroundImage'] = 'url(' + a['toDataURL']() + ')';
                    var g = document['getElementById']('actionBarItem' + e);
                    g['onmouseover'] = d['checkTrusted'](function() {
                        w(f['list'][e - f['weapons']['length']]);
                    });
                    g['onclick'] = d['checkTrusted'](function() {
                        am(e - f['weapons']['length']);
                    });
                    d['hookTouchEvents'](g);
                }
            }(a));
        }
        ab['ontouchstart'] = d['checkTrusted'](function(a) {
            a['preventDefault']();
            var b = prompt('enter name', a['currentTarget']['value']);
            a['currentTarget']['value'] = b['slice'](0x0, 0xf);
        });
        aB['checked'] = bX;
        aB['onchange'] = d['checkTrusted'](function(a) {
            bm(a['target']['checked']);
        });
        cd(bs);
        bb['checked'] = bs;
        bb['onchange'] = d['checkTrusted'](function(a) {
            console['log'](0x1);
            cd();
        });
        W['play']('menu', 0x1, !![]);
    }

    function c6(b, d) {
        if (b) {
            if (d) e['weapons'] = b;
            else e['items'] = b;
        }
        for (var a = 0x0; a < f['list']['length']; ++a) {
            var c = f['weapons']['length'] + a;
            document['getElementById']('actionBarItem' + c)['style']['display'] = e['items']['indexOf'](f['list'][a]['id']) >= 0x0 ? 'inline-block' : 'none';
        }
        for (var a = 0x0; a < f['weapons']['length']; ++a) {
            document['getElementById']('actionBarItem' + a)['style']['display'] = e['weapons'][f['weapons'][a]['type']] == f['weapons'][a]['id'] ? 'inline-block' : 'none';
        }
    }

    function bm(a) {
        bX = a;
        B = a ? window['devicePixelRatio'] || 0x1 : 0x1;
        aB['checked'] = a;
        ay('native_resolution', a['toString']());
        bu();
    }

    function cF() {
        if (av) {
            _['classList']['add']('touch');
        } else {
            _['classList']['remove']('touch');
        }
    }

    function cD() {
        if (_['classList']['contains']('showing')) {
            _['classList']['remove']('showing');
            bf['innerText'] = 'Settings';
        } else {
            _['classList']['add']('showing');
            bf['innerText'] = 'Close';
        }
    }

    function ca() {
        var b = '';
        for (var a = 0x0; a < c['skinColors']['length']; ++a) {
            if (a == aA) {
                b += '<div class=\'skinColorItem activeSkin\' style=\'background-color:' + c['skinColors'][a] + '\' onclick=\'selectSkinColor(' + a + ')\'></div>';
            } else {
                b += '<div class=\'skinColorItem\' style=\'background-color:' + c['skinColors'][a] + '\' onclick=\'selectSkinColor(' + a + ')\'></div>';
            }
        }
        ck['innerHTML'] = b;
    }

    function cC(a) {
        aA = a;
        ca();
    }
    var Y = document['getElementById']('chatBox');
    var al = document['getElementById']('chatHolder');

    function ce() {
        if (!av) {
            if (al['style']['display'] == 'block') {
                if (Y['value']) {
                    cf(Y['value']);
                }
                az();
            } else {
                H['style']['display'] = 'none';
                v['style']['display'] = 'none';
                al['style']['display'] = 'block';
                Y['focus']();
                bx();
            }
        } else {
            setTimeout(function() {
                var a = prompt('chat message');
                if (a) {
                    cf(a);
                }
            }, 0x1);
        }
        Y['value'] = '';
    }

    function cf(a) {
        g['emit']('ch', a['slice'](0x0, 0x1e));
    }

    function az() {
        Y['value'] = '';
        al['style']['display'] = 'none';
    }
    var ai = ['cunt', 'whore', 'fuck', 'shit', 'faggot', 'nigger', 'nigga', 'dick', 'vagina', 'minge', 'cock', 'rape', 'cum', 'sex', 'tits', 'penis', 'clit', 'pussy', 'meatcurtain', 'jizz', 'prune', 'douche', 'wanker', 'ass', 'damn', 'bitch', 'dick', 'fag', 'bastard'];

    function cB(b) {
        var c;
        for (var a = 0x0; a < ai['length']; ++a) {
            if (b['indexOf'](ai[a]) > -0x1) {
                c = '';
                for (var d = 0x0; d < ai[a]['length']; ++d) {
                    c += c['length'] ? 'o' : 'M';
                }
                var e = new RegExp(ai[a], 'g');
                b = b['replace'](e, c);
            }
        }
        return b;
    }

    function cy(b, d) {
        var a = aD(b);
        if (a) {
            a['chatMessage'] = cB(d);
            a['chatCountdown'] = c['chatCountdown'];
        }
    }
    window['addEventListener']('resize', d['checkTrusted'](bu));

    function bu() {
        a6 = window['innerWidth'];
        a1 = window['innerHeight'];
        var a = Math['max'](a6 / i, a1 / l) * B;
        s['width'] = a6 * B;
        s['height'] = a1 * B;
        s['style']['width'] = a6 + 'px';
        s['style']['height'] = a1 + 'px';
        b['setTransform'](a, 0x0, 0x0, a, (a6 * B - i * a) / 0x2, (a1 * B - l * a) / 0x2);
    }
    bu();
    var av;
    G(![]);

    function G(a) {
        av = a;
        cF();
    }
    window['setUsingTouch'] = G;
    s['addEventListener']('touchmove', d['checkTrusted'](cx), ![]);

    function cx(b) {
        b['preventDefault']();
        b['stopPropagation']();
        G(!![]);
        for (var c = 0x0; c < b['changedTouches']['length']; c++) {
            var a = b['changedTouches'][c];
            if (a['identifier'] == k['id']) {
                k['currentX'] = a['pageX'];
                k['currentY'] = a['pageY'];
                an();
            } else if (a['identifier'] == j['id']) {
                j['currentX'] = a['pageX'];
                j['currentY'] = a['pageY'];
                t = 0x1;
            }
        }
    }
    s['addEventListener']('touchstart', d['checkTrusted'](cw), ![]);

    function cw(b) {
        b['preventDefault']();
        b['stopPropagation']();
        G(!![]);
        for (var c = 0x0; c < b['changedTouches']['length']; c++) {
            var a = b['changedTouches'][c];
            if (a['pageX'] < document['body']['scrollWidth'] / 0x2 && k['id'] == -0x1) {
                k['id'] = a['identifier'];
                k['startX'] = k['currentX'] = a['pageX'];
                k['startY'] = k['currentY'] = a['pageY'];
                an();
            } else if (a['pageX'] > document['body']['scrollWidth'] / 0x2 && j['id'] == -0x1) {
                j['id'] = a['identifier'];
                j['startX'] = j['currentX'] = a['pageX'];
                j['startY'] = j['currentY'] = a['pageY'];
                if (e['buildIndex'] < 0x0) {
                    t = 0x1;
                    M();
                }
            }
        }
    }
    s['addEventListener']('touchend', d['checkTrusted'](bz), ![]);
    s['addEventListener']('touchcancel', d['checkTrusted'](bz), ![]);
    s['addEventListener']('touchleave', d['checkTrusted'](bz), ![]);

    function bz(a) {
        a['preventDefault']();
        a['stopPropagation']();
        G(!![]);
        for (var b = 0x0; b < a['changedTouches']['length']; b++) {
            var c = a['changedTouches'][b];
            if (c['identifier'] == k['id']) {
                k['id'] = -0x1;
                an();
            } else if (c['identifier'] == j['id']) {
                j['id'] = -0x1;
                if (e['buildIndex'] >= 0x0) {
                    t = 0x1;
                    M();
                }
                t = 0x0;
                M();
            }
        }
    }
    s['addEventListener']('mousemove', cv, ![]);

    function cv(a) {
        a['preventDefault']();
        a['stopPropagation']();
        G(![]);
        bn = a['clientX'];
        bl = a['clientY'];
    }
    s['addEventListener']('mousedown', cu, ![]);

    function cu(a) {
        G(![]);
        if (t != 0x1) {
            t = 0x1;
            M();
        }
    }
    s['addEventListener']('mouseup', ct, ![]);

    function ct(a) {
        G(![]);
        if (t != 0x0) {
            t = 0x0;
            M();
        }
    }

    function d7() {
        var a = 0x0;
        var b = 0x0;
        if (k['id'] != -0x1) {
            a += k['currentX'] - k['startX'];
            b += k['currentY'] - k['startY'];
        } else {
            for (var c in ao) {
                var e = ao[c];
                a += !!z[c] * e[0x0];
                b += !!z[c] * e[0x1];
            }
        }
        return a == 0x0 && b == 0x0 ? undefined : d['fixTo'](Math['atan2'](b, a), 0x2);
    }
    var bB;

    function bA() {
        if (!e) return 0x0;
        if (j['id'] != -0x1) {
            bB = Math['atan2'](j['currentY'] - j['startY'], j['currentX'] - j['startX']);
        } else if (!e['lockDir'] && !av) {
            bB = Math['atan2'](bl - a1 / 0x2, bn - a6 / 0x2);
        }
        return d['fixTo'](bB || 0x0, 0x2);
    }
    var z = {};
    var ao = {
        87: [0x0, -0x1],
        38: [0x0, -0x1],
        83: [0x0, 0x1],
        40: [0x0, 0x1],
        65: [-0x1, 0x0],
        37: [-0x1, 0x0],
        68: [0x1, 0x0],
        39: [0x1, 0x0]
    };

    function bx() {
        z = {};
        g['emit']('rmd');
    }

    function cj() {
        return v['style']['display'] != 'block' && al['style']['display'] != 'block';
    }

    function cz(b) {
        var a = b['which'] || b['keyCode'] || 0x0;
        if (a == 0x1b) {
            c4();
        } else if (e && e['alive'] && cj()) {
            if (!z[a]) {
                z[a] = 0x1;
                if (a == 0x45) {
                    cG();
                } else if (a == 0x43) {
                    cV();
                } else if (a == 0x58) {
                    cE();
                } else if (e['weapons'][a - 0x31] != undefined) {
                    am(e['weapons'][a - 0x31], !![]);
                } else if (e['items'][a - 0x31 - e['weapons']['length']] != undefined) {
                    am(e['items'][a - 0x31 - e['weapons']['length']]);
                } else if (a == 0x51) {
                    am(e['items'][0x0]);
                } else if (a == 0x52) {
                    c8();
                } else if (ao[a]) {
                    an();
                } else if (a == 0x20) {
                    t = 0x1;
                    M();
                }
            }
        }
    }
    window['addEventListener']('keydown', d['checkTrusted'](cz));

    function cA(b) {
        if (e && e['alive']) {
            var a = b['which'] || b['keyCode'] || 0x0;
            if (a == 0xd) {
                ce();
            } else if (cj()) {
                if (z[a]) {
                    z[a] = 0x0;
                    if (ao[a]) {
                        an();
                    } else if (a == 0x20) {
                        t = 0x0;
                        M();
                    }
                }
            }
        }
    }
    window['addEventListener']('keyup', d['checkTrusted'](cA));

    function M() {
        if (e && e['alive']) {
            g['emit']('4', t, e['buildIndex'] >= 0x0 ? bA() : null);
        }
    }
    var aC = undefined;

    function an() {
        var a = d7();
        if (aC == undefined || a == undefined || Math['abs'](a - aC) > 0.3) {
            g['emit']('3', a);
            aC = a;
        }
    }

    function cE() {
        e['lockDir'] = e['lockDir'] ? 0x0 : 0x1;
        g['emit']('7', 0x0);
    }

    function c8() {
        g['emit']('14', 0x1);
    }

    function cG() {
        g['emit']('7', 0x1);
    }

    function am(a, b) {
        g['emit']('5', a, b);
    }

    function cI() {
        g['on']('id', dh);
        g['on']('d', bS);
        g['on']('1', cL);
        g['on']('2', dD);
        g['on']('4', dE);
        g['on']('3', dI);
        g['on']('5', cZ);
        g['on']('6', du);
        g['on']('a', dz);
        g['on']('7', d5);
        g['on']('8', dv);
        g['on']('s', dw);
        g['on']('9', dG);
        g['on']('10', dH);
        g['on']('11', cO);
        g['on']('12', cQ);
        g['on']('13', cP);
        g['on']('14', dF);
        g['on']('15', bT);
        g['on']('16', bU);
        g['on']('17', c6);
        g['on']('18', dx);
        g['on']('19', dy);
        g['on']('ac', d3);
        g['on']('ad', d0);
        g['on']('an', d4);
        g['on']('st', d2);
        g['on']('sa', d1);
        g['on']('us', cJ);
        g['on']('ch', cy);
        g['on']('mm', cT);
        g['on']('t', cM);
        g['on']('p', cW);
    }

    function aI() {
        ay('moo_name', ab['value']);
        if (!ah && dA()) {
            ah = !![];
            W['stop']('menu');
            bV('Loading...');
            g['emit']('1', {
                'name': ab['value'],
                'moofoll': af,
                'skin': aA
            });
        }
    }
    var aK = !![];

    function cL(a) {
        $['style']['display'] = 'none';
        ad['style']['display'] = 'block';
        aJ['style']['display'] = 'none';
        z = {};
        bY = a;
        t = 0x0;
        ah = !![];
        if (aK) {
            aK = ![];
            D['length'] = 0x0;
        }
    }

    function cM(b, c, a, d) {
        bw['showText'](b, c, 0x32, 0.18, 0x1f4, Math['abs'](a), a >= 0x0 ? '#fff' : '#8ecc51');
    }
    var aq = 0x1869f;

    function cO() {
        ah = ![];
        try {
            factorem['refreshAds']([0x2], !![]);
        } catch (a) {};
        aG['style']['display'] = 'none';
        c4();
        aR = {
            'x': e['x'],
            'y': e['y']
        };
        $['style']['display'] = 'none';
        a2['style']['display'] = 'block';
        a2['style']['fontSize'] = '0px';
        aq = 0x0;
        setTimeout(function() {
            ad['style']['display'] = 'block';
            aJ['style']['display'] = 'block';
            W['play']('menu', 0x1, !![]);
            a2['style']['display'] = 'none';
            da();
        }, c['deathFadeout']);
    }

    function cP(a) {
        if (e) n['removeAllItems'](a);
    }

    function cQ(a) {
        n['disableBySid'](a);
    }

    function bZ() {
        bF['innerText'] = e['points'];
        bI['innerText'] = e['food'];;
        bJ['innerText'] = e['wood'];
        bP['innerText'] = e['stone'];
        bQ['innerText'] = e['kills'];
    }
    var Z = {};
    var aw = ['crown', 'skull'];

    function cU() {
        for (var a = 0x0; a < aw['length']; ++a) {
            var b = new Image();
            b['onload'] = function() {
                this['isLoaded'] = !![];
            };
            b['src'] = '.././img/icons/' + aw[a] + '.png';
            Z[aw[a]] = b;
        }
    }
    var O = [];

    function bU(h, i) {
        e['upgradePoints'] = h;
        e['upgrAge'] = i;
        if (h > 0x0) {
            O['length'] = 0x0;
            d['removeAllChildren'](X);
            for (var a = 0x0; a < f['weapons']['length']; ++a) {
                if (f['weapons'][a]['age'] == i && (f['weapons'][a]['pre'] == undefined || e['weapons']['indexOf'](f['weapons'][a]['pre']) >= 0x0)) {
                    var b = d['generateElement']({
                        'id': 'upgradeItem' + a,
                        'class': 'actionBarItem',
                        'onmouseout': function() {
                            w();
                        },
                        'parent': X
                    });
                    b['style']['backgroundImage'] = document['getElementById']('actionBarItem' + a)['style']['backgroundImage'];
                    O['push'](a);
                }
            }
            for (var a = 0x0; a < f['list']['length']; ++a) {
                if (f['list'][a]['age'] == i && (f['list'][a]['pre'] == undefined || e['items']['indexOf'](f['list'][a]['pre']) >= 0x0)) {
                    var c = f['weapons']['length'] + a;
                    var b = d['generateElement']({
                        'id': 'upgradeItem' + c,
                        'class': 'actionBarItem',
                        'onmouseout': function() {
                            w();
                        },
                        'parent': X
                    });
                    b['style']['backgroundImage'] = document['getElementById']('actionBarItem' + c)['style']['backgroundImage'];
                    O['push'](c);
                }
            }
            for (var a = 0x0; a < O['length']; a++) {
                (function(a) {
                    var b = document['getElementById']('upgradeItem' + a);
                    b['onmouseover'] = function() {
                        if (f['weapons'][a]) {
                            w(f['weapons'][a], !![]);
                        } else {
                            w(f['list'][a - f['weapons']['length']]);
                        }
                    };
                    b['onclick'] = d['checkTrusted'](function() {
                        g['emit']('6', a);
                    });
                    d['hookTouchEvents'](b);
                }(O[a]));
            }
            if (O['length']) {
                X['style']['display'] = 'block';
                a7['style']['display'] = 'block';
                a7['innerHTML'] = 'SELECT ITEMS (' + h + ')';
            } else {
                X['style']['display'] = 'none';
                a7['style']['display'] = 'none';
                w();
            }
        } else {
            X['style']['display'] = 'none';
            a7['style']['display'] = 'none';
            w();
        }
    }

    function dO(a) {
        g['emit']('6', a);
    }

    function bT(b, d, a) {
        if (b != undefined) e['XP'] = b;
        if (d != undefined) e['maxXP'] = d;
        if (a != undefined) e['age'] = a;
        if (a == c['maxAge']) {
            b8['innerHTML'] = 'MAX AGE';
            b7['style']['width'] = '100%';
        } else {
            b8['innerHTML'] = 'AGE ' + e['age'];
            b7['style']['width'] = e['XP'] / e['maxXP'] * 0x64 + '%';
        }
    }

    function cZ(a) {
        d['removeAllChildren'](b9);
        var c = 0x1;
        for (var b = 0x0; b < a['length']; b += 0x3) {
            (function(b) {
                d['generateElement']({
                    'class': 'leaderHolder',
                    'parent': b9,
                    'children': [d['generateElement']({
                        'class': 'leaderboardItem',
                        'style': 'color:' + (a[b] == bY ? '#fff' : 'rgba(255,255,255,0.6)'),
                        'text': c + '. ' + (a[b + 0x1] != '' ? a[b + 0x1] : 'unknown')
                    }), d['generateElement']({
                        'class': 'leaderScore',
                        'text': d['kFormat'](a[b + 0x2]) || '0'
                    })]
                });
            }(b));
            c++;
        }
    }

    function c_() {
        if (!![]) {
            if (g && e) {
                if (!br || a0 - br >= 0x3e8 / c['clientSendRate']) {
                    br = a0;
                    g['emit']('2', bA());
                }
            }
            if (aq < 0x78) {
                aq += 0.1 * u;
                a2['style']['fontSize'] = Math['min'](Math['round'](aq), 0x78) + 'px';
            }
            if (e) {
                var x = d['getDistance'](E, F, e['x'], e['y']);
                var z = d['getDirection'](e['x'], e['y'], E, F);
                var A = Math['min'](x * 0.01 * u, x);
                if (x > 0.05) {
                    E += A * Math['cos'](z);
                    F += A * Math['sin'](z);
                } else {
                    E = e['x'];
                    F = e['y'];
                }
            } else {
                E = c['mapScale'] / 0x2;
                F = c['mapScale'] / 0x2;
            }
            var L = a0 - 0x3e8 / c['serverUpdateRate'];
            var v;
            for (var n = 0x0; n < h['length'] + q['length']; ++n) {
                a = h[n] || q[n - h['length']];
                if (a && a['visible']) {
                    if (a['forcePos']) {
                        a['x'] = a['x2'];
                        a['y'] = a['y2'];
                        a['dir'] = a['d2'];
                    } else {
                        var J = a['t2'] - a['t1'];
                        var I = L - a['t1'];
                        var H = I / J;
                        var G = 0xaa;
                        a['dt'] += u;
                        var y = Math['min'](1.7, a['dt'] / G);
                        var v = a['x2'] - a['x1'];
                        a['x'] = a['x1'] + v * y;
                        v = a['y2'] - a['y1'];
                        a['y'] = a['y1'] + v * y;
                        a['dir'] = Math['lerpAngle'](a['d2'], a['d1'], Math['min'](1.2, H));
                    }
                }
            }
            var m = E - i / 0x2;
            var f = F - l / 0x2;
            if (c['snowBiomeTop'] - f <= 0x0 && c['mapScale'] - c['snowBiomeTop'] - f >= l) {
                b['fillStyle'] = '#b6db66';
                b['fillRect'](0x0, 0x0, i, l);
            } else if (c['mapScale'] - c['snowBiomeTop'] - f <= 0x0) {
                b['fillStyle'] = '#dbc666';
                b['fillRect'](0x0, 0x0, i, l);
            } else if (c['snowBiomeTop'] - f >= l) {
                b['fillStyle'] = '#fff';
                b['fillRect'](0x0, 0x0, i, l);
            } else if (c['snowBiomeTop'] - f >= 0x0) {
                b['fillStyle'] = '#fff';
                b['fillRect'](0x0, 0x0, i, c['snowBiomeTop'] - f);
                b['fillStyle'] = '#b6db66';
                b['fillRect'](0x0, c['snowBiomeTop'] - f, i, l - (c['snowBiomeTop'] - f));
            } else {
                b['fillStyle'] = '#b6db66';
                b['fillRect'](0x0, 0x0, i, c['mapScale'] - c['snowBiomeTop'] - f);
                b['fillStyle'] = '#dbc666';
                b['fillRect'](0x0, c['mapScale'] - c['snowBiomeTop'] - f, i, l - (c['mapScale'] - c['snowBiomeTop'] - f));
            }
            if (!aK) {
                N += aH * c['waveSpeed'] * u;
                if (N >= c['waveMax']) {
                    N = c['waveMax'];
                    aH = -0x1;
                } else if (N <= 0x1) {
                    N = aH = 0x1;
                }
                b['globalAlpha'] = 0x1;
                b['fillStyle'] = '#dbc666';
                bD(m, f, b, c['riverPadding']);
                b['fillStyle'] = '#91b2db';
                bD(m, f, b, (N - 0x1) * 0xfa);
            }
            b['lineWidth'] = 0x4;
            b['strokeStyle'] = '#000';
            b['globalAlpha'] = 0.06;
            b['beginPath']();
            for (var r = -E; r < i; r += l / 0x12) {
                if (r > 0x0) {
                    b['moveTo'](r, 0x0);
                    b['lineTo'](r, l);
                }
            }
            for (var w = -F; w < l; w += l / 0x12) {
                if (r > 0x0) {
                    b['moveTo'](0x0, w);
                    b['lineTo'](i, w);
                }
            }
            b['stroke']();
            b['globalAlpha'] = 0x1;
            b['strokeStyle'] = aj;
            ak(-0x1, m, f);
            b['globalAlpha'] = 0x1;
            b['lineWidth'] = T;
            bG(0x0, m, f);
            cn(m, f, 0x0);
            b['globalAlpha'] = 0x1;
            for (var n = 0x0; n < q['length']; ++n) {
                a = q[n];
                if (a['active'] && a['visible']) {
                    b['save']();
                    b['translate'](a['x'] - m, a['y'] - f);
                    b['rotate'](a['dir'] - Math['PI'] / 0x2);
                    dB(a, b);
                    b['restore']();
                }
            }
            ak(0x0, m, f);
            bG(0x1, m, f);
            ak(0x1, m, f);
            cn(m, f, 0x1);
            ak(0x2, m, f);
            ak(0x3, m, f);
            b['fillStyle'] = '#000';
            b['globalAlpha'] = 0.09;
            if (m <= 0x0) {
                b['fillRect'](0x0, 0x0, -m, l);
            }
            if (c['mapScale'] - m <= i) {
                var s = Math['max'](0x0, -f);
                b['fillRect'](c['mapScale'] - m, s, i - (c['mapScale'] - m), l - s);
            }
            if (f <= 0x0) {
                b['fillRect'](-m, 0x0, i + m, -f);
            }
            if (c['mapScale'] - f <= l) {
                var o = Math['max'](0x0, -m);
                var C = 0x0;
                if (c['mapScale'] - m <= i) C = i - (c['mapScale'] - m);
                b['fillRect'](o, c['mapScale'] - f, i - o - C, l - (c['mapScale'] - f));
            }
            b['globalAlpha'] = 0x1;
            b['fillStyle'] = 'rgba(0, 0, 70, 0.35)';
            b['fillRect'](0x0, 0x0, i, l);
            b['strokeStyle'] = b1;
            for (var n = 0x0; n < h['length'] + q['length']; ++n) {
                a = h[n] || q[n - h['length']];
                if (a['visible']) {
                    if (a['skinIndex'] != 0xa || a == e || a['team'] && a['team'] == e['team']) {
                        var t = (a['team'] ? '[' + a['team'] + '] ' : '') + (a['name'] || '');
                        if (t != '') {
                            b['font'] = '30px Hammersmith One';
                            b['fillStyle'] = '#fff';
                            b['textBaseline'] = 'middle';
                            b['textAlign'] = 'center';
                            b['lineWidth'] = 0x8;
                            b['lineJoin'] = 'round';
                            b['strokeText'](t, a['x'] - m, a['y'] - f - a['scale'] - c['nameY']);
                            b['fillText'](t, a['x'] - m, a['y'] - f - a['scale'] - c['nameY']);
                            if (a['isLeader'] && Z['crown']['isLoaded']) {
                                var p = c['crownIconScale'];
                                var o = a['x'] - m - p / 0x2 - b['measureText'](t)['width'] / 0x2 - c['crownPad'];
                                b['drawImage'](Z['crown'], o, a['y'] - f - a['scale'] - c['nameY'] - p / 0x2 - 0x5, p, p);
                            }
                            if (a['iconIndex'] == 0x1 && Z['skull']['isLoaded']) {
                                var p = c['crownIconScale'];
                                var o = a['x'] - m - p / 0x2 + b['measureText'](t)['width'] / 0x2 + c['crownPad'];
                                b['drawImage'](Z['skull'], o, a['y'] - f - a['scale'] - c['nameY'] - p / 0x2 - 0x5, p, p);
                            }
                        }
                        if (a['health'] > 0x0) {
                            var M = c['healthBarWidth'];
                            b['fillStyle'] = b1;
                            b['roundRect'](a['x'] - m - c['healthBarWidth'] - c['healthBarPad'], a['y'] - f + a['scale'] + c['nameY'], c['healthBarWidth'] * 0x2 + c['healthBarPad'] * 0x2, 0x11, 0x8);
                            b['fill']();
                            b['fillStyle'] = a == e || a['team'] && a['team'] == e['team'] ? '#8ecc51' : '#cc5151';
                            b['roundRect'](a['x'] - m - c['healthBarWidth'], a['y'] - f + a['scale'] + c['nameY'] + c['healthBarPad'], c['healthBarWidth'] * 0x2 * (a['health'] / a['maxHealth']), 0x11 - c['healthBarPad'] * 0x2, 0x7);
                            b['fill']();
                        }
                    }
                }
            }
            bw['update'](u, b, m, f);
            for (var n = 0x0; n < h['length']; ++n) {
                a = h[n];
                if (a['visible'] && a['chatCountdown'] > 0x0) {
                    a['chatCountdown'] -= u;
                    if (a['chatCountdown'] <= 0x0) a['chatCountdown'] = 0x0;
                    b['font'] = '32px Hammersmith One';
                    var K = b['measureText'](a['chatMessage']);
                    b['textBaseline'] = 'middle';
                    b['textAlign'] = 'center';
                    var o = a['x'] - m;
                    var s = a['y'] - a['scale'] - f - 0x5a;
                    var B = 0x2f;
                    var D = K['width'] + 0x11;
                    b['fillStyle'] = 'rgba(0,0,0,0.2)';
                    b['roundRect'](o - D / 0x2, s - B / 0x2, D, B, 0x6);
                    b['fill']();
                    b['fillStyle'] = '#fff';
                    b['fillText'](a['chatMessage'], o, s);
                }
            }
        }
        cS(u);
        if (k['id'] !== -0x1) {
            bH(k['startX'], k['startY'], k['currentX'], k['currentY']);
        }
        if (j['id'] !== -0x1) {
            bH(j['startX'], j['startY'], j['currentX'], j['currentY']);
        }
    }

    function bH(e, f, i, j) {
        b['save']();
        b['setTransform'](0x1, 0x0, 0x0, 0x1, 0x0, 0x0);
        b['scale'](B, B);
        var a = 0x32;
        b['beginPath']();
        b['arc'](e, f, a, 0x0, Math['PI'] * 0x2, ![]);
        b['closePath']();
        b['fillStyle'] = 'rgba(255, 255, 255, 0.3)';
        b['fill']();
        var a = 0x32;
        var c = i - e;
        var d = j - f;
        var g = Math['sqrt'](Math['pow'](c, 0x2) + Math['pow'](d, 0x2));
        var h = g > a ? g / a : 0x1;
        c /= h;
        d /= h;
        b['beginPath']();
        b['arc'](e + c, f + d, a * 0.5, 0x0, Math['PI'] * 0x2, ![]);
        b['closePath']();
        b['fillStyle'] = 'white';
        b['fill']();
        b['restore']();
    }

    function bG(f, d, e) {
        for (var c = 0x0; c < V['length']; ++c) {
            a = V[c];
            if (a['active'] && a['layer'] == f) {
                a['update'](u);
                if (a['active'] && bR(a['x'] - d, a['y'] - e, a['scale'])) {
                    b['save']();
                    b['translate'](a['x'] - d, a['y'] - e);
                    b['rotate'](a['dir']);
                    b3(0x0, 0x0, a, b, 0x1);
                    b['restore']();
                }
            }
        }
    }
    var b4 = {};

    function b3(e, g, a, d, h) {
        if (a['src']) {
            var c = f['projectiles'][a['indx']]['src'];
            var b = b4[c];
            if (!b) {
                b = new Image();
                b['onload'] = function() {
                    this['isLoaded'] = !![];
                };
                b['src'] = '.././img/weapons/' + c + '.png';
                b4[c] = b;
            }
            if (b['isLoaded']) d['drawImage'](b, e - a['scale'] / 0x2, g - a['scale'] / 0x2, a['scale'], a['scale']);
        } else if (a['indx'] == 0x1) {
            d['fillStyle'] = '#939393';
            o(e, g, a['scale'], d);
        }
    }

    function bD(g, d, e, f) {
        var a = c['riverWidth'] + f;
        var b = c['mapScale'] / 0x2 - d - a / 0x2;
        if (b < l && b + a > 0x0) {
            e['fillRect'](0x0, b, i, a);
        }
    }

    function ak(g, h, i) {
        var c, d, e;
        for (var f = 0x0; f < D['length']; ++f) {
            a = D[f];
            if (a['active']) {
                d = a['x'] + a['xWiggle'] - h;
                e = a['y'] + a['yWiggle'] - i;
                if (g == 0x0) {
                    a['update'](u);
                }
                if (a['layer'] == g && bR(d, e, a['scale'])) {
                    b['globalAlpha'] = a['hideFromEnemy'] ? 0.6 : 0x1;
                    if (a['isItem']) {
                        c = bt(a);
                        b['save']();
                        b['translate'](d, e);
                        b['rotate'](a['dir']);
                        b['drawImage'](c, -(c['width'] / 0x2), -(c['height'] / 0x2));
                        b['restore']();
                    } else {
                        c = di(a);
                        b['drawImage'](c, d - c['width'] / 0x2, e - c['height'] / 0x2);
                    }
                }
            }
        }
    }

    function d5(b, c, d) {
        a = aD(b);
        if (a) {
            a['startAnim'](c, d);
        }
    }

    function cn(d, f, g) {
        b['globalAlpha'] = 0x1;
        for (var c = 0x0; c < h['length']; ++c) {
            a = h[c];
            if (a['zIndex'] == g) {
                a['animate'](u);
                if (a['visible']) {
                    a['skinRot'] += 0.002 * u;
                    cl = (a == e ? bA() : a['dir']) + a['dirPlus'];
                    b['save']();
                    b['translate'](a['x'] - d, a['y'] - f);
                    b['rotate'](cl);
                    cs(a, b);
                    b['restore']();
                }
            }
        }
    }

    function cs(a, d) {
        d = d || b;
        d['lineWidth'] = T;
        d['lineJoin'] = 'miter';
        var e = Math['PI'] / 0x4 * (f['weapons'][a['weaponIndex']]['armS'] || 0x1);
        var g = a['buildIndex'] < 0x0 ? f['weapons'][a['weaponIndex']]['hndS'] || 0x1 : 0x1;
        var h = a['buildIndex'] < 0x0 ? f['weapons'][a['weaponIndex']]['hndD'] || 0x1 : 0x1;
        if (a['tailIndex'] > 0x0) {
            de(a['tailIndex'], d, a);
        }
        if (a['buildIndex'] < 0x0 && !f['weapons'][a['weaponIndex']]['aboveHand']) {
            bW(f['weapons'][a['weaponIndex']], c['weaponVariants'][a['weaponVariant']]['src'], a['scale'], 0x0, d);
            if (f['weapons'][a['weaponIndex']]['projectile'] != undefined && !f['weapons'][a['weaponIndex']]['hideProjectile']) {
                b3(a['scale'], 0x0, f['projectiles'][f['weapons'][a['weaponIndex']]['projectile']], b);
            }
        }
        d['fillStyle'] = c['skinColors'][a['skinColor']];
        o(a['scale'] * Math['cos'](e), a['scale'] * Math['sin'](e), 0xe);
        o(a['scale'] * h * Math['cos'](-e * g), a['scale'] * h * Math['sin'](-e * g), 0xe);
        if (a['buildIndex'] < 0x0 && f['weapons'][a['weaponIndex']]['aboveHand']) {
            bW(f['weapons'][a['weaponIndex']], c['weaponVariants'][a['weaponVariant']]['src'], a['scale'], 0x0, d);
            if (f['weapons'][a['weaponIndex']]['projectile'] != undefined && !f['weapons'][a['weaponIndex']]['hideProjectile']) {
                b3(a['scale'], 0x0, f['projectiles'][f['weapons'][a['weaponIndex']]['projectile']], b);
            }
        }
        if (a['buildIndex'] >= 0x0) {
            var i = bt(f['list'][a['buildIndex']]);
            d['drawImage'](i, a['scale'] - f['list'][a['buildIndex']]['holdOffset'], -i['width'] / 0x2);
        }
        o(0x0, 0x0, a['scale'], d);
        if (a['skinIndex'] > 0x0) {
            d['rotate'](Math['PI'] / 0x2);
            cc(a['skinIndex'], d, null, a);
        }
    }
    var aY = {};
    var aX = {};
    var A;

    function cc(b, c, f, g) {
        A = aY[b];
        if (!A) {
            var d = new Image();
            d['onload'] = function() {
                this['isLoaded'] = !![];
                this['onload'] = null;
            };
            d['src'] = '.././img/hats/hat_' + b + '.png';
            aY[b] = d;
            A = d;
        }
        var a = f || aX[b];
        if (!a) {
            for (var e = 0x0; e < a5['length']; ++e) {
                if (a5[e]['id'] == b) {
                    a = a5[e];
                    break;
                }
            }
            aX[b] = a;
        }
        if (A['isLoaded']) c['drawImage'](A, -a['scale'] / 0x2, -a['scale'] / 0x2, a['scale'], a['scale']);
        if (!f && a['topSprite']) {
            c['save']();
            c['rotate'](g['skinRot']);
            cc(b + '_top', c, a, g);
            c['restore']();
        }
    }
    var be = {};
    var aW = {};

    function de(b, c, f) {
        A = be[b];
        if (!A) {
            var d = new Image();
            d['onload'] = function() {
                this['isLoaded'] = !![];
                this['onload'] = null;
            };
            d['src'] = '.././img/accessories/access_' + b + '.png';
            be[b] = d;
            A = d;
        }
        var a = aW[b];
        if (!a) {
            for (var e = 0x0; e < a3['length']; ++e) {
                if (a3[e]['id'] == b) {
                    a = a3[e];
                    break;
                }
            }
            aW[b] = a;
        }
        if (A['isLoaded']) {
            c['save']();
            c['translate'](-0x14 - (a['xOff'] || 0x0), 0x0);
            if (a['spin']) c['rotate'](f['skinRot']);
            c['drawImage'](A, -(a['scale'] / 0x2), -(a['scale'] / 0x2), a['scale'], a['scale']);
            c['restore']();
        }
    }
    var aM = {};

    function bW(b, d, e, f, g) {
        var c = b['src'] + (d || '');
        var a = aM[c];
        if (!a) {
            a = new Image();
            a['onload'] = function() {
                this['isLoaded'] = !![];
            };
            a['src'] = '.././img/weapons/' + c + '.png';
            aM[c] = a;
        }
        if (a['isLoaded']) g['drawImage'](a, e + b['xOff'] - b['length'] / 0x2, f + b['yOff'] - b['width'] / 0x2, b['length'], b['width']);
    }
    var b0 = {};

    function di(e) {
        var g = e['y'] >= c['mapScale'] - c['snowBiomeTop'] ? 0x2 : e['y'] <= c['snowBiomeTop'] ? 0x1 : 0x0;
        var l = e['type'] + '_' + e['scale'] + '_' + g;
        var i = b0[l];
        if (!i) {
            var h = document['createElement']('canvas');
            h['width'] = h['height'] = e['scale'] * 2.1 + T;
            var b = h['getContext']('2d');
            b['translate'](h['width'] / 0x2, h['height'] / 0x2);
            b['rotate'](d['randFloat'](0x0, Math['PI']));
            b['strokeStyle'] = aj;
            b['lineWidth'] = T;
            if (e['type'] == 0x0) {
                var k;
                for (var f = 0x0; f < 0x2; ++f) {
                    k = a['scale'] * (!f ? 0x1 : 0.5);
                    x(b, 0x7, k, k * 0.7);
                    b['fillStyle'] = !g ? !f ? '#9ebf57' : '#b4db62' : !f ? '#e3f1f4' : '#fff';
                    b['fill']();
                    if (!f) b['stroke']();
                }
            } else if (e['type'] == 0x1) {
                if (g == 0x2) {
                    b['fillStyle'] = '#606060';
                    x(b, 0x6, e['scale'] * 0.3, e['scale'] * 0.71);
                    b['fill']();
                    b['stroke']();
                    b['fillStyle'] = '#89a54c';
                    o(0x0, 0x0, e['scale'] * 0.55, b);
                    b['fillStyle'] = '#a5c65b';
                    o(0x0, 0x0, e['scale'] * 0.3, b, !![]);
                } else {
                    dr(b, 0x6, a['scale'], a['scale'] * 0.7);
                    b['fillStyle'] = g ? '#e3f1f4' : '#89a54c';
                    b['fill']();
                    b['stroke']();
                    b['fillStyle'] = g ? '#6a64af' : '#c15555';
                    var m;
                    var n = 0x4;
                    var j = Q / n;
                    for (var f = 0x0; f < n; ++f) {
                        m = d['randInt'](a['scale'] / 3.5, a['scale'] / 2.3);
                        o(m * Math['cos'](j * f), m * Math['sin'](j * f), d['randInt'](0xa, 0xc), b);
                    }
                }
            } else if (e['type'] == 0x2 || e['type'] == 0x3) {
                b['fillStyle'] = e['type'] == 0x2 ? g == 0x2 ? '#938d77' : '#939393' : '#e0c655';
                x(b, 0x3, e['scale'], e['scale']);
                b['fill']();
                b['stroke']();
                b['fillStyle'] = e['type'] == 0x2 ? g == 0x2 ? '#b2ab90' : '#bcbcbc' : '#ebdca3';
                x(b, 0x3, e['scale'] * 0.55, e['scale'] * 0.65);
                b['fill']();
            }
            i = h;
            b0[l] = i;
        }
        return i;
    }
    var bi = [];

    function bt(b, h) {
        var g = bi[b['id']];
        if (!g || h) {
            var e = document['createElement']('canvas');
            e['width'] = e['height'] = b['scale'] * 2.5 + T + (f['list'][b['id']]['spritePadding'] || 0x0);
            var a = e['getContext']('2d');
            a['translate'](e['width'] / 0x2, e['height'] / 0x2);
            a['rotate'](h ? 0x0 : Math['PI'] / 0x2);
            a['strokeStyle'] = aj;
            a['lineWidth'] = T * (h ? e['width'] / 0x51 : 0x1);
            if (b['name'] == 'apple') {
                a['fillStyle'] = '#c15555';
                o(0x0, 0x0, b['scale'], a);
                a['fillStyle'] = '#89a54c';
                var i = -(Math['PI'] / 0x2);
                dl(b['scale'] * Math['cos'](i), b['scale'] * Math['sin'](i), 0x19, i + Math['PI'] / 0x2, a);
            } else if (b['name'] == 'cookie') {
                a['fillStyle'] = '#cca861';
                o(0x0, 0x0, b['scale'], a);
                a['fillStyle'] = '#937c4b';
                var m = 0x4;
                var p = Q / m;
                var l;
                for (var c = 0x0; c < m; ++c) {
                    l = d['randInt'](b['scale'] / 2.5, b['scale'] / 1.7);
                    o(l * Math['cos'](p * c), l * Math['sin'](p * c), d['randInt'](0x4, 0x5), a, !![]);
                }
            } else if (b['name'] == 'wood wall' || b['name'] == 'stone wall' || b['name'] == 'castle wall') {
                a['fillStyle'] = b['name'] == 'castle wall' ? '#83898e' : b['name'] == 'wood wall' ? '#a5974c' : '#939393';
                var n = b['name'] == 'castle wall' ? 0x4 : 0x3;
                x(a, n, b['scale'] * 1.1, b['scale'] * 1.1);
                a['fill']();
                a['stroke']();
                a['fillStyle'] = b['name'] == 'castle wall' ? '#9da4aa' : b['name'] == 'wood wall' ? '#c9b758' : '#bcbcbc';
                x(a, n, b['scale'] * 0.65, b['scale'] * 0.65);
                a['fill']();
            } else if (b['name'] == 'spikes' || b['name'] == 'greater spikes' || b['name'] == 'poison spikes' || b['name'] == 'spinning spikes') {
                a['fillStyle'] = b['name'] == 'poison spikes' ? '#7b935d' : '#939393';
                var j = b['scale'] * 0.6;
                x(a, b['name'] == 'spikes' ? 0x5 : 0x6, b['scale'], j);
                a['fill']();
                a['stroke']();
                a['fillStyle'] = '#a5974c';
                o(0x0, 0x0, j, a);
                a['fillStyle'] = '#c9b758';
                o(0x0, 0x0, j / 0x2, a, !![]);
            } else if (b['name'] == 'windmill' || b['name'] == 'faster windmill') {
                a['fillStyle'] = '#a5974c';
                o(0x0, 0x0, b['scale'], a);
                a['fillStyle'] = '#c9b758';
                c2(0x0, 0x0, b['scale'] * 1.5, 0x1d, 0x4, a);
                a['fillStyle'] = '#a5974c';
                o(0x0, 0x0, b['scale'] * 0.5, a);
            } else if (b['name'] == 'mine') {
                a['fillStyle'] = '#939393';
                x(a, 0x3, b['scale'], b['scale']);
                a['fill']();
                a['stroke']();
                a['fillStyle'] = '#bcbcbc';
                x(a, 0x3, b['scale'] * 0.55, b['scale'] * 0.65);
                a['fill']();
            } else if (b['name'] == 'pit trap') {
                a['fillStyle'] = '#a5974c';
                x(a, 0x3, b['scale'] * 1.1, b['scale'] * 1.1);
                a['fill']();
                a['stroke']();
                a['fillStyle'] = aj;
                x(a, 0x3, b['scale'] * 0.65, b['scale'] * 0.65);
                a['fill']();
            } else if (b['name'] == 'boost pad') {
                a['fillStyle'] = '#7e7f82';
                a4(0x0, 0x0, b['scale'] * 0x2, b['scale'] * 0x2, a);
                a['fill']();
                a['stroke']();
                a['fillStyle'] = '#dbd97d';
                ds(b['scale'] * 0x1, a);
            } else if (b['name'] == 'turret') {
                a['fillStyle'] = '#a5974c';
                o(0x0, 0x0, b['scale'], a);
                a['fill']();
                a['stroke']();
                a['fillStyle'] = '#939393';
                var q = 0x32;
                a4(0x0, -q / 0x2, b['scale'] * 0.9, q, a);
                o(0x0, 0x0, b['scale'] * 0.6, a);
                a['fill']();
                a['stroke']();
            } else if (b['name'] == 'platform') {
                a['fillStyle'] = '#cebd5f';
                var k = 0x4;
                var s = b['scale'] * 0x2;
                var t = s / k;
                var r = -(b['scale'] / 0x2);
                for (var c = 0x0; c < k; ++c) {
                    a4(r - t / 0x2, 0x0, t, b['scale'] * 0x2, a);
                    a['fill']();
                    a['stroke']();
                    r += s / k;
                }
            } else if (b['name'] == 'healing pad') {
                a['fillStyle'] = '#7e7f82';
                a4(0x0, 0x0, b['scale'] * 0x2, b['scale'] * 0x2, a);
                a['fill']();
                a['stroke']();
                a['fillStyle'] = '#db6e6e';
                c2(0x0, 0x0, b['scale'] * 0.65, 0x14, 0x4, a, !![]);
            } else if (b['name'] == 'spawn pad') {
                a['fillStyle'] = '#7e7f82';
                a4(0x0, 0x0, b['scale'] * 0x2, b['scale'] * 0x2, a);
                a['fill']();
                a['stroke']();
                a['fillStyle'] = '#71aad6';
                o(0x0, 0x0, b['scale'] * 0.6, a);
            }
            g = e;
            if (!h) bi[b['id']] = g;
        }
        return g;
    }

    function dl(c, d, h, b, a) {
        var f = c + h * Math['cos'](b);
        var g = d + h * Math['sin'](b);
        var e = h * 0.4;
        a['moveTo'](c, d);
        a['beginPath']();
        a['quadraticCurveTo']((c + f) / 0x2 + e * Math['cos'](b + Math['PI'] / 0x2), (d + g) / 0x2 + e * Math['sin'](b + Math['PI'] / 0x2), f, g);
        a['quadraticCurveTo']((c + f) / 0x2 - e * Math['cos'](b + Math['PI'] / 0x2), (d + g) / 0x2 - e * Math['sin'](b + Math['PI'] / 0x2), c, d);
        a['closePath']();
        a['fill']();
        a['stroke']();
    }

    function o(c, d, e, a, f) {
        a = a || b;
        a['beginPath']();
        a['arc'](c, d, e, 0x0, 0x2 * Math['PI']);
        a['fill']();
        if (!f) a['stroke']();
    }

    function x(b, h, c, i) {
        var a = Math['PI'] / 0x2 * 0x3;
        var d, e;
        var f = Math['PI'] / h;
        b['beginPath']();
        b['moveTo'](0x0, -c);
        for (var g = 0x0; g < h; g++) {
            d = Math['cos'](a) * c;
            e = Math['sin'](a) * c;
            b['lineTo'](d, e);
            a += f;
            d = Math['cos'](a) * i;
            e = Math['sin'](a) * i;
            b['lineTo'](d, e);
            a += f;
        }
        b['lineTo'](0x0, -c);
        b['closePath']();
    }

    function a4(c, d, a, b, e, f) {
        e['fillRect'](c - a / 0x2, d - b / 0x2, a, b);
        if (!f) e['strokeRect'](c - a / 0x2, d - b / 0x2, a, b);
    }

    function c2(d, e, f, g, b, a, h) {
        a['save']();
        a['translate'](d, e);
        b = Math['ceil'](b / 0x2);
        for (var c = 0x0; c < b; c++) {
            a4(0x0, 0x0, f * 0x2, g, a, h);
            a['rotate'](Math['PI'] / b);
        }
        a['restore']();
    }

    function dr(c, i, h, e) {
        var a = Math['PI'] / 0x2 * 0x3;
        var j, k;
        var b = Math['PI'] / i;
        var f;
        c['beginPath']();
        c['moveTo'](0x0, -e);
        for (var g = 0x0; g < i; g++) {
            f = d['randInt'](h + 0.9, h * 1.2);
            c['quadraticCurveTo'](Math['cos'](a + b) * f, Math['sin'](a + b) * f, Math['cos'](a + b * 0x2) * e, Math['sin'](a + b * 0x2) * e);
            a += b * 0x2;
        }
        c['lineTo'](0x0, -e);
        c['closePath']();
    }

    function ds(d, a) {
        a = a || b;
        var c = d * (Math['sqrt'](0x3) / 0x2);
        a['beginPath']();
        a['moveTo'](0x0, -c / 0x2);
        a['lineTo'](-d / 0x2, c / 0x2);
        a['lineTo'](d / 0x2, c / 0x2);
        a['lineTo'](0x0, -c / 0x2);
        a['fill']();
        a['closePath']();
    }

    function dt() {
        var a = c['mapScale'] / 0x2;
        n['add'](0x0, a, a + 0xc8, 0x0, c['treeScales'][0x3], 0x0);
        n['add'](0x1, a, a - 0x1e0, 0x0, c['treeScales'][0x3], 0x0);
        n['add'](0x2, a + 0x12c, a + 0x1c2, 0x0, c['treeScales'][0x3], 0x0);
        n['add'](0x3, a - 0x3b6, a - 0x82, 0x0, c['treeScales'][0x2], 0x0);
        n['add'](0x4, a - 0x2ee, a - 0x190, 0x0, c['treeScales'][0x3], 0x0);
        n['add'](0x5, a - 0x2bc, a + 0x190, 0x0, c['treeScales'][0x2], 0x0);
        n['add'](0x6, a + 0x320, a - 0xc8, 0x0, c['treeScales'][0x3], 0x0);
        n['add'](0x7, a - 0x104, a + 0x154, 0x0, c['bushScales'][0x3], 0x1);
        n['add'](0x8, a + 0x2f8, a + 0x136, 0x0, c['bushScales'][0x3], 0x1);
        n['add'](0x9, a - 0x320, a + 0x64, 0x0, c['bushScales'][0x3], 0x1);
        n['add'](0xa, a - 0x320, a + 0x12c, 0x0, f['list'][0x4]['scale'], f['list'][0x4]['id'], f['list'][0x9]);
        n['add'](0xb, a + 0x28a, a - 0x186, 0x0, f['list'][0x4]['scale'], f['list'][0x4]['id'], f['list'][0x9]);
        n['add'](0xc, a - 0x190, a - 0x1c2, 0x0, c['rockScales'][0x2], 0x2);
    }

    function du(b) {
        for (var a = 0x0; a < b['length'];) {
            n['add'](b[a], b[a + 0x1], b[a + 0x2], b[a + 0x3], b[a + 0x4], b[a + 0x5], f['list'][b[a + 0x6]], !![], b[a + 0x7] >= 0x0 ? {
                'sid': b[a + 0x7]
            } : null);
            a += 0x8;
        }
    }

    function dv(b, d) {
        a = cq(d);
        if (a) {
            a['xWiggle'] += c['gatherWiggle'] * Math['cos'](b);
            a['yWiggle'] += c['gatherWiggle'] * Math['sin'](b);
        }
    }

    function dw(d, b) {
        a = cq(d);
        if (a) {
            a['dir'] = b;
            a['xWiggle'] += c['gatherWiggle'] * Math['cos'](b + Math['PI']);
            a['yWiggle'] += c['gatherWiggle'] * Math['sin'](b + Math['PI']);
        }
    }

    function dx(a, b, c, d, e, f, g, h) {
        if (aL) {
            bp['addProjectile'](a, b, c, d, e, f, null, null, g)['sid'] = h;
        }
    }

    function dy(b, c) {
        for (var a = 0x0; a < V['length']; ++a) {
            if (V[a]['sid'] == b) {
                V[a]['range'] = c;
            }
        }
    }

    function dz(d) {
        for (var b = 0x0; b < q['length']; ++b) {
            q[b]['forcePos'] = !q[b]['visible'];
            q[b]['visible'] = ![];
        }
        if (d) {
            var e = Date['now']();
            for (var b = 0x0; b < d['length'];) {
                a = dm(d[b]);
                if (a) {
                    a['index'] = d[b + 0x1];
                    a['t1'] = a['t2'] === undefined ? e : a['t2'];
                    a['t2'] = e;
                    a['x1'] = a['x'];
                    a['y1'] = a['y'];
                    a['x2'] = d[b + 0x2];
                    a['y2'] = d[b + 0x3];
                    a['d1'] = a['d2'] === undefined ? d[b + 0x4] : a['d2'];
                    a['d2'] = d[b + 0x4];
                    a['health'] = d[b + 0x5];
                    a['dt'] = 0x0;
                    a['visible'] = !![];
                } else {
                    a = bo['spawn'](d[b + 0x2], d[b + 0x3], d[b + 0x4], d[b + 0x1]);
                    a['x2'] = a['x'];
                    a['y2'] = a['y'];
                    a['d2'] = a['dir'];
                    a['health'] = d[b + 0x5];
                    if (!bo['aiTypes'][d[b + 0x1]]['name']) a['name'] = c['cowNames'][d[b + 0x6]];
                    a['forcePos'] = !![];
                    a['sid'] = d[b];
                    a['visible'] = !![];
                }
                b += 0x7;
            }
        }
    }
    var bv = {};

    function dB(d, f) {
        var e = d['index'];
        var a = bv[e];
        if (!a) {
            var c = new Image();
            c['onload'] = function() {
                this['isLoaded'] = !![];
                this['onload'] = null;
            };
            c['src'] = '.././img/animals/' + d['src'] + '.png';
            a = c;
            bv[e] = a;
        }
        if (a['isLoaded']) {
            var b = d['scale'] * 1.2;
            f['drawImage'](a, -b, -b, b * 0x2, b * 0x2);
        }
    }

    function bR(b, c, a) {
        return b + a >= 0x0 && b - a <= i && c + a >= 0x0 && c - a <= l;
    }

    function dD(b, g) {
        var a = dJ(b[0x0]);
        if (!a) {
            a = new c0(b[0x0], b[0x1], c, d, bp, n, h, q, f, a5, a3);
            h['push'](a);
        }
        a['spawn'](g ? af : null);
        a['visible'] = ![];
        a['x2'] = undefined;
        a['y2'] = undefined;
        a['setData'](b);
        if (g) {
            e = a;
            E = e['x'];
            F = e['y'];
            c6();
            bZ();
            bT();
            bU(0x0);
            aG['style']['display'] = 'block';
        }
    }

    function dE(b) {
        for (var a = 0x0; a < h['length']; a++) {
            if (h[a]['id'] == b) {
                h['splice'](a, 0x1);
                break;
            }
        }
    }

    function dF(a, b) {
        if (e) {
            e['itemCounts'][a] = b;
        }
    }

    function dG(a, b, c) {
        if (e) {
            e[a] = b;
            if (c) bZ();
        }
    }

    function dH(b, c) {
        a = aD(b);
        if (a) {
            a['health'] = c;
        }
    }

    function dI(c) {
        var d = Date['now']();
        for (var b = 0x0; b < h['length']; ++b) {
            h[b]['forcePos'] = !h[b]['visible'];
            h[b]['visible'] = ![];
        }
        for (var b = 0x0; b < c['length'];) {
            a = aD(c[b]);
            if (a) {
                a['t1'] = a['t2'] === undefined ? d : a['t2'];
                a['t2'] = d;
                a['x1'] = a['x'];
                a['y1'] = a['y'];
                a['x2'] = c[b + 0x1];
                a['y2'] = c[b + 0x2];
                a['d1'] = a['d2'] === undefined ? c[b + 0x3] : a['d2'];
                a['d2'] = c[b + 0x3];
                a['dt'] = 0x0;
                a['buildIndex'] = c[b + 0x4];
                a['weaponIndex'] = c[b + 0x5];
                a['weaponVariant'] = c[b + 0x6];
                a['team'] = c[b + 0x7];
                a['isLeader'] = c[b + 0x8];
                a['skinIndex'] = c[b + 0x9];
                a['tailIndex'] = c[b + 0xa];
                a['iconIndex'] = c[b + 0xb];
                a['zIndex'] = c[b + 0xc];
                a['visible'] = !![];
            }
            b += 0xd;
        }
    }

    function dJ(b) {
        for (var a = 0x0; a < h['length']; ++a) {
            if (h[a]['id'] == b) {
                return h[a];
            }
        }
        return null;
    }

    function aD(b) {
        for (var a = 0x0; a < h['length']; ++a) {
            if (h[a]['sid'] == b) {
                return h[a];
            }
        }
        return null;
    }

    function dm(b) {
        for (var a = 0x0; a < q['length']; ++a) {
            if (q[a]['sid'] == b) {
                return q[a];
            }
        }
        return null;
    }

    function cq(b) {
        for (var a = 0x0; a < D['length']; ++a) {
            if (D[a]['sid'] == b) {
                return D[a];
            }
        }
        return null;
    }
    window['requestAnimFrame'] = function() {
        return window['requestAnimationFrame'] || window['webkitRequestAnimationFrame'] || window['mozRequestAnimationFrame'] || function(a) {
            window['setTimeout'](a, 0x3e8 / 0x3c);
        };
    }();

    function c5() {
        a0 = Date['now']();
        u = a0 - bq;
        bq = a0;
        c_();
        requestAnimFrame(c5);
    }

    function cX() {
        dg();
        cU();
        $['style']['display'] = 'none';
        ad['style']['display'] = 'block';
        ab['value'] = aE('moo_name') || '';
        cH();
    }
    dt();
    c5();

    function cm(a) {
        window['open'](a, '_blank');
    }
    window['openLink'] = cm;
    window['aJoinReq'] = b6;
    window['follmoo'] = dk;
    window['kickFromClan'] = bK;
    window['sendJoin'] = bL;
    window['leaveAlliance'] = bN;
    window['createAlliance'] = bM;
    window['storeBuy'] = c3;
    window['storeEquip'] = bk;
    window['showItemInfo'] = w;
    window['selectSkinColor'] = cC;
    window['changeStoreIndex'] = cN;
    window['config'] = c;
}, function(a, b) {
    (function(b) {
        a['exports'] = b;
    }['call'](b, {}));
}, function(a, b) {}]));