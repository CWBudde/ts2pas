#! /usr/bin/env node
/**
* ts2pas
* https://github.com/CWBudde/TS2Pas
*
* Copyright (c) 2016 Christian-W. Budde
* Licensed under the MIT license.
*/

var userArgs = process.argv.slice(2);
if (userArgs.length == 0) {
  return 'Usage: ts2pas inputfile [outputfile]';
} 
var inputFile = userArgs[0];

var fs = require("fs");
var ts = require("typescript");

function ScanText(text) {
   var Scanner = null;
   Scanner = ts.createScanner(0,true,0,text);
   while (Scanner.scan()>1) {
      console.log(Scanner.getTokenText())   }
};

fs.readFile(inputFile,function (err, data) {
   var text = data.toString("utf8");
   ScanText(text)
});