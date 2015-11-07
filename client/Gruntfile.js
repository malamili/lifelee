/*jslint node: true */
'use strict';

var pkg = require('./package.json');

//Using exclusion patterns slows down Grunt significantly
//instead of creating a set of patterns like '**/*.js' and '!**/node_modules/**'
//this method is used to create a set of inclusive patterns for all subdirectories
//skipping node_modules, bower_components, dist, and any .dirs
//This enables users to create any directory structure they desire.
var createFolderGlobs = function(fileTypePatterns) {
  fileTypePatterns = Array.isArray(fileTypePatterns) ? fileTypePatterns : [fileTypePatterns];
  var ignore = ['node_modules','bower_components','dist','tmp', 'server'];
  var fs = require('fs');
  return fs.readdirSync(process.cwd())
          .map(function(file){
            if (ignore.indexOf(file) !== -1 ||
                file.indexOf('.') === 0 ||
                !fs.lstatSync(file).isDirectory()) {
              return null;
            } else {
              return fileTypePatterns.map(function(pattern) {
                return file + '/**/' + pattern;
              });
            }
          })
          .filter(function(patterns){
            return patterns;
          })
          .concat(fileTypePatterns);
};

module.exports = function (grunt) {

  // load all grunt tasks
  require('load-grunt-tasks')(grunt);

  // Project configuration.
  grunt.initConfig({
    connect: {
      main: {
        options: {
          livereload: 35730,
          open: false,
          port: 9000,
          hostname: 'localhost',
          base: ['.','src']
        }
      }
    },

    watch: {
      main: {
        options: {
            livereload: 35730,
            livereloadOnError: false,
            spawn: false
        },
        files: [createFolderGlobs(['*.js','*.less','*.html','*.coffee']),'!_SpecRunner.html','!.grunt'],
        tasks: [] //all the tasks are run dynamically during the watch event handler
      }
    },

    clean: {
      before:{
        src:['dist','tmp']
      },
      after: {
        src:['tmp']
      },
      temp: {
        src:['tmp']
      }
    },

    // Automatically inject Bower components into the app
    wiredep: {
      app: {
        src: ['src/index.html'],
        cwd: 'src',
        bowerJson: require('./bower.json'),
        directory: 'bower_components',
        ignorePath: '../',
        exclude: ['bower_components/socket.io-client', 'bower_components/cuid', 'bower_components/x-editable']
      }
    },

    coffeelint: {
      app: ['src/**/*.coffee'],
      options: {
        'arrow_spacing': {
          'level': 'error'
        },
        'braces_spacing' : {
          empty_object_spaces: 0,
          'level': 'error'
        },
        'colon_assignment_spacing': {
          'spacing': {
            'left': 0,
            'right': 1,
          },
          'level': 'error'
        },
        'cyclomatic_complexity': {
          'level':'warn'
        },
        'max_line_length': {
          'value': 120,
          'level': 'error'
        },
        'newlines_after_classes' : {
          'level': 'ignore'
        },
        'no_debugger' : {
          'level': 'error'
        },
        'no_empty_functions' : {
          'level': 'ignore'
        },
        'no_empty_param_list' : {
          'level': 'error'
        },
        'no_implicit_braces': {
          'level': 'ignore'
        },
        'no_implicit_parens': {
          'level': 'ignore'
        },
        'no_this': {
          'level': 'error'
        },
        'prefer_english_operator': {
          'level': 'error'
        }
      }

    },

    // Compiles CoffeeScript to JavaScript
    coffee: {
      main: {
        options: {
          sourceRoot: '',
          sourceMap: false  // Enable when coffee is also copied to tmp
        },
        src: createFolderGlobs('*.coffee'),
        dest: 'tmp',
        expand: true,
        ext: '.js'
      },
    },

    less: {
      production: {
        options: {
        },
        files: {
          'tmp/lifelee.css': 'src/lifelee.less'
        }
      }
    },

    // Validates HTML with AngularJS in mind for custom tags/attributes and file templates.
    htmlangular: {
      options: {
        tmplext: 'ng.html',
        customtags: [
          'weaver-*'
        ],
        customattrs: [
          // Weaver attributes and tags from weaver directive
          'weaver-*',

          // Script tags for dom-munger
          'in-production',

          // Right click context menu
          'context-menu',

          // Bootstrap Tooltip
          'tooltip',
          'tooltip-placement',

          // Editable
          'editable-text',
          'editable-textarea',
          'onaftersave',
          'e-form'
        ],
        reportpath: null
      },
      files: {
        src: ['src/**/*.html', 'src/**/*.ng.html']
      },
    },

    ngtemplates: {
      main: {
        options: {
            module: pkg.name,
            htmlmin:'<%= htmlmin.main.options %>'
        },
        src: [createFolderGlobs('*.html'),'!src/index.html','!_SpecRunner.html'],
        dest: 'tmp/templates.js'
      }
    },

    copy: {
      main: {
        files: [
          {cwd: 'src/img/', src: ['**'], dest: 'dist/img/', expand: true},
          {src: ['bower_components/font-awesome/fonts/**'], dest: 'dist/',filter:'isFile',expand:true},
          {src: ['bower_components/bootstrap/fonts/**'], dest: 'dist/',filter:'isFile',expand:true}
          //{client: ['bower_components/angular-ui-utils/ui-utils-ieshiv.min.js'], dest: 'dist/'},
          //{client: ['bower_components/select2/*.png','bower_components/select2/*.gif'], dest:'dist/css/',flatten:true,expand:true},
          //{client: ['bower_components/angular-mocks/angular-mocks.js'], dest: 'dist/'}
        ]
      }
    },

    dom_munger:{
      read: {
        options: {
          read:[
            {selector:'script[in-production!="false"]',attribute:'src',writeto:'appjs'},
            {selector:'link[rel="stylesheet"][in-production!="false"]',attribute:'href',writeto:'appcss'}
          ]
        },
        src: 'src/index.html'
      },
      update: {
        options: {
          remove: ['script','link[rel="stylesheet"]'],
          append: [
            {selector:'body',html:'<script src="lifelee.js"></script>'},
            {selector:'head',html:'<link rel="stylesheet" href="lifelee.css">'}
          ]
        },
        src:'src/index.html',
        dest: 'dist/index.html'
      }
    },

    cssmin: {
      main: {
        src:['tmp/lifelee.css','<%= dom_munger.data.appcss %>'],
        dest:'dist/lifelee.css'
      }
    },

    concat: {
      main: {
        src: ['<%= dom_munger.data.appjs %>','<%= ngtemplates.main.dest %>'],
        dest: 'tmp/lifelee.js'
      }
    },

    ngAnnotate: {
      main: {
        src:'tmp/lifelee.js',
        dest: 'tmp/lifelee.js'
      }
    },

    uglify: {
      main: {
        src: 'tmp/lifelee.js',
        dest:'dist/lifelee.js'
      }
    },

    htmlmin: {
      main: {
        options: {
          collapseBooleanAttributes: true,
          collapseWhitespace: true,
          removeAttributeQuotes: true,
          removeComments: true,
          removeEmptyAttributes: true,
          removeScriptTypeAttributes: true,
          removeStyleLinkTypeAttributes: true
        },
        files: {
          'dist/index.html': 'dist/index.html'
        }
      }
    },

    imagemin: {
       main:{
         files: [{
           expand: true, cwd:'dist/',
           src:['**/{*.png,*.jpg}'],
           dest: 'dist/'
         }]
       }
     },

    karma: {
      options: {
        frameworks: ['jasmine'],
        files: [  //this files data is also updated in the watch handler, if updated change there too
          '<%= dom_munger.data.appjs %>',
          'bower_components/angular-mocks/angular-mocks.js',
          createFolderGlobs('*-spec.js')
        ],
        logLevel:'ERROR',
        reporters:['mocha'],
        autoWatch: false, //watching is handled by grunt-contrib-watch
        singleRun: true
      },
      all_tests: {
        browsers: ['PhantomJS','Chrome','Firefox']
      },
      during_watch: {
        browsers: ['PhantomJS']
      },
    }
  });

  grunt.registerTask('serve', ['clean:temp', 'coffee', 'connect', 'watch']);
  grunt.registerTask('wire', ['wiredep']);
  grunt.registerTask('build',['clean:before', 'coffeelint', 'coffee','less', 'htmlangular', 'dom_munger','ngtemplates','cssmin','concat','ngAnnotate','uglify','copy', 'htmlmin','imagemin','clean:after']);


  grunt.event.on('watch', function(action, filepath) {
    //https://github.com/gruntjs/grunt-contrib-watch/issues/156

    var tasksToRun = [];

    if (filepath.lastIndexOf('.coffee') !== -1 && filepath.lastIndexOf('.coffee') === filepath.length - 7) {
      tasksToRun.push('coffee');
    }

    if (filepath.lastIndexOf('.js') !== -1 && filepath.lastIndexOf('.js') === filepath.length - 3) {

      //find the appropriate unit test for the changed file
      var spec = filepath;
      if (filepath.lastIndexOf('-spec.js') === -1 || filepath.lastIndexOf('-spec.js') !== filepath.length - 8) {
        spec = filepath.substring(0,filepath.length - 3) + '-spec.js';
      }

      //if the spec exists then lets run it
      if (grunt.file.exists(spec)) {
        var files = [].concat(grunt.config('dom_munger.data.appjs'));
        files.push('bower_components/angular-mocks/angular-mocks.js');
        files.push(spec);
        grunt.config('karma.options.files', files);
        tasksToRun.push('karma:during_watch');
      }
    }

    //if index.html changed, we need to reread the <script> tags so our next run of karma
    //will have the correct environment
    if (filepath === 'src/index.html') {
      tasksToRun.push('dom_munger:read');
    }

    grunt.config('watch.main.tasks',tasksToRun);

  });
};
