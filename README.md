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

The following TypeScript definitions have been tested to work (in terms of a simple translation and not it terms to produce a header that works without manual post processing):

* abs
* absolute
* accounting
* acc-wizard
* amazon-product-api
* AmCharts
* amplifyjs
* babylon
* box2dweb
* browserify
* d3
* devextreme
* dijit
* dojo
* easeljs
* ember
* ExtJS
* fabricjs
* fhir
* flot
* goJS
* google.maps
* gruntjs
* gulp
* jquery
* jquerymobile
* kendo-ui
* LeapMotionTS
* linq
* matter-js
* node
* office-js
* phonegap
* plottable
* preloadjs
* SenchaTouch
* socket.io
* soundjs
* sugar
* three
* titanium
* tweenjs
* typescript
* ui-grid
* webix
* winjs
* winrt

The following TypeScript definitions still fail for sure:

* angular
* baconjs
* evernote
* leaflet
* lodash
* mongodb
* nvd3


## Release History

* 0.4.0 Fixed issue with ambigiousness of parenthesized type and function types
* 0.3.8 Ability to convert URLs (especially from GitHub) as well
* 0.3.7 Improved source code generation
* 0.3.6 Basic support for several major libraries/framework (see list)
* 0.3.5 Improved compatibility 
* 0.3.4 Fixed several minor issues 
* 0.3.3 Function overload works 
* 0.3.2 Improved parsing and code generation
* 0.3.0 Improved parsing
* 0.2.0 Improved parsing significantly
* 0.1.0 Initial release