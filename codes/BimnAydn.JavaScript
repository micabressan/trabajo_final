	module.exports = function  (grunt) {
	var config = {};


	//setup the configuration object
	var jshint;

	//all tasks that must be loaded.
	var tasks = [
			'grunt-contrib-jshint'
			,'grunt-contrib-watch'
			,'grunt-contrib-concat'
			,'grunt-contrib-uglify'
			,'grunt-contrib-jasmine'
			,'grunt-contrib-sass'
			,'grunt-contrib-handlebars'
	];

		//handlebars ===============================

		var hbs;
		config.handlebars = hbs = {};

		hbs.dist = {
			options: {
				namespace: "myapp.templates"
				,processName: function(path) {
					console.log("=>", path);
					return path.replace(/^templates\/(.*?)\.hbs$/, "$1");
				}
			}
			,files: {
				"tmp/templates.js": "templates/**/*.hbs"
			}
		};	

		//concat ===============================

		var concat;
		config.concat = concat = {};

		concat.dev = {
			files: {
				"public/myapp.development.js": [
					"lib/vendor"
					,"node_modules/handlebars-runtime/handlebars.runtime.js"
					,"tmp/templates.js"
					,"lib/**/*.js"
					,"calc/**/*.js"
				]
			}
		};


		//uglify ===============================
		config.uglify = {dist: {
			options: {sourceMap:"public/myapp.production.js.map", report:"gzip"}
			,files: {
				"public/myapp.production.js": ["public/myapp.development.js"]
			}
		}}


		//jasmine ===============================
		var jasmine;
		config.jasmine = jasmine = {};

		jasmine.calc = {
			src:"calc/calc.js"
			, options:{
				specs: "spec/calc.spec.js"
			}
		};


	config.jshint = jshint ={};


	jshint.dist = {
	options: {jshintrc: ".jshintrc"},
	files: {all: ["lib/main.js","lib/test.js"]}
	};

	//Watch ===============================

	config.watch = {
		 scripts: {
		 	files: ["lib/**/*.js", "calc/**/*.js" , "spec/**/*.js", "scss/**/*.scss"]
		 	,tasks: ["dev"]
		 }
	}

	jshint.dev = {
	options: {jshintrc: ".jshintrc.dev"},
	files: {all: ["lib/main.js","lib/test.js"]}
	};


	//Sass ===============================
	var sass;
	config.sass = sass = {};

//production
	sass.dist = {
		options: { style: "compressed"}
		, files: {
			"public/myapp.production.css" : "scss/main.scss"
		}
	};

	//development env.
		sass.dev = {
		options: { style: "expanded", lineNumber: true}
		, files: {
			"public/myapp.development.css" : "scss/main.scss"
		}
	};


	

	//Register custom tasks ===============================
	grunt.registerTask('default',['dev']);
	grunt.registerTask('dev',['jshint:dev','jasmine','handlebars', 'concat:dev', 'sass:dev']);
	grunt.registerTask('dist',['jshint:dist','jasmine', 'handlebars', 'concat:dev', 'uglify' , 'sass:dist']);


	//General setup ===============================
	grunt.initConfig(config);
	tasks.forEach(grunt.loadNpmTasks);

};