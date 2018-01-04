var calcBinary = {
    bin: 128,
    final: null,
    rest: null,

    step: function (nr) {
        'use strict';
        if (this.bin === 128) {
            this.final = nr >= this.bin ? 1 : 0;
            this.rest = nr % this.bin;
        } else {
            this.final += this.rest >= this.bin ? '1' : '0';
            this.rest = this.rest % this.bin;
        }
        this.bin = this.bin / 2;
    },

    calc: function (nr) {
        'use strict';
        for (var i = 0; i < 8; i++) {
            this.step(nr);
        }
        return this.final;
    }
};

var calcDecimal = {
    final: null,
    temp: [],

    calc: function (binNr) {
        this.temp = binNr.split('');

        for (var i = 0, bin = 128; i < this.temp.length; i++) {
            this.final += this.temp[i] === '1' ? bin : 0;
            bin = bin / 2;
        }
        return this.final;
    }
};

var calcBinary2 = {
    final: null,

    calc: function (nr) {
        this.final = nr.toString(2);
        if (this.final.length < 8) {
            var diff = 8 - this.final.length;
            for (var i = 0, add = ''; i < diff; i++) {
                add += '0';
            }
            this.final = add.concat(this.final);
        }
        return this.final;
    }
};
var nr = 194;
var r = calcBinary.calc(nr);
var r1 = calcBinary2.calc(nr);
var rr = calcDecimal.calc(r);
console.log(r);
console.log(r1);
console.log(rr);