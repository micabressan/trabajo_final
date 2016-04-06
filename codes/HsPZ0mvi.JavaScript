function Sounds() {
    this.loaded = new signals.Signal();
    this.instances = Array();
    this.actions = Array();
    this.intervals = Array();
    this.timechanged = new signals.Signal();
    this.end = new signals.Signal();
    this.load = true;
    this.getDuration = function(id) {
        return this.instances[id].getDuration()
    }
    this.start = function() {
        if (!createjs.Sound.initializeDefaultPlugins()) {
            return;
        } else {
            if (debug()) {
                console.log('audiojs created');
            }
        }
    }
    this.mute = function() {
        createjs.Sound.setMute(true);
    }
    this.unmute = function() {
        createjs.Sound.setMute(false);
    }
    this.getPosition = function(id) {
        if (this.exists(id)) {
            return this.instances[id].getPosition();
        } else {
            return 0;
        }
    }
    this.checkposition = function(id) {
        this.timechanged.dispatch(id, this.getPosition(id));
    }
    this.pause = function(id) {
        console.log(this.instances[id]);
        if (this.exists(id)) {
            this.instances[id].stop();
            if (this.intervals[id]) {
                clearInterval(this.intervals[id]);
            }
        }
    }
    this.resume = function(id) {
        if (this.exists(id)) {
            if (this.instances[id]) {
                this.instances[id].resume();
            }
            if (this.actions[id].time) {
                if (this.actions[id].time == true) {
                    var self = this;
                    this.intervals[id] = setInterval(function() {
                        self.checkposition(id);
                    }, 50);
                }
            }
        }
    }
    this.stop = function(id) {
        if (this.exists(id)) {
            if (this.instances[id]) {
                this.instances[id].stop();
            }
            if (this.intervals[id]) {
                clearInterval(this.intervals[id]);
            }
        }
    }
    this.fadein = function(id, time) {
        if (this.exists(id)) {
            TweenMax.to(this.instances[id], time, {
                volume: 1
            })
        }
    }
    this.exists = function(id) {
        if (this.instances[id]) {
            return true;
        } else {
            return false;
        }
    }
    this.fadeout = function(id, time) {
        if (this.exists(id)) {
            TweenMax.to(this.instances[id], time, {
                volume: 0,
                onComplete: this.stop,
                onCompleteScope: this,
                onCompleteParams: [id]
            });
        }
    }
    this.ended = function(id) {
        var ca = this.actions[id];
        if (ca.loop == true) {
            this.play(id, ca.time, 0, 1, true);
        } else {
            this.end.dispatch(id);
        }
        if (this.intervals[id]) {
            clearInterval(this.intervals[id]);
        }
    }
    this.setPosition = function(id, position) {
        if (this.exists(id)) {
            this.instances[id].setPosition(position);
        }
    }
    this.play = function(id, time, playhead, volume, loop) {
        console.log('play ' + id, this.load);
        if (this.load == true) {
            if (this.instances[id]) {
                this.instances[id].stop();
            }
            if (this.intervals[id]) {
                clearInterval(this.intervals[id]);
            }
            if (!this.actions[id]) {
                this.actions[id] = Object();
            }
            this.actions[id].time = time;
            if (loop == true) {
                this.actions[id].loop = true;
            } else {
                this.actions[id].loop = false;
            }
            var self = this;
            if (this.instances[id]) {
                this.instances[id].play();
            } else {
                this.instances[id] = createjs.Sound.play(id);
                this.instances[id].on("complete", function() {
                    self.ended(id);
                });
            }
            console.log(this.instances[id]);
            if (playhead) {
                this.instances[id].setPosition(playhead);
            }
            if (volume != undefined) {
                this.instances[id].volume = volume;
            }
            if (time == true) {
                var self = this;
                this.intervals[id] = setInterval(function() {
                    self.checkposition(id);
                }, 100);
            }
        }
    }
    this.start();
    return this;
}

function FPSTicker(fps) {
    this.fps = fps;
    this.every = config['fps'] / fps;
    this.current = 0;
    this.tick = function() {
        this.current++;
        if (this.current >= this.every) {
            this.current = 0;
            return true;
        } else {
            return false;
        }
    }
}

function FileAnalyzer(input, scales) {
    this.files = Array();
    this.cvfiles = Array();
    this.pl = undefined;
    this.loadChanged = new signals.Signal();
    this.webgl = false;
    this.scale = 1;
    this.scales = Array();
    this.size = 0;
    if (scales) {
        this.scales = scales;
    }
    this.parseJson = function(input) {
        this.files = $.parseJSON(input);
    }
    this.preload = function() {
        this.manifest = Array();
        for (var i in this.files) {
            var file = this.files[i].webpath;
            if ((this.files[i].type == 'image' || this.files[i].type == 'json') && this.files[i].scaled == true) {
                var naked = this.files[i].webpath.replace(/\.[^/.]+$/, "");
                var file = naked + "__" + this.scale + "." + this.files[i].ext;
            }
            if (this.files[i].preload) {
                this.manifest.push({
                    id: this.files[i].file,
                    src: file
                });
            }
        }
        this.pl.loadManifest(this.manifest);
    }
    this.setScale = function(s) {
        var s2 = s * 100;
        var currentscale = 100;
        for (var i in this.scales) {
            if (s2 < this.scales[i]) {
                currentscale = this.scales[i];
            }
        }
        this.scale = currentscale;
    }
    this.getCVLine = function(name, objects, ss) {
        this.cvfiles[name] = Object();
        if (this.webgl == false) {
            this.cvfiles[name].o = new createjs.Container();
        } else {
            this.cvfiles[name].o = new createjs.SpriteContainer();
        }
        this.cvfiles[name].objects = Array();
        var x = 0;
        var h = 0;
        for (var i in objects) {
            var ob = this.getCV(objects[i], name + "-" + objects[i], null, ss);
            this.cvfiles[name].objects.push(ob);
            this.cvfiles[name].o.addChild(ob.o);
            ob.o.x = x;
            x = x + ob.width;
            h = ob.height;
        }
        this.cvfiles[name].width = x;
        this.cvfiles[name].height = h;
        return this.cvfiles[name];
    }
    this.insertCV = function(objectname, newname, data, insertin, x, y, addContainer) {
        var object = this.getCV(objectname, newname, data);
        if (addContainer) {
            var c = new createjs.Container();
            c.addChild(object.o);
            insertin.addChild(c);
            object.o = c;
        } else {
            insertin.addChild(object.o);
        }
        object.o.x = x;
        object.o.y = y;
        return object;
    }
    this.getScale = function(width, height) {
        var o = {};
        o.width = width * (100 / this.scale);
        o.height = height * (100 / this.scale);
        return o;
    }
    this.addContainer = function(object, parent, x, y, scale, offsetx, offsety) {
        var c = new createjs.Container();
        c.addChild(object.o);
        if (parent) {
            parent.addChild(c);
        }
        c.scaleX = c.scaleY = scale;
        c.x = x;
        c.y = y;
        if (offsetx) {
            object.o.x = (0 - offsetx);
        }
        if (offsety) {
            object.o.y = (0 - offsety);
        }
        return c;
    }
    this.getCV = function(objectname, newname, data, ss) {
        if (ss) {
            var sso = this.files[ss + ".json"];
            var ob = sso.object;
            var animation = new createjs.Sprite(ob, objectname);
            this.cvfiles[newname] = jQuery.extend({}, this.files[ss + ".png"]);
            this.cvfiles[newname].o = animation;
            if (data.fps) {
                this.cvfiles[newname].o._animation.speed = data.fps / config['fps'];
            }
            var size = this.getScale(this.cvfiles[newname].o.spriteSheet._frames[0].rect.width, this.cvfiles[newname].o.spriteSheet._frames[0].rect.height);
            this.cvfiles[newname].width = size.width;
            this.cvfiles[newname].height = size.height;
        } else {
            this.cvfiles[newname] = jQuery.extend({}, this.files[objectname]);
            this.cvfiles[newname].o = new createjs.Bitmap(this.cvfiles[newname].object);
        }
        if (this.scale != 1) {
            this.cvfiles[newname].o.scaleX = this.cvfiles[newname].o.scaleY = 1 / (this.scale / 100);
        }
        if (data) {
            if (data.registration) {
                if (data.registration == 'center') {
                    this.cvfiles[newname].o.regX = (this.cvfiles[newname].width * (this.scale / 100)) / 2;
                    this.cvfiles[newname].o.regY = (this.cvfiles[newname].height * (this.scale / 100)) / 2;;
                } else if (data.registration == 'bottomcenter') {
                    this.cvfiles[newname].o.regX = (this.cvfiles[newname].width * (this.scale / 100)) / 2;
                    this.cvfiles[newname].o.regY = (this.cvfiles[newname].height * (this.scale / 100));
                } else if (data.registration == 'topcenter') {
                    this.cvfiles[newname].o.regX = (this.cvfiles[newname].width * (this.scale / 100)) / 2;
                    this.cvfiles[newname].o.regY = 0;
                } else if (data.registration == 'bottomleft') {
                    this.cvfiles[newname].o.regX = 0;
                    this.cvfiles[newname].o.regY = (this.cvfiles[newname].height * (this.scale / 100));;
                } else if (data.registration == 'centerleft') {
                    this.cvfiles[newname].o.regX = 0;
                    this.cvfiles[newname].o.regY = (this.cvfiles[newname].height * (this.scale / 100)) / 2;
                }
            }
            if (data.flipped) {
                if (data.flipped == true) {
                    this.cvfiles[newname].o.scaleX = 0 - this.cvfiles[newname].o.scaleX;
                }
            }
        }
        var r = this.cvfiles[newname];
        delete this.cvfiles[newname];
        return r;
    }
    this.fill = function() {
        for (var i in this.files) {
            var cf = this.files[i];
            if (cf.type == 'image') {
                if (this.pl.getResult(cf.file)) {
                    this.files[i]['url'] = this.pl.getResult(cf.file).src;
                    this.files[i]['object'] = this.pl.getResult(cf.file);
                }
            } else if (cf.type == 'sound') {
                console.log(cf.file);
                console.log(this.pl.getResult(cf.file));
                this.files[i]['object'] = this.pl.getResult(cf.file);
                this.files[i]['duration'] = this.pl.getResult(cf.file).duration;
            } else if (cf.type == 'json') {
                if (i.indexOf("spritesheet") != -1) {
                    var imgbase = i.replace(/\.[^/.]+$/, "");
                    var img = imgbase + ".png";
                    var sourceimg = imgbase + "__" + this.scale + ".png";
                    var json = this.pl.getResult(cf.file, true).replace(sourceimg, this.pl.getResult(img).src);
                    var tempjson = $.parseJSON(json);
                    var f = [];
                    f[0] = 0;
                    f[1] = tempjson.frames.length - 1;
                    tempjson.animations['full'] = f;
                    this.files[i]['object'] = new createjs.SpriteSheet(tempjson);
                }
            }
        }
        var self = this;
        $("img").each(function() {
            var img = $(this);
            var factor = 1;
            var scale = 1;
            if (img.attr("data-source") != undefined && img.attr('src') == undefined) {
                if (self.files[img.attr("data-source")].scale) {
                    scale = self.files[img.attr("data-source")].scale;
                }
                if (img.attr("data-scale")) {
                    scale = img.attr("data-scale");
                }
                if (self.files[img.attr("data-source")].src) {
                    img.attr("src", self.pl.getResult(img.attr("data-source")).src);
                } else {
                    img.attr("src", self.files[img.attr("data-source")].path);
                }
                if (!img.hasClass("nosize")) {
                    img.css("width", Math.round(self.files[img.attr("data-source")].width / factor) * scale);
                    img.css("height", Math.round(self.files[img.attr("data-source")].height / factor) * scale);
                }
            }
        });
    }
    this.getObject = function(key) {
        return this.files[key];
    }
    this.width = function(key) {
        var f = this.files[key];
        if (f.type != 'image') {
            console.log(key + " is not an image");
        } else {
            return f.width;
        }
    }
    this.height = function(key) {
        var f = this.files[key];
        if (f.type != 'image') {
            console.log(key + " is not an image");
        } else {
            return f.height;
        }
    }
    this.duration = function(key) {
        var f = this.files[key];
        if (f.type != 'sound') {
            console.log(key + " is not a sound");
        } else {
            return f.duration;
        }
    }
    this.createPreload = function() {
        var self = this;

        function handleProgress(event) {
            self.loadChanged.dispatch("progress", event.progress * 100);
        }

        function handleFileLoaded(event) {
            console.log('file complete', event);
        }

        function handleComplete(event) {
            self.fill();
            self.loadChanged.dispatch("complete", 100);
        }
        this.pl = new createjs.LoadQueue(true);
        this.pl.setMaxConnections(10);
        createjs.Sound.alternateExtensions = ["mp3"];
        this.pl.installPlugin(createjs.Sound);
        this.pl.on("fileload", handleFileLoaded);
        this.pl.on("progress", handleProgress);
        this.pl.on("complete", handleComplete);
    }
    this.createPreload();
    this.parseJson(input);
    return this;
}

function FPSAnimator() {
    this.objects = [];
    this.addObject = function(name, object, fps) {
        var o = [];
        o['object'] = object;
        o['name'] = name;
        o['every'] = config['fps'] / fps;
        o['current'] = 0;
        o['attrs'] = {};
        this.objects[name] = o;
    }
    this.updateAttr = function(objectname) {
        this.objects[objectname].current++;
        if (this.objects[objectname].current >= this.objects[objectname].every) {
            for (var i in this.objects[objectname].attrs) {
                this.objects[objectname].object[i] = this.objects[objectname].attrs[i];
            }
            this.objects[objectname].current = 0;
        }
    }
    this.stopAll = function() {
        for (var i in this.objects) {
            if (this.objects[i].tween) {
                this.objects[i].tween.kill();
                this.objects[i].tween = null;
            }
        }
    }
    this.onComplete = function(objectname) {
        for (var i in this.objects[objectname].attrs) {
            this.objects[objectname].object[i] = this.objects[objectname].attrs[i];
        }
        if (this.objects[objectname]['onComplete']) {
            if (this.objects[objectname]['onCompleteParams']) {
                this.objects[objectname]['onComplete'].apply(this.objects[objectname]['onCompleteScope'], this.objects[objectname]['onCompleteParams']);
            } else {
                this.objects[objectname]['onComplete'].apply(this.objects[objectname]['onCompleteScope']);
            }
        }
    }
    this.animate = function(objectname, time, attr) {
        attr.onUpdate = this.updateAttr;
        attr.onUpdate = this.updateAttr;
        attr.onUpdateScope = this;
        attr.onUpdateParams = [objectname];
        if (attr.onComplete) {
            this.objects[objectname]['onComplete'] = attr.onComplete;
        }
        if (attr.onCompleteScope) {
            this.objects[objectname]['onCompleteScope'] = attr.onCompleteScope;
        } else {
            this.objects[objectname]['onCompleteScope'] = this;
        }
        if (attr.onCompleteParams) {
            this.objects[objectname]['onCompleteParams'] = attr.onCompleteParams;
        }
        attr.onComplete = this.onComplete;
        attr.onCompleteScope = this;
        attr.onCompleteParams = [objectname];
        for (var i in attr) {
            if (i.indexOf("on") == -1 && i != 'ease') {
                this.objects[objectname].attrs[i] = this.objects[objectname].object[i];
            }
        }
        this.objects[objectname].tween = TweenMax.to(this.objects[objectname].attrs, time, attr);
    }
    return this;
}

function SpriteSheetController(object) {
    this.animations = {};
    this.currentframe = 0;
    this.currentanimation = undefined;
    this.object = object;
    this.complete = new signals.Signal();
    this.object.gotoAndStop(0);
    this.positions = {};
    this.method = "";
    this.direction = 'forward';
    this.playing = false;
    this.tick = function() {
        if (this.playing) {
            if (this.currentanimation) {
                if (this.currentframe < this.animations[this.currentanimation][1] && this.direction == 'forward') {
                    this.currentframe++;
                    this.setFrame(this.currentframe);
                } else if (this.currentframe > this.animations[this.currentanimation][0] && this.direction == 'backward') {
                    this.currentframe--;
                    this.setFrame(this.currentframe);
                } else {
                    if (this.method == 'loop') {
                        this.currentframe = this.animations[this.currentanimation][0] - 1;
                        this.tick();
                    } else if (this.method == "") {
                        this.playing = false;
                        this.complete.dispatch(this.currentanimation, this.direction);
                    }
                }
            }
        }
    }
    this.addPosition = function(frame, x, y) {
        this.positions[frame] = [];
        this.positions[frame].x = x;
        this.positions[frame].y = y;
    }
    this.play = function(animation, type, direction) {
        this.playing = true;
        if (direction != undefined && direction != "") {
            this.direction = direction;
        } else {
            this.direction = 'forward';
        }
        if (type) {
            this.method = type;
        } else {
            this.method = "";
        }
        this.currentanimation = animation;
        if (this.direction == 'forward') {
            this.currentframe = this.animations[this.currentanimation][0] - 1;
        } else {
            this.currentframe = this.animations[this.currentanimation][1] - 1;
        }
    }
    this.setFrame = function(frame) {
        if (this.positions[frame]) {
            this.object.x = this.positions[frame].x;
            this.object.y = this.positions[frame].y;
        }
        this.object.gotoAndStop(frame);
    }
    this.add = function(name, fromframe, toframe) {
        this.animations[name] = [fromframe, toframe];
    }
    return this;
}

function FieldBlinker() {
    this.fields = [];
    this.repeats = 3;
    this.time = 150;
    this.addField = function(field, object, type) {
        if (type == undefined) {
            type = "empty";
        }
        this.fields.push({
            field: field,
            object: object,
            type: type,
            repeat: 0
        });
    }
    this.blink = function(object) {
        this.hide(object);
        object.repeat = 0;
    }
    this.hide = function(object) {
        var self = this;
        TweenMax.set(object.object, {
            alpha: 0
        });
        setTimeout(function() {
            self.show(object);
        }, this.time);
    }
    this.show = function(object) {
        object.repeat++;
        var self = this;
        TweenMax.set(object.object, {
            alpha: 1
        });
        if (object.repeat < this.repeats) {
            setTimeout(function() {
                self.hide(object);
            }, this.time);
        }
    }
    this.check = function(data) {
        var noerror = true;
        for (var i in this.fields) {
            if (this.fields[i].type == 'empty') {
                if (data[this.fields[i].field] == "" || data[this.fields[i].field] == undefined) {
                    this.blink(this.fields[i]);
                    noerror = false;
                }
            } else if (this.fields[i].type == 'email') {
                if (validateEmail(data[this.fields[i].field]) == false) {
                    this.blink(this.fields[i]);
                    noerror = false;
                }
            }
        }
        return noerror;
    }
    return this;
}

function FitIn(containerwidth, containerheight, width, height, method) {
    var r = Object();
    r.width = 0;
    r.height = 0;
    if (!method) {
        method = 'fill';
    }
    if (method == 'fit') {
        var factor1 = containerwidth / containerheight;
        var factor2 = width / height;
        if (factor1 < factor2) {
            r.width = containerwidth;
            r.height = (containerwidth / width) * height;
        } else {
            r.height = containerheight;
            r.width = (containerheight / height) * width;
        }
    }
    if (method == 'fill') {
        var factor1 = containerwidth / containerheight;
        var factor2 = width / height;
        if (factor1 > factor2) {
            r.width = containerwidth;
            r.height = (containerwidth / width) * height;
        } else {
            r.height = containerheight;
            r.width = (containerheight / height) * width;
        }
    }
    r.scaleX = r.width / width;
    r.scaleY = r.height / height;
    return r;
}

function pageManager(stateManager) {
    this.sm = stateManager;
    this.pages = {};
    this.numberofpages = 0;
    this.initted = 0;
    this.tostate = "";
    this.fromstate = "";
    this.wait = false;
    this.ready = false;
    this.initto = "";
    this.names = {};
    this.hashes = {};
    this.backenabled = true;
    this.stateChange = function(to, from) {
        this.fromstate = from;
        if (from == "") {
            this.pages[to].intro(from);
        } else {
            this.pages[from].outro(to);
            if (this.wait == false) {
                this.pages[to].intro(from);
            }
        }
    }
    this.changed = function(name, state) {
        if (state == 'intro') {
            if (name == this.tostate) {
                this.ready = true;
                if (this.initto) {
                    this.set(this.initto, this.initwait);
                    this.initto = undefined;
                    this.initwait = undefined;
                }
            }
        } else if (state == 'outro') {
            console.log('hola! ', state, this.fromstate);
            if (name == this.fromstate) {
                if (this.wait == true) {
                    this.pages[this.tostate].intro(this.fromstate);
                }
            }
        } else if (state == 'init') {
            this.initted++;
            if (this.initted == this.numberofpages) {
                this.ready = true;
                if (this.initto != "") {
                    this.set(this.initto, this.initwait);
                    this.initto = undefined;
                    this.initwait = undefined;
                }
            }
        }
    }
    this.get = function(name) {
        return this.pages[name];
    }
    this.add = function(name, object, displayname) {
        this.pages[name] = object;
        object.changed.add(this.changed, this);
        this.numberofpages++;
        if (displayname) {
            this.names[name] = displayname;
            this.hashes[displayname] = name;
        }
    }
    this.start = function() {
        for (var i in this.pages) {
            this.pages[i].init();
        }
    }
    this.init = function() {
        var self = this;
        $(window).on('hashchange', function() {
            var h = window.location.hash.substring(1);
            if (self.backenabled) {
                if (h != self.names[self.sm.state]) {
                    self.set(self.hashes[h]);
                }
            }
        });
    }
    this.set = function(state, wait) {
        if (debug()) {
            console.log('set ', state, wait, this.ready);
        }
        if (state != this.sm.state) {
            if (this.ready == true) {
                if (debug()) {
                    console.log('ready for new state!');
                }
                if (wait == undefined) {
                    wait = true;
                }
                this.initto = undefined;
                this.initwait = undefined;
                this.tostate = state;
                this.ready = false;
                this.wait = wait;
                this.sm.set(state);
                if (this.names[state]) {
                    track("/" + this.names[state]);
                } else {
                    track("/" + state);
                }
            } else {
                if (debug()) {
                    console.log('not ready for new state set initto ', this.sm.state);
                }
                this.initto = state;
                this.initwait = wait;
            }
        }
    }
    this.sm.changed.add(this.stateChange, this);
    this.init();
    return this;
}

function validateListener(listener, fnName) {
    if (typeof listener !== 'function') {
        throw new Error('listener is a required param of {fn}() and should be a Function.'.replace('{fn}', fnName));
    }
}

function Signal() {
    this._bindings = [];
    this._prevParams = null;
    var self = this;
    this.dispatch = function() {
        Signal.prototype.dispatch.apply(self, arguments);
    };
}
Signal.prototype = {
    VERSION: '::VERSION_NUMBER::',
    memorize: false,
    _shouldPropagate: true,
    active: true,
    _registerListener: function(listener, isOnce, listenerContext, priority) {
        var prevIndex = this._indexOfListener(listener, listenerContext),
            binding;
        if (prevIndex !== -1) {
            binding = this._bindings[prevIndex];
            if (binding.isOnce() !== isOnce) {
                throw new Error('You cannot add' + (isOnce ? '' : 'Once') + '() then add' + (!isOnce ? '' : 'Once') + '() the same listener without removing the relationship first.');
            }
        } else {
            binding = new SignalBinding(this, listener, isOnce, listenerContext, priority);
            this._addBinding(binding);
        }
        if (this.memorize && this._prevParams) {
            binding.execute(this._prevParams);
        }
        return binding;
    },
    _addBinding: function(binding) {
        var n = this._bindings.length;
        do {
            --n;
        } while (this._bindings[n] && binding._priority <= this._bindings[n]._priority);
        this._bindings.splice(n + 1, 0, binding);
    },
    _indexOfListener: function(listener, context) {
        var n = this._bindings.length,
            cur;
        while (n--) {
            cur = this._bindings[n];
            if (cur._listener === listener && cur.context === context) {
                return n;
            }
        }
        return -1;
    },
    has: function(listener, context) {
        return this._indexOfListener(listener, context) !== -1;
    },
    add: function(listener, listenerContext, priority) {
        validateListener(listener, 'add');
        return this._registerListener(listener, false, listenerContext, priority);
    },
    addOnce: function(listener, listenerContext, priority) {
        validateListener(listener, 'addOnce');
        return this._registerListener(listener, true, listenerContext, priority);
    },
    remove: function(listener, context) {
        validateListener(listener, 'remove');
        var i = this._indexOfListener(listener, context);
        if (i !== -1) {
            this._bindings[i]._destroy();
            this._bindings.splice(i, 1);
        }
        return listener;
    },
    removeAll: function() {
        var n = this._bindings.length;
        while (n--) {
            this._bindings[n]._destroy();
        }
        this._bindings.length = 0;
    },
    getNumListeners: function() {
        return this._bindings.length;
    },
    halt: function() {
        this._shouldPropagate = false;
    },
    dispatch: function(params) {
        if (!this.active) {
            return;
        }
        var paramsArr = Array.prototype.slice.call(arguments),
            n = this._bindings.length,
            bindings;
        if (this.memorize) {
            this._prevParams = paramsArr;
        }
        if (!n) {
            return;
        }
        bindings = this._bindings.slice();
        this._shouldPropagate = true;
        do {
            n--;
        } while (bindings[n] && this._shouldPropagate && bindings[n].execute(paramsArr) !== false);
    },
    forget: function() {
        this._prevParams = null;
    },
    dispose: function() {
        this.removeAll();
        delete this._bindings;
        delete this._prevParams;
    },
    toString: function() {
        return '[Signal active:' + this.active + ' numListeners:' + this.getNumListeners() + ']';
    }
};
var signals = Signal;
signals.Signal = Signal;

function SignalBinding(signal, listener, isOnce, listenerContext, priority) {
    this._listener = listener;
    this._isOnce = isOnce;
    this.context = listenerContext;
    this._signal = signal;
    this._priority = priority || 0;
}
SignalBinding.prototype = {
    active: true,
    params: null,
    execute: function(paramsArr) {
        var handlerReturn, params;
        if (this.active && !!this._listener) {
            params = this.params ? this.params.concat(paramsArr) : paramsArr;
            handlerReturn = this._listener.apply(this.context, params);
            if (this._isOnce) {
                this.detach();
            }
        }
        return handlerReturn;
    },
    detach: function() {
        return this.isBound() ? this._signal.remove(this._listener, this.context) : null;
    },
    isBound: function() {
        return (!!this._signal && !!this._listener);
    },
    isOnce: function() {
        return this._isOnce;
    },
    getListener: function() {
        return this._listener;
    },
    getSignal: function() {
        return this._signal;
    },
    _destroy: function() {
        delete this._signal;
        delete this._listener;
        delete this.context;
    },
    toString: function() {
        return '[SignalBinding isOnce:' + this._isOnce + ', isBound:' + this.isBound() + ', active:' + this.active + ']';
    }
};

function apiConnector() {
    this.send = function(page, values, callback, callbackvars, scope) {
        $.ajax({
            dataType: "json",
            url: getPath() + "/_api/" + page + ".php",
            data: values,
            type: "post",
            success: function(e) {
                console.log('success');
                if (callbackvars) {
                    if (scope) {
                        callback.call(scope, e, callbackvars);
                    } else {
                        callback(e, callbackvars);
                    }
                } else {
                    if (scope) {
                        callback.call(scope, e);
                    } else {
                        callback(e);
                    }
                }
            }
        });
    }
    return this;
}

function fullResizer() {
    this.objects = [];
    this.objectsbyname = [];
    this.width = 0;
    this.height = 0;
    this.scaletimeout = 0;
    this.first = false;
    this.addObject = function(data) {
        if (data.object == undefined) {
            data.object = window;
        }
        var ob = $(data.object);
        this.setAbsolute(ob);
        if (data.type == 'percent') {
            if (!data.width) {
                data.width = 0;
            }
            if (!data.height) {
                data.height = 0;
            }
            if (!data.minuswidth) {
                data.minuswidth = 0;
            }
            if (!data.minusheight) {
                data.minusheight = 0;
            }
            if (!data.follow) {
                data.follow = "";
            }
            var ob = {
                objectname: data.object,
                object: $(data.object),
                type: data.type,
                width: data.width,
                height: data.height,
                minusheight: data.minusheight,
                minuswidth: data.minuswidth,
                follow: data.follow
            };
            this.objects.push(ob);
            this.objectsbyname[data.object] = ob;
        } else if (data.type == 'callback') {
            if (!data.minuswidth) {
                data.minuswidth = 0;
            }
            if (!data.minusheight) {
                data.minusheight = 0;
            }
            var ob = {
                objectname: data.object,
                object: $(data.object),
                type: data.type,
                callback: data.callback,
                minusheight: data.minusheight,
                minuswidth: data.minuswidth,
                callbackScope: data.callbackScope
            };
            this.objects.push(ob);
            this.objectsbyname[data.object] = ob;
        }
    }
    this.setAbs = function(target) {
        target.css("position", "absolute");
    }
    this.setAbsolute = function(target) {
        if (target.length == 1) {
            this.setAbs(target);
        } else {
            var self = this;
            target.each(function() {
                self.setAbs($(this));
            })
        }
    }
    this.apply = function(o, target) {
        if (o.type == 'attach') {}
        if (o.type == 'callback') {
            var func = o.callback;
            var scope = o.callbackScope;
            console.log(o.minuswidth, o.minusheight);
            func.call(scope, o.object.width() - o.minuswidth, o.object.height() - o.minusheight);
        }
        if (o.type == 'percent') {
            var twidth = this.width;
            var theight = this.height;
            if (o.follow == 'parent') {
                var follow = target.parent();
                twidth = follow.width();
                theight = follow.height();
            }
            if (o.width != 0) {
                if (typeof o.width == 'string') {
                    target.width(o.width);
                } else {
                    target.width(((twidth / 100) * o.width) - o.minuswidth);
                }
            }
            if (o.height != 0) {
                if (typeof o.height == 'string') {
                    target.height(o.height);
                } else {
                    target.height(((theight / 100) * o.height) - o.minusheight);
                }
            }
        }
    }
    this.resize = function(ob, forcerefind) {
        if (ob) {
            var o = this.objectsbyname[ob];
            if (forcerefind == true) {
                o.object = $(o.objectname);
            }
            var target = o.object;
            if (target.length == 1) {
                this.apply(o, target);
            } else {
                var self = this;
                target.each(function() {
                    self.apply(o, $(this));
                })
            }
        } else {
            for (var i in this.objects) {
                var o = this.objects[i];
                if (forcerefind == true) {
                    o.object = $(o.objectname);
                }
                var target = o.object;
                if (target.length == 1) {
                    this.apply(o, target);
                } else {
                    var self = this;
                    target.each(function() {
                        self.apply(o, $(this));
                    })
                }
            }
        }
    }
    this.testresize = function(force) {
        var wdow = $(window);
        var wheight = wdow.height();
        var wwidth = wdow.width();
        if ((wheight != this.height || wwidth != this.width) || force == true) {
            this.height = wheight;
            this.width = wwidth;
            this.resize();
        }
    }
    this.start = function(cb) {
        if (cb) {
            this.callback = cb;
        }
        var self = this;
        setInterval(function() {
            self.testresize();
        }, 1000);
        this.testresize();
        var self = this;
        $(window).load(function() {
            self.testresize(true);
        });
        $(window).resize(function() {
            if (self.scaletimeout) {
                clearInterval(self.scaletimeout);
            }
            self.scaletimeout = setTimeout(function() {
                self.testresize();
            }, 200);
        });
        if (this.callback) {
            this.callback();
        }
    }
    return this;
}

function positioner() {
    this.objects = [];
    this.width = 0;
    this.height = 0;
    this.scaletimeout = 0;
    this.objectsbyname = [];
    this.debugs = Array();
    this.addDebug = function(id) {
        this.debugs[id] = true;
    }
    this.addObject = function(data) {
        var ob = this.fixdata(data);
        this.objects.push(ob);
    }
    this.fixdata = function(data) {
        if (!data.offsety) {
            data.offsety = 0;
        }
        if (!data.offsetx) {
            data.offsetx = 0;
        }
        var ob = $(data.object);
        var dataobject = {
            object: ob,
            type: data.type,
            top: data.top,
            scaled: data.scaled,
            bottom: data.bottom,
            left: data.left,
            right: data.right,
            follow: data.follow,
            offsetx: data.offsetx,
            offsety: data.offsety,
            miny: data.miny,
            maxy: data.maxy,
            minx: data.minx,
            maxx: data.maxx,
            yprio: data.yprio,
            xpro: data.xprio,
            axis: data.axis
        };
        this.setAbsolute(ob);
        this.objectsbyname[data.object] = dataobject;
        return dataobject;
    }
    this.minmax = function(value, min, max) {
        if (min) {
            if (value < min) {
                value = min;
            }
        }
        if (max) {
            if (value > max) {
                value = max;
            }
        }
        return value;
    }
    this.positionOnce = function(data) {
        var o = this.fixdata(data);
        var target = o.object;
        if (target.length == 1) {
            this.apply(o, target);
        } else {
            var self = this;
            target.each(function() {
                self.apply(o, $(this));
            })
        }
    }
    this.setAbs = function(target) {
        target.css("position", "absolute");
    }
    this.setAbsolute = function(target) {
        if (target.length == 1) {
            this.setAbs(target);
        } else {
            var self = this;
            target.each(function() {
                self.setAbs($(this));
            })
        }
    }
    this.apply = function(o, target) {
        if (o.type == 'attach') {
            var follow = $(o.follow);
            var position = follow.position();
            target.css("left", position.left + o.offsetx);
            target.css("top", position.top + o.offsety);
        }
        if (o.type == 'center') {
            var debugobject = false;
            var parent = target.parent();
            var pw = parent.width();
            var ph = parent.height();
            var ow = target.outerWidth();
            var oh = target.outerHeight();
            if (debug()) {
                if (this.debugs[target.attr("id")]) {
                    alert('jup debug');
                    debugobject = true;
                    console.log("--------------------------------");
                    console.log("POSITIONING: " + target.attr("id"));
                    console.log("PW = " + pw);
                    console.log("PH = " + ph);
                    console.log("OW = " + ow);
                    console.log("OH = " + oh);
                }
            }
            if (pw == 0 || ph == 0 || ow == 0 || oh == 0) {
                return;
            }
            if (o.scaled) {
                if (debugobject) {
                    console.log("o.scaled = true");
                }
                if (pw > ow || oh > ph) {
                    var s1 = 1;
                    var s2 = 1;
                    if (ow > pw) {
                        s1 = pw / ow;
                    }
                    if (oh > ph) {
                        s2 = ph / oh;
                    }
                    var sf = 1;
                    if (s2 > s1) {
                        sf = s1;
                    } else {
                        sf = s2;
                    }
                    if (sf < 1) {
                        TweenMax.set(target, {
                            scaleX: sf,
                            scaleY: sf
                        });
                    } else {
                        TweenMax.set(target, {
                            scaleX: sf,
                            scaleY: sf
                        });
                    }
                    ow = target.outerWidth();
                    oh = target.outerHeight();
                } else {
                    var sf = 1;
                    TweenMax.set(target, {
                        scaleX: sf,
                        scaleY: sf
                    });
                }
            }
            var totop = ((ph - oh) / 2) + o.offsety;
            var toleft = ((pw - ow) / 2) + o.offsetx;
            var left = this.minmax(toleft, o.minx, o.maxx);
            var top = this.minmax(totop, o.miny, o.maxy);
            if (o.yprio) {
                if (debugobject) {
                    console.log("o.yprio = true");
                }
                if (o.yprio == 'bottom') {
                    if (ph < oh) {
                        top = ph - oh;
                    }
                } else if (o.yprio == 'top') {
                    if (ph < oh) {
                        top = 0;
                    }
                }
            }
            if (o.xprio) {
                if (debugobject) {
                    console.log("o.xprio = true");
                }
                if (o.xprio == 'right') {
                    if (pw < ow) {
                        left = pw - ow;
                    }
                } else if (o.xprio == 'left') {
                    if (pw < ow) {
                        left = 0;
                    }
                }
            }
            if (o.axis) {
                if (debugobject) {
                    console.log("o.axis = " + o.axis);
                }
                if (o.axis == 'x') {
                    target.css("left", left);
                } else if (o.axis == 'y') {
                    target.css("top", this.minmax(totop, o.miny, o.maxy));
                }
            } else {
                if (debugobject) {
                    console.log("gewoon placen = " + left + "x" + top);
                }
                target.css("left", left);
                target.css("top", top);
            }
        } else if (o.type == 'pixels') {
            if (debugobject) {
                console.log("TYPE = pixels");
            }
            var parent = target.parent();
            var pw = parent.width();
            var ph = parent.height();
            var ow = target.outerWidth();
            var oh = target.outerHeight();
            if (o.bottom != undefined) {
                if (o.bottom == "height") {
                    target.css("top", ph - oh);
                } else {
                    target.css("top", this.height - o.bottom);
                }
            }
            if (o.top != undefined) {
                target.css("top", o.top);
            }
            if (o.left != undefined) {
                target.css("left", o.left);
            }
            if (o.right != undefined) {
                target.css("left", this.width - o.right);
            }
        }
        if (debugobject) {
            console.log("/--------------------------------");
        }
    }
    this.resize = function(ob, forcerefind) {
        if (ob) {
            var o = this.objectsbyname[ob];
            if (forcerefind == true) {
                o.object = $(o.objectname);
            }
            if (o == undefined) {
                alert(ob + ' does not exist');
            }
            var target = o.object;
            if (target.length == 1) {
                this.apply(o, target);
            } else {
                var self = this;
                target.each(function() {
                    self.apply(o, $(this));
                })
            }
        } else {
            for (var i in this.objects) {
                var o = this.objects[i];
                var target = o.object;
                if (target.length == 1) {
                    this.apply(o, target);
                } else {
                    var self = this;
                    target.each(function() {
                        self.apply(o, $(this));
                    })
                }
            }
        }
    }
    this.testresize = function(force) {
        var self = this;
        var wdow = $(window);
        var wheight = wdow.height();
        var wwidth = wdow.width();
        if ((wheight != this.height || wwidth != this.width) || force == true) {
            this.height = wheight;
            this.width = wwidth;
            this.resize();
        }
    }
    this.start = function(cb) {
        if (cb) {
            this.callback = cb;
        }
        var self = this;
        setInterval(function() {
            self.testresize();
        }, 1000);
        this.testresize();
        var self = this;
        $(window).load(function() {
            self.testresize(true);
        });
        $(window).resize(function() {
            if (self.scaletimeout) {
                clearInterval(self.scaletimeout);
            }
            self.scaletimeout = setTimeout(function() {
                self.testresize();
            }, 200);
        });
        if (this.callback) {
            this.callback();
        }
    }
    return this;
}

function stateManager() {
    this.state = "";
    this.changed = new signals.Signal();
    this.states = Array();
    this.set = function(newstate) {
        if (newstate != this.state) {
            if (debug()) {
                console.log('going from state ' + this.state + ' to state ' + newstate);
            }
            this.changed.dispatch(newstate, this.state);
            this.state = newstate;
            this.states.push(newstate);
        }
    }
    this.get = function(history) {
        if (history) {
            return this.states[(this.states.length - 1) - history];
        } else {
            return this.state;
        }
    }
    return this;
}
var dpr = 1;

function ext(file) {
    var a = file.split(".");
    if (a.length === 1 || (a[0] === "" && a.length === 2)) {
        return "";
    }
    return a.pop().toLowerCase();
}
if (!debug()) {
    if (!window.console) {
        console = {
            log: function() {}
        }
    };
}
if (window.devicePixelRatio !== undefined) dpr = window.devicePixelRatio;
if (!debug()) {
    console = {
        log: function() {}
    }
}

function getMS() {
    var d = new Date();
    var n = d.getTime();
    return n;
}

function check_max_anisotropy() {
    var canvas = document.getElementById("webGLCanvas");
    var gl = canvas.getContext("experimental-webgl");
    if (gl == null) {
        return 0;
    }
    var ext = (gl.getExtension('EXT_texture_filter_anisotropic') || gl.getExtension('MOZ_EXT_texture_filter_anisotropic') || gl.getExtension('WEBKIT_EXT_texture_filter_anisotropic'));
    if (ext) {
        var max = gl.getParameter(ext.MAX_TEXTURE_MAX_ANISOTROPY_EXT);
    }
    return parseInt(max);
}

function showHidden(element) {
    element.show();
    TweenMax.set(element, {
        alpha: 0
    });
}

function hideHide2(element) {
    element.hide();
}

function hideHide(element, time) {
    TweenMax.to(element, time, {
        alpha: 0,
        onComplete: hideHide2,
        onCompleteParams: [element]
    });
}

function webglAvailable() {
    try {
        var canvas = document.createElement('canvas');
        return !!(window.WebGLRenderingContext && (canvas.getContext('webgl') || canvas.getContext('experimental-webgl')));
    } catch (e) {
        return false;
    }
}

function cutoff(string, length) {
    var st = string;
    if (string.length > length) {
        st = string.substr(0, length) + "…";
    }
    return st;
}

function is(name) {
    if (config[name] == '1') {
        return true;
    } else {
        return false;
    }
}

function track() {
    console.log('Ja, deze moet weg! TRACK');
}

function debug() {
    if (config['debug'] == '1') {
        return true;
    } else {
        return false;
    }
}

function getRandomNumber(min, max) {
    return Math.random() * (max - min) + min;
}

function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function shareFacebook() {
    alert("Delen is tijdelijk uitgeschakeld");
    return;
    track("/sharefacebook");
    var share = getPath();
    if (sharelink != '') {
        share = sharelink;
    }
    window.open("https://www.facebook.com/sharer/sharer.php?u=" + share);
}

function shareTwitter() {
    alert("Delen is tijdelijk uitgeschakeld");
    return;
    track("/sharetwitter");
    var share = getPath();
    var text = "Inspire Mr. Probz. Deel jouw idee voor zijn nieuwe clip. ";
    if (sharelink != '') {
        share = sharelink;
        text = "Ik heb Mr. Probz geïnspireerd. Deel ook jouw idee voor zijn clip.";
    }
    window.open("http://twitter.com/share?url=" + encodeURIComponent(share) + "&text=" + encodeURIComponent(text));
}

function setUploaded(image, id, original, error) {
    if (error == false) {
        userid = id;
        imagefilename = image;
        pages['page5'].setFile(image, original);
    }
}

function getPath() {
    var p = config['domain'];
    if (config['folder']) {
        p += "/" + config['folder'];
    }
    return p;
}

function getRandomAndRemove(array) {
    var random = Math.floor(Math.random() * array.length);
    var chosen = array[random];
    var tmp = [];
    for (var i in array) {
        if (i != random) {
            tmp.push(array[i]);
        }
    }
    var ob = {
        val: chosen,
        array: tmp
    };
    return ob;
}

function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function openSpotify() {
    document.location = 'http://open.spotify.com/album/2wTGbAhq4iHt2nLyjkmgWU';
}

function openRedBull() {
    document.location = 'http://www.redbull.com/nl/nl';
}

function getRandom(array) {
    var random = Math.floor(Math.random() * array.length);
    var chosen = array[random];
    return chosen;
}

function getimage(image, size) {
    return image.replace("__size", "__" + size);
}

function mSecondsToTime(ms) {
    var secs = ms / 1000;
    var hours = Math.floor(secs / (60 * 60));
    var divisor_for_minutes = secs % (60 * 60);
    var minutes = Math.floor(divisor_for_minutes / 60);
    var divisor_for_seconds = divisor_for_minutes % 60;
    var seconds = Math.ceil(divisor_for_seconds);
    return pad(minutes, 2) + ":" + pad(seconds, 2);
}

function pad(n, width, z) {
    z = z || '0';
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}

function doRefresh() {
    ps.resize();
    fr.resize();
    ps.resize();
    fr.resize();
}

function refresh() {
    setTimeout(doRefresh, 500);
}

function getimage(image, size) {
    return image.replace("__size", "__" + size);
}

function CanvasScene(container) {
    this.container = container;
    this.stage = undefined;
    this.width = $(window).width();
    this.height = $(window).height();
    this.canvas = undefined;
    this.objects = Array();
    this.o = new createjs.Container();
    this.scale = 1;
    this.distractioninterval = null;
    this.overlay = $("#overlay");
    this.currentlayer = "";
    this.fpsticker = new FPSTicker(config['anifps']);
    this.started = false;
    this.active = false;
    this.paused = false;
    this.addObject = function(name, img) {
        this.objects[name] = fa.getObject(img);
        this.objects[name].o = new createjs.Bitmap(this.objects[name].object);
        this.stage.addChild(this.objects[name].o);
    }
    this.addMask = function(object) {}
    this.endGame = function(won) {
        cursor();
        this.active = false;
        track("/game_end");
        clearInterval(this.distractioninterval);
        snd.fadeout("office.mp3", 4);
        if (punten > highscore) {
            highscore = punten;
            this.objects['office'].deur.open(3);
        } else {
            if (punten < 300) {
                this.objects['office'].deur.open(4);
            } else {
                this.objects['office'].deur.open(2);
            }
        }
    }
    this.showOverlay = function() {
        showHidden(this.overlay);
        TweenMax.to(this.overlay, 0.5, {
            alpha: 0.8
        });
    }
    this.hideOverlay2 = function() {
        hideHide(this.overlay);
    }
    this.hideOverlay = function() {
        TweenMax.to(this.overlay, 0.5, {
            alpha: 0,
            delay: 2,
            onComplete: this.hideOverlay2,
            onCompleteScope: this
        });
    }
    this.doorclosed = function(screen) {
        cursor();
        pageM.backenabled = true;
        if (screen == 1) {
            this.objects['countdown'].start();
        }
        if (screen == 2 || screen == 4) {
            if (config['mobile']) {
                tt.seto("p", copy['draai']);
            }
            this.showOverlay();
            pageM.set("end_nonwon");
        }
        if (screen == 3) {
            if (config['mobile']) {
                tt.seto("p", copy['draai']);
            }
            this.showOverlay();
            pageM.set("end_won");
        }
    }
    this.createElements = function() {
        var self = this;
        this.stage.addChild(this.o);
        this.objects['office'] = new Office();
        this.objects['office'].deur.closed.add(function(screen) {
            self.doorclosed(screen);
        });
        this.o.addChild(this.objects['office'].o);
        this.scoreoverlay = new createjs.Container();
        var grad = fa.getCV("grad.png", "gradient", {
            align: 'center'
        });
        this.objects['overlay'] = easelRect(grad.width, grad.height, "#ffffff", true, 0.8);
        this.objects['overlay'].o.addChild(grad.o);
        this.o.addChild(this.objects['overlay'].o);
        this.objects['overlay'].o.visible = false;
        this.objects['countdown'] = new countdown(this.o, this.objects['overlay'], this.width, this.height);
        this.objects['countdown'].complete.add(function() {
            self.continueStart();
        });
        this.o.addChild(this.scoreoverlay);
        this.score1 = new Score("time", this.scoreoverlay, config['time']);
        this.score2 = new Score("score", this.scoreoverlay, 0);
        this.score3 = new Score("correct", this.scoreoverlay, 0);
        this.game = new Game(this.objects['office']);
        this.game.showscore.add(function(score, point) {
            self.showscore(score, point);
        });
        this.game.score1 = this.score1;
        this.game.score2 = this.score2;
        this.game.score3 = this.score3;
        this.game.completed.add(function(won) {
            self.endGame(won);
        });
        this.bord = new Border(this.width, this.height)
        this.o.addChild(this.bord.o);
    }
    this.showscore = function(score, point) {
        point = this.objects['office'].o.globalToLocal(this.stage.mouseX, this.stage.mouseY);
        new scorepoint(this.objects['office'].o, point.x, point.y, score);
    }
    this.pause = function() {
        if (this.active) {
            cursor();
            this.paused = true;
            this.game.pause();
        }
    }
    this.resume = function() {
        if (config['mobile']) {
            tt.seto("l", copy['draaicontinue']);
        }
        if (this.active && this.started && this.objects['office'].deur.active == false) {
            cursor1();
            this.game.resume();
            pageM.set("empty");
        }
        if (this.active) {
            cursor1();
            gs.hide();
            pageM.set("empty");
        }
        this.paused = false;
    }
    this.start = function() {
        if (this.active == false) {
            track("/game_start");
            pageM.backenabled = false;
            this.active = true;
            currentstate = 'game';
            this.objects['office'].deur.open(1);
            if (config['mobile']) {
                tt.seto("l", copy['draaicontinue']);
            }
            if (this.started == false) {
                this.game.reset();
                this.objects['office'].animate();
                this.resize(this.width, this.height);
                createjs.Ticker.addEventListener("tick", createjs.proxy(this.tick, this));
                showHidden(this.container);
                TweenMax.to(this.container, 1, {
                    alpha: 1
                });
                this.startAnimation();
                this.stage.enableMouseOver();
                gs.hide();
            } else {
                gs.hide();
                this.game.reset();
            }
        }
    }
    this.checkDistraction = function() {
        if (this.active == true) {
            this.objects['office'].distractions.show();
        }
    }
    this.continueStart = function() {
        cursor1();
        $(".speelbutton .text").html(copy['speelverder'].toUpperCase());
        var self = this;
        if (this.paused == false) {
            this.distractioninterval = setInterval(function() {
                self.checkDistraction();
            }, 5000);
            snd.play("office.mp3", null, null, 1, true);
            if (this.started == false) {
                this.game.show();
                this.started = true;
            } else {
                this.game.show();
            }
            addDebug(this.game.currenttime, "start", this.game.score, this.game.level, this.details);
        } else {
            setTimeout(function() {
                self.continueStart();
            }, 100);
        }
    }
    this.scaleStuff = function() {
        var of = FitIn(this.width, this.height, this.objects['office'].bg.width, this.objects['office'].bg.height, 'fit');
        this.objects['office'].o.scaleX = this.objects['office'].o.scaleY = of.scaleX;
        centerObjectEasel(this.width, this.height, this.objects['office'], 0, 50);
        this.bord.resize(this.width, this.height);
        var of = FitIn(this.width, this.height, this.objects['overlay'].width, this.objects['overlay'].height, 'fill');
        this.objects['overlay'].o.scaleX = this.objects['overlay'].o.scaleY = of.scaleX;
        centerObjectEasel(this.width, this.height, this.objects['overlay'], 0, 0);
        this.objects['countdown'].resize(this.width, this.height);
        this.score1.o.x = -200;
        this.score2.o.x = 0;
        this.score3.o.x = 200;
        this.scoreoverlay.y = this.height - 90;
        this.scoreoverlay.x = this.width / 2;
    }
    this.resize = function(w, h) {
        this.width = w;
        this.height = h;
        if (this.canvas) {
            this.canvas.css("height", h + 'px');
            this.canvas.css("width", w + 'px');
            this.canvas.height = h;
            this.canvas.width = w;
            this.stage.canvas.height = h;
            this.stage.canvas.width = w;
            this.scaleStuff();
            this.stage.update();
        } else {}
        var f = (this.height / viewportheight);
        this.scale = f;
    }
    this.updateElements = function() {
        this.objects['office'].update();
    }
    var c = 0;
    var timespent = 0;
    this.tickTest = function() {
        timespent = timespent + 0.1;
    }
    this.tick = function() {
        if (this.fpsticker.tick()) {
            this.objects['office'].tick();
        }
        this.updateElements();
        this.stage.update();
    }
    this.init = function() {
        console.log(this.width, this.height);
        this.canvas = "<canvas id='bgcanvas' style='width:" + this.width + "px;height:" + this.height + "px'></canvas>";
        this.container.append(this.canvas);
        this.canvas = $("#bgcanvas");
        this.stage = new createjs.Stage("bgcanvas");
        this.createElements();
        createjs.Ticker.setFPS(config['fps']);
        this.resize(this.width, this.height);
    }
    this.nextPhase = function() {
        this.phase++;
        this.animate(this.phase);
    }
    this.animate = function(phase) {}
    this.startAnimation = function() {
        this.phase = 1;
        this.animate(this.phase);
    }
    this.init();
    return this;
}

function CanvasScene2(container) {
    this.container = container;
    this.stage = undefined;
    this.width = $(window).width();
    this.height = $(window).height();
    this.canvas = undefined;
    this.objects = Array();
    this.o = new createjs.Container();
    this.scale = 1;
    this.currentlayer = "";
    this.animating = false;
    this.vid = $("#bgvid");
    this.changed = new signals.Signal();
    this.overlay = $("#overlay");
    this.stopped = false;
    this.addMask = function(object) {}
    this.createElements = function() {
        var self = this;
        this.stage.addChild(this.o);
        this.stad = new stad();
        this.o.addChild(this.stad.o);
        TweenMax.set(this.overlay, {
            alpha: 0.8
        });
        this.vid.bind("ended", function() {
            self.endVideo();
        });
        $("#skipbutton").on("click", function() {
            self.endVideo();
        });
        $(".playbutton").on("click", function() {
            self.vid.get(0).play();
            hideHide($(".playbutton"), 0.5);
        });
    }
    this.endVideo = function() {
        hideHide($(".playbutton"), 0.5);
        this.vid.get(0).pause();
        hideHide($("#skipbutton"), 0.5);
        this.changed.dispatch('video');
    }
    this.scaleImage = function(width, height, imagewidth, imageheight) {
        var vidholder = $("#videoholder");
        var factor1 = width / height;
        var factor2 = imagewidth / imageheight;
        if (width > imagewidth || height > imageheight) {
            if (factor1 > factor2) {
                this.vid.width(width);
                this.vid.height((width / imagewidth) * imageheight);
            } else {
                this.vid.height(height);
                this.vid.width((height / imageheight) * imagewidth);
            }
        }
        if (width < imagewidth && height < imageheight) {
            this.vid.width(imagewidth);
            this.vid.height(imageheight);
        }
        var factor = 1;
        if (this.started && is("tablet")) {
            factor = dpr;
        }
        vidholder.css("left", ((width - this.vid.width()) / 2) * factor);
        vidholder.css("top", ((height - this.vid.height()) / 2) * factor);
        if (config['iPhone'] != "") {
            vidholder.css("top", -10 - this.vid.height());
        }
    }
    this.stopCanvas = function() {
        this.overlay.hide();
        gs.hide();
        fpsa.stopAll();
        this.stopped = true;
        this.stage.autoClear = true;
        this.stage.removeAllChildren();
        this.stage.update();
    }
    this.playVideo = function() {
        if (skipintro == false) {
            showHidden($("#skipbutton"));
            TweenMax.to($("#skipbutton"), 0.5, {
                alpha: 1
            });
            if (config['device']) {
                showHidden($(".playbutton"));
                TweenMax.to($(".playbutton"), 0.5, {
                    alpha: 1
                });
            }
            if (config['iPhone'] != "") {
                $("#mobileimage").show();
            }
            this.scaleImage(this.width, this.height, 1280, 720);
            $("#videoholder").show();
            this.vid.get(0).play();
            this.canvas.hide();
            TweenMax.to(this.overlay, 1, {
                alpha: 0,
                onComplete: this.stopCanvas,
                onCompleteScope: this
            });
        } else {
            this.canvas.hide();
            pageM.get("game").start();
        }
    }
    this.intro = function() {
        menuObject.hide();
        this.animating = true;
        TweenMax.to(this.overlay, 0.5, {
            alpha: 0
        });
        var scaleF = 5;
        TweenMax.to(this.stad.o, 1.5, {
            scaleX: scaleF,
            scaleY: scaleF,
            ease: Power2.easeIn,
            delay: 1,
            x: 0 - (1050 * scaleF) + (this.width / 2),
            y: 0 - (600 * scaleF) + (this.height / 2)
        });
        TweenMax.to(this.overlay, 0.5, {
            alpha: 1,
            delay: 2,
            onComplete: this.playVideo,
            onCompleteScope: this
        });
    }
    this.scaleStuff = function() {
        if (this.animating == false) {
            var of = FitIn(this.width, this.height, this.stad.width, this.stad.height, 'fill');
            this.stad.o.scaleX = this.stad.o.scaleY = of.scaleX;
            centerObjectEasel(this.width, this.height, this.stad, 0, 0);
        } else {
            this.scaleImage(this.width, this.height, 1280, 720);
        }
    }
    this.resize = function(w, h) {
        this.width = w;
        this.height = h;
        if (this.stopped == false) {
            if (this.canvas) {
                this.canvas.css("height", h + 'px');
                this.canvas.css("width", w + 'px');
                this.canvas.height = h;
                this.canvas.width = w;
                this.stage.canvas.height = h;
                this.stage.canvas.width = w;
                this.scaleStuff();
                this.stage.update();
            } else {}
        }
        var f = (this.height / viewportheight);
        this.scale = f;
    }
    this.updateElements = function() {}
    this.tick = function(event) {
        if (this.stopped) {
            event.remove();
        }
        this.updateElements();
        this.stage.update();
    }
    this.init = function() {
        this.canvas = "<canvas id='bgcanvas2' style='width:" + this.width + "px;height:" + this.height + "px'></canvas>";
        this.container.append(this.canvas);
        this.canvas = $("#bgcanvas2");
        this.stage = new createjs.Stage("bgcanvas2");
        this.createElements();
        createjs.Ticker.addEventListener("tick", createjs.proxy(this.tick, this));
        createjs.Ticker.setFPS(config['fps']);
        this.resize(this.width, this.height);
        this.stage.update();
        this.startAnimation();
    }
    this.nextPhase = function() {
        this.phase++;
        this.animate(this.phase);
    }
    this.animate = function(phase) {}
    this.startAnimation = function() {
        this.phase = 1;
        this.animate(this.phase);
    }
    return this;
}

function Office() {
    this.o = new createjs.Container();
    this.phones = Array();
    this.width = 0;
    this.height = 0;
    this.fromx = 750;
    this.tox = 1800;
    this.fromy = 400;
    this.toy = 600;
    this.init = function() {
        var self = this;
        this.bg = fa.insertCV("bg.jpg", "bg", null, this.o, 0, 0);
        this.bg.o.alpha = 0;
        this.width = this.bg.width;
        this.height = this.bg.height;
        this.wolk1 = fa.getCV("full", "ssbureau", {
            fps: config['anifps']
        }, "spritesheet_stad_wolk1");
        this.wolk1holder = fa.addContainer(this.wolk1, this.o, getRandomInt(this.fromx, this.tox), getRandomInt(this.fromy, this.toy), 0.9, 990, 749);
        this.wolk2 = fa.getCV("full", "ssbureau", {
            fps: config['anifps']
        }, "spritesheet_stad_wolk2");
        this.wolk2holder = fa.addContainer(this.wolk2, this.o, getRandomInt(this.fromx, this.tox), getRandomInt(this.fromy, this.toy), 0.95, 1676, 778);
        this.wolk3 = fa.getCV("full", "ssbureau", {
            fps: config['anifps']
        }, "spritesheet_stad_wolk2");
        this.wolk3holder = fa.addContainer(this.wolk3, this.o, getRandomInt(this.fromx, this.tox), getRandomInt(this.fromy, this.toy), 0.95, 1676, 778);
        this.stadzicht = fa.getCV("full", "stadzicht", {
            fps: config['anifps']
        }, "spritesheet_stadzicht");
        this.stadzichtcontainer = fa.addContainer(this.stadzicht, this.o, 125, -100, 0.90);
        this.distractions = new Distractions(this.o);
        this.distractions.o.x = 750;
        this.distractions.o.y = 100;
        this.o.addChild(this.distractions.o);
        this.ramen = fa.getCV("full", "ssramen", {
            fps: config['anifps']
        }, "spritesheet_ramen");
        this.raamcontainer = fa.addContainer(this.ramen, this.o, 130, -70, 0.88);
        this.deur = new Deur(this.o);
        this.deur.o.x = 50;
        this.deur.o.y = -100;
        this.bureau = fa.getCV("full", "ssbureau", {
            fps: config['anifps']
        }, "spritesheet_bureau");
        this.bureauHolder = fa.addContainer(this.bureau, this.o, 100, -160, 0.95);
        fpsa.addObject("wolk1", this.wolk1holder, config['anifps']);
        fpsa.addObject("wolk2", this.wolk2holder, config['anifps']);
        fpsa.addObject("wolk3", this.wolk3holder, config['anifps']);
        this.phone1 = new Phone(1, this.o, 320, 960, 232, 1177);
        this.phone2 = new Phone(2, this.o, 720, 940, 656, 1145);
        this.phone3 = new Phone(3, this.o, 1160, 945, 1130, 1145);
        this.phone4 = new Phone(4, this.o, 1380, 930, 1414, 1145);
        this.phone5 = new Phone(5, this.o, 1730, 1000, 1788, 1200);
        this.netjes = new netjes(this.o, this.width / 2, this.height / 2);
        this.phones[1] = this.phone1;
        this.phones[2] = this.phone2;
        this.phones[3] = this.phone3;
        this.phones[4] = this.phone4;
        this.phones[5] = this.phone5;
        this.animate();
        this.can = fa.getCV("full", "can", {
            fps: config['anifps']
        }, "spritesheet_can");
        this.can.o.y = -100;
        this.can.o.x = 50;
        this.cancont = new SpriteSheetController(this.can.o);
        this.cancont.complete.add(function(name, dir) {
            self.completeAnimation(name, dir);
        });
        this.cancont.add("idle", 0, 4);
        this.cancont.add("turn", 5, 20);
        this.cancont.play("idle", "loop");
        this.o.addChild(this.can.o);
    }
    this.completeAnimation = function(name, dir) {
        this.cancont.play("idle", "loop");
    }
    this.tick = function() {
        this.phone1.tick();
        this.phone2.tick();
        this.phone3.tick();
        this.phone4.tick();
        this.phone5.tick();
        this.deur.tick();
        this.distractions.tick();
        this.cancont.tick();
    }
    this.animateWolk = function(object, holder, noreset) {
        if (noreset != true) {
            object.x = this.tox;
            object.y = getRandomInt(this.fromy, this.toy);
        }
        var percent = 1;
        if (object.x != this.tox) {
            var range = this.tox - this.fromx;
            var cx = object.x - this.fromx;
            percent = (1 / range) * cx;
            console.log(percent);
        }
        fpsa.animate(holder, getRandomNumber(20, 40) * percent, {
            x: this.fromx,
            onComplete: this.animateWolk,
            onCompleteScope: this,
            onCompleteParams: [object, holder],
            ease: Linear.easeNone
        });
    }
    this.animate = function() {
        this.animateWolk(this.wolk1holder, "wolk1", true);
        this.animateWolk(this.wolk2holder, "wolk2", true);
        this.animateWolk(this.wolk3holder, "wolk3", true);
    }
    this.update = function() {}
    this.init();
    return this;
}

function stad() {
    this.o = new createjs.Container();
    this.phones = Array();
    this.width = 2048;
    this.height = 1536;
    this.fromx = -150;
    this.tox = 2200;
    this.fromy = 200;
    this.toy = 700;
    this.init = function() {
        this.wolk2b = fa.getCV("full", "wolk2", {
            fps: config['anifps']
        }, "spritesheet_buiten_wolk2");
        this.wolk2holder = fa.addContainer(this.wolk2b, this.o, getRandomInt(this.fromx, this.tox), getRandomInt(this.fromy, this.toy), 1, 641, 343);
        this.wolk3b = fa.getCV("full", "wolk3", {
            fps: config['anifps']
        }, "spritesheet_buiten_wolk3");
        this.wolk3holder = fa.addContainer(this.wolk3b, this.o, getRandomInt(this.fromx, this.tox), getRandomInt(this.fromy, this.toy), 1, 455, 676);
        this.wolk1b = fa.getCV("full", "wolk1", {
            fps: config['anifps']
        }, "spritesheet_buiten_wolk1");
        this.wolk1holder = fa.addContainer(this.wolk1b, this.o, getRandomInt(this.fromx, this.tox), getRandomInt(this.fromy, this.toy), 1, 504, 392);
        this.wolk5b = fa.getCV("full", "wolk5", {
            fps: config['anifps']
        }, "spritesheet_buiten_wolk5");
        this.wolk5holder = fa.addContainer(this.wolk5b, this.o, getRandomInt(this.fromx, this.tox), getRandomInt(this.fromy, this.toy), 1, 1601, 579);
        this.wolk4b = fa.getCV("full", "wolk4", {
            fps: config['anifps']
        }, "spritesheet_buiten_wolk4");
        this.wolk4holder = fa.addContainer(this.wolk4b, this.o, getRandomInt(this.fromx, this.tox), getRandomInt(this.fromy, this.toy), 1, 1375, 386);
        this.stad = fa.getCV("full", "stad", {
            fps: config['anifps']
        }, "spritesheet_kantoor_stad");
        this.stadholder = fa.addContainer(this.stad, this.o, 0, 0, 1);
        this.kantoor = fa.getCV("full", "kantoor", {
            fps: config['anifps']
        }, "spritesheet_kantoor_buiten");
        this.kantoorholder = fa.addContainer(this.kantoor, this.o, 80, 0, 1);
        fpsa.addObject("wolk1b", this.wolk1holder, config['anifps']);
        fpsa.addObject("wolk2b", this.wolk2holder, config['anifps']);
        fpsa.addObject("wolk3b", this.wolk3holder, config['anifps']);
        fpsa.addObject("wolk4b", this.wolk4holder, config['anifps']);
        fpsa.addObject("wolk5b", this.wolk5holder, config['anifps']);
        this.animate();
    }
    this.animateWolk = function(object, holder, noreset) {
        if (noreset != true) {
            object.x = this.tox;
            object.y = getRandomInt(this.fromy, this.toy);
        }
        var percent = 1;
        if (object.x != this.tox) {
            var range = this.tox - this.fromx;
            var cx = object.x - this.fromx;
            percent = (1 / range) * cx;
            console.log(percent);
        }
        var f = (this[holder].width / 272)
        fpsa.animate(holder, (getRandomNumber(30, 50) * percent) / f, {
            x: this.fromx,
            onComplete: this.animateWolk,
            onCompleteScope: this,
            onCompleteParams: [object, holder],
            ease: Linear.easeNone
        });
    }
    this.animate = function() {
        this.animateWolk(this.wolk1holder, "wolk1b", true);
        this.animateWolk(this.wolk2holder, "wolk2b", true);
        this.animateWolk(this.wolk3holder, "wolk3b", true);
        this.animateWolk(this.wolk4holder, "wolk4b", true);
        this.animateWolk(this.wolk5holder, "wolk5b", true);
    }
    this.update = function() {}
    this.init();
    return this;
}

function Phone(image, container, x, y, xpos, ypos) {
    this.o = new createjs.Container();
    this.image = image;
    this.container = container;
    this.x = x;
    this.y = y;
    this.xpos = xpos;
    this.ypos = ypos;
    this.rang = new signals.Signal();
    this.clicked = new signals.Signal();
    this.enabled = false;
    this.hover = false;
    this.init = function() {
        var self = this;
        this.container.addChild(this.o);
        this.phonea = fa.getCV("full", "phone" + this.image, {
            fps: config['anifps']
        }, "spritesheet_telefoon" + this.image);
        this.phoneaholder = fa.addContainer(this.phonea, this.o, this.x, this.y, 1, this.xpos, this.ypos);
        this.cont = new SpriteSheetController(this.phonea.o);
        this.cont.complete.add(function(name, dir) {
            self.completeAnimation(name, dir);
        });
        this.cont.add("pending", 0, 4);
        this.cont.add("ring", 5, 14);
        this.cont.play("pending", "loop");
        var self = this;
        this.o.addEventListener("click", function(event) {
            console.log(event);
            var point = self.o.localToGlobal(event.rawX, event.rawY);
            self.click(point);
        });
        this.o.addEventListener("rollover", function(event) {
            self.hover = true;
            if (self.enabled) {
                cursor2();
            } else {}
        });
        this.o.addEventListener("rollout", function(event) {
            if (self.enabled) {
                cursor1();
            }
            self.hover = false;
        });
    }
    this.completeAnimation = function(name, dir) {
        if (name == 'ring') {
            this.cont.play("pending", "loop");
            this.completeRing();
        }
    }
    this.tick = function() {
        this.cont.tick();
    }
    this.completeRing = function() {
        this.rang.dispatch();
    }
    this.doShake = function(repeatCount) {}
    this.stop = function() {
        this.cont.play("pending", "loop");
        this.o.x = 0;
        this.o.y = 0;
        snd.stop("phone" + this.image + ".mp3");
    }
    this.shake = function() {
        snd.play("phone" + this.image + ".mp3");
        this.cont.play("ring");
    }
    this.click = function(point) {
        if (this.enabled) {
            this.clicked.dispatch(this.image, point);
            cursor1();
        }
    }
    this.enableMouse = function() {
        var self = this;
        this.enabled = true;
        if (this.hover) {
            cursor2();
        }
    }
    this.disableMouse = function() {
        this.enabled = false;
    }
    this.init();
    return this;
}

function countdown(container, bg, width, height) {
    this.container = container;
    this.o = new createjs.Container();
    this.bg = bg;
    this.fontsize = 80;
    this.width = width;
    this.height = height;
    this.numbers = {};
    this.speed = 0.1;
    this.angle = 20;
    this.wb = 0;
    this.complete = new signals.Signal();
    this.init = function() {
        this.number1 = new createjs.Text("1", this.fontsize + "px FuturaC", color_gray);
        this.number1.textAlign = "center";
        this.o.addChild(this.number1);
        this.number1.textBaseline = 'center';
        this.number1.alpha = 0;
        this.number2 = new createjs.Text("2", this.fontsize + "px FuturaC", color_gray);
        this.number2.textAlign = "center";
        this.o.addChild(this.number2);
        this.number2.textBaseline = 'center';
        this.number2.alpha = 0;
        this.number3 = new createjs.Text("3", this.fontsize + "px FuturaC", color_gray);
        this.number3.textAlign = "center";
        this.o.addChild(this.number3);
        this.number3.textBaseline = 'center';
        this.number3.alpha = 0;
        this.number3.y = 20;
        this.number2.y = 20;
        this.number1.y = 20;
        this.numbers[1] = this.number1;
        this.numbers[2] = this.number2;
        this.numbers[3] = this.number3;
    }
    this.resize = function(width, height) {
        this.width = width;
        this.height = height;
        this.o.x = this.width / 2;
        this.o.y = this.height / 2
    }
    this.start = function() {
        this.container.addChild(this.o);
        this.bg.o.alpha = 0;
        this.bg.o.visible = true;
        TweenMax.to(this.bg.o, 0.5, {
            alpha: 1
        });
        this.show(4);
    }
    this.completeShake2 = function() {}
    this.completeShake = function() {}
    this.checkComplete = function() {
        if (this.numbers[this.number] == undefined) {
            this.container.removeChild(this.o);
            TweenMax.to(this.bg.o, 0.5, {
                alpha: 0
            });
            this.complete.dispatch();
        }
    }
    this.show = function(number) {
        if (this.current) {
            TweenMax.to(this.current, 0.3, {
                alpha: 0,
                scaleX: 3,
                scaleY: 3,
                onComplete: this.checkComplete,
                onCompleteScope: this
            });
            this.current = undefined;
        }
        if (number) {
            this.number = number;
        }
        var repeatCount = 50;
        this.number--;
        if (this.numbers[this.number]) {
            snd.play("count.mp3");
            this.current = this.numbers[this.number];
            this.numbers[this.number].scaleX = this.numbers[this.number].scaleY = 0.5;
            TweenMax.to(this.numbers[this.number], 1, {
                alpha: 1,
                scaleX: 2.5,
                scaleY: 2.5,
                onComplete: this.show,
                onCompleteScope: this
            });
            this.completeShake();
        }
    }
    this.init();
}

function Distractions(container) {
    this.o = new createjs.Container();
    this.container = container;
    this.supermanfrom = -1200;
    this.supermanto = 1500;
    this.glazenfrom = -200;
    this.glazento = 1300;
    this.glazeny = 400;
    this.vogelzijfrom = -50;
    this.vogelzijto = 1200;
    this.vogelzijy = 400;
    this.vogelfrontfromx = 50;
    this.vogelfronttox = 1000;
    this.vogelfrontfromy = 50;
    this.vogelfronttoy = 600;
    this.active = false;
    this.init = function() {
        var self = this;
        this.rect = easelRect(1200 * 0.88, 772 * 0.88);
        this.rect.alpha = 0.6;
        this.container.addChild(this.o);
        this.o.mask = this.rect;
        this.superman = fa.getCV("full", "deur", {
            fps: config['anifps']
        }, "spritesheet_superman");
        this.supermanholder = fa.addContainer(this.superman, null, this.supermanto, 400, 1, 797, 785);
        this.glazen = fa.getCV("full", "glazenwasser", {
            fps: config['anifps']
        }, "spritesheet_glazenwasser");
        this.glazenholder = fa.addContainer(this.glazen, null, 400, this.glazento, 1, 1209, 591);
        this.vogelzij = fa.getCV("full", "vogelzij", {
            fps: config['anifps']
        }, "spritesheet_vogelzij");
        this.vogelzijholder = fa.addContainer(this.vogelzij, null, this.vogelzijfrom, this.vogelzijy, 1, 191, 153);
        this.vogelfront = fa.getCV("full", "vogelzij", {
            fps: config['anifps']
        }, "spritesheet_vogelvoor");
        this.vogelfrontholder = fa.addContainer(this.vogelfront, null, getRandomNumber(this.vogelfrontfromx, this.vogelfronttox), 400, 1, 202, 141);
        this.vogelcrash = fa.getCV("full", "vogelzij", {
            fps: config['anifps']
        }, "spritesheet_vogelcrash");
        this.vogelcrashholder = fa.addContainer(this.vogelcrash, null, 0, 0, 1, 202, 141);
        this.vogelcont = new SpriteSheetController(this.vogelcrash.o);
        this.vogelcont.complete.add(function(name, dir) {
            self.completeAnimation(name, dir);
        });
        this.vogelcont.add("crash", 0, 5);
        this.vogelcont.add("loop", 6, 10);
    }
    this.completeAnimation = function(name, dir) {
        this.vogelcont.play("loop", "loop");
    }
    this.endAni = function() {
        if (this.tween) {
            this.tween.kill();
            this.tween = undefined;
        }
        if (this.current != undefined) {
            switch (this.current) {
                case 0:
                case 1:
                    this.o.removeChild(this.supermanholder);
                    break;
                case 2:
                case 3:
                    this.o.removeChild(this.glazenholder);
                    break;
                case 4:
                    this.o.removeChild(this.vogelzijholder);
                    break;
                case 5:
                    this.o.removeChild(this.vogelcrashholder);
                    break;
            }
        }
        this.active = false;
    }
    this.switchCrash = function() {
        snd.play("crash.mp3");
        this.vogelcrashholder.x = this.vogelfrontholder.x;
        this.vogelcrashholder.y = this.vogelfrontholder.y;
        this.o.removeChild(this.vogelfrontholder);
        this.o.addChild(this.vogelcrashholder);
        TweenMax.to(this.vogelcrashholder, 5, {
            y: 760,
            ease: Linear.easeNone,
            onComplete: this.endAni,
            onCompleteScope: this
        });
        this.vogelcont.play("crash");
    }
    this.show = function() {
        this.rect.x = this.o.x;
        this.rect.y = this.o.y;
        if (this.active == false) {
            this.active = true;
            var r = getRandomInt(1, 5);
            while (r == this.current) {
                r = getRandomInt(1, 5);
            }
            this.current = r;
            console.log("play animatie " + r);
            switch (r) {
                case 1:
                    this.supermanholder.x = this.supermanto;
                    this.supermanholder.scaleX = this.supermanholder.scaleY = 0.7;
                    this.o.addChild(this.supermanholder);
                    TweenMax.to(this.supermanholder, 10, {
                        x: this.supermanfrom,
                        ease: Linear.easeNone,
                        onComplete: this.endAni,
                        onCompleteScope: this
                    });
                    break;
                case 2:
                    this.glazenholder.x = this.glazento;
                    this.o.addChild(this.glazenholder);
                    TweenMax.to(this.glazenholder, 10, {
                        x: this.glazenfrom,
                        ease: Linear.easeNone,
                        onComplete: this.endAni,
                        onCompleteScope: this
                    });
                    this.glazenholder.y = this.glazeny - 50;
                    this.tween = TweenMax.to(this.glazenholder, 2, {
                        y: this.glazeny + 50,
                        repeat: -1,
                        yoyo: true,
                        ease: Sine.easeInOut
                    });
                    break;
                case 3:
                    this.glazenholder.x = this.glazenfrom;
                    this.o.addChild(this.glazenholder);
                    TweenMax.to(this.glazenholder, 10, {
                        x: this.glazento,
                        ease: Linear.easeNone,
                        onComplete: this.endAni,
                        onCompleteScope: this
                    });
                    this.glazenholder.y = this.glazeny - 50;
                    this.tween = TweenMax.to(this.glazenholder, 2, {
                        y: this.glazeny + 50,
                        repeat: -1,
                        yoyo: true,
                        ease: Sine.easeInOut
                    });
                    break;
                case 4:
                    this.vogelzijholder.x = this.vogelzijto;
                    this.o.addChild(this.vogelzijholder);
                    TweenMax.to(this.vogelzijholder, getRandomNumber(6, 12), {
                        x: this.vogelzijfrom,
                        ease: Linear.easeNone,
                        onComplete: this.endAni,
                        onCompleteScope: this
                    });
                    this.vogelzijholder.y = this.vogelzijy - 70;
                    this.tween = TweenMax.to(this.vogelzijholder, getRandomNumber(3, 6), {
                        y: this.vogelzijy + 70,
                        repeat: -1,
                        yoyo: true,
                        ease: Sine.easeInOut
                    });
                    break;
                case 5:
                    this.vogelfrontholder.x = getRandomNumber(this.vogelfrontfromx, this.vogelfronttox);
                    var vy = this.vogelfrontholder.y = getRandomNumber(this.vogelfrontfromy, this.vogelfronttoy);
                    this.vogelfrontholder.y = vy;
                    this.o.addChild(this.vogelfrontholder);
                    this.vogelfrontholder.scaleX = this.vogelfrontholder.scaleY = 0.1
                    TweenMax.to(this.vogelfrontholder, getRandomNumber(2, 3), {
                        y: vy + 50,
                        scaleX: 1,
                        scaleY: 1,
                        ease: Linear.easeNone,
                        onComplete: this.switchCrash,
                        onCompleteScope: this
                    });
                    break;
            }
        }
    }
    this.tick = function() {
        if (this.current == 5) {
            this.vogelcont.tick();
        }
    }
    this.init();
    return this;
}

function Border(width, height) {
    this.o = new createjs.Container();
    this.width = width;
    this.height = height;
    this.hmargin = 100;
    this.vmargin = 50;
    this.first = false;
    this.init = function() {
        this.top = fa.getCV("full", "top", {
            fps: config['anifps'],
            registration: 'centerleft'
        }, "spritesheet_balk_top");
        this.topholder = fa.addContainer(this.top, this.o, 0, 0, 1, 0, 0);
        this.bottom = fa.getCV("full", "bottom", {
            fps: config['anifps'],
            registration: 'centerleft'
        }, "spritesheet_balk_bottom");
        this.bottomholder = fa.addContainer(this.bottom, this.o, 0, 0, 1, 0, 0);
        this.bottom2 = fa.getCV("full", "bottom", {
            fps: config['anifps'],
            registration: 'centerleft'
        }, "spritesheet_balk_bottom");
        this.bottom2holder = fa.addContainer(this.bottom2, this.o, 0, 0, 1, 0, 0);
        this.left = fa.getCV("full", "left", {
            fps: config['anifps'],
            registration: 'topcenter'
        }, "spritesheet_balk_left");
        this.leftholder = fa.addContainer(this.left, this.o, 0, 0, 1, 0, 0);
        this.right = fa.getCV("full", "right", {
            fps: config['anifps'],
            registration: 'topcenter'
        }, "spritesheet_balk_right");
        this.rightholder = fa.addContainer(this.right, this.o, 0, 0, 1, 0, 0);
        this.mask = new createjs.Shape();
        this.mask2 = new createjs.Shape();
        this.mask.alpha = 0.3;
        this.mask2.alpha = 0.3;
        this.resize(this.width, this.height);
    }
    this.resize = function(width, height) {
        this.hmargin = width / 100;
        this.vmargin = height / 200;
        var prop = false;
        if (this.first == false) {
            prop = true;
            this.first = true;
        }
        this.height = height;
        this.width = width;
        var bottomr = 60;
        setWidth(this.top, width - (this.hmargin * 2), this.topholder, true);
        this.topholder.y = this.vmargin;
        this.topholder.x = this.hmargin;
        setWidth(this.bottom, width - (this.hmargin * 2), this.bottomholder, true);
        this.bottomholder.y = height - bottomr;
        this.bottomholder.x = this.hmargin;
        setWidth(this.bottom2, width - (this.hmargin * 2), this.bottom2holder, true);
        this.bottom2holder.y = height - bottomr;
        this.bottom2holder.x = this.hmargin;
        setHeight(this.left, height - (this.vmargin + bottomr), this.leftholder, true);
        this.leftholder.y = this.vmargin;
        this.leftholder.x = this.hmargin;
        setHeight(this.right, height - (this.vmargin + bottomr), this.rightholder, true);
        this.rightholder.y = this.vmargin;
        this.rightholder.x = this.width - this.hmargin;
        var mw = (this.width / 2) - 300;
        var mh = 200;
        if (this.mask.graphics) {}
        this.mask.graphics.beginFill("#000000").drawRect(0, 0, mw, mh);
        this.mask2.graphics.beginFill("#000000").drawRect(width - mw, 0, mw, mh);
        this.bottomholder.mask = this.mask;
        this.bottom2holder.mask = this.mask2;
        this.mask.y = height - mh;
        this.mask2.y = height - mh;
        console.log('resize border ', height);
    }
    this.init();
    return this;
}

function scorepoint(parent, x, y, points) {
    this.o = new createjs.Container();
    this.x = x;
    this.y = (y - 500) + getRandomInt(-100, 100);
    this.size = 100;
    this.parent = parent;
    this.points = points;
    this.destroy = function() {
        this.o.removeChild(this.title);
        this.o.removeChild(this.pt);
        this.parent.removeChild(this.o);
        this.title = null;
        this.pt = null;
        this.o = null;
    }
    this.init = function() {
        this.title = new createjs.Text("+" + this.points, this.size + "px FuturaCB", color_gray);
        this.title.textAlign = "right";
        this.pt = new createjs.Text("PT", "50px FuturaCB", color_gray);
        this.pt.textAlign = "left";
        this.pt.y = 40;
        this.o.x = this.x;
        this.o.y = this.y;
        this.o.alpha = 0;
        var time = 1.5;
        this.o.scaleX = this.o.scaleY = 0.5
        TweenMax.to(this.o, time, {
            y: this.y + 600,
            ease: Circ.easeIn
        });
        TweenMax.to(this.o, 0.2, {
            alpha: 1
        });
        TweenMax.to(this.o, time, {
            scaleX: 1,
            scaleY: 1
        });
        TweenMax.to(this.o, 0.4, {
            delay: time - 0.4,
            alpha: 0,
            onComplete: this.destroy,
            onCompleteScope: this
        });
        this.o.addChild(this.title);
        this.o.addChild(this.pt);
        this.parent.addChild(this.o);
    }
    this.init();
    return this;
}

function netjes(parent, x, y) {
    this.x = x;
    this.y = y
    this.size = 150;
    this.parent = parent;
    this.o = new createjs.Container();
    this.angle = 10;
    this.speed = 0.2;
    this.init = function() {
        this.title = new createjs.Text(copy["netjes"], this.size + "px FuturaBold", color_gray);
        this.title.textAlign = "center";
        this.o.x = this.x;
        this.o.y = this.y;
        this.title.y = 0 - (this.size / 2);
        this.o.addChild(this.title);
        this.o.alpha = 0;
    }
    this.rotate1 = function() {
        this.tween1 = TweenMax.to(this.o, this.speed, {
            rotation: this.angle,
            onComplete: this.rotate2,
            onCompleteScope: this
        });
    }
    this.rotate2 = function() {
        this.tween2 = TweenMax.to(this.o, this.speed, {
            rotation: 0 - this.angle,
            onComplete: this.rotate1,
            onCompleteScope: this
        });
    }
    this.stop = function() {
        this.tween1.kill();
        this.tween2.kill();
        this.parent.removeChild(this.o);
    }
    this.show = function(copy) {
        this.title.text = copy;
        this.parent.addChild(this.o);
        var time = 1;
        this.o.scaleX = this.o.scaleY = 0.2;
        TweenMax.to(this.o, 0.3, {
            alpha: 1
        });
        TweenMax.to(this.o, 0.2, {
            delay: time - 0.2,
            alpha: 0
        });
        TweenMax.to(this.o, time, {
            scaleX: 1,
            scaleY: 1,
            onComplete: this.stop,
            onCompleteScope: this
        });
        this.o.rotation = 0;
        this.rotate1();
    }
    this.init();
    return this;
}

function Score(type, container, val) {
    this.container = container;
    this.o = new createjs.Container();
    this.container.addChild(this.o);
    this.width = 100;
    this.height = 177;
    this.type = type;
    this.fontsize = 14;
    this.fontsize2 = 14;
    this.miny = 0;
    this.value = val;
    this.checkSize = function() {}
    this.setRandom = function() {
        var b = getRandomInt(0, 2000);
        this.update(b);
    }
    this.update = function(number) {
        if (this.type == 'score') {
            this.number.text = pad(number, 4);
            punten = number;
        }
        if (this.type == 'time') {
            this.number.text = number;
            var w1 = this.number.getBounds().width;
            var w2 = this.sec.getBounds().width;
            var totalwidth = w1 - w2;
            this.o2.x = totalwidth / 2;
        } else {
            this.number.text = number;
        }
    }
    this.init = function() {
        var t = "";
        switch (this.type) {
            case "time":
                t = copy['game_tijd'].toUpperCase();
                this.fontsize2 = 40;
                this.miny = 5;
                this.minx = 0;
                break;
            case "score":
                t = copy['game_score'].toUpperCase();
                this.fontsize2 = 50;
                this.minx = 0;
                break;
            case "correct":
                t = copy['game_goed'].toUpperCase();
                this.fontsize2 = 40;
                this.miny = 3;
                this.minx = 0;
                break;
        }
        this.title = new createjs.Text(t, this.fontsize + "px FuturaCB", color_red);
        this.title.textAlign = "center";
        this.o.addChild(this.title);
        this.number = new createjs.Text(t, this.fontsize2 + "px FuturaCB", color_gray);
        this.number.textAlign = "center";
        this.o.addChild(this.number);
        this.number.text = "0000";
        this.number.textBaseline = 'bottom';
        this.number.y = 75 - this.miny;
        this.number.x = 0 - this.minx;
        if (this.type == 'time') {
            this.sec = new createjs.Text("SEC", this.fontsize + "px FuturaCB", color_gray);
            this.sec.textAlign = "left";
            this.number.textAlign = "right";
            this.sec.y = this.number.y - 10;
            this.sec.textBaseline = 'bottom';
            this.o.addChild(this.sec);
            this.o2 = new createjs.Container();
            this.o.addChild(this.o2);
            this.o2.addChild(this.number);
            this.o2.addChild(this.sec);
        }
        var self = this;
        this.update(this.value);
        setInterval(function() {
            self.checkSize()
        }, 100);
    }
    this.init();
    return this;
}

function Deur(container) {
    this.scale = scale;
    this.o = new createjs.Container();
    this.container = container;
    this.width = 0;
    this.height = 0;
    this.handy = 15;
    this.closed = new signals.Signal();
    this.active = false;
    this.init = function() {
        var self = this;
        this.deur = fa.getCV("full", "deur", {
            fps: config['anifps']
        }, "spritesheet_deur");
        this.deurcont = new SpriteSheetController(this.deur.o);
        this.deurcont.complete.add(function(name, dir) {
            self.completeAnimation(name, dir);
        });
        this.deurcont.add("closed", 0, 4);
        this.deurcont.add("opening", 5, 9);
        this.deurcont.add("open", 10, 14);
        this.deurcont.play("closed", "loop");
        this.directeur = fa.getCV("full", "directeur", {
            fps: config['anifps']
        }, "spritesheet_directeur");
        this.directeur.o.y = 30;
        this.directeurcont = new SpriteSheetController(this.directeur.o);
        this.directeurcont.complete.add(function(name, dir) {
            self.completeAnimation(name, dir);
        });
        this.directeur.o.visible = false;
        this.directeurcont.add("show", 0, 6);
        this.directeurcont.add("talk1", 7, 9);
        this.directeurcont.add("talk2", 11, 15);
        this.directeurcont.add("still", 15, 18);
        this.directeurhand = fa.getCV("full", "directeur_hand", {
            fps: config['anifps']
        }, "spritesheet_directeurarm");
        this.directeurhand.o.y = this.handy;
        this.directeurhandcont = new SpriteSheetController(this.directeurhand.o);
        this.directeurhandcont.addPosition(0, -120, -50);
        this.directeurhandcont.addPosition(1, -100, -40);
        this.directeurhandcont.addPosition(2, -70, -30);
        this.directeurhandcont.addPosition(3, -60, -18);
        this.directeurhandcont.addPosition(4, -50, -16);
        this.directeurhandcont.addPosition(5, -30, -15);
        this.directeurhandcont.addPosition(6, 0, -15);
        this.directeurhandcont.complete.add(function(name, dir) {
            self.completeAnimation(name, dir);
        });
        this.directeurhandcont.add("showhand", 0, 19);
        this.directeurhandcont.add("showhandloop", 15, 19);
        this.directeurhandcont.add("hidehand", 0, 5);
        this.o.addChild(this.deur.o);
        this.spraakwolk = new SpraakWolk(this.o);
        this.spraakwolk.o.x = 900;
        this.spraakwolk.o.y = 450;
        this.spraakwolk.changed.add(function() {
            self.closeDoor();
        });
        this.container.addChild(this.o);
    }
    this.closeDoor = function() {
        snd.play("doorclose.mp3");
        this.deurcont.play("opening", "", "backward");
        this.directeurhandcont.play("hidehand", "", "backward");
        this.directeurcont.play("show", "", "backward");
    }
    this.completeAnimation = function(name, dir) {
        if (name == 'opening') {
            if (dir == 'forward') {
                this.deurcont.play("open", "loop");
            } else {
                this.deurcont.play("closed", "loop");
            }
        }
        if (name == 'show') {
            if (dir == 'forward') {
                this.directeurcont.play("talk1");
                this.spraakwolk.play("intro", this.screen);
            } else {
                this.directeur.o.visible = false;
                this.o.removeChild(this.directeurhand.o);
                this.o.removeChild(this.directeur.o);
                this.active = false;
                this.closed.dispatch(this.screen);
            }
        }
        if (name == 'showhand') {
            if (dir == 'forward') {
                this.directeurhandcont.play("showhandloop", 'loop');
            } else {
                this.directeurhand.o.visible = false;
            }
        }
        if (name == 'talk1' || name == 'talk2') {
            var r = getRandomInt(0, 1);
            if (r == 1) {
                this.directeurcont.play("talk1");
            } else {
                this.directeurcont.play("talk2");
            }
        }
    }
    this.open = function(screen) {
        snd.play("door_open.mp3");
        this.screen = screen;
        this.directeurhand.o.x = -50;
        this.directeurhand.o.y = -50;
        this.o.addChild(this.directeurhand.o);
        this.o.addChild(this.directeur.o);
        this.o.addChild(this.deur.o);
        this.active = true;
        this.directeur.o.visible = true;
        this.deurcont.play("opening");
        this.directeurhandcont.play("showhand");
        this.directeurcont.play("show");
    }
    this.tick = function() {
        this.deurcont.tick();
        if (this.active) {
            this.directeurcont.tick();
            this.directeurhandcont.tick();
            this.spraakwolk.tick();
        }
    }
    this.init();
    return this;
}

function SpraakWolk(container) {
    this.o = new createjs.Container();
    this.container = container;
    this.screens = {};
    this.changed = new signals.Signal();
    this.maxh = 390;
    this.createText = function(text, size, container, width, x, y, lh) {
        var t = new createjs.Text(text, size + "px Visum", color_gray);
        t.textAlign = "center";
        t.textBaseline = "top";
        t.lineWidth = width;
        t.lineHeight = lh;
        t.x = x;
        t.y = y;
        container.addChild(t);
        return t;
    }
    this.hideme2 = function() {
        var cs = this.screens[this.screen];
        this.o.removeChild(cs);
        this.screen = undefined;
        this.spraakwolkcont.play("intro", "", "backward");
    }
    this.hideme = function() {
        var cs = this.screens[this.screen];
        TweenMax.to(cs, 0.5, {
            alpha: 0,
            onComplete: this.hideme2,
            onCompleteScope: this
        });
    }
    this.replaceAll = function(screen) {
        if (screen == 1) {
            var s1text3bounds = this.s1text3.getBounds();
            this.s1button1.o.y = (this.s1text3.y + s1text3bounds.height) + 20;
            var th = this.s1button1.o.y + this.s1button1.height;
            var over = this.maxh - th;
            this.s1text3.y = this.s1text3.y + (over / 2);
            this.s1button1.o.y = this.s1button1.o.y + (over / 2);
            var s1text2bounds = this.s1text2.getBounds();
            this.s1text2.y = (this.maxh - s1text2bounds.height) / 2;
        }
    }
    this.init = function() {
        var self = this;
        this.screen1 = new createjs.Container();
        this.s1text2 = this.createText(copy['game_spraakwolk1_body1'].toUpperCase(), 61, this.screen1, 600, 318, 100, 60);
        this.s1text3 = this.createText(copy['game_spraakwolk1_body2'].toUpperCase(), 61, this.screen1, 600, 318, 0, 57);
        this.s1text3.alpha = 0;
        var s1text3bounds = this.s1text3.getBounds();
        this.s1button1 = new Button(copy['game_spraakwolk1_button'].toUpperCase(), this.screen1, 365, 70, 318 - (365 / 2), 100);
        this.screens[1] = this.screen1;
        this.s1button1.o.alpha = 0;
        this.screen2 = new createjs.Container();
        this.s2text1 = this.createText(copy['game_spraakwolk2_title'], 80, this.screen2, 600, 318, 40, 0);
        this.s2text2 = this.createText(copy['game_spraakwolk2_body'].toUpperCase(), 61, this.screen2, 600, 318, this.s2text1.y + 115, 60);
        this.screens[2] = this.screen2;
        this.screen3 = new createjs.Container();
        this.s3text1 = this.createText(copy['game_spraakwolk3_title'], 80, this.screen3, 600, 318, 90, 60);
        this.s3text2 = this.createText(copy['game_spraakwolk3_body'], 61, this.screen3, 600, 318, 200, 60);
        this.screens[3] = this.screen3;
        this.screen4 = new createjs.Container();
        this.s4text1 = this.createText(copy['game_spraakwolk4_title'], 80, this.screen4, 600, 318, 40, 0);
        this.s4text2 = this.createText(copy['game_spraakwolk4_body'].toUpperCase(), 61, this.screen4, 600, 318, this.s2text1.y + 115, 60);
        this.screens[4] = this.screen4;
        this.s1button1.clicked.add(function() {
            snd.play("pop.mp3");
            self.hideme();
        });
        var r = easelRect(100, 100);
        this.container.addChild(this.o);
        this.spraakwolk = fa.getCV("full", "spraakwolk", {
            fps: config['anifps']
        }, "spritesheet_spraakwolk");
        this.spraakwolkholder = fa.addContainer(this.spraakwolk, this.o, 0, 0, 1, 687, 513);
        this.spraakwolkcont = new SpriteSheetController(this.spraakwolk.o);
        this.spraakwolkcont.add("intro", 0, 4);
        this.spraakwolkcont.add("spraakwolkloop", 5, 9);
        this.spraakwolkholder.visible = false;
        this.spraakwolkholder.scaleX = this.spraakwolkholder.scaleY = 0.8;
        this.spraakwolkcont.complete.add(function(name, dir) {
            self.completeAnimation(name, dir);
        });
    }
    this.switchText = function() {
        TweenMax.to(this.s1text2, 1, {
            alpha: 0
        });
        TweenMax.to(this.s1text3, 1, {
            alpha: 1
        });
        TweenMax.to(this.s1button1.o, 1, {
            alpha: 1
        });
    }
    this.play = function(ani, screen) {
        var time = 5000;
        if (config['language'] == 'br') {
            time = 7000;
        }
        var self = this;
        if (screen == 1) {
            this.s1text2.alpha = 1;
            this.s1text3.alpha = 0;
            this.s1button1.o.alpha = 0;
            setTimeout(function() {
                self.switchText();
            }, time);
        }
        this.o.addChild(this.spraakwolkholder);
        this.spraakwolkholder.visible = true;
        this.spraakwolkcont.play(ani);
        this.screen = screen;
        if (this.screen == 3) {
            this.s3text2.text = punten + ", " + copy['game_spraakwolk3_body'];
        }
        if (this.screen == 2) {
            this.s2text2.text = copy['game_spraakwolk2_body'].replace("[score]", highscore).toUpperCase();
        }
        if (this.screen == 4) {
            this.s4text2.text = copy['game_spraakwolk4_body'].replace("[score]", highscore).toUpperCase();
        }
        this.replaceAll(this.screen);
    }
    this.tick = function() {
        this.spraakwolkcont.tick();
    }
    this.returnit = function() {
        this.hideme();
    }
    this.completeAnimation = function(name, dir) {
        var self = this;
        if (name == 'intro' && dir == 'forward') {
            this.spraakwolkcont.play("spraakwolkloop", "loop");
            var cs = this.screens[this.screen];
            cs.alpha = 0;
            cs.visible = false;
            this.o.addChild(cs);
            cs.visible = true;
            TweenMax.to(cs, 0.5, {
                alpha: 1
            });
            if (this.screen == 2 || this.screen == 3 || this.screen == 4) {
                setTimeout(function() {
                    self.returnit();
                }, 4000)
            }
        }
        if (name == 'intro' && dir == 'backward') {
            this.o.removeChild(this.spraakwolkholder);
            this.spraakwolkholder.visible = false;
            this.changed.dispatch();
        }
    }
    this.init();
    return this;
}

function Button(text, container, width, height, x, y) {
    this.text = text;
    this.container = container;
    this.width = width;
    this.height = height;
    this.x = x;
    this.y = y;
    this.o = new createjs.Container();
    this.clicked = new signals.Signal();
    this.init = function() {
        var self = this;
        var gradient2 = new createjs.Shape();
        gradient2.graphics.beginLinearGradientFill(["rgb(249,90,124)", "rgb(248,47,97)"], [0, 1], 0, 0, 0, this.height).drawRoundRect(0, 0, this.width, this.height, 8);
        this.gradient2 = gradient2;
        var gradient = new createjs.Shape();
        gradient.graphics.beginLinearGradientFill(["rgba(203,29,75,1)", "rgba(234,10,98,1)"], [0, 1], 0, 0, 0, this.height).drawRoundRect(0, 0, this.width, this.height, 8);
        this.o.cursor = "pointer";
        this.gradient = gradient;
        this.o.addEventListener("rollover", function() {
            TweenMax.to(self.gradient, 0.2, {
                alpha: 0
            });
        });
        this.o.addEventListener("rollout", function() {
            TweenMax.to(self.gradient, 0.2, {
                alpha: 1
            });
        });
        this.o.addEventListener("click", function() {
            self.clicked.dispatch();
        });
        var fs = 58;
        var t = new createjs.Text(text, fs + "px FuturaCB", "#ffffff");
        t.textBaseline = 'middle';
        t.textAlign = "center";
        t.lineWidth = this.width;
        t.x = this.width / 2;
        t.y = (this.height / 2);
        this.o.addChild(gradient2);
        this.o.addChild(gradient);
        this.o.addChild(t);
        this.o.x = this.x;
        this.o.y = this.y;
        this.container.addChild(this.o);
    }
    this.init();
    return this;
}

function tinaturner(obj) {
    if (config['mobile']) {
        this.obj = obj;
        this.o = "";
        this.orientation = 'p';
        this.visible = false;
        this.changed = new signals.Signal();
        this.init = function() {}
        this.checko = function() {
            if (this.o != this.orientation) {
                if (this.visible == false) {
                    this.obj.show();
                    if (ps) {
                        ps.resize();
                    }
                    this.visible = true;
                }
            } else {
                if (this.visible == true) {
                    this.obj.hide();
                    this.visible = false;
                    this.changed.dispatch(this.o);
                }
            }
        }
        this.seto = function(orientation, text) {
            if (text != undefined) {
                this.obj.find("#turnscreentext").html(text);
            }
            this.orientation = orientation;
            if (this.o != this.orientation) {
                this.checko();
                return false;
            } else {
                return true;
            }
        }
        this.resize = function(width, height) {
            if (width > height) {
                this.o = "l";
            } else {
                this.o = "p";
            }
            this.checko();
        }
        this.init();
    }
    return this;
}

function Game(office) {
    this.office = office;
    this.level = 2;
    this.phones = 5;
    this.ca = Array();
    this.currentkey = 0;
    this.currentclickedkey = 0;
    this.mode = 'play';
    this.completed = new signals.Signal();
    this.showscore = new signals.Signal();
    this.good = new signals.Signal();
    this.totaltime = config['time'];
    this.currenttime = 0;
    this.timer;
    this.score1;
    this.score2;
    this.score3;
    this.goed = 0;
    this.score = 0;
    this.stopped = true;
    this.lastms = 0;
    this.bonustime = 1000;
    this.bonusfactor = 10;
    this.generate = function() {
        this.currentkey = 0;
        this.ca = Array();
        var i = 1;
        while (i <= this.level) {
            this.ca.push(getRandomInt(1, this.phones));
            i++;
        }
    }
    this.show = function() {
        this.currenttime = config['time'];
        this.startCounter();
        this.nextLevel();
    }
    this.countDown = function() {
        this.currenttime = (this.currenttime - 0.1).toFixed(1);
        if (this.currenttime <= 0) {
            addDebug(this.currenttime, "tijd op", this.score, this.level);
            console.log('end');
            this.score1.update("0.0");
            this.endGame(true);
        } else {
            this.score1.update(this.currenttime);
        }
    }
    this.startCounter = function() {
        var self = this;
        this.timer = setInterval(function() {
            self.countDown();
        }, 100);
    }
    this.ring = function() {
        var self = this;
        if (pageM.get("game").cs.paused == false) {
            var tk = this.ca[this.currentkey];
            if (tk) {
                this.office.phones[tk].shake();
            } else {
                this.office.netjes.show(copy["nujij"].toUpperCase());
                this.mode = 'input';
                this.enableMouse();
            }
        } else {
            setTimeout(function() {
                self.ring()
            }, 100);
        }
    }
    this.enableMouse = function() {
        var self = this;
        this.lastms = getMS();
        for (var i in this.office.phones) {
            this.office.phones[i].enableMouse();
        }
    }
    this.disableMouse = function() {
        for (var i in this.office.phones) {
            this.office.phones[i].disableMouse();
        }
    }
    this.nextLevel = function() {
        this.currentkey = 0;
        this.mode = 'play';
        this.level++;
        this.currentclickedkey = 0;
        this.generate();
        this.ring();
        addDebug(this.currenttime, "nextlevel", this.score, this.level);
    }
    this.hasrang = function() {
        var self = this;
        if (this.stopped == false) {
            if (this.mode == 'play') {
                this.currentkey++;
                this.ring();
            } else {
                if (this.ca[this.currentclickedkey] == undefined) {
                    this.disableMouse();
                    this.office.netjes.show(copy["netjes"].toUpperCase());
                    this.office.cancont.play("turn");
                    setTimeout(function() {
                        self.nextLevel();
                    }, 1000);
                }
            }
        }
    }
    this.reset = function() {
        this.stopped = false;
        this.goed = 0;
        this.score = 0;
        this.level = 1;
        this.currentclickedkey = 0;
        this.currenttime = this.totaltime;
        if (this.score2) {
            this.score1.update(this.totaltime);
            this.score2.update(this.score);
            this.score3.update(this.goed);
        }
        this.generate();
    }
    this.pause = function() {
        clearInterval(this.timer);
        this.timer = undefined;
    }
    this.resume = function() {
        if (this.timer == undefined) {
            var self = this;
            this.timer = setInterval(function() {
                self.countDown();
            }, 100);
        }
    }
    this.fout = function() {
        this.endGame(false);
    }
    this.stop = function() {
        this.disableMouse();
        this.stopped = true;
    }
    this.endGame = function(good) {
        this.stop();
        if (this.timer) {
            clearInterval(this.timer);
            this.timer = undefined;
        }
        this.completed.dispatch(good);
    }
    this.isClicked = function(phone, point) {
        for (var i in this.office.phones) {
            this.office.phones[i].stop();
        }
        var s = this.ca[this.currentclickedkey];
        if (phone == s) {
            var bonus = 0;
            var m = getMS();
            var spent = m - this.lastms;
            if (spent < this.bonustime) {
                bonus = bonus + Math.round(((this.bonustime - spent) / this.bonusfactor));
            }
            this.lastms = getMS();
            this.office.phones[phone].shake();
            this.goed++;
            var score = (10 * this.goed) + bonus;
            addDebug(this.currenttime, "goed", this.score, this.level, "bonus=" + bonus + ",bonustime=" + this.bonustime + ",spent=" + spent);
            this.showscore.dispatch(score, point);
            this.score = this.score + score;
            this.score2.update(this.score);
            this.score3.update(this.goed);
            this.good.dispatch();
            snd.play("correct.mp3");
        } else {
            snd.play("fout.mp3");
            addDebug(this.currenttime, "fout", this.score, this.level);
            this.fout();
        }
        this.currentclickedkey++;
        if (this.ca[this.currentclickedkey] == undefined) {
            for (var i in this.office.phones) {
                this.office.phones[i].disableMouse();
            }
        }
    }
    this.init = function() {
        this.reset();
        var self = this;
        for (var i in this.office.phones) {
            this.office.phones[i].rang.add(function() {
                self.hasrang();
            });
            this.office.phones[i].clicked.add(function(phone, point) {
                self.isClicked(phone, point);
            });
        }
    }
    this.init();
    return this;
}

function centerObjectEasel(width, height, object, minx, miny) {
    if (minx == undefined) {
        minx = 0
    }
    if (miny == undefined) {
        miny = 0
    }
    var cw = object.width * object.o.scaleX;
    var ch = object.height * object.o.scaleY;
    object.o.x = ((width - cw) / 2) - minx;
    object.o.y = ((height - ch) / 2) - miny;
}

function setWidth(object, width, target, proportional) {
    var s = (((width) / object.width));
    var t = object.o;
    if (target) {
        t = target;
    }
    t.scaleX = s;
    if (proportional) {
        t.scaleY = s;
    }
}

function setHeight(object, height, target, proportional) {
    var s = (((height) / object.height));
    var t = object.o;
    if (target) {
        t = target;
    }
    t.scaleY = s;
    if (proportional) {
        t.scaleX = s;
    }
}

function centerObjectEaselScale(width, height, object, scale, minx, miny) {
    if (scale == undefined) {
        scale = 1;
    }
    if (minx == undefined) {
        minx = 0
    }
    if (miny == undefined) {
        miny = 0
    }
    scale = 1;
    setWidth(object, width - minx);
    setHeight(object, height - miny);
    object.o.x = (width - (width - minx)) / 2;
    object.o.y = (height - (height - minx)) / 2;
}

function easelRect(width, height, color, tobject, alpha) {
    if (color == undefined) {
        color = "#000000";
    }
    if (alpha == undefined) {
        alpha = 1;
    }
    var m = new createjs.Shape();
    m.graphics.beginFill(color).drawRect(0, 0, width, height);
    if (tobject) {
        m.alpha = alpha;
        var c = new createjs.Container();
        var ob = {};
        ob.width = width;
        ob.height = height;
        c.addChild(m);
        ob.o = c;
        return ob;
    } else {
        return m;
    }
}

function background(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'gamepage';
    this.innited = false;
    this.init = function() {
        this.cs = new CanvasScene2(this.object);
        this.cs.init();
        var self = this;
        this.cs.changed.add(function(state) {
            self.changeState(state);
        });
    }
    this.changeState = function(state) {
        if (state == 'video') {
            gs.show(1);
        }
    }
    this.intro = function() {
        if (config['frombanner']) {
            if (config['mobile']) {
                tt.seto("l", copy['draai']);
            }
            this.cs.stopCanvas();
            gs.show(1);
        } else {
            this.cs.intro();
        }
    }
    this.initPage = function() {}
    this.resize = function(width, height) {
        this.cs.resize(width, height);
    }
    this.init();
}

function page_select(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'page_select';
    this.innited = false;
    this.init = function() {
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
        this.object.find("#button1").on("click", function() {
            document.location = getPath() + "fr";
        });
        this.object.find("#button2").on("click", function() {
            document.location = getPath() + "nl";
        });
    }
    this.initPage = function() {}
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.position = function() {}
    this.intro = function(from) {
        $(".menubutton").hide();
        $(".soundbutton").hide();
        this.object.show();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function page1(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'page1';
    this.innited = false;
    this.init = function() {
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
        this.object.find("#button1").on("click", function() {
            pageM.set("page3");
        });
        this.object.find("#button2").on("click", function() {
            pageM.set("page2");
        });
    }
    this.initPage = function() {}
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.position = function() {}
    this.intro = function(from) {
        showButtons();
        this.object.show();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function page2(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'page2';
    this.innited = false;
    this.init = function() {
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
    }
    this.initPage = function() {}
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.intro = function(from) {
        hideButtons();
        this.object.show();
        ps.resize();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function page3(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'page3';
    this.innited = false;
    this.init = function() {
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
    }
    this.initPage = function() {}
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.intro = function(from) {
        this.object.show();
        hideButtons();
        ps.resize();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function page4(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'page4';
    this.innited = false;
    this.blinker = new FieldBlinker();
    this.init = function() {
        this.blinker.addField("adres", this.object.find("#form_adres"));
        this.blinker.addField("voornaam", this.object.find("#form_voornaam"));
        this.blinker.addField("achternaam", this.object.find("#form_achternaam"));
        this.blinker.addField("email", this.object.find("#form_email"), "email");
        this.blinker.addField("postcode", this.object.find("#form_postcode"));
        this.blinker.addField("bedrijf", this.object.find("#form_bedrijf"));
        this.blinker.addField("plaats", this.object.find("#form_plaats"));
        this.blinker.addField("collegas", this.object.find("#form_collegas"));
        this.blinker.addField("akkoord", this.object.find("#form_akkoord"));
        var self = this;
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
        this.object.find("#showform").on("click", function() {
            self.openForm();
        });
        this.object.find("#sendform").on("click", function() {
            self.sendForm();
        });
    }
    this.openForm = function() {
        var f = this.object.find("#form");
        var c = this.object.find("#copy");
        if (config['mobile']) {
            this.object.find(".mobiletitle").hide();
            f.show();
            c.hide();
        } else {
            showHidden(f);
            TweenMax.to(f, 1, {
                alpha: 1
            });
            hideHide(c, 1);
        }
    }
    this.returnsubmit = function(vals, vars) {
        var f = this.object.find("#form");
        var c = this.object.find("#complete");
        var co = c.find("#emailcopy");
        $(co).text($(f).find("#form_email").val());
        if (config['mobile']) {
            c.show();
            f.hide();
        } else {
            showHidden(c);
            TweenMax.to(c, 1, {
                alpha: 1
            });
            hideHide(f, 1);
        }
    }
    this.sendForm = function() {
        var form = Object();
        var fd = $("#page4_form");
        var fdata = fd.serializeArray();
        for (var item in fdata) {
            form[fdata[item]['name']] = fdata[item]['value'];
        }
        if (this.blinker.check(form)) {
            apiConnector().send("saveWings", form, this.returnsubmit, undefined, this);
        }
    }
    this.initPage = function() {}
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.intro = function(from) {
        var f = this.object.find("#form");
        var c = this.object.find("#copy");
        var cc = this.object.find("#complete");
        if (config['mobile']) {
            this.object.find(".mobiletitle").show();
        }
        f.hide();
        c.show();
        TweenMax.set(c, {
            alpha: 1
        });
        cc.hide();
        this.object.show();
        hideButtons();
        ps.resize();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function page5(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'page5';
    this.innited = false;
    this.init = function() {
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
    }
    this.initPage = function() {}
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.intro = function(from) {
        hideButtons();
        this.object.show();
        ps.resize();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function page6(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'page6';
    this.innited = false;
    this.init = function() {
        var self = this;
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
    }
    this.initPage = function() {}
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.intro = function(from) {
        this.object.show();
        hideButtons();
        ps.resize();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function page7(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'page7';
    this.innited = false;
    this.init = function() {
        var self = this;
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
    }
    this.initPage = function() {}
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.intro = function(from) {
        this.object.show();
        hideButtons();
        ps.resize();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function page_bedankt(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'page_bedankt';
    this.innited = false;
    this.init = function() {
        this.facebook = $(this.object.find("#share_facebook"));
        this.twitter = $(this.object.find("#share_twitter"));
        this.linkedin = $(this.object.find("#share_linkedin"));
        this.mail = $(this.object.find("#share_mail"));
        TweenMax.set(this.facebook, {
            alpha: 0
        });
        TweenMax.set(this.twitter, {
            alpha: 0
        });
        TweenMax.set(this.linkedin, {
            alpha: 0
        });
        TweenMax.set(this.mail, {
            alpha: 0
        });
        this.fly = $("#fly");
        this.facebook.on("click", shareFacebook);
        this.twitter.on("click", shareTwitter);
        this.linkedin.on("click", shareLinkedin);
        this.mail.on("click", shareMail);
        var self = this;
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
    }
    this.initPage = function() {}
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.stopBee = function() {
        snd.stop("bee.mp3");
    }
    this.showSocial = function(name) {
        if (name == 'facebook') {
            TweenMax.to(this.facebook, 1, {
                alpha: 1,
                onComplete: this.stopBee,
                onCompleteScope: this
            });
            this.doFly(5);
        }
        if (name == 'linkedin') {
            TweenMax.to(this.linkedin, 1, {
                alpha: 1
            });
            this.doFly(4);
        }
        if (name == 'twitter') {
            TweenMax.to(this.twitter, 1, {
                alpha: 1
            });
            this.doFly(3);
        }
        if (name == 'mail') {
            TweenMax.to(this.mail, 1, {
                alpha: 1
            });
            this.doFly(2);
        }
    }
    this.doFly = function(t) {
        snd.play("bee.mp3", null, null, 1, true);
        if (t == undefined) {
            t = 1;
            TweenMax.set(this.fly, {
                x: fr.width + 100,
                y: fr.height / 2
            });
        }
        this.fly.show();
        var minx = 15;
        var miny = 15;
        var position = {};
        var send = "facebook";
        var speed = 0.5;
        switch (t) {
            case 4:
                position = this.facebook.offset();
                break;
            case 3:
                position = this.linkedin.offset();
                send = "linkedin";
                break;
            case 2:
                position = this.twitter.offset();
                send = "twitter";
                speed = 1;
                break;
            case 1:
                position = this.mail.offset();
                send = "mail";
                speed = 1;
                break;
            case 5:
                position = {
                    left: -100,
                    top: 500
                }
                send = "";
                speed = 2;
                break;
        }
        TweenMax.to(this.fly, speed, {
            x: position.left - minx,
            y: position.top - miny,
            onComplete: this.showSocial,
            onCompleteScope: this,
            onCompleteParams: [send]
        });
    }
    this.intro = function(from) {
        var body = copy['end_bedankt_copy' + bedankttype].replace("[email]", emaila).toUpperCase();
        this.object.find(".bedankttext").html(body);
        TweenMax.set(this.facebook, {
            alpha: 0
        });
        TweenMax.set(this.twitter, {
            alpha: 0
        });
        TweenMax.set(this.linkedin, {
            alpha: 0
        });
        this.object.show();
        ps.resize();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
        this.doFly();
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function end_nonwon(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'end_nonwon';
    this.innited = false;
    this.init = function() {
        var self = this;
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
        this.object.find("#showform").on("click", function() {
            pageM.set("end_form");
        });
        this.facebook = $(this.object.find("#share_facebook"));
        this.twitter = $(this.object.find("#share_twitter"));
        this.linkedin = $(this.object.find("#share_linkedin"));
        this.mail = $(this.object.find("#share_mail"));
        this.facebook.on("click", shareFacebook);
        this.twitter.on("click", shareTwitter);
        this.linkedin.on("click", shareLinkedin);
        this.mail.on("click", shareMail);
    }
    this.initPage = function() {}
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.intro = function(from) {
        var sp = $(this.object.find("#scorepoints"));
        sp.text(punten);
        this.object.show();
        ps.resize();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function end_won(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'end_won';
    this.innited = false;
    this.init = function() {
        var self = this;
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
        this.object.find("#showform").on("click", function() {
            pageM.set("end_won_form");
        });
        this.object.find("#sendform").on("click", function() {
            self.sendForm();
        });
    }
    this.openForm = function() {
        var f = this.object.find("#form");
        var c = this.object.find("#copy");
        showHidden(f);
        TweenMax.to(f, 1, {
            alpha: 1
        });
        hideHide(c, 1);
    }
    this.sendForm = function() {
        var f = this.object.find("#form");
        var c = this.object.find("#complete");
        var co = c.find("#emailcopy");
        $(co).text($(f).find("#email").val());
        showHidden(c);
        TweenMax.to(c, 1, {
            alpha: 1
        });
        hideHide(f, 1);
    }
    this.initPage = function() {}
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.intro = function(from) {
        this.object.show();
        ps.resize();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function end_form(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'end_form';
    this.innited = false;
    this.blinker = new FieldBlinker();
    this.init = function() {
        this.blinker.addField("adres", this.object.find("#form_adres"));
        this.blinker.addField("voornaam", this.object.find("#form_voornaam"));
        this.blinker.addField("achternaam", this.object.find("#form_achternaam"));
        this.blinker.addField("email", this.object.find("#form_email"), "email");
        this.blinker.addField("postcode", this.object.find("#form_postcode"));
        this.blinker.addField("bedrijf", this.object.find("#form_bedrijf"));
        this.blinker.addField("plaats", this.object.find("#form_plaats"));
        this.blinker.addField("collegas", this.object.find("#form_collegas"));
        this.blinker.addField("akkoord", this.object.find("#form_akkoord"));
        var self = this;
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
        this.object.find("#sendform").on("click", function() {
            self.sendForm();
        });
    }
    this.initPage = function() {}
    this.returnsubmit = function(vals, vars) {
        var em = this.object.find("#form_email").val();
        emaila = em;
        bedankttype = 1;
        pageM.set("page_bedankt");
    }
    this.sendForm = function() {
        var form = Object();
        var fd = $("#end_form_form");
        var fdata = fd.serializeArray();
        for (var item in fdata) {
            form[fdata[item]['name']] = fdata[item]['value'];
        }
        if (this.blinker.check(form)) {
            apiConnector().send("saveWings", form, this.returnsubmit, undefined, this);
        }
    }
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.intro = function(from) {
        this.object.show();
        ps.resize();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function end_won_form(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'end_won_form';
    this.innited = false;
    this.wings = false;
    this.blinker1 = new FieldBlinker();
    this.blinker2 = new FieldBlinker();
    this.submitting = false;
    this.init = function() {
        this.blinker2.addField("adres", this.object.find("#form_adres"));
        this.blinker2.addField("voornaam", this.object.find("#form_voornaam"));
        this.blinker2.addField("achternaam", this.object.find("#form_achternaam"));
        this.blinker2.addField("email", this.object.find("#form_email"), "email");
        this.blinker2.addField("postcode", this.object.find("#form_postcode"));
        this.blinker2.addField("bedrijf", this.object.find("#form_bedrijf"));
        this.blinker2.addField("plaats", this.object.find("#form_plaats"));
        this.blinker2.addField("collegas", this.object.find("#form_collegas"));
        this.blinker2.addField("akkoord", this.object.find("#form_akkoord"));
        if (config['country'] == 'br') {
            this.blinker2.addField("telefoon", this.object.find("#form_phone"));
        }
        this.blinker1.addField("voornaam", this.object.find("#form_voornaam"));
        this.blinker1.addField("achternaam", this.object.find("#form_achternaam"));
        this.blinker1.addField("email", this.object.find("#form_email"), "email");
        this.blinker1.addField("bedrijf", this.object.find("#form_bedrijf"));
        this.blinker1.addField("plaats", this.object.find("#form_plaats"));
        this.blinker1.addField("akkoord", this.object.find("#form_akkoord"));
        var self = this;
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.changed.dispatch(this.name, "init");
        this.object.hide();
        this.object.find("#showform").on("click", function() {
            self.openForm();
        });
        this.object.find("#sendform").on("click", function() {
            self.sendForm();
        });
        this.object.find("#wingscheckbox").click(function() {
            if ($(this).is(':checked')) {
                self.showFields();
            } else {
                self.hideFields();
            }
        });
    }
    this.showFields = function() {
        this.wings = true;
        this.object.find(".hidden").show();
        this.object.find(".state2").show();
        this.object.find(".state1").hide();
        this.object.find("#end_won_form_inner").css("height", "600px");
        ps.resize();
    }
    this.hideFields = function() {
        this.wings = false;
        this.object.find(".hidden").hide();
        this.object.find(".state1").show();
        this.object.find(".state2").hide();
        this.object.find("#end_won_form_inner").css("height", "450px");
        ps.resize();
    }
    this.openForm = function() {
        var f = this.object.find("#form");
        var c = this.object.find("#copy");
        showHidden(f);
        TweenMax.to(f, 1, {
            alpha: 1
        });
        hideHide(c, 1);
    }
    this.returnsubmit = function(vals, vars) {
        this.submitting = false;
        var em = this.object.find("#form_email").val();
        emaila = em;
        if (self.wings == true) {
            bedankttype = 3;
        } else {
            bedankttype = 2;
        }
        pageM.set("page_bedankt");
    }
    this.sendForm = function() {
        if (this.submitting == true) {
            return;
        }
        var form = Object();
        var fd = $("#end_won_form_form");
        var fdata = fd.serializeArray();
        for (var item in fdata) {
            form[fdata[item]['name']] = fdata[item]['value'];
        }
        if (this.wings || config['country'] == 'br') {
            if (this.blinker2.check(form)) {
                form['wings'] = 1;
                form['debug'] = gamedebug;
                form['score'] = punten;
                this.submitting = true;
                apiConnector().send("saveScore", form, this.returnsubmit, undefined, this);
            }
        } else {
            if (this.blinker1.check(form)) {
                form['wings'] = 0;
                form['debug'] = gamedebug;
                form['score'] = punten;
                this.submitting = true;
                apiConnector().send("saveScore", form, this.returnsubmit, undefined, this);
            }
        }
    }
    this.initPage = function() {}
    this.stateChange = function(state) {
        if (state == 'outro') {
            this.object.hide();
        }
        this.changed.dispatch(this.name, state);
    }
    this.intro = function(from) {
        this.wings = false;
        this.hideFields();
        this.object.show();
        ps.resize();
        TweenMax.to(this.object, 1, {
            alpha: 1,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["intro"]
        });
    }
    this.outro = function(to) {
        TweenMax.to(this.object, 0.5, {
            alpha: 0,
            onComplete: this.stateChange,
            onCompleteScope: this,
            onCompleteParams: ["outro"]
        });
    }
}

function gamepage(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'game';
    this.innited = false;
    this.width = 0;
    this.height = 0;
    this.init = function() {
        this.cs = new CanvasScene(this.object);
        this.resize(this.width, this.height);
        this.changed.dispatch(this.name, "init");
        TweenMax.set(this.object, {
            alpha: 0
        });
        this.object.hide();
    }
    this.initPage = function() {}
    this.pause = function() {
        this.cs.pause();
    }
    this.resume = function() {
        this.cs.resume();
    }
    this.start = function() {
        this.cs.start();
        this.cs.resize(this.width, this.height);
    }
    this.resize = function(width, height) {
        this.width = width;
        this.height = height;
        this.cs.resize(width, height);
    }
    this.stateChange = function(state) {
        if (state == 'outro') {}
        if (state == 'intro') {}
        this.changed.dispatch(this.name, state);
    }
    this.intro = function(from) {
        currentstate = 'inbetween';
        bg.intro();
        this.stateChange("intro");
    }
    this.outro = function(to) {
        this.stateChange("outro");
    }
}

function gamescreens(element) {
    this.object = element;
    this.overlay = $("#overlay");
    this.active = undefined;
    this.init = function() {
        var self = this;
        this.screens = {};
        this.screens[1] = $(this.object.find("#screen1"));
        this.screens[2] = $(this.object.find("#screen2"));
        this.screens[3] = $(this.object.find("#screen3"));
        this.screens[4] = $(this.object.find("#screen4"));
        this.screens[1].find("#speelgame1").on("click", function() {
            self.startGame();
        });
        this.screens[2].find("#speelgame1").on("click", function() {
            self.startGame();
        });
        this.screens[3].find("#speelgame1").on("click", function() {
            self.startGame();
        });
        this.screens[4].find("#speelgame1").on("click", function() {
            menuObject.hide();
        });
    }
    this.startGame = function() {
        pageM.get("game").start();
    }
    this.show = function(screen) {
        if (screen != this.active) {
            if (this.active) {
                this.hide(screen, true);
            }
            this.object.show();
            var el = this.screens[screen];
            showHidden(el);
            showHidden(this.overlay);
            TweenMax.to(this.overlay, 1, {
                alpha: 0.8
            });
            TweenMax.to(el, 1, {
                alpha: 1
            });
            this.active = screen;
        }
    }
    this.checkHide = function() {
        if (this.active == undefined) {
            this.overlay.hide();
            this.object.hide();
        }
    }
    this.hide = function(screen, ignorebg) {
        if (screen == undefined) {
            screen = this.active;
        }
        if (screen) {
            this.active = undefined;
            var el = this.screens[screen];
            hideHide(el, 1);
        }
        if (ignorebg == undefined) {
            TweenMax.to(this.overlay, 1, {
                alpha: 0,
                onComplete: this.checkHide,
                onCompleteScope: this
            });
        }
    }
    this.init();
}

function empty(object) {
    this.shown = false;
    this.object = $(object);
    this.changed = new signals.Signal();
    this.name = 'empty';
    this.innited = false;
    this.width = 0;
    this.height = 0;
    this.init = function() {
        this.changed.dispatch(this.name, "init");
    }
    this.resize = function(width, height) {
        this.width = width;
        this.height = height;
    }
    this.stateChange = function(state) {
        if (state == 'outro') {}
        if (state == 'intro') {}
        this.changed.dispatch(this.name, state);
    }
    this.intro = function(from) {
        this.stateChange("intro");
    }
    this.outro = function(to) {
        this.stateChange("outro");
    }
}

function menu(name) {
    this.object = $(name);
    this.shown = false;
    this.width = 309;
    if (config['mobile']) {
        this.width = 480;
    }
    this.init = function() {
        var self = this;
        $("#closemenu").on("click", function() {
            self.hide();
        });
        $(this.object.find(".menuButton")).on("click", function() {
            self.object.find(".menuButton").removeClass("menu_right");
            var active = $(this);
            if (active.hasClass("menuItem2") == false) {
                active.addClass("menu_right");
            }
            gs.hide(null, true);
            switch (this.id) {
                case "menu_hoewerkthet":
                    pageM.set("page2");
                    break;
                case "menu_winnen":
                    pageM.set("page3");
                    break;
                case "menu_wingsteam":
                    pageM.set("page4");
                    break;
                case "menu_wingsteamactie":
                    pageM.set("page5");
                    break;
                case "menu_voorwaarden":
                    pageM.set("page6");
                    break;
                case "menu_top10":
                    pageM.set("page7");
                    break;
                case "menu_watziterin":
                    track("/watziterin");
                    window.open(copy['link_watziterin']);
                    break;
                case "menu_planet":
                    track("/mywings");
                    window.open(copy['link_planet']);
                    break;
                case "menu_cartoons":
                    track("/cartoons");
                    window.open(copy['link_cartoons']);
                    break;
            }
            if (config['mobile']) {
                self.hide(true);
            }
        });
    }
    this.show = function() {
        if (config['mobile']) {
            tt.seto("p", copy['draai']);
        }
        if (currentstate == 'menu') {} else if (currentstate == 'game') {
            if (pageM.get("game").cs.active == true) {
                gs.show(4);
                pageM.get("game").pause();
            }
        }
        if (this.shown == false) {
            this.shown = true;
            if (!config['mobile']) {
                TweenMax.to("#maindiv", 0.5, {
                    left: 150
                });
            }
            TweenMax.to(this.object, 0.5, {
                left: 0
            });
        }
    }
    this.hide = function(noaction) {
        this.object.find(".menuButton").removeClass("menu_right");
        if (!noaction) {
            if (currentstate == 'home') {
                pageM.set("page1");
            } else if (currentstate == 'game') {
                pageM.get("game").resume();
            }
        }
        if (this.shown == true) {
            this.shown = false;
            if (!config['mobile']) {
                TweenMax.to("#maindiv", 0.5, {
                    left: 0
                });
            }
            TweenMax.to(this.object, 0.5, {
                left: 0 - this.width
            });
        }
    }
    this.init();
}
var layers = Array();
var viewportheight = 1536;
var snd = new Sounds();
var fr;
var ps;
var color_red = "#e20e5c";
var color_gray = "#373737";
var fpsa;
var topState = new stateManager();
var pageM;
var menuObject;
var bg;
var gs;
var rbbarheight = 37;
var scale = ($(window).height() / viewportheight);
var currentstate = "home";
var punten = 0;
var highscore = config['highscore'];
var bedankttype = 0;
var emaila = "";
var muted = false;
var vido = "";
var tt;
var waitingstate = "";
var starttime = 0;
var gamedebug = "";
var skipintro = false;
if (config['mobile']) {
    rbbarheight = 0;
}

function addDebug(time, action, score, level, details) {
    var d = new Date();
    var realtime = d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
    if (details == undefined) {
        details = "";
    }
    gamedebug = gamedebug + "\n" + realtime + "||" + time + "||" + action + "||" + score + "||" + level + "||" + details;
}

function resize(width, height) {
    if (config['mobile']) {
        tt.resize(width, height);
    }
    if (pageM) {
        pageM.get("game").resize(width, height - rbbarheight);
        bg.resize(width, height - rbbarheight);
    }
}

function cursor1() {
    console.log("cursor1 caller is " + arguments.callee.caller.toString());
    $("#bgcanvas").addClass("cursor1");
    $("#bgcanvas").removeClass("cursor2");
}

function cursor2() {}

function cursor() {
    console.log("cursor caller is " + arguments.callee.caller.toString());
    $("#bgcanvas").removeClass("cursor2");
    $("#bgcanvas").removeClass("cursor1");
}

function ttchanged(orientation) {
    if (orientation == 'l' && waitingstate == 'game') {
        pageM.set("game");
        waitingstate = "";
    }
}

function init() {
    if (config['mobile']) {
        tt = new tinaturner($("#tinaturner"));
        tt.changed.add(ttchanged);
    }
    gs = new gamescreens($("#gamescreens"));
    menuObject = new menu(".menu");
    fpsa = new FPSAnimator();
    TweenMax.ticker.fps(config['fps']);
    bg = new background("#canvascontainer2");
    var pselect = new page_select("#page_select");
    var p1 = new page1("#page1");
    var p2 = new page2("#page2");
    var p3 = new page3("#page3");
    var p4 = new page4("#page4");
    var p5 = new page5("#page5");
    var p6 = new page6("#page6");
    var p7 = new page7("#page7");
    var pempty = new empty("#page5");
    var bedankt = new page_bedankt("#page_bedankt");
    var pend_nonwon = new end_nonwon("#end_nonwon");
    var pend_won = new end_won("#end_won");
    var pend_won_form = new end_won_form("#end_won_form");
    var pend_form = new end_form("#end_form");
    var pgame = new gamepage("#canvascontainer");
    fr = new fullResizer();
    fr.addObject({
        object: ".full",
        type: 'percent',
        height: 100,
        width: 100,
        minusheight: rbbarheight
    });
    fr.addObject({
        object: ".fullheight",
        type: 'percent',
        height: 100,
        minusheight: rbbarheight
    });
    if (config['mobile']) {
        fr.addObject({
            object: ".full2",
            type: 'percent',
            height: 100,
            width: 100,
            minusheight: 100
        });
        fr.addObject({
            object: ".fullheight2",
            type: 'percent',
            height: 100,
            minusheight: 100
        });
    }
    if (config['mobile']) {
        fr.addObject({
            object: ".fullmobile",
            type: 'percent',
            height: 100,
            width: 90,
            minusheight: rbbarheight
        });
    }
    fr.addObject({
        object: ".fullfull",
        type: 'percent',
        height: 100,
        width: 100
    });
    fr.addObject({
        type: 'callback',
        callback: resize
    });
    fr.start();
    ps = new positioner();
    ps.addObject({
        object: ".vcenter",
        type: "center",
        axis: 'y'
    });
    ps.addObject({
        object: ".center",
        type: "center"
    });
    ps.start();
    pageM = new pageManager(topState);
    pageM.add("page_select", pselect);
    pageM.add("page1", p1, "home");
    pageM.add("page2", p2, "hoewerkthet");
    pageM.add("page3", p3, "watkanikwinnen");
    pageM.add("page4", p4, "wingsopkantoor");
    pageM.add("page5", p5, "wingsteaminactie");
    pageM.add("page6", p6, "voorwaarden");
    pageM.add("page7", p7, "top10");
    pageM.add("end_nonwon", pend_nonwon);
    pageM.add("end_won", pend_won);
    pageM.add("end_won_form", pend_won_form);
    pageM.add("end_form", pend_form);
    pageM.add("page_bedankt", bedankt);
    pageM.add("empty", pempty);
    pageM.add("game", pgame);
    pageM.start();
    var h = window.location.hash.substring(1);
    switch (h) {
        case "hoewerkthet":
            pageM.set("page2");
            break;
        case "watkanikwinnen":
            pageM.set("page3");
            break;
        case "wingsopkantoor":
            pageM.set("page4");
            break;
        case "wingsteaminactie":
            pageM.set("page5");
            break;
        case "voorwaarden":
            pageM.set("page6");
            break;
        default:
            if (config['topage'] != "") {
                if (config['topage'] == "winnen") {
                    pageM.set("page3");
                    menuObject.show();
                } else if (config['topage'] == "wingsteam") {
                    pageM.set("page4");
                    menuObject.show();
                } else if (config['topage'] == "game2") {
                    skipintro = true;
                    pageM.set("game");
                } else {
                    pageM.set("page1");
                    if (!config['mobile']) {
                        menuObject.show();
                    }
                }
            } else {
                if (config['frombanner']) {
                    pageM.set("game");
                } else {
                    if (config['country'] == 'be' && config['languageset'] == "") {
                        pageM.set("page_select");
                    } else {
                        pageM.set("page1");
                        if (!config['mobile']) {
                            menuObject.show();
                        }
                    }
                }
            }
            break;
    }
    fr.resize();
    ps.resize();
    makeGlobalListeners();
}

function playOrContinueGame() {
    pageM.backenabled = false;
    if (currentstate != 'game') {
        if (config['mobile']) {
            if (tt.seto("l", copy['draaigame'])) {
                pageM.set("game");
            } else {
                waitingstate = "game";
            }
        } else {
            pageM.set("game");
        }
    } else {
        if (pageM.get("game").cs.active == true && pageM.get("game").cs.paused == true && pageM.get("game").cs.started == true) {
            track("game_resume");
            pageM.get("game").resume();
            menuObject.hide();
        } else if (pageM.get("game").cs.active == true && pageM.get("game").cs.paused == true && pageM.get("game").cs.started == false) {
            track("game_retry");
            pageM.get("game").start();
            pageM.set("empty");
            menuObject.hide();
        } else if (pageM.get("game").cs.active == false && pageM.get("game").cs.paused == false && pageM.get("game").cs.started == true) {
            track("game_retry");
            pageM.get("game").start();
            pageM.set("empty");
            menuObject.hide(true);
        } else {
            console.log(pageM.get("game").cs.active, pageM.get("game").cs.paused, pageM.get("game").cs.started);
        }
    }
}

function makeGlobalListeners() {
    $(".speelbutton").on("click", function() {
        playOrContinueGame();
    })
    $(".replaybutton").on("click", function() {
        pageM.get("game").start();
        pageM.set("empty");
    })
    $(".menubutton").on("click", function() {
        menuObject.show();
    });
    $(".voorwaardenbutton").on("click", function() {
        openVoorwaarden();
    });
    $(".soundbutton").on("click", function() {
        var o = $(this);
        if (muted == false) {
            muted = true;
            o.find("#sound").hide();
            o.find("#mute").show();
            vido.prop('muted', true);
            snd.mute();
        } else {
            muted = false;
            o.find("#sound").show();
            o.find("#mute").hide();
            vido.prop('muted', false);
            snd.unmute();
        }
    });
    if (config['mobile']) {
        $(".bar #closebutton").on("click", function() {
            if (currentstate != 'game') {
                pageM.set("page1");
            } else {
                playOrContinueGame();
                showButtons();
            }
        });
        $(".bar #backbutton").on("click", function() {
            if (currentstate != 'game') {
                pageM.set("page1");
            } else {
                playOrContinueGame();
                showButtons();
            }
        });
    }
}

function showButtons() {
    if (config['mobile']) {
        $(".basicbutton").show();
        TweenMax.to(".basicbutton", 0.5, {
            alpha: 1
        });
    }
}

function hideButtons2() {
    $(".basicbutton").hide();
}

function hideButtons() {
    if (config['mobile']) {
        TweenMax.to(".basicbutton", 0.5, {
            alpha: 0,
            onComplete: hideButtons2
        });
    }
}

function openVoorwaarden() {
    window.open(getPath() + "terms");
}

function shareFacebook() {
    track("/sharefacebook");
    var share = getPath();
    if (punten != 0) {
        share = getPath() + "?s=" + punten;
    }
    window.open("https://www.facebook.com/sharer/sharer.php?u=" + share);
}

function shareMail() {
    track("/sharemail");
    var text = copy["description1"];
    if (punten != 0) {
        text = copy["description_points"]
        if (copy["share_mail"]) {
            text = copy['share_mail'];
        }
        text = copy["description_points"].replace("[points]", punten);
    }
    document.location.href = "mailto:?subject=" + copy['share_title2'] + "&body=" + text + " " + copy['share_link'];
}

function shareTwitter() {
    track("/sharetwitter");
    var share = copy["share_link"];
    track("/sharetwitter");
    var text = copy["description3"] + " " + copy["share_link"];
    text = copy["description3"].replace("[points]", punten);
    window.open("http://twitter.com/share?url=" + encodeURIComponent(share) + "&text=" + encodeURIComponent(text));
}

function shareLinkedin() {
    track("/sharelinkedin");
    var share = getPath();
    if (punten != 0) {
        share = getPath() + "?s=" + punten;
    }
    window.open("https://www.linkedin.com/cws/share?url=" + share);
}

function setScale() {
    if (config['mobile']) {
        var ww = ($(window).width() < window.screen.width) ? $(window).width() : window.screen.width;
        var mw = 480;
        var ratio = ww / mw;
        if (is("android") && is("chrome") == false) {
            $('#Viewport').attr('content', 'initial-scale=' + ratio + ', maximum-scale=' + ratio + ', minimum-scale=' + ratio + ', user-scalable=no, width=480');
        } else {
            $('#Viewport').attr('content', 'initial-scale=' + ratio + ', maximum-scale=' + ratio + ', minimum-scale=' + ratio + ', user-scalable=yes, width=' + ww);
        }
    }
}
$(function() {
    setScale();
    vido = $("#bgvid");
    var vogel = $("#birdimage");
    var vw = 215;
    vogel.css("width", 0);

    function loadChanged(type, percent) {
        vogel.css("width", (vw / 100) * percent);
        console.log('loadchanged ', type, percent);
        if (type == 'complete') {
            var endtime = getMS();
            console.log('loaded in ', (endtime - starttime) / 1000);
            $("#loader").remove();
            init();
        }
    }
    fa.loadChanged.add(loadChanged);
    fa.preload();
    starttime = getMS();
});
copy = []
copy['small_mail'] = "Olá,<br><br>Recebemos o seu contato para a visita das nossas Wings e ficamos muito felizes pelo interesse em recebê-las no seu escritório.<br><br>Como a visita depende tanto da disponibilidade da equipe como da localização geográfica do seu escritório, estamos avaliando se a visita será possível e em caso positivo, entraremos em contato em breve para agendarmos.<br><br>Porém se as Wings não conseguirem te visitar, não desanime! Você ainda poderá tentar descolar uma geladeira de Red Bull para manter o seu foco e dos seus colegas de trabalho!<br><br>Obrigado,<br><br>Equipe Red Bull";
copy['big_mail'] = "Olá,<br><br>Recebemos o seu contato para a visita das nossas Wings e ficamos muito felizes pelo interesse em recebê-las no seu escritório.<br><br>Como a visita depende tanto da disponibilidade da equipe como da localização geográfica do seu escritório, estamos avaliando se a visita será possível e em caso positivo, entraremos em contato em breve para agendarmos.<br><br>Porém se as Wings não conseguirem te visitar, não desanime! Você ainda poderá tentar descolar uma geladeira de Red Bull para manter o seu foco e dos seus colegas de trabalho!<br><br>Obrigado,<br><br>Equipe Red Bull";
copy['mail_subject'] = "Wings Team no seu escritório";
copy['mail_from'] = "Red Bull Foco";
copy['mail_from_email'] = "redbullfoco@br.redbull.com";
copy['share_title1'] = "Precisa de foco? Descole uma geladeira de Red Bull para o seu escritório.";
copy['share_title2'] = "Precisa de foco? Descole uma geladeira de Red Bull para o seu escritório.";
copy['description1'] = "Teste o seu foco e veja se é capaz de substituí-la. Eu joguei e ganhei [points] pontos #foconotrabalho #tedáasas";
copy['description2'] = "Precisando de uma assistente pessoal? Participe do Jogo Foco e concorra a uma geladeira de Red Bull para o seu escritório.";
copy['description3'] = "Você tem foco para me vencer? Eu joguei e consegui [points] pontos #foconotrabalho #tedáasas";
copy['share_link'] = "http://www.redbullfoco.com.br";
copy['share_mail'] = "Jogue e teste se você está focado suficiente. Eu joguei e ganhei [points] pontos em ";
copy['description_points'] = "Você tem foco suficiente para substituí-la? Eu tentei e obtive [points] pontos no Jogo Foco.";
copy['description_points2'] = "Focado suficiente para me vencer? Eu joguei e ganhei [points] pontos.";
copy['draai'] = "Gire seu telefone";
copy['draaigame'] = "Gire seu telefone<br>para começar o jogo";
copy['draaicontinue'] = "Gire seu telefone<br>para continuar jogando";
copy['skip'] = "Pular";
copy['nujij'] = "Sua vez!";
copy['speel'] = "Jogar";
copy['speelverder'] = "JOGAR DE NOVO";
copy['speelopnieuw'] = "Jogar novamente";
copy['bevestig'] = "Confirmar";
copy['netjes'] = "Muito bem!";
copy['menu_hoewerkthet'] = "Como funciona?";
copy['menu_top10'] = "RANKING";
copy['menu_winnen'] = "O que posso ganhar?";
copy['menu_wingsteam'] = "Wings Team no seu escritório";
copy['menu_wingsteamactie'] = "Wings Team em ação";
copy['menu_cartoons'] = "Mais Cartoons Red Bull";
copy['menu_planet'] = "My Wings";
copy['menu_voorwaarden'] = "REGULAMENTO";
copy['menu_watziterin'] = "Red Bull – conheça os ingredientes";
copy['page1_title'] = "PRECISA DE FOCO?";
copy['page1_subtitle'] = "ENTÃO DESCOLE UMA GELADEIRA<br>DE RED BULL PARA SEU ESCRITÓRIO.";
copy['page1_button1'] = "O que posso ganhar?";
copy['page1_button2'] = "Como funciona?";
copy['page2_1'] = "Memorize a ordem em que os telefones tocam e, em seguida, clique nos telefones seguindo a mesma ordem.";
copy['page2_2'] = "Este jogo dura apenas 45 segundos. Então quanto mais rápido você repetir as séries na ordem certa, mais pontos você ganha.";
copy['page2_3'] = "semanalmente, os jogadores com a maior pontuação poderão ganhar uma geladeira de Red Bull para o seu escritório.*<br><br>* Veja o regulamento";
copy['page3_copy1'] = "A assistente pessoal que vai manter você e o seus colegas focados o dia todo.";
copy['page3_copy2'] = "JÁ IMAGINOU TER UMA GELADEIRA DE RED BULL EM SEU ESCRITÓRIO?";
copy['page3_copy2b'] = "Uma geladeira de Red Bull.";
copy['page3_copy3'] = "Semanalmente, você poderá ganhar uma geladeira de Red Bull para seu escritório";
copy['page4_title'] = "Wings Team no seu escritório.";
copy['page4_copy'] = "Quer convidar as Wings para uma visita ao seu escritório? Então clique em “agendar visita”, preencha os dados e caso a visita seja possível, entraremos em contato para informa-lo.";
copy['page4_button'] = "Agendar visita";
copy['page4_title2'] = "<nobr>INFORMAÇÕES PARA VISITA</nobr>";
copy['page4_copy2'] = "Entraremos em contato em breve no ";
copy['page4_title3'] = "Obrigado!";
copy['page4_button2'] = "enviar";
copy['page5_title'] = "Wings Team em ação";
copy['page5_copy'] = "As Wings são jovens cheias de energia que distribuem asas às pessoas quando elas mais precisam em seus charmosos minis!";
copy['form_voornaam'] = "Nome";
copy['form_achternaam'] = "Sobrenome";
copy['form_bedrijf'] = "Empresa";
copy['form_plaats'] = "Cidade";
copy['form_email'] = "E-mail";
copy['form_postcode'] = "CEP";
copy['form_collegas'] = "Nº DE FUNCIONÁRIOS";
copy['form_phone'] = "número de telefone";
copy['form_straatnummer'] = "Rua, número e complemento";
copy['form_voorwaarden'] = "Li e concordo com os <span class='voorwaardenbutton'><u>termos e condições gerais</u></span><br><br>*Visita sujeita à disponibilidade da equipe e da localização geográfica da sua empresa.";
copy['form_voorwaarden2'] = "Li e concordo com os <span class='voorwaardenbutton'><u>termos e condições gerais</u></span>";
copy['form_wings'] = "Agendar visita ";
copy['end_nonwon_title'] = "Sua pontuação:";
copy['end_nonwon_body'] = "Você está precisando de mais foco! Convide as Wings Team para o seu escritório ou tente jogar novamente.";
copy['end_nonwon_button1'] = "Convide as Wings Team";
copy['end_won_title1'] = "Parabéns! Neste momento você está entre os";
copy['end_won_title2'] = "melhores da semana";
copy['end_won_body'] = "Envie suas informações e concorra a uma geladeira de Red Bull para o seu escritório. Semanalmente, os melhores jogadores serão os escolhidos e você e seus colegas poderão ganhar uma assistente pessoal para manter o foco no trabalho.";
copy['end_won_button1'] = "ENVIE SUAS INFORMAÇÕES";
copy['end_won_form_title1'] = "Informe seus dados";
copy['end_won_form_title2'] = "Estamos quase lá";
copy['end_won_form_body1'] = "Assim podemos entrar em contato caso você seja um dos ganhadores";
copy['end_won_form_body2'] = "Ainda precisamos de algumas informações para poder confirmar a visita das Wings Team ao seu escritório.";
copy['end_bedankt_copy1'] = "Entraremos em contato com você o mais rápido possível pelo [email].";
copy['end_bedankt_copy2'] = "Caso você seja um dos ganhadores, nós o avisaremos em breve.";
copy['end_bedankt_copy3'] = "Caso você tenha ganhado, nós o avisaremos!<br><br>Entraremos em contato com você o mais rápido possível pelo [email]";
copy['end_bedankt_share'] = "Compartilhe sua pontuação e desafie seus colegas";
copy['game_screen1_title'] = "Parece fácil, né?";
copy['game_screen1_subtitle'] = "Assuma o lugar da<br>Sra.Valéria e teste o seu foco!";
copy['game_screen1_subtitle2'] = "Assuma o lugar da<br>Sra.Valéria e teste o seu foco!";
copy['game_spraakwolk1_body1'] = "Ah, você é o(a) substituto da Sra. Valéria. Logo você vai receber vários telefonemas. Se prepare!";
copy['game_spraakwolk1_body2'] = "Preste bastante atenção na ordem em que os telefones tocam. Assim que eles pararem de tocar, você deverá repetir a mesma ordem. Boa sorte!";
copy['game_spraakwolk1_button'] = "Começar";
copy['game_spraakwolk2_title'] = "Muito bem!";
copy['game_spraakwolk2_body'] = "Boa pontuação. Mas para ganhar, você deve obter mais do que [score].";
copy['game_spraakwolk3_title'] = "Bom trabalho!";
copy['game_spraakwolk3_body'] = "Você está focado hoje!";
copy['game_spraakwolk4_title'] = "Cade o seu foco?";
copy['game_spraakwolk4_body'] = "Você deve obter no mínimo [score] pontos para ficar entre os melhores.";
copy['link_watziterin'] = "http://energydrink-br.redbull.com/red-bull-energy-drink#whatsinside";
copy['link_planet'] = "http://mywings.redbull.com/br-pt/";
copy['link_cartoons'] = "http://cartoons.redbull.com/br-pt";
copy['game_score'] = "Pontuação";
copy['game_tijd'] = "Tempo";
copy['game_goed'] = "Correto";
copy['pauze'] = "PAUSADO";
copy['page7_title'] = "RANKING DA SEMANA";
copy['page7_nummer'] = "POSIÇÃO";
copy['page7_naam'] = "NOme";
copy['page7_bedrijf'] = "EMPRESA";
copy['page7_punten'] = "PONTUAÇÃO";
copy['ranking_disclaimer'] = "*Os resultados do ranking são renovados semanalmente – veja o regulamento.";