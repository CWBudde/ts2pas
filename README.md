ts2pas
======

A tool to convert TypeScript definition files to DWScript based Object Pascal headers. A lot of TypeScript definitions can be found at [Definitely Typed](http://DefinitelyTyped.org/).

The Object Pascal output can be used in DWScript based compilers as can be found in Smart Mobile Studio or the DWSWebServer.

At the moment the tool is not ready for productional use. Moreover, the produced output often has to be post processed manually in order to have the proper order of classes for example (and eventually to provide some forward definitions).    

## Installation

  npm install -g ts2pas

## Usage

  ts2pas inputfile.d.ts [outputfile.pas]

## Tested definitions

The following TypeScript definitions have been tested to work:

* abs
* absolute
* accounting
* acc-wizard
* amazon-product-api
* AmCharts
* amplifyjs
* box2dweb
* d3
* dijit
* easeljs
* ExtJS
* flot
* jquery
* jquerymobile
* LeapMotionTS
* linq
* matter-js
* node
* phonegap
* preloadjs
* socket.io
* soundjs
* three
* tweenjs
* typescript

The following TypeScript definitions still fail for sure:

* angular
* google.maps
* mongodb


## Release History

* 0.3.5 Improved compatibility 
* 0.3.4 Fixed several minor issues 
* 0.3.3 Function overload works 
* 0.3.2 Improved parsing and code generation
* 0.3.0 Improved parsing
* 0.2.0 Improved parsing significantly
* 0.1.0 Initial release