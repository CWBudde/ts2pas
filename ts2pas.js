#! /usr/bin/env node
/**
* ts2pas
* https://github.com/CWBudde/TS2Pas
*
* Copyright (c) 2016 Christian-W. Budde
* Licensed under the MIT license.
*/

var TObject={
	$ClassName: "TObject",
	$Parent: null,
	ClassName: function (s) { return s.$ClassName },
	ClassType: function (s) { return s },
	ClassParent: function (s) { return s.$Parent },
	$Init: function () {},
	Create: function (s) { return s },
	Destroy: function (s) { for (var prop in s) if (s.hasOwnProperty(prop)) delete s.prop },
	Destroy$: function(s) { return s.ClassType.Destroy(s) },
	Free: function (s) { if (s!==null) s.ClassType.Destroy(s) }
}
var Exception={
	$ClassName: "Exception",
	$Parent: TObject,
	$Init: function () { var FMessage="" },
	Create: function (s,Msg) { s.FMessage=Msg; return s }
}
function stringRepeat(s, n) {
    if (n<1) return '';
    var r = '';
    while (n > 0) {
        if (n & 1) r += s;
        n >>= 1, s += s;
    };
    return r;
};
function DupeString(s,n) { return stringRepeat(s,n) }
function $W(e) { return e.ClassType?e:Exception.Create($New(Exception),e.constructor.name+", "+e.message) }
function $New(c) { var i={ClassType:c}; c.$Init(i); return i }
function $Is(o,c) {
	if (o===null) return false;
	return $Inh(o.ClassType,c);
}
;
function $Inh(s,c) {
	if (s===null) return false;
	while ((s)&&(s!==c)) s=s.$Parent;
	return (s)?true:false;
}
;
function $Extend(base, sub, props) {
	function F() {};
	F.prototype = base.prototype;
	sub.prototype = new F();
	sub.prototype.constructor = sub;
	for (var n in props) {
		if (props.hasOwnProperty(n)) {
			sub.prototype[n]=props[n];
		}
	}
}
function $AsIntf(o,i) {
	if (o===null) return null;
	var r = o.ClassType.$Intf[i].map(function (e) {
		return function () {
			var arg=Array.prototype.slice.call(arguments);
			arg.splice(0,0,o);
			return e.apply(o, arg);
		}
	});
	r.O = o;
	return r;
}
;
function $As(o,c) {
	if ((o===null)||$Is(o,c)) return o;
	throw Exception.Create($New(Exception),"Cannot cast instance of type \""+o.ClassType.$ClassName+"\" to class \""+c.$ClassName+"\"");
}
function JError() {
}
$Extend(Object,JError,
   {
   });

function Copy$TwriteFileSyncOptions(s,d) {
   d.encoding=s.encoding;
   d.mode=s.mode;
   d.flag=s.flag;
   return d;
}
function Clone$TwriteFileSyncOptions($) {
   return {
      encoding:$.encoding,
      mode:$.mode,
      flag:$.flag
   }
}
function Copy$TwriteFileOptions(s,d) {
   d.encoding=s.encoding;
   d.mode=s.mode;
   d.flag=s.flag;
   return d;
}
function Clone$TwriteFileOptions($) {
   return {
      encoding:$.encoding,
      mode:$.mode,
      flag:$.flag
   }
}
function Copy$TwatchOptions(s,d) {
   d.persistent=s.persistent;
   return d;
}
function Clone$TwatchOptions($) {
   return {
      persistent:$.persistent
   }
}
function Copy$TwatchFile_listener_object_fs(s,d) {
   d.curr=s.curr;
   d.prev=s.prev;
   return d;
}
function Clone$TwatchFile_listener_object_fs($) {
   return {
      curr:$.curr,
      prev:$.prev
   }
}
function Copy$TwatchFile_listener_object(s,d) {
   d.curr=s.curr;
   d.prev=s.prev;
   return d;
}
function Clone$TwatchFile_listener_object($) {
   return {
      curr:$.curr,
      prev:$.prev
   }
}
function Copy$TwatchFileOptions(s,d) {
   d.persistent=s.persistent;
   d.interval=s.interval;
   return d;
}
function Clone$TwatchFileOptions($) {
   return {
      persistent:$.persistent,
      interval:$.interval
   }
}
function Copy$TreadFileSyncOptions(s,d) {
   d.encoding=s.encoding;
   d.flag=s.flag;
   return d;
}
function Clone$TreadFileSyncOptions($) {
   return {
      encoding:$.encoding,
      flag:$.flag
   }
}
function Copy$TReadFileOptions(s,d) {
   d.encoding=s.encoding;
   d.flag=s.flag;
   return d;
}
function Clone$TReadFileOptions($) {
   return {
      encoding:$.encoding,
      flag:$.flag
   }
}
function Copy$TcreateWriteStreamOptions(s,d) {
   d.flags=s.flags;
   d.encoding=s.encoding;
   d.string_=s.string_;
   return d;
}
function Clone$TcreateWriteStreamOptions($) {
   return {
      flags:$.flags,
      encoding:$.encoding,
      string_:$.string_
   }
}
function Copy$TcreateReadStreamOptions(s,d) {
   d.bufferSize=s.bufferSize;
   d.encoding=s.encoding;
   d.fd=s.fd;
   d.mode=s.mode;
   d.flags=s.flags;
   return d;
}
function Clone$TcreateReadStreamOptions($) {
   return {
      bufferSize:$.bufferSize,
      encoding:$.encoding,
      fd:$.fd,
      mode:$.mode,
      flags:$.flags
   }
}
function Copy$TappendFileSyncOptions(s,d) {
   d.encoding=s.encoding;
   d.mode=s.mode;
   d.flag=s.flag;
   return d;
}
function Clone$TappendFileSyncOptions($) {
   return {
      encoding:$.encoding,
      mode:$.mode,
      flag:$.flag
   }
}
function Copy$TappendFileOptions(s,d) {
   d.encoding=s.encoding;
   d.mode=s.mode;
   d.flag=s.flag;
   return d;
}
function Clone$TappendFileOptions($) {
   return {
      encoding:$.encoding,
      mode:$.mode,
      flag:$.flag
   }
}
function fs() {
   var Result = null;
   Result = require("fs");
   return Result
};
function stream() {
   var Result = null;
   Result = require("stream");
   return Result
};
function events() {
   var Result = null;
   Result = require("events");
   return Result
};
var TTranslator = {
   $ClassName:"TTranslator",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.Name = "";
      $.FDeclarations = [];
      $.FInterfaces = [];
      $.FModules = [];
      $.FScanner = null;
   }
   ,AssumeIdentifier:function(Self) {
      if (!Self.FScanner.isIdentifier()) {
         TTranslator.HandleScanError(Self);
      }
   }
   ,AssumeToken$1:function(Self, Tokens) {
      if (!(Tokens.indexOf(Self.FScanner.getToken())>=0)) {
         TTranslator.HandleScanError(Self);
      }
   }
   ,AssumeToken:function(Self, Token) {
      if (Self.FScanner.getToken()!=Token) {
         TTranslator.HandleScanError(Self);
      }
   }
   ,BuildPascalHeader:function(Self) {
      var Result = "";
      var a$78 = 0;
      var Declaration = null,
         a$79 = 0;
      var Module$1 = null,
         a$80 = 0;
      var Interface = null;
      var a$81 = [],
          a$82 = [],
          a$83 = [];
      Result = "unit "+Self.Name+";"+"\r\n"+"\r\n";
      Result+="interface"+"\r\n"+"\r\n";
      a$83 = Self.FDeclarations;
      var $temp1;
      for(a$78=0,$temp1=a$83.length;a$78<$temp1;a$78++) {
         Declaration = a$83[a$78];
         Result = Result+TCustomExpression.GetAsCode$(Declaration);
      }
      a$82 = Self.FModules;
      var $temp2;
      for(a$79=0,$temp2=a$82.length;a$79<$temp2;a$79++) {
         Module$1 = a$82[a$79];
         Result = Result+TCustomExpression.GetAsCode$(Module$1);
      }
      a$81 = Self.FInterfaces;
      var $temp3;
      for(a$80=0,$temp3=a$81.length;a$80<$temp3;a$80++) {
         Interface = a$81[a$80];
         Result = Result+TCustomExpression.GetAsCode$(Interface);
      }
      return Result
   }
   ,Create$3:function(Self) {
      return Self
   }
   ,HandleScanError:function(Self) {
      throw Exception.Create($New(Exception),("Unknown token ("+Self.FScanner.getTokenText().toString()+") in this context. At pos "+Self.FScanner.getTokenPos().toString()));
   }
   ,ReadClassExpression:function(Self) {
      var Result = null;
      var List = [],
         Visibility$1 = 0,
         IsStatic$1 = false,
         Member = null;
      TTranslator.AssumeToken(Self,73);
      Result = TCustomExpression.Create$4$($New(TClassExpression),$AsIntf(Self,"IExpressionOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = Self.FScanner.getTokenText();
      console.log("Read class: "+Result.Name);
      TTranslator.ReadToken(Self);
      while (([83,106].indexOf(Self.FScanner.getToken())>=0)) {
         List = (Self.FScanner.getToken()==83)?Result.Extends:Result.Implements;
         TTranslator.ReadIdentifier(Self,true);
         List.push(TTranslator.ReadScopedName(Self));
         while (Self.FScanner.getToken()==24) {
            TTranslator.ReadIdentifier(Self,true);
            List.push(TTranslator.ReadScopedName(Self));
         }
      }
      TTranslator.AssumeToken(Self,15);
      while (TTranslator.ReadIdentifier(Self,false)) {
         Visibility$1 = 0;
         switch (Self.FScanner.getToken()) {
            case 112 :
               Visibility$1 = 0;
               TTranslator.ReadIdentifier(Self,true);
               break;
            case 111 :
               Visibility$1 = 1;
               TTranslator.ReadIdentifier(Self,true);
               break;
            case 110 :
               Visibility$1 = 2;
               TTranslator.ReadIdentifier(Self,true);
               break;
         }
         IsStatic$1 = Self.FScanner.getToken()==113;
         if (IsStatic$1) {
            TTranslator.ReadIdentifier(Self,true);
         }
         Member = TTranslator.ReadStructureMember(Self);
         Member.Visibility = Visibility$1;
         Member.IsStatic = IsStatic$1;
         Result.Members.push(Member);
      }
      return Result
   }
   ,ReadDeclarationExpression:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,122);
      Result = TCustomExpression.Create$4$($New(TDeclarationExpression),$AsIntf(Self,"IExpressionOwner"));
      while (TTranslator.ReadToken(Self)>0) {
         switch (Self.FScanner.getToken()) {
            case 122 :
               continue;
               break;
            case 102 :
               Result.Variables.push(TTranslator.ReadVariableExpression(Self));
               break;
            case 87 :
               Result.Functions.push(TTranslator.ReadFunctionExpression(Self));
               break;
            case 125 :
               Result.Modules.push(TTranslator.ReadModuleExpression(Self));
               break;
            case 107 :
               Result.Interfaces.push(TTranslator.ReadInterfaceExpression(Self));
               break;
            case 73 :
               Result.Classes.push(TTranslator.ReadClassExpression(Self));
               break;
            case 81 :
               TTranslator.ReadEnumerationExpression(Self);
               break;
            case 1 :
               return Result;
               break;
            default :
               TTranslator.HandleScanError(Self);
         }
      }
      return Result
   }
   ,ReadDefinition:function(Self) {
      while (TTranslator.ReadToken(Self)>0) {
         switch (Self.FScanner.getToken()) {
            case 82 :
               continue;
               break;
            case 122 :
               Self.FDeclarations.push(TTranslator.ReadDeclarationExpression(Self));
               break;
            case 107 :
               Self.FInterfaces.push(TTranslator.ReadInterfaceExpression(Self));
               break;
            case 125 :
               Self.FModules.push(TTranslator.ReadModuleExpression(Self));
               break;
            case 89 :
               TTranslator.ReadImportExpression(Self);
               break;
            case 1 :
               return;
               break;
            default :
               TTranslator.HandleScanError(Self);
         }
      }
   }
   ,ReadEnumerationExpression:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,81);
      Result = TCustomExpression.Create$4$($New(TEnumerationExpression),$AsIntf(Self,"IExpressionOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = Self.FScanner.getTokenText();
      TTranslator.ReadToken$1(Self,15,true);
      TTranslator.ReadIdentifier(Self,true);
      do {
         Result.Items.push(TTranslator.ReadEnumerationItem(Self));
      } while (!(!TTranslator.ReadIdentifier(Self,false)));
      TTranslator.AssumeToken(Self,16);
      return Result
   }
   ,ReadEnumerationItem:function(Self) {
      var Result = null;
      TTranslator.AssumeIdentifier(Self);
      Result = TCustomExpression.Create$4$($New(TEnumerationItem),$AsIntf(Self,"IExpressionOwner"));
      Result.Name = Self.FScanner.getTokenText();
      if (TTranslator.ReadToken$1(Self,56,false)) {
         TTranslator.ReadToken$1(Self,8,true);
         Result.Value = Self.FScanner.getTokenText();
         TTranslator.ReadToken(Self);
      }
      TTranslator.AssumeToken(Self,24);
      return Result
   }
   ,ReadFieldExpression:function(Self) {
      var Result = null;
      Result = TCustomExpression.Create$4$($New(TFieldExpression),$AsIntf(Self,"IExpressionOwner"));
      Result.Type = TTranslator.ReadType(Self);
      TTranslator.AssumeToken(Self,23);
      return Result
   }
   ,ReadFunctionExpression:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,102);
      Result = TCustomExpression.Create$4$($New(TFunctionExpression),$AsIntf(Self,"IExpressionOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = Self.FScanner.getTokenText();
      TTranslator.ReadToken$1(Self,17,true);
      Result.Type = TTranslator.ReadFunctionType(Self);
      return Result
   }
   ,ReadFunctionParameter:function(Self) {
      var Result = null;
      TTranslator.AssumeIdentifier(Self);
      Result = TCustomExpression.Create$4$($New(TFunctionParameter),$AsIntf(Self,"IExpressionOwner"));
      Result.Name = Self.FScanner.getTokenText();
      TTranslator.ReadToken$2(Self,[53, 54, 18].slice(),true);
      Result.Nullable = Self.FScanner.getToken()==53;
      if (Result.Nullable) {
         TTranslator.ReadToken$1(Self,54,true);
      }
      if (Self.FScanner.getToken()==54) {
         Result.Type = TTranslator.ReadType(Self);
      }
      return Result
   }
   ,ReadFunctionType:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,17);
      Result = TCustomExpression.Create$4$($New(TFunctionType),$AsIntf(Self,"IExpressionOwner"));
      while (TTranslator.ReadIdentifier(Self,false)) {
         Result.Parameters.push(TTranslator.ReadFunctionParameter(Self));
         TTranslator.AssumeToken$1(Self,[24, 18].slice());
         if (Self.FScanner.getToken()==18) {
            break;
         }
      }
      TTranslator.AssumeToken(Self,18);
      if (TTranslator.ReadToken$2(Self,[54, 34].slice(),false)) {
         Result.ResultType = TTranslator.ReadType(Self);
      }
      return Result
   }
   ,ReadIdentifier:function(Self, Required) {
      var Result = false;
      TTranslator.ReadToken(Self);
      Result = Self.FScanner.isIdentifier();
      if ((!Result)&&Required) {
         TTranslator.HandleScanError(Self);
      }
      return Result
   }
   ,ReadImportExpression:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,89);
      Result = TCustomExpression.Create$4$($New(TImportExpression),$AsIntf(Self,"IExpressionOwner"));
      return Result
   }
   ,ReadInterfaceExpression:function(Self) {
      var Result = null;
      var List$1 = [];
      TTranslator.AssumeToken(Self,107);
      Result = TCustomExpression.Create$4$($New(TInterfaceExpression),$AsIntf(Self,"IExpressionOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = Self.FScanner.getTokenText();
      console.log("Read interface: "+Result.Name);
      TTranslator.ReadToken(Self);
      while (([83,106].indexOf(Self.FScanner.getToken())>=0)) {
         List$1 = (Self.FScanner.getToken()==83)?Result.Extends:Result.Implements;
         TTranslator.ReadIdentifier(Self,true);
         List$1.push(TTranslator.ReadScopedName(Self));
         while (Self.FScanner.getToken()==24) {
            TTranslator.ReadIdentifier(Self,true);
            List$1.push(TTranslator.ReadScopedName(Self));
         }
      }
      TTranslator.AssumeToken(Self,15);
      while (TTranslator.ReadIdentifier(Self,false)) {
         Result.Members.push(TTranslator.ReadStructureMember(Self));
      }
      return Result
   }
   ,ReadMethodExpression:function(Self) {
      var Result = null;
      Result = TCustomExpression.Create$4$($New(TMethodExpression),$AsIntf(Self,"IExpressionOwner"));
      Result.Type = TTranslator.ReadFunctionType(Self);
      TTranslator.AssumeToken(Self,23);
      return Result
   }
   ,ReadModuleExpression:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,125);
      Result = TCustomExpression.Create$4$($New(TModuleExpression),$AsIntf(Self,"IExpressionOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = TTranslator.ReadScopedName(Self);
      console.log("Read module: "+Result.Name);
      TTranslator.AssumeToken(Self,15);
      while (TTranslator.ReadToken$2(Self,[73, 82, 81, 89, 107, 102].slice(),false)) {
         switch (Self.FScanner.getToken()) {
            case 73 :
               Result.Classes.push(TTranslator.ReadClassExpression(Self));
               break;
            case 82 :
               continue;
               break;
            case 81 :
               TTranslator.ReadEnumerationExpression(Self);
               break;
            case 89 :
               TTranslator.ReadImportExpression(Self);
               break;
            case 107 :
               Result.Interfaces.push(TTranslator.ReadInterfaceExpression(Self));
               break;
            case 102 :
               Result.Variables.push(TTranslator.ReadVariableExpression(Self));
               break;
            default :
               TTranslator.HandleScanError(Self);
         }
      }
      TTranslator.AssumeToken(Self,16);
      return Result
   }
   ,ReadObjectType:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,15);
      Result = TCustomExpression.Create$4$($New(TObjectType),$AsIntf(Self,"IExpressionOwner"));
      while (Self.FScanner.scan()!=16) {
         /* null */
      }
      return Result
   }
   ,ReadScopedName:function(Self) {
      var Result = "";
      TTranslator.AssumeIdentifier(Self);
      Result = Self.FScanner.getTokenText();
      while (TTranslator.ReadToken$1(Self,21,false)) {
         TTranslator.ReadIdentifier(Self,true);
         Result+="."+Self.FScanner.getTokenText();
      }
      return Result
   }
   ,ReadStructureMember:function(Self) {
      var Result = null;
      var MemberName = "",
         Nullable$2 = false;
      TTranslator.AssumeIdentifier(Self);
      MemberName = Self.FScanner.getTokenText();
      TTranslator.ReadToken$2(Self,[53, 54, 17].slice(),true);
      Nullable$2 = Self.FScanner.getToken()==53;
      if (Nullable$2) {
         TTranslator.ReadToken$1(Self,54,true);
      }
      switch (Self.FScanner.getToken()) {
         case 54 :
            Result = TTranslator.ReadFieldExpression(Self);
            $As(Result,TFieldExpression).Nullable = Nullable$2;
            break;
         case 17 :
            Result = TTranslator.ReadMethodExpression(Self);
            break;
      }
      Result.Name = MemberName;
      TTranslator.AssumeToken(Self,23);
      return Result
   }
   ,ReadToken$2:function(Self, Tokens$1, Required$1) {
      var Result = false;
      Result = Tokens$1.indexOf(TTranslator.ReadToken(Self))>=0;
      if ((!Result)&&Required$1) {
         TTranslator.HandleScanError(Self);
      }
      return Result
   }
   ,ReadToken$1:function(Self, Token$1, Required$2) {
      var Result = false;
      Result = TTranslator.ReadToken(Self)==Token$1;
      if ((!Result)&&Required$2) {
         TTranslator.HandleScanError(Self);
      }
      return Result
   }
   ,ReadToken:function(Self) {
      var Result = 0;
      Result = Self.FScanner.scan();
      return Result
   }
   ,ReadType:function(Self) {
      var Result = null;
      TTranslator.ReadToken$2(Self,[69, 117, 15, 128, 130, 120, 103, 17].slice(),true);
      switch (Self.FScanner.getToken()) {
         case 69 :
            Result = TNamedType.Create$5($New(TNamedType),$AsIntf(Self,"IExpressionOwner"),TTranslator.ReadScopedName(Self));
            break;
         case 117 :
            Result = TCustomExpression.Create$4$($New(TVariantType),$AsIntf(Self,"IExpressionOwner"));
            TTranslator.ReadToken(Self);
            break;
         case 128 :
            Result = TCustomExpression.Create$4$($New(TFloatType),$AsIntf(Self,"IExpressionOwner"));
            TTranslator.ReadToken(Self);
            break;
         case 103 :
            Result = null;
            TTranslator.ReadToken(Self);
            break;
         case 130 :
            Result = TCustomExpression.Create$4$($New(TStringType),$AsIntf(Self,"IExpressionOwner"));
            TTranslator.ReadToken(Self);
            break;
         case 120 :
            Result = TCustomExpression.Create$4$($New(TBooleanType),$AsIntf(Self,"IExpressionOwner"));
            TTranslator.ReadToken(Self);
            break;
         case 17 :
            Result = TTranslator.ReadFunctionType(Self);
            return Result;
            break;
         case 15 :
            Result = TTranslator.ReadObjectType(Self);
            TTranslator.ReadToken(Self);
            break;
      }
      if (Self.FScanner.getToken()==19) {
         Result.IsArray = true;
         TTranslator.ReadToken$1(Self,20,true);
         TTranslator.ReadToken(Self);
      }
      return Result
   }
   ,ReadVariableExpression:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,87);
      Result = TCustomExpression.Create$4$($New(TVariableExpression),$AsIntf(Self,"IExpressionOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = Self.FScanner.getTokenText();
      TTranslator.ReadToken$1(Self,54,true);
      return Result
   }
   ,Translate:function(Self, Source) {
      var Result = "";
      Self.FScanner = TypeScriptExport.createScanner(0,true,0,Source);
      try {
         TTranslator.ReadDefinition$(Self);
      } catch ($e) {
         var e = $W($e);
         console.log(e.FMessage)      }
      Result = TTranslator.BuildPascalHeader$(Self);
      return Result
   }
   ,Destroy:TObject.Destroy
   ,BuildPascalHeader$:function($){return $.ClassType.BuildPascalHeader($)}
   ,ReadDefinition$:function($){return $.ClassType.ReadDefinition($)}
};
TTranslator.$Intf={
   IExpressionOwner:[]
}
var TNodeFlags = { 1:"Export", 2:"Ambient", 4:"Public", 8:"Private", 16:"Protected", 32:"Static", 64:"Abstract", 128:"Async", 256:"Default", 512:"MultiLine", 1024:"Synthetic", 2048:"DeclarationFile", 4096:"Let", 8192:"Const", 16384:"OctalLiteral", 32768:"Namespace", 65536:"ExportContext", 131072:"ContainsThis" };
var TJsxFlags = { 1:"None", 2:"IntrinsicNamedElement", 4:"IntrinsicIndexedElement", 8:"ClassElement", 16:"UnknownElement" };
var TDiagnosticCategory = [ "Warning", "Error", "Message" ];
var TVisibility = [ "vPublic", "vProtected", "vPrivate" ];
var TCustomExpression = {
   $ClassName:"TCustomExpression",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FOwner = null;
   }
   ,BeginIndention:function(Self) {
      ++IndentionLevel;
   }
   ,Create$4:function(Self, Owner) {
      Self.FOwner = Owner;
      return Self
   }
   ,EndIndention:function(Self) {
      --IndentionLevel;
   }
   ,GetIndentionString:function(Self) {
      var Result = "";
      Result = DupeString("  ",IndentionLevel);
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4$:function($){return $.ClassType.Create$4.apply($.ClassType, arguments)}
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TCustomType = {
   $ClassName:"TCustomType",$Parent:TCustomExpression
   ,$Init:function ($) {
      TCustomExpression.$Init($);
      $.IsArray = false;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = TCustomType.GetName$(Self);
      if (Self.IsArray) {
         Result = "array of "+Result;
      }
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TVariantType = {
   $ClassName:"TVariantType",$Parent:TCustomType
   ,$Init:function ($) {
      TCustomType.$Init($);
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = "Variant";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode:TCustomType.GetAsCode
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TNamedExpression = {
   $ClassName:"TNamedExpression",$Parent:TCustomExpression
   ,$Init:function ($) {
      TCustomExpression.$Init($);
      $.Name = "";
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode:TCustomExpression.GetAsCode
};
var TVariableExpression = {
   $ClassName:"TVariableExpression",$Parent:TNamedExpression
   ,$Init:function ($) {
      TNamedExpression.$Init($);
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TStructureExpression = {
   $ClassName:"TStructureExpression",$Parent:TNamedExpression
   ,$Init:function ($) {
      TNamedExpression.$Init($);
      $.Members = [];
      $.Implements = [];
      $.Extends = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      var a$84 = 0;
      var Extend = "",
         a$85 = 0;
      var Member$1 = null;
      var a$86 = [],
          a$87 = [];
      Result = TCustomExpression.GetIndentionString(Self.ClassType);
      Result+="J"+Self.Name+" = class external '"+Self.Name+"'";
      a$87 = Self.Extends;
      var $temp4;
      for(a$84=0,$temp4=a$87.length;a$84<$temp4;a$84++) {
         Extend = a$87[a$84];
         Result+=" \/\/ extends "+Extend;
      }
      Result+="\r\n";
      TCustomExpression.BeginIndention(Self.ClassType);
      a$86 = Self.Members;
      var $temp5;
      for(a$85=0,$temp5=a$86.length;a$85<$temp5;a$85++) {
         Member$1 = a$86[a$85];
         Result+=TCustomExpression.GetAsCode$(Member$1);
      }
      TCustomExpression.EndIndention(Self.ClassType);
      Result+=TCustomExpression.GetIndentionString(Self.ClassType)+"end;";
      Result+="\r\n"+"\r\n";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TStringType = {
   $ClassName:"TStringType",$Parent:TCustomType
   ,$Init:function ($) {
      TCustomType.$Init($);
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = "Boolean";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode:TCustomType.GetAsCode
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TObjectType = {
   $ClassName:"TObjectType",$Parent:TCustomType
   ,$Init:function ($) {
      TCustomType.$Init($);
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = "record";
      return Result
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = "{ object definition placeholder }";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TNamedType = {
   $ClassName:"TNamedType",$Parent:TCustomType
   ,$Init:function ($) {
      TCustomType.$Init($);
      $.FName = "";
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = Self.FName;
      return Result
   }
   ,Create$5:function(Self, Owner$1, AName) {
      TCustomExpression.Create$4(Self,Owner$1);
      Self.FName = AName;
      return Self
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode:TCustomType.GetAsCode
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TModuleExpression = {
   $ClassName:"TModuleExpression",$Parent:TNamedExpression
   ,$Init:function ($) {
      TNamedExpression.$Init($);
      $.Variables = [];
      $.Interfaces = [];
      $.Classes = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      var a$88 = 0;
      var Class = null,
         a$89 = 0;
      var Interface$1 = null,
         a$90 = 0;
      var Variable = null;
      if (Self.Classes.length>0) {
         var a$91 = [];
         Result+="type"+"\r\n";
         TCustomExpression.BeginIndention(Self.ClassType);
         a$91 = Self.Classes;
         var $temp6;
         for(a$88=0,$temp6=a$91.length;a$88<$temp6;a$88++) {
            Class = a$91[a$88];
            Result = Result+TCustomExpression.GetAsCode$(Class);
         }
         TCustomExpression.EndIndention(Self.ClassType);
      }
      if (Self.Interfaces.length>0) {
         var a$92 = [];
         Result+="type"+"\r\n";
         TCustomExpression.BeginIndention(Self.ClassType);
         a$92 = Self.Interfaces;
         var $temp7;
         for(a$89=0,$temp7=a$92.length;a$89<$temp7;a$89++) {
            Interface$1 = a$92[a$89];
            Result = Result+TCustomExpression.GetAsCode$(Interface$1);
         }
         TCustomExpression.EndIndention(Self.ClassType);
      }
      if (Self.Variables.length>0) {
         var a$93 = [];
         Result+="var"+"\r\n";
         TCustomExpression.BeginIndention(Self.ClassType);
         a$93 = Self.Variables;
         var $temp8;
         for(a$90=0,$temp8=a$93.length;a$90<$temp8;a$90++) {
            Variable = a$93[a$90];
            Result = Result+TCustomExpression.GetAsCode$(Variable);
         }
         TCustomExpression.EndIndention(Self.ClassType);
      }
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TCustomStructureMember = {
   $ClassName:"TCustomStructureMember",$Parent:TNamedExpression
   ,$Init:function ($) {
      TNamedExpression.$Init($);
      $.Visibility = 0;
      $.IsStatic = false;
   }
   ,Create$4:function(Self, Owner$2) {
      TCustomExpression.Create$4(Self,Owner$2);
      Self.Visibility = 0;
      return Self
   }
   ,Destroy:TObject.Destroy
   ,Create$4$:function($){return $.ClassType.Create$4.apply($.ClassType, arguments)}
   ,GetAsCode:TCustomExpression.GetAsCode
};
var TMethodExpression = {
   $ClassName:"TMethodExpression",$Parent:TCustomStructureMember
   ,$Init:function ($) {
      TCustomStructureMember.$Init($);
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = TCustomExpression.GetIndentionString(Self.ClassType)+"function "+Self.Name;
      if (Self.Type) {
         Result+=TCustomExpression.GetAsCode$(Self.Type);
      }
      Result+=";"+"\r\n";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomStructureMember.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TInterfaceExpression = {
   $ClassName:"TInterfaceExpression",$Parent:TStructureExpression
   ,$Init:function ($) {
      TStructureExpression.$Init($);
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode:TStructureExpression.GetAsCode
};
var TImportExpression = {
   $ClassName:"TImportExpression",$Parent:TNamedExpression
   ,$Init:function ($) {
      TNamedExpression.$Init($);
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TFunctionType = {
   $ClassName:"TFunctionType",$Parent:TCustomType
   ,$Init:function ($) {
      TCustomType.$Init($);
      $.ResultType = null;
      $.Parameters = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      var Index = 0;
      if (Self.Parameters.length>0) {
         Result = "("+TCustomExpression.GetAsCode$(Self.Parameters[0]);
         var $temp9;
         for(Index=0+1,$temp9=Self.Parameters.length;Index<$temp9;Index++) {
            Result+="; "+TCustomExpression.GetAsCode$(Self.Parameters[Index]);
         }
         Result+=")";
      }
      if (Self.ResultType) {
         Result+=": "+TCustomExpression.GetAsCode$(Self.ResultType);
      }
      return Result
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = "function";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TFunctionParameter = {
   $ClassName:"TFunctionParameter",$Parent:TNamedExpression
   ,$Init:function ($) {
      TNamedExpression.$Init($);
      $.Type = null;
      $.Nullable = false;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = Self.Name+": ";
      if (Self.Type) {
         Result+=TCustomExpression.GetAsCode$(Self.Type);
      } else {
         Result+="Variant";
      }
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TFunctionExpression = {
   $ClassName:"TFunctionExpression",$Parent:TNamedExpression
   ,$Init:function ($) {
      TNamedExpression.$Init($);
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = TCustomExpression.GetAsCode$(Self.Type);
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TFloatType = {
   $ClassName:"TFloatType",$Parent:TCustomType
   ,$Init:function ($) {
      TCustomType.$Init($);
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = "Float";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode:TCustomType.GetAsCode
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TFieldExpression = {
   $ClassName:"TFieldExpression",$Parent:TCustomStructureMember
   ,$Init:function ($) {
      TCustomStructureMember.$Init($);
      $.Nullable = false;
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = TCustomExpression.GetIndentionString(Self.ClassType)+Self.Name+": "+TCustomExpression.GetAsCode$(Self.Type)+";";
      if (Self.Nullable) {
         Result+=" \/\/ nullable";
      }
      Result+="\r\n";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomStructureMember.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TEnumerationItem = {
   $ClassName:"TEnumerationItem",$Parent:TCustomExpression
   ,$Init:function ($) {
      TCustomExpression.$Init($);
      $.Name = $.Value = "";
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TEnumerationExpression = {
   $ClassName:"TEnumerationExpression",$Parent:TNamedExpression
   ,$Init:function ($) {
      TNamedExpression.$Init($);
      $.Items = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TDefinitionExpression = {
   $ClassName:"TDefinitionExpression",$Parent:TNamedExpression
   ,$Init:function ($) {
      TNamedExpression.$Init($);
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TDeclarationExpression = {
   $ClassName:"TDeclarationExpression",$Parent:TNamedExpression
   ,$Init:function ($) {
      TNamedExpression.$Init($);
      $.Variables = [];
      $.Modules = [];
      $.Classes = [];
      $.Functions = [];
      $.Interfaces = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      var a$94 = 0;
      var Function$2 = null,
         a$95 = 0;
      var Module$2 = null,
         a$96 = 0;
      var Class$1 = null,
         a$97 = 0;
      var Interface$2 = null,
         a$98 = 0;
      var Variable$1 = null;
      var a$99 = [],
          a$100 = [];
      a$100 = Self.Functions;
      var $temp10;
      for(a$94=0,$temp10=a$100.length;a$94<$temp10;a$94++) {
         Function$2 = a$100[a$94];
         Result+=TCustomExpression.GetAsCode$(Function$2);
      }
      a$99 = Self.Modules;
      var $temp11;
      for(a$95=0,$temp11=a$99.length;a$95<$temp11;a$95++) {
         Module$2 = a$99[a$95];
         Result+=TCustomExpression.GetAsCode$(Module$2);
      }
      if (Self.Classes.length>0) {
         var a$101 = [];
         Result+="type"+"\r\n";
         TCustomExpression.BeginIndention(Self.ClassType);
         a$101 = Self.Classes;
         var $temp12;
         for(a$96=0,$temp12=a$101.length;a$96<$temp12;a$96++) {
            Class$1 = a$101[a$96];
            Result = Result+TCustomExpression.GetAsCode$(Class$1);
         }
         TCustomExpression.EndIndention(Self.ClassType);
      }
      if (Self.Interfaces.length>0) {
         var a$102 = [];
         Result+="type"+"\r\n";
         TCustomExpression.BeginIndention(Self.ClassType);
         a$102 = Self.Interfaces;
         var $temp13;
         for(a$97=0,$temp13=a$102.length;a$97<$temp13;a$97++) {
            Interface$2 = a$102[a$97];
            Result = Result+TCustomExpression.GetAsCode$(Interface$2);
         }
         TCustomExpression.EndIndention(Self.ClassType);
      }
      if (Self.Variables.length>0) {
         var a$103 = [];
         Result+="var"+"\r\n";
         TCustomExpression.BeginIndention(Self.ClassType);
         a$103 = Self.Variables;
         var $temp14;
         for(a$98=0,$temp14=a$103.length;a$98<$temp14;a$98++) {
            Variable$1 = a$103[a$98];
            Result = Result+TCustomExpression.GetAsCode$(Variable$1);
         }
         TCustomExpression.EndIndention(Self.ClassType);
      }
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TClassExpression = {
   $ClassName:"TClassExpression",$Parent:TStructureExpression
   ,$Init:function ($) {
      TStructureExpression.$Init($);
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode:TStructureExpression.GetAsCode
};
var TBooleanType = {
   $ClassName:"TBooleanType",$Parent:TCustomType
   ,$Init:function ($) {
      TCustomType.$Init($);
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = "Boolean";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomExpression.Create$4
   ,GetAsCode:TCustomType.GetAsCode
   ,GetName$:function($){return $.ClassType.GetName($)}
};
function ConvertFile(InputFile, OutputFile) {
   FileSystem.readFile(InputFile,function (err, data) {
      var InputText = "",
         Translator = null,
         OutputText = "";
      InputText = data.toString("utf8");
      Translator = TTranslator.Create$3($New(TTranslator));
      Translator.Name = (InputFile).split(".")[0];
      OutputText = TTranslator.Translate(Translator,InputText);
      FileSystem.writeFile(OutputFile,OutputText,function (err$1) {
      });
      Translator = null;
   });
};
var TypeScriptExport = null;
var TypeScriptExport = require("typescript");
var IndentionLevel = 0;
var FileSystem = null;
FileSystem = fs();

var userArgs = process.argv.slice(2);
if (userArgs.length == 0) {
  return 'Usage: ts2pas inputfile [outputfile]';
} 
var inputFile = userArgs[0];
var outputfile = userArgs[0]+".pas"; 
if (userArgs.length == 2)
  outputfile = userArgs[1];

ConvertFile(inputFile, outputfile);