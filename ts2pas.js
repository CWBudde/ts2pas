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
      $.NeedsSemicolon = false;
      $.Name = "";
      $.FDeclarations = [];
      $.FInterfaces = [];
      $.FModules = [];
      $.FScanner = $.FSourceFile = null;
   }
   ,a$2:function(Self) {
      return Self.FScanner.getTokenText();
   }
   ,a$1:function(Self) {
      return Self.FScanner.getToken();
   }
   ,AssumeIdentifier:function(Self, AdditionalToken) {
      if (!(Self.FScanner.isIdentifier()||AdditionalToken.indexOf(TTranslator.a$1(Self))>=0)) {
         TTranslator.HandleScanError(Self,0);
      }
   }
   ,AssumeToken$1:function(Self, Tokens) {
      if (!(Tokens.indexOf(TTranslator.a$1(Self))>=0)) {
         TTranslator.HandleScanError(Self,0);
      }
   }
   ,AssumeToken:function(Self, Token) {
      if (TTranslator.a$1(Self)!=Token) {
         TTranslator.HandleScanError(Self,Token);
      }
   }
   ,BuildPascalHeader:function(Self) {
      var Result = "";
      var a$125 = 0;
      var Declaration = null,
         a$126 = 0;
      var Module$1 = null,
         a$127 = 0;
      var Interface = null;
      var a$128 = [],
          a$129 = [],
          a$130 = [];
      Result = "unit "+Self.Name+";"+"\r\n"+"\r\n";
      Result+="interface"+"\r\n"+"\r\n";
      a$130 = Self.FDeclarations;
      var $temp1;
      for(a$125=0,$temp1=a$130.length;a$125<$temp1;a$125++) {
         Declaration = a$130[a$125];
         Result = Result+TCustomDeclaration.GetAsCode$(Declaration);
      }
      a$129 = Self.FModules;
      var $temp2;
      for(a$126=0,$temp2=a$129.length;a$126<$temp2;a$126++) {
         Module$1 = a$129[a$126];
         Result = Result+TCustomDeclaration.GetAsCode$(Module$1);
      }
      a$128 = Self.FInterfaces;
      var $temp3;
      for(a$127=0,$temp3=a$128.length;a$127<$temp3;a$127++) {
         Interface = a$128[a$127];
         Result = Result+TCustomDeclaration.GetAsCode$(Interface);
      }
      return Result
   }
   ,Create$3:function(Self) {
      Self.NeedsSemicolon = false;
      return Self
   }
   ,HandleScanError:function(Self, Expected) {
      var LineChar = null,
         Text$1 = "";
      LineChar = TypeScriptExport.getLineAndCharacterOfPosition(Self.FSourceFile,Self.FScanner.getTokenPos());
      Text$1 = ("Unknown token \""+TTranslator.a$2(Self).toString()+"\" in this context ("+(LineChar.line+1).toString()+":"+(LineChar.character+1).toString()+")");
      if (Expected>0) {
         Text$1+=("; Expected ("+Expected.toString()+")");
      }
      console.trace("");
      throw Exception.Create($New(Exception),Text$1);
   }
   ,ReadAmbientBinding:function(Self) {
      var Result = null;
      TTranslator.ReadIdentifier(Self,true);
      Result = TCustomDeclaration.Create$4$($New(TAmbientBinding),$AsIntf(Self,"IDeclarationOwner"));
      Result.BindingIdentifier = TTranslator.a$2(Self);
      if (TTranslator.ReadToken$1(Self,54,false)) {
         Result.Type = TTranslator.ReadTypeAnnotation(Self);
      }
      if (Self.NeedsSemicolon) {
         TTranslator.AssumeToken$1(Self,[23, 24].slice());
      }
      return Result
   }
   ,ReadAmbientClassDeclaration:function(Self) {
      var Result = null;
      var ClassElementTokens = [],
         Visibility$1 = 0,
         IsStatic$1 = false,
         Member = null;
      TTranslator.AssumeToken(Self,73);
      Result = TCustomDeclaration.Create$4$($New(TAmbientClassDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = TTranslator.a$2(Self);
      TTranslator.ReadToken$2(Self,[83, 106, 15].slice(),true);
      if (TTranslator.a$1(Self)==83) {
         TTranslator.ReadIdentifier(Self,true);
         Result.Extends.push(TTranslator.ReadTypeReference(Self));
      }
      if (TTranslator.a$1(Self)==106) {
         TTranslator.ReadIdentifier(Self,true);
         Result.Implements.push(TTranslator.ReadIdentifierPath(Self));
         while (TTranslator.a$1(Self)==24) {
            TTranslator.ReadIdentifier(Self,true);
            Result.Implements.push(TTranslator.ReadIdentifierPath(Self));
         }
      }
      TTranslator.AssumeToken(Self,15);
      ClassElementTokens.push(92, 9, 82, 16, 23);
      TTranslator.ReadIdentifier$1(Self,ClassElementTokens,false);
      while (TTranslator.a$1(Self)!=16) {
         Visibility$1 = 0;
         switch (TTranslator.a$1(Self)) {
            case 112 :
               Visibility$1 = 0;
               TTranslator.ReadIdentifier$1(Self,[92].slice(),true);
               break;
            case 111 :
               Visibility$1 = 1;
               TTranslator.ReadIdentifier$1(Self,[92].slice(),true);
               break;
            case 110 :
               Visibility$1 = 2;
               TTranslator.ReadIdentifier$1(Self,[92].slice(),true);
               break;
         }
         IsStatic$1 = TTranslator.a$1(Self)==113;
         if (IsStatic$1) {
            TTranslator.ReadIdentifier$1(Self,[92, 17].slice(),true);
         }
         Member = TTranslator.ReadAmbientClassMember(Self);
         Member.Visibility = Visibility$1;
         Member.IsStatic = IsStatic$1;
         Result.Members.push(Member);
         if (TTranslator.a$1(Self)==23) {
            TTranslator.ReadIdentifier$1(Self,ClassElementTokens,false);
         }
      }
      TTranslator.AssumeToken(Self,16);
      return Result
   }
   ,ReadAmbientClassMember:function(Self) {
      var Result = null;
      var MemberName = "",
         Nullable$2 = false;
      TTranslator.AssumeIdentifier(Self,[92, 17, 9, 82].slice());
      if (TTranslator.a$1(Self)==17) {
         Result = TTranslator.ReadCallbackInterface(Self);
      } else {
         MemberName = TTranslator.a$2(Self);
         TTranslator.ReadToken$2(Self,[25, 53, 54, 17].slice(),true);
         if (TTranslator.a$1(Self)==25) {
            TTranslator.ReadTypeParameter(Self);
            TTranslator.ReadToken$2(Self,[53, 54, 17].slice(),true);
         }
         Nullable$2 = TTranslator.a$1(Self)==53;
         if (Nullable$2) {
            TTranslator.ReadToken$1(Self,54,true);
         }
         switch (TTranslator.a$1(Self)) {
            case 54 :
               Result = TTranslator.ReadFieldDeclaration(Self);
               $As(Result,TFieldDeclaration).Nullable = Nullable$2;
               break;
            case 17 :
               if ((MemberName).toLowerCase()=="constructor") {
                  Result = TTranslator.ReadConstructorDeclaration(Self);
               } else {
                  Result = TTranslator.ReadMethodDeclaration(Self);
               }
               break;
         }
         Result.Name = MemberName;
      }
      if (Self.NeedsSemicolon) {
         TTranslator.AssumeToken$1(Self,[23, 24, 16].slice());
      }
      return Result
   }
   ,ReadAmbientDeclaration:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,122);
      Result = TCustomDeclaration.Create$4$($New(TAmbientDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadToken$2(Self,[102, 108, 74, 87, 73, 81, 125, 126].slice(),true);
      switch (TTranslator.a$1(Self)) {
         case 102 :
         case 108 :
         case 74 :
            Result.Variables.push(TTranslator.ReadAmbientVariableDeclaration(Self));
            break;
         case 87 :
            Result.Functions.push(TTranslator.ReadAmbientFunctionDeclaration(Self));
            break;
         case 73 :
            Result.Classes.push(TTranslator.ReadAmbientClassDeclaration(Self));
            break;
         case 81 :
            Result.Enums.push(TTranslator.ReadAmbientEnumDeclaration(Self));
            break;
         case 125 :
            Result.Modules.push(TTranslator.ReadAmbientModuleDeclaration(Self));
            break;
         case 126 :
            Result.Namespaces.push(TTranslator.ReadAmbientNamespaceDeclaration(Self));
            break;
      }
      return Result
   }
   ,ReadAmbientEnumDeclaration:function(Self) {
      var Result = null;
      return Result
   }
   ,ReadAmbientFunctionDeclaration:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,87);
      Result = TCustomDeclaration.Create$4$($New(TAmbientFunctionDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.BindingIdentifier = TTranslator.a$2(Self);
      Result.CallSignature = TTranslator.ReadCallSignature(Self);
      if (Self.NeedsSemicolon) {
         TTranslator.AssumeToken$1(Self,[23].slice());
      }
      return Result
   }
   ,ReadAmbientModuleDeclaration:function(Self) {
      var Result = null;
      var ModuleTokens = [],
         ModuleTokens = [82, 102, 87, 73, 107, 81, 125, 89, 16, 23].slice();
      var IsExport = false;
      TTranslator.AssumeToken(Self,125);
      Result = TCustomDeclaration.Create$4$($New(TAmbientModuleDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier$1(Self,[9].slice(),true);
      Result.IdentifierPath = TTranslator.ReadIdentifierPath(Self);
      TTranslator.AssumeToken(Self,15);
      TTranslator.ReadToken$2(Self,ModuleTokens,true);
      while (TTranslator.a$1(Self)!=16) {
         IsExport = TTranslator.a$1(Self)==82;
         if (IsExport) {
            TTranslator.ReadToken$2(Self,ModuleTokens.concat([77, 56]),true);
            if (TTranslator.a$1(Self)==77) {
               IsExport = false;
               TTranslator.ReadIdentifier(Self,false);
               TTranslator.ReadToken$1(Self,23,false);
               TTranslator.ReadToken$2(Self,ModuleTokens,true);
            }
            if (TTranslator.a$1(Self)==56) {
               IsExport = false;
               TTranslator.ReadIdentifier(Self,false);
               TTranslator.ReadToken$1(Self,23,false);
               TTranslator.ReadToken$2(Self,ModuleTokens,true);
            }
         }
         switch (TTranslator.a$1(Self)) {
            case 102 :
               Result.Variables.push(TTranslator.ReadAmbientVariableDeclaration(Self));
               break;
            case 87 :
               Result.Functions.push(TTranslator.ReadAmbientFunctionDeclaration(Self));
               break;
            case 73 :
               Result.Classes.push(TTranslator.ReadAmbientClassDeclaration(Self));
               TTranslator.ReadToken$2(Self,ModuleTokens,true);
               break;
            case 125 :
               Result.Modules.push(TTranslator.ReadAmbientModuleDeclaration(Self));
               TTranslator.ReadToken$2(Self,ModuleTokens,true);
               break;
            case 107 :
               Result.Interfaces.push(TTranslator.ReadInterfaceDeclaration(Self));
               TTranslator.ReadToken$2(Self,ModuleTokens,true);
               break;
            case 89 :
               TTranslator.ReadImportDeclaration(Self);
               if (!Self.NeedsSemicolon) {
                  TTranslator.ReadToken$2(Self,ModuleTokens,true);
               }
               break;
         }
         if (TTranslator.a$1(Self)==23) {
            TTranslator.ReadToken$2(Self,ModuleTokens,true);
         }
      }
      TTranslator.AssumeToken(Self,16);
      return Result
   }
   ,ReadAmbientNamespaceDeclaration:function(Self) {
      var Result = null;
      return Result
   }
   ,ReadAmbientVariableDeclaration:function(Self) {
      var Result = null;
      TTranslator.AssumeToken$1(Self,[102, 108, 74].slice());
      Result = TCustomDeclaration.Create$4$($New(TAmbientVariableDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      Result.IsConst = TTranslator.a$1(Self)==74;
      do {
         Result.AmbientBindingList.push(TTranslator.ReadAmbientBinding(Self));
      } while (!(TTranslator.a$1(Self)==23||(!Self.NeedsSemicolon)&&(!Self.FScanner.isIdentifier())));
      return Result
   }
   ,ReadCallbackInterface:function(Self) {
      var Result = null;
      Result = TCustomDeclaration.Create$4$($New(TCallbackDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      Result.Type = TTranslator.ReadFunctionType(Self);
      TTranslator.AssumeToken$1(Self,[23, 16].slice());
      return Result
   }
   ,ReadCallSignature:function(Self) {
      var Result = null;
      Result = TCustomDeclaration.Create$4$($New(TCallSignature),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadToken$2(Self,[17, 25].slice(),true);
      if (TTranslator.a$1(Self)==25) {
         TTranslator.ReadTypeParameter(Self);
         TTranslator.ReadToken$1(Self,17,true);
      }
      TTranslator.AssumeToken(Self,17);
      TTranslator.ReadIdentifier$1(Self,[112, 110, 111, 22, 18].slice(),true);
      while (TTranslator.a$1(Self)!=18) {
         Result.ParameterList.push(TTranslator.ReadParameter(Self));
         if (TTranslator.a$1(Self)==24) {
            TTranslator.ReadIdentifier$1(Self,[22].slice(),false);
         }
      }
      TTranslator.AssumeToken$1(Self,[18].slice());
      TTranslator.ReadToken$2(Self,[54, 23].slice(),true);
      if (TTranslator.a$1(Self)==54) {
         Result.Type = TTranslator.ReadType(Self);
      }
      return Result
   }
   ,ReadClassDeclaration:function(Self) {
      var Result = null;
      var ClassElementTokens$1 = [],
         Visibility$2 = 0,
         IsStatic$2 = false,
         Member$1 = null;
      TTranslator.AssumeToken(Self,73);
      Result = TCustomDeclaration.Create$4$($New(TClassDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = TTranslator.a$2(Self);
      console.log("Read class: "+Result.Name);
      TTranslator.ReadToken$2(Self,[83, 106, 15].slice(),true);
      if (TTranslator.a$1(Self)==83) {
         TTranslator.ReadIdentifier(Self,true);
         Result.Extends.push(TTranslator.ReadTypeReference(Self));
      }
      if (TTranslator.a$1(Self)==106) {
         TTranslator.ReadIdentifier(Self,true);
         Result.Implements.push(TTranslator.ReadIdentifierPath(Self));
         while (TTranslator.a$1(Self)==24) {
            TTranslator.ReadIdentifier(Self,true);
            Result.Implements.push(TTranslator.ReadIdentifierPath(Self));
         }
      }
      TTranslator.AssumeToken(Self,15);
      TTranslator.AssumeToken(Self,15);
      ClassElementTokens$1.push(92, 9, 82, 16, 23);
      TTranslator.ReadIdentifier$1(Self,ClassElementTokens$1,false);
      while (TTranslator.a$1(Self)!=16) {
         Visibility$2 = 0;
         switch (TTranslator.a$1(Self)) {
            case 112 :
               Visibility$2 = 0;
               TTranslator.ReadIdentifier$1(Self,[92].slice(),true);
               break;
            case 111 :
               Visibility$2 = 1;
               TTranslator.ReadIdentifier$1(Self,[92].slice(),true);
               break;
            case 110 :
               Visibility$2 = 2;
               TTranslator.ReadIdentifier$1(Self,[92].slice(),true);
               break;
         }
         IsStatic$2 = TTranslator.a$1(Self)==113;
         if (IsStatic$2) {
            TTranslator.ReadIdentifier$1(Self,[92, 17].slice(),true);
         }
         Member$1 = TTranslator.ReadAmbientClassMember(Self);
         Member$1.Visibility = Visibility$2;
         Member$1.IsStatic = IsStatic$2;
         Result.Members.push(Member$1);
         if (TTranslator.a$1(Self)==23) {
            TTranslator.ReadIdentifier$1(Self,ClassElementTokens$1,false);
         }
      }
      return Result
   }
   ,ReadClassMember:function(Self) {
      var Result = null;
      var MemberName$1 = "",
         Nullable$3 = false;
      TTranslator.AssumeIdentifier(Self,[92, 17, 9, 82].slice());
      if (TTranslator.a$1(Self)==17) {
         Result = TTranslator.ReadCallbackInterface(Self);
      } else {
         MemberName$1 = TTranslator.a$2(Self);
         TTranslator.ReadToken$2(Self,[25, 53, 54, 17].slice(),true);
         if (TTranslator.a$1(Self)==25) {
            TTranslator.ReadTypeParameter(Self);
            TTranslator.ReadToken$2(Self,[53, 54, 17].slice(),true);
         }
         Nullable$3 = TTranslator.a$1(Self)==53;
         if (Nullable$3) {
            TTranslator.ReadToken$1(Self,54,true);
         }
         switch (TTranslator.a$1(Self)) {
            case 54 :
               Result = TTranslator.ReadFieldDeclaration(Self);
               $As(Result,TFieldDeclaration).Nullable = Nullable$3;
               break;
            case 17 :
               if ((MemberName$1).toLowerCase()=="constructor") {
                  Result = TTranslator.ReadConstructorDeclaration(Self);
               } else {
                  Result = TTranslator.ReadMethodDeclaration(Self);
               }
               break;
         }
         Result.Name = MemberName$1;
      }
      if (Self.NeedsSemicolon) {
         TTranslator.AssumeToken$1(Self,[23, 24, 16].slice());
      }
      return Result
   }
   ,ReadConstructorDeclaration:function(Self) {
      var Result = null;
      Result = TCustomDeclaration.Create$4$($New(TConstructorDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      Result.Type = TTranslator.ReadFunctionType(Self);
      if (Self.NeedsSemicolon) {
         TTranslator.AssumeToken$1(Self,[23, 16].slice());
      }
      return Result
   }
   ,ReadConstructorSignature:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,92);
      Result = TCustomDeclaration.Create$4$($New(TConstructorDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      if (TTranslator.ReadIdentifier(Self,false)) {
         TTranslator.ReadToken$1(Self,17,false);
      }
      TTranslator.AssumeToken(Self,17);
      TTranslator.ReadIdentifier$1(Self,[112, 110, 111, 22, 18].slice(),true);
      while (TTranslator.a$1(Self)!=18) {
         Result.ParameterList.push(TTranslator.ReadParameter(Self));
         if (TTranslator.a$1(Self)==24) {
            TTranslator.ReadIdentifier$1(Self,[22].slice(),false);
         }
      }
      TTranslator.AssumeToken(Self,18);
      TTranslator.ReadToken$1(Self,54,true);
      Result.Type = TTranslator.ReadTypeAnnotation(Self);
      return Result
   }
   ,ReadDefinition:function(Self) {
      while (TTranslator.ReadToken$2(Self,[82, 122, 107, 125, 89, 1].slice(),true)) {
         {var $temp4 = TTranslator.a$1(Self);
            if ($temp4==82) {
               continue;
            }
             else if ($temp4==122) {
               Self.FDeclarations.push(TTranslator.ReadAmbientDeclaration(Self));
            }
             else if ($temp4==107) {
               Self.FInterfaces.push(TTranslator.ReadInterfaceDeclaration(Self));
            }
             else if ($temp4==125) {
               Self.FModules.push(TTranslator.ReadModuleDeclaration(Self));
            }
             else if ($temp4==89) {
               TTranslator.ReadImportDeclaration(Self)            }
             else if ($temp4==1) {
               break;
            }
         }
      }
   }
   ,ReadEnumerationDeclaration:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,81);
      Result = TCustomDeclaration.Create$4$($New(TEnumerationDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = TTranslator.a$2(Self);
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
      TTranslator.AssumeIdentifier(Self,[]);
      Result = TCustomDeclaration.Create$4$($New(TEnumerationItem),$AsIntf(Self,"IDeclarationOwner"));
      Result.Name = TTranslator.a$2(Self);
      if (TTranslator.ReadToken$1(Self,56,false)) {
         TTranslator.ReadToken$1(Self,8,true);
         Result.Value = TTranslator.a$2(Self);
         TTranslator.ReadToken(Self);
      }
      TTranslator.AssumeToken(Self,24);
      return Result
   }
   ,ReadExportDeclaration:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,82);
      Result = TCustomDeclaration.Create$4$($New(TExportDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier$1(Self,[77].slice(),true);
      Result.FDefault = TTranslator.a$1(Self)==82||(TTranslator.a$2(Self)).toLowerCase()=="default";
      if (Result.FDefault) {
         TTranslator.ReadIdentifier(Self,true);
      }
      Result.Name = TTranslator.a$2(Self);
      TTranslator.ReadToken$1(Self,23,true);
      return Result
   }
   ,ReadFieldDeclaration:function(Self) {
      var Result = null;
      Result = TCustomDeclaration.Create$4$($New(TFieldDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      Result.Type = TTranslator.ReadType(Self);
      if (Self.NeedsSemicolon) {
         TTranslator.AssumeIdentifier(Self,[23, 16, 24].slice());
      }
      return Result
   }
   ,ReadFunctionDeclaration:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,87);
      Result = TCustomDeclaration.Create$4$($New(TFunctionDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = TTranslator.a$2(Self);
      TTranslator.ReadToken$1(Self,17,true);
      Result.Type = TTranslator.ReadFunctionType(Self);
      return Result
   }
   ,ReadFunctionParameter:function(Self) {
      var Result = null;
      var OpenArray = false;
      TTranslator.AssumeIdentifier(Self,[22].slice());
      OpenArray = TTranslator.a$1(Self)==22;
      if (OpenArray) {
         TTranslator.ReadIdentifier(Self,true);
      }
      Result = TCustomDeclaration.Create$4$($New(TFunctionParameter),$AsIntf(Self,"IDeclarationOwner"));
      Result.Name = TTranslator.a$2(Self);
      TTranslator.ReadToken$2(Self,[53, 54, 18].slice(),true);
      Result.Nullable = TTranslator.a$1(Self)==53;
      if (Result.Nullable) {
         TTranslator.ReadToken$2(Self,[54].slice(),true);
      }
      if (TTranslator.a$1(Self)==54) {
         Result.Type = TTranslator.ReadType(Self);
      }
      return Result
   }
   ,ReadFunctionType:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,17);
      Result = TCustomDeclaration.Create$4$($New(TFunctionType),$AsIntf(Self,"IDeclarationOwner"));
      while (TTranslator.ReadIdentifier$1(Self,[22].slice(),false)) {
         Result.Parameters.push(TTranslator.ReadFunctionParameter(Self));
         TTranslator.AssumeToken$1(Self,[24, 18, 23].slice());
         if (TTranslator.a$1(Self)==18) {
            break;
         }
      }
      TTranslator.AssumeToken$1(Self,[18, 23].slice());
      if (TTranslator.ReadToken$2(Self,[54, 34].slice(),false)) {
         Result.ResultType = TTranslator.ReadType(Self);
      }
      return Result
   }
   ,ReadIdentifier$1:function(Self, AdditionalToken$1, Required) {
      var Result = false;
      TTranslator.ReadToken(Self);
      Result = Self.FScanner.isIdentifier()||AdditionalToken$1.indexOf(TTranslator.a$1(Self))>=0;
      if ((!Result)&&Required) {
         TTranslator.HandleScanError(Self,0);
      }
      return Result
   }
   ,ReadIdentifier:function(Self, Required$1) {
      var Result = false;
      TTranslator.ReadToken(Self);
      Result = Self.FScanner.isIdentifier();
      if ((!Result)&&Required$1) {
         TTranslator.HandleScanError(Self,69);
      }
      return Result
   }
   ,ReadIdentifierPath:function(Self) {
      var Result = "";
      TTranslator.AssumeIdentifier(Self,[9].slice());
      Result = TTranslator.a$2(Self);
      while (TTranslator.ReadToken$1(Self,21,false)) {
         TTranslator.ReadIdentifier(Self,true);
         Result+="."+TTranslator.a$2(Self);
      }
      return Result
   }
   ,ReadImportDeclaration:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,89);
      Result = TCustomDeclaration.Create$4$($New(TImportDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier$1(Self,[37].slice(),true);
      if (TTranslator.a$1(Self)==37) {
         TTranslator.ReadToken$1(Self,116,true);
         TTranslator.ReadIdentifier(Self,true);
         TTranslator.ReadToken$1(Self,133,true);
         TTranslator.ReadToken$1(Self,9,true);
      } else {
         TTranslator.ReadToken$1(Self,56,true);
         TTranslator.ReadIdentifier(Self,true);
      }
      if (Self.NeedsSemicolon) {
         TTranslator.ReadToken$1(Self,23,true);
      }
      return Result
   }
   ,ReadIndexSignature:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,19);
      Result = TCustomDeclaration.Create$4$($New(TIndexDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier(Self,true);
      TTranslator.ReadToken$1(Self,54,true);
      TTranslator.ReadToken$2(Self,[130, 128].slice(),true);
      Result.IsStringIndex = TTranslator.a$1(Self)==130;
      TTranslator.ReadToken$1(Self,20,true);
      TTranslator.ReadToken$1(Self,54,true);
      Result.Type = TTranslator.ReadTypeAnnotation(Self);
      return Result
   }
   ,ReadInterfaceDeclaration:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,107);
      Result = TCustomDeclaration.Create$4$($New(TInterfaceDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = TTranslator.a$2(Self);
      TTranslator.ReadToken$2(Self,[25, 83, 15].slice(),true);
      if (TTranslator.a$1(Self)==25) {
         TTranslator.ReadTypeParameter(Self);
         TTranslator.ReadToken$2(Self,[83, 15].slice(),true);
      }
      while (TTranslator.a$1(Self)==83) {
         TTranslator.ReadIdentifier(Self,true);
         Result.Extends.push(TTranslator.ReadTypeReference(Self));
         while (TTranslator.a$1(Self)==24) {
            TTranslator.ReadIdentifier(Self,true);
            Result.Extends.push(TTranslator.ReadTypeReference(Self));
         }
      }
      TTranslator.AssumeToken(Self,15);
      Result.Type = TTranslator.ReadObjectType(Self);
      TTranslator.AssumeToken(Self,16);
      return Result
   }
   ,ReadMethodDeclaration:function(Self) {
      var Result = null;
      Result = TCustomDeclaration.Create$4$($New(TMethodDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      Result.Type = TTranslator.ReadFunctionType(Self);
      if (Self.NeedsSemicolon) {
         TTranslator.AssumeToken$1(Self,[23, 16].slice());
      }
      return Result
   }
   ,ReadModuleDeclaration:function(Self) {
      var Result = null;
      var ModuleTokens$1 = [],
         ModuleTokens$1 = [73, 82, 81, 89, 125, 87, 107, 102, 23].slice();
      TTranslator.AssumeToken(Self,125);
      Result = TCustomDeclaration.Create$4$($New(TModuleDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier$1(Self,[9].slice(),true);
      Result.Name = TTranslator.ReadIdentifierPath(Self);
      TTranslator.AssumeToken(Self,15);
      TTranslator.ReadToken$2(Self,ModuleTokens$1,true);
      while (TTranslator.a$1(Self)!=16) {
         switch (TTranslator.a$1(Self)) {
            case 73 :
               Result.Classes.push(TTranslator.ReadAmbientClassDeclaration(Self));
               break;
            case 82 :
               Result.Exports.push(TTranslator.ReadExportDeclaration(Self));
               break;
            case 81 :
               TTranslator.ReadEnumerationDeclaration(Self);
               break;
            case 87 :
               Result.Functions.push(TTranslator.ReadFunctionDeclaration(Self));
               break;
            case 89 :
               TTranslator.ReadImportDeclaration(Self);
               break;
            case 125 :
               Result.Modules.push(TTranslator.ReadModuleDeclaration(Self));
               break;
            case 107 :
               Result.Interfaces.push(TTranslator.ReadInterfaceDeclaration(Self));
               break;
            case 102 :
               Result.Variables.push(TTranslator.ReadVariableDeclaration(Self));
               break;
         }
         TTranslator.ReadToken$2(Self,ModuleTokens$1,true);
      }
      TTranslator.AssumeToken(Self,16);
      return Result
   }
   ,ReadObjectType:function(Self) {
      var Result = null;
      var ObjectTokens = [],
         ObjectTokens = [9, 8, 92, 17, 78, 19, 16].slice();
      TTranslator.AssumeToken(Self,15);
      Result = TCustomDeclaration.Create$4$($New(TObjectType),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier$1(Self,ObjectTokens,true);
      while (TTranslator.a$1(Self)!=16) {
         Result.Members.push(TTranslator.ReadTypeMember(Self));
         if (([23,24].indexOf(TTranslator.a$1(Self))>=0)) {
            TTranslator.ReadIdentifier$1(Self,ObjectTokens,true);
         }
      }
      TTranslator.AssumeToken(Self,16);
      return Result
   }
   ,ReadParameter:function(Self) {
      var Result = null;
      TTranslator.AssumeIdentifier(Self,[112, 110, 111, 22].slice());
      Result = TObject.Create($New(TParameter));
      Result.IsRest = TTranslator.a$1(Self)==22;
      if (Result.IsRest) {
         TTranslator.ReadIdentifier(Self,true);
         Result.BindingIdentifier = TTranslator.a$2(Self);
         if (TTranslator.ReadToken$1(Self,54,false)) {
            Result.Type = TTranslator.ReadTypeAnnotation(Self);
         }
         TTranslator.AssumeToken(Self,18);
         return Result;
      }
      TTranslator.AssumeIdentifier(Self,[112, 110, 111].slice());
      switch (TTranslator.a$1(Self)) {
         case 112 :
            Result.AccessibilityModifier = 0;
            TTranslator.ReadIdentifier(Self,false);
            break;
         case 110 :
            Result.AccessibilityModifier = 1;
            TTranslator.ReadIdentifier(Self,false);
            break;
         case 111 :
            Result.AccessibilityModifier = 2;
            TTranslator.ReadIdentifier(Self,false);
            break;
      }
      TTranslator.AssumeIdentifier(Self,[]);
      TTranslator.ReadToken$2(Self,[53, 54, 56, 24, 18].slice(),true);
      Result.IsOptional = TTranslator.a$1(Self)==53;
      if (Result.IsOptional) {
         TTranslator.ReadToken$2(Self,[54, 56, 24, 18].slice(),true);
      }
      if (TTranslator.a$1(Self)==54) {
         Result.Type = TTranslator.ReadType(Self);
      }
      TTranslator.AssumeToken$1(Self,[56, 24, 18].slice());
      if (TTranslator.a$1(Self)==56) {
         TTranslator.ReadIdentifier(Self,true);
         Result.DefaultValue = TTranslator.a$2(Self);
      }
      TTranslator.AssumeToken$1(Self,[24, 18].slice());
      return Result
   }
   ,ReadPrimaryType:function(Self) {
      var Result = null;
      var PrimaryTypeTokens = [],
         PrimaryTypeTokens = [69, 9, 117, 15, 128, 130, 120, 103, 101, 17].slice();
      var OldType = null;
      TTranslator.AssumeToken$1(Self,PrimaryTypeTokens);
      switch (TTranslator.a$1(Self)) {
         case 17 :
            Result = TTranslator.ReadType(Self);
            TTranslator.AssumeToken(Self,18);
            TTranslator.ReadToken(Self);
            break;
         case 69 :
            Result = TNamedType.Create$5($New(TNamedType),$AsIntf(Self,"IDeclarationOwner"),TTranslator.ReadIdentifierPath(Self));
            if (TTranslator.a$1(Self)==25) {
               $As(Result,TNamedType).Arguments.push(TTranslator.ReadTypeArgument(Self));
               TTranslator.ReadToken(Self);
            }
            break;
         case 9 :
            Result = TNamedType.Create$5($New(TNamedType),$AsIntf(Self,"IDeclarationOwner"),TTranslator.a$2(Self));
            TTranslator.ReadToken(Self);
            break;
         case 117 :
            Result = TCustomDeclaration.Create$4$($New(TVariantType),$AsIntf(Self,"IDeclarationOwner"));
            TTranslator.ReadToken(Self);
            break;
         case 128 :
            Result = TCustomDeclaration.Create$4$($New(TFloatType),$AsIntf(Self,"IDeclarationOwner"));
            TTranslator.ReadToken(Self);
            break;
         case 103 :
            Result = null;
            TTranslator.ReadToken(Self);
            break;
         case 101 :
            Result = TCustomDeclaration.Create$4$($New(TTypeOfType),$AsIntf(Self,"IDeclarationOwner"));
            $As(Result,TTypeOfType).Type = TTranslator.ReadType(Self);
            break;
         case 130 :
            Result = TCustomDeclaration.Create$4$($New(TStringType),$AsIntf(Self,"IDeclarationOwner"));
            TTranslator.ReadToken(Self);
            break;
         case 120 :
            Result = TCustomDeclaration.Create$4$($New(TBooleanType),$AsIntf(Self,"IDeclarationOwner"));
            TTranslator.ReadToken(Self);
            break;
         case 15 :
            Result = TTranslator.ReadObjectType(Self);
            TTranslator.ReadToken(Self);
            break;
      }
      while (TTranslator.a$1(Self)==19) {
         OldType = Result;
         Result = TCustomDeclaration.Create$4$($New(TArrayType),$AsIntf(Self,"IDeclarationOwner"));
         $As(Result,TArrayType).Type = OldType;
         TTranslator.ReadToken$1(Self,20,true);
         TTranslator.ReadToken(Self);
      }
      return Result
   }
   ,ReadToken$2:function(Self, Tokens$1, Required$2) {
      var Result = false;
      Result = Tokens$1.indexOf(TTranslator.ReadToken(Self))>=0;
      if ((!Result)&&Required$2) {
         TTranslator.HandleScanError(Self,0);
      }
      return Result
   }
   ,ReadToken$1:function(Self, Token$1, Required$3) {
      var Result = false;
      Result = TTranslator.ReadToken(Self)==Token$1;
      if ((!Result)&&Required$3) {
         TTranslator.HandleScanError(Self,Token$1);
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
      var TypeTokens = [],
         OldType$1 = null;
      TypeTokens.push(69, 9, 117, 15, 128, 130, 120, 103, 101, 17);
      TTranslator.ReadToken$2(Self,TypeTokens,true);
      if (TTranslator.a$1(Self)==17) {
         return TTranslator.ReadFunctionType(Self);
      }
      Result = TTranslator.ReadPrimaryType(Self);
      while (TTranslator.a$1(Self)==47) {
         if (!$Is(Result,TUnionType)) {
            OldType$1 = Result;
            Result = TCustomDeclaration.Create$4$($New(TUnionType),$AsIntf(Self,"IDeclarationOwner"));
            $As(Result,TUnionType).Types.push(OldType$1);
         }
         TTranslator.ReadToken$2(Self,TypeTokens,true);
         $As(Result,TUnionType).Types.push(TTranslator.ReadPrimaryType(Self));
      }
      return Result
   }
   ,ReadTypeAnnotation:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,54);
      Result = TTranslator.ReadType(Self);
      return Result
   }
   ,ReadTypeArgument:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,25);
      Result = TCustomDeclaration.Create$4$($New(TTypeArgument),$AsIntf(Self,"IDeclarationOwner"));
      Result.Type = TTranslator.ReadType(Self);
      TTranslator.AssumeToken(Self,27);
      return Result
   }
   ,ReadTypeMember:function(Self) {
      var Result = null;
      var MemberName$2 = "",
         Nullable$4 = false;
      TTranslator.AssumeIdentifier(Self,[9, 8, 110, 92, 78, 17, 19].slice());
      if (TTranslator.a$1(Self)==92) {
         return TTranslator.ReadConstructorSignature(Self);
      }
      if (TTranslator.a$1(Self)==17) {
         return TTranslator.ReadCallbackInterface(Self);
      }
      if (TTranslator.a$1(Self)==19) {
         return TTranslator.ReadIndexSignature(Self);
      }
      if (Self.FScanner.isIdentifier()||([9,8,78].indexOf(Self.FScanner.getToken())>=0)) {
         MemberName$2 = TTranslator.a$2(Self);
         TTranslator.ReadToken$2(Self,[53, 54, 17].slice(),true);
         Nullable$4 = TTranslator.a$1(Self)==53;
         if (Nullable$4) {
            TTranslator.ReadToken$1(Self,54,true);
         }
         switch (TTranslator.a$1(Self)) {
            case 54 :
               Result = TTranslator.ReadFieldDeclaration(Self);
               $As(Result,TFieldDeclaration).Nullable = Nullable$4;
               break;
            case 17 :
               Result = TTranslator.ReadMethodDeclaration(Self);
               break;
         }
         Result.Name = MemberName$2;
      }
      return Result
   }
   ,ReadTypeParameter:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,25);
      Result = TCustomDeclaration.Create$4$($New(TTypeParameter),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = TTranslator.a$2(Self);
      TTranslator.ReadToken$2(Self,[83, 27].slice(),true);
      if (TTranslator.a$1(Self)==83) {
         Result.ExtendsType = TTranslator.ReadType(Self);
         TTranslator.AssumeToken(Self,27);
      }
      return Result
   }
   ,ReadTypeReference:function(Self) {
      var Result = null;
      TTranslator.AssumeIdentifier(Self,[]);
      Result = TCustomDeclaration.Create$4$($New(TTypeReference),$AsIntf(Self,"IDeclarationOwner"));
      Result.Name = TTranslator.ReadIdentifierPath(Self);
      return Result
   }
   ,ReadVariableDeclaration:function(Self) {
      var Result = null;
      TTranslator.AssumeToken(Self,102);
      Result = TCustomDeclaration.Create$4$($New(TVariableDeclaration),$AsIntf(Self,"IDeclarationOwner"));
      TTranslator.ReadIdentifier(Self,true);
      Result.Name = TTranslator.a$2(Self);
      TTranslator.ReadToken$1(Self,54,true);
      Result.Type = TTranslator.ReadType(Self);
      return Result
   }
   ,Translate:function(Self, Source) {
      var Result = "";
      Self.FScanner = TypeScriptExport.createScanner(0,true,0,Source);
      Self.FSourceFile = TypeScriptExport.createSourceFile("main",Source,0);
      try {
         TTranslator.ReadDefinition$(Self);
      } catch ($e) {
         var e = $W($e);
         console.error(e.FMessage);
      }
      Result = TTranslator.BuildPascalHeader$(Self);
      return Result
   }
   ,Destroy:TObject.Destroy
   ,BuildPascalHeader$:function($){return $.ClassType.BuildPascalHeader($)}
   ,ReadDefinition$:function($){return $.ClassType.ReadDefinition($)}
};
TTranslator.$Intf={
   IDeclarationOwner:[]
}
var TNodeFlags = { 1:"Export", 2:"Ambient", 4:"Public", 8:"Private", 16:"Protected", 32:"Static", 64:"Abstract", 128:"Async", 256:"Default", 512:"MultiLine", 1024:"Synthetic", 2048:"DeclarationFile", 4096:"Let", 8192:"Const", 16384:"OctalLiteral", 32768:"Namespace", 65536:"ExportContext", 131072:"ContainsThis" };
var TJsxFlags = { 1:"None", 2:"IntrinsicNamedElement", 4:"IntrinsicIndexedElement", 8:"ClassElement", 16:"UnknownElement" };
var TDiagnosticCategory = [ "Warning", "Error", "Message" ];
var TVisibility = [ "vPublic", "vProtected", "vPrivate" ];
var TCustomDeclaration = {
   $ClassName:"TCustomDeclaration",$Parent:TObject
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
   $ClassName:"TCustomType",$Parent:TCustomDeclaration
   ,$Init:function ($) {
      TCustomDeclaration.$Init($);
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode:TCustomDeclaration.GetAsCode
};
var TCustomNamedType = {
   $ClassName:"TCustomNamedType",$Parent:TCustomType
   ,$Init:function ($) {
      TCustomType.$Init($);
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = TCustomNamedType.GetName$(Self);
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TVariantType = {
   $ClassName:"TVariantType",$Parent:TCustomNamedType
   ,$Init:function ($) {
      TCustomNamedType.$Init($);
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = "Variant";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode:TCustomNamedType.GetAsCode
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TNamedDeclaration = {
   $ClassName:"TNamedDeclaration",$Parent:TCustomDeclaration
   ,$Init:function ($) {
      TCustomDeclaration.$Init($);
      $.Name = "";
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode:TCustomDeclaration.GetAsCode
};
var TVariableDeclaration = {
   $ClassName:"TVariableDeclaration",$Parent:TNamedDeclaration
   ,$Init:function ($) {
      TNamedDeclaration.$Init($);
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TUnionType = {
   $ClassName:"TUnionType",$Parent:TCustomType
   ,$Init:function ($) {
      TCustomType.$Init($);
      $.Types = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      var a$131 = 0;
      var SubType = null;
      var a$132 = [];
      Result = "Variant {";
      a$132 = Self.Types;
      var $temp5;
      for(a$131=0,$temp5=a$132.length;a$131<$temp5;a$131++) {
         SubType = a$132[a$131];
         Result+=TCustomDeclaration.GetAsCode$(SubType);
      }
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TTypeReference = {
   $ClassName:"TTypeReference",$Parent:TCustomDeclaration
   ,$Init:function ($) {
      TCustomDeclaration.$Init($);
      $.Name = "";
      $.Arguments = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TTypeParameter = {
   $ClassName:"TTypeParameter",$Parent:TCustomDeclaration
   ,$Init:function ($) {
      TCustomDeclaration.$Init($);
      $.Name = "";
      $.ExtendsType = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TTypeOfType = {
   $ClassName:"TTypeOfType",$Parent:TCustomNamedType
   ,$Init:function ($) {
      TCustomNamedType.$Init($);
      $.Type = null;
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = "type of";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode:TCustomNamedType.GetAsCode
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TTypeArgument = {
   $ClassName:"TTypeArgument",$Parent:TCustomDeclaration
   ,$Init:function ($) {
      TCustomDeclaration.$Init($);
      $.Name = "";
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TStringType = {
   $ClassName:"TStringType",$Parent:TCustomNamedType
   ,$Init:function ($) {
      TCustomNamedType.$Init($);
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = "Boolean";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode:TCustomNamedType.GetAsCode
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TParameter = {
   $ClassName:"TParameter",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.DefaultValue = $.BindingIdentifier = "";
      $.IsRest = $.IsOptional = false;
      $.Type = null;
      $.AccessibilityModifier = 0;
   }
   ,Destroy:TObject.Destroy
};
var TObjectType = {
   $ClassName:"TObjectType",$Parent:TCustomType
   ,$Init:function ($) {
      TCustomType.$Init($);
      $.Members = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      var a$133 = 0;
      var Member$2 = null;
      var a$134 = [];
      TCustomDeclaration.BeginIndention(Self.ClassType);
      a$134 = Self.Members;
      var $temp6;
      for(a$133=0,$temp6=a$134.length;a$133<$temp6;a$133++) {
         Member$2 = a$134[a$133];
         Result+=TCustomDeclaration.GetAsCode$(Member$2);
      }
      TCustomDeclaration.EndIndention(Self.ClassType);
      Result+=TCustomDeclaration.GetIndentionString(Self.ClassType)+"end;";
      Result+="\r\n"+"\r\n";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TNamespaceDeclaration = {
   $ClassName:"TNamespaceDeclaration",$Parent:TNamedDeclaration
   ,$Init:function ($) {
      TNamedDeclaration.$Init($);
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode:TCustomDeclaration.GetAsCode
};
var TNamedType = {
   $ClassName:"TNamedType",$Parent:TCustomNamedType
   ,$Init:function ($) {
      TCustomNamedType.$Init($);
      $.FName = "";
      $.Arguments = [];
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = Self.FName;
      return Result
   }
   ,Create$5:function(Self, Owner$1, AName) {
      TCustomDeclaration.Create$4(Self,Owner$1);
      Self.FName = AName;
      return Self
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode:TCustomNamedType.GetAsCode
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TModuleDeclaration = {
   $ClassName:"TModuleDeclaration",$Parent:TNamedDeclaration
   ,$Init:function ($) {
      TNamedDeclaration.$Init($);
      $.Modules = [];
      $.Variables = [];
      $.Exports = [];
      $.Functions = [];
      $.Interfaces = [];
      $.Classes = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      var a$135 = 0;
      var Class = null,
         a$136 = 0;
      var Interface$1 = null,
         a$137 = 0;
      var Variable = null;
      if (Self.Classes.length>0) {
         var a$138 = [];
         Result+="type"+"\r\n";
         TCustomDeclaration.BeginIndention(Self.ClassType);
         a$138 = Self.Classes;
         var $temp7;
         for(a$135=0,$temp7=a$138.length;a$135<$temp7;a$135++) {
            Class = a$138[a$135];
            Result = Result+TCustomDeclaration.GetAsCode$(Class);
         }
         TCustomDeclaration.EndIndention(Self.ClassType);
      }
      if (Self.Interfaces.length>0) {
         var a$139 = [];
         Result+="type"+"\r\n";
         TCustomDeclaration.BeginIndention(Self.ClassType);
         a$139 = Self.Interfaces;
         var $temp8;
         for(a$136=0,$temp8=a$139.length;a$136<$temp8;a$136++) {
            Interface$1 = a$139[a$136];
            Result = Result+TCustomDeclaration.GetAsCode$(Interface$1);
         }
         TCustomDeclaration.EndIndention(Self.ClassType);
      }
      if (Self.Variables.length>0) {
         var a$140 = [];
         Result+="var"+"\r\n";
         TCustomDeclaration.BeginIndention(Self.ClassType);
         a$140 = Self.Variables;
         var $temp9;
         for(a$137=0,$temp9=a$140.length;a$137<$temp9;a$137++) {
            Variable = a$140[a$137];
            Result = Result+TCustomDeclaration.GetAsCode$(Variable);
         }
         TCustomDeclaration.EndIndention(Self.ClassType);
      }
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TCustomTypeMember = {
   $ClassName:"TCustomTypeMember",$Parent:TNamedDeclaration
   ,$Init:function ($) {
      TNamedDeclaration.$Init($);
      $.Visibility = 0;
      $.IsStatic = false;
   }
   ,Create$4:function(Self, Owner$2) {
      TCustomDeclaration.Create$4(Self,Owner$2);
      Self.Visibility = 0;
      return Self
   }
   ,Destroy:TObject.Destroy
   ,Create$4$:function($){return $.ClassType.Create$4.apply($.ClassType, arguments)}
   ,GetAsCode:TCustomDeclaration.GetAsCode
};
var TMethodDeclaration = {
   $ClassName:"TMethodDeclaration",$Parent:TCustomTypeMember
   ,$Init:function ($) {
      TCustomTypeMember.$Init($);
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = TCustomDeclaration.GetIndentionString(Self.ClassType)+"function "+Self.Name;
      if (Self.Type) {
         Result+=TCustomDeclaration.GetAsCode$(Self.Type);
      }
      Result+=";"+"\r\n";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomTypeMember.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TInterfaceDeclaration = {
   $ClassName:"TInterfaceDeclaration",$Parent:TCustomDeclaration
   ,$Init:function ($) {
      TCustomDeclaration.$Init($);
      $.Members = [];
      $.Name = "";
      $.Extends = [];
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TIndexDeclaration = {
   $ClassName:"TIndexDeclaration",$Parent:TCustomTypeMember
   ,$Init:function ($) {
      TCustomTypeMember.$Init($);
      $.IsStringIndex = false;
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomTypeMember.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TImportDeclaration = {
   $ClassName:"TImportDeclaration",$Parent:TNamedDeclaration
   ,$Init:function ($) {
      TNamedDeclaration.$Init($);
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TFunctionType = {
   $ClassName:"TFunctionType",$Parent:TCustomNamedType
   ,$Init:function ($) {
      TCustomNamedType.$Init($);
      $.ResultType = null;
      $.Parameters = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      var Index = 0;
      if (Self.Parameters.length>0) {
         Result = "("+TCustomDeclaration.GetAsCode$(Self.Parameters[0]);
         var $temp10;
         for(Index=0+1,$temp10=Self.Parameters.length;Index<$temp10;Index++) {
            Result+="; "+TCustomDeclaration.GetAsCode$(Self.Parameters[Index]);
         }
         Result+=")";
      }
      if (Self.ResultType) {
         Result+=": "+TCustomDeclaration.GetAsCode$(Self.ResultType);
      }
      return Result
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = "function";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TFunctionParameter = {
   $ClassName:"TFunctionParameter",$Parent:TNamedDeclaration
   ,$Init:function ($) {
      TNamedDeclaration.$Init($);
      $.Type = null;
      $.Nullable = false;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = Self.Name+": ";
      if (Self.Type) {
         Result+=TCustomDeclaration.GetAsCode$(Self.Type);
      } else {
         Result+="Variant";
      }
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TFunctionDeclaration = {
   $ClassName:"TFunctionDeclaration",$Parent:TNamedDeclaration
   ,$Init:function ($) {
      TNamedDeclaration.$Init($);
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = TCustomDeclaration.GetAsCode$(Self.Type);
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TFloatType = {
   $ClassName:"TFloatType",$Parent:TCustomNamedType
   ,$Init:function ($) {
      TCustomNamedType.$Init($);
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = "Float";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode:TCustomNamedType.GetAsCode
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TFieldDeclaration = {
   $ClassName:"TFieldDeclaration",$Parent:TCustomTypeMember
   ,$Init:function ($) {
      TCustomTypeMember.$Init($);
      $.Nullable = false;
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = TCustomDeclaration.GetIndentionString(Self.ClassType)+Self.Name+": "+TCustomDeclaration.GetAsCode$(Self.Type)+";";
      if (Self.Nullable) {
         Result+=" \/\/ nullable";
      }
      Result+="\r\n";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomTypeMember.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TExportDeclaration = {
   $ClassName:"TExportDeclaration",$Parent:TNamedDeclaration
   ,$Init:function ($) {
      TNamedDeclaration.$Init($);
      $.FDefault = false;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TEnumerationItem = {
   $ClassName:"TEnumerationItem",$Parent:TCustomDeclaration
   ,$Init:function ($) {
      TCustomDeclaration.$Init($);
      $.Name = $.Value = "";
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TEnumerationDeclaration = {
   $ClassName:"TEnumerationDeclaration",$Parent:TNamedDeclaration
   ,$Init:function ($) {
      TNamedDeclaration.$Init($);
      $.Items = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TEnumDeclaration = {
   $ClassName:"TEnumDeclaration",$Parent:TNamedDeclaration
   ,$Init:function ($) {
      TNamedDeclaration.$Init($);
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode:TCustomDeclaration.GetAsCode
};
var TDefinitionDeclaration = {
   $ClassName:"TDefinitionDeclaration",$Parent:TNamedDeclaration
   ,$Init:function ($) {
      TNamedDeclaration.$Init($);
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TConstructorDeclaration = {
   $ClassName:"TConstructorDeclaration",$Parent:TCustomTypeMember
   ,$Init:function ($) {
      TCustomTypeMember.$Init($);
      $.TypeParameters = "";
      $.ParameterList = [];
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = TCustomDeclaration.GetIndentionString(Self.ClassType)+"constructor Create";
      if (Self.Type) {
         Result+=TCustomDeclaration.GetAsCode$(Self.Type);
      }
      Result+=";"+"\r\n";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomTypeMember.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TClassDeclaration = {
   $ClassName:"TClassDeclaration",$Parent:TInterfaceDeclaration
   ,$Init:function ($) {
      TInterfaceDeclaration.$Init($);
      $.Implements = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TCallSignature = {
   $ClassName:"TCallSignature",$Parent:TCustomDeclaration
   ,$Init:function ($) {
      TCustomDeclaration.$Init($);
      $.TypeParameters = "";
      $.ParameterList = [];
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TCallbackDeclaration = {
   $ClassName:"TCallbackDeclaration",$Parent:TCustomTypeMember
   ,$Init:function ($) {
      TCustomTypeMember.$Init($);
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = TCustomDeclaration.GetIndentionString(Self.ClassType)+"callback "+Self.Name;
      if (Self.Type) {
         Result+=TCustomDeclaration.GetAsCode$(Self.Type);
      }
      Result+=";"+"\r\n";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomTypeMember.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TBooleanType = {
   $ClassName:"TBooleanType",$Parent:TCustomNamedType
   ,$Init:function ($) {
      TCustomNamedType.$Init($);
   }
   ,GetName:function(Self) {
      var Result = "";
      Result = "Boolean";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode:TCustomNamedType.GetAsCode
   ,GetName$:function($){return $.ClassType.GetName($)}
};
var TArrayType = {
   $ClassName:"TArrayType",$Parent:TCustomType
   ,$Init:function ($) {
      TCustomType.$Init($);
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      Result = "array of "+TCustomDeclaration.GetAsCode$(Self.Type);
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TAmbientVariableDeclaration = {
   $ClassName:"TAmbientVariableDeclaration",$Parent:TCustomDeclaration
   ,$Init:function ($) {
      TCustomDeclaration.$Init($);
      $.IsConst = false;
      $.AmbientBindingList = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      var a$141 = 0;
      var AmbientBinding = null;
      var a$142 = [];
      Result = (Self.IsConst)?"const ":"var ";
      a$142 = Self.AmbientBindingList;
      var $temp11;
      for(a$141=0,$temp11=a$142.length;a$141<$temp11;a$141++) {
         AmbientBinding = a$142[a$141];
         Result+=TCustomDeclaration.GetAsCode$(AmbientBinding);
      }
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TAmbientModuleDeclaration = {
   $ClassName:"TAmbientModuleDeclaration",$Parent:TCustomDeclaration
   ,$Init:function ($) {
      TCustomDeclaration.$Init($);
      $.Interfaces = [];
      $.Modules = [];
      $.Classes = [];
      $.Functions = [];
      $.Variables = [];
      $.IdentifierPath = "";
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TAmbientFunctionDeclaration = {
   $ClassName:"TAmbientFunctionDeclaration",$Parent:TCustomDeclaration
   ,$Init:function ($) {
      TCustomDeclaration.$Init($);
      $.BindingIdentifier = "";
      $.CallSignature = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TAmbientDeclaration = {
   $ClassName:"TAmbientDeclaration",$Parent:TNamedDeclaration
   ,$Init:function ($) {
      TNamedDeclaration.$Init($);
      $.Variables = [];
      $.Namespaces = [];
      $.Modules = [];
      $.Classes = [];
      $.Functions = [];
      $.Enums = [];
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      var a$143 = 0;
      var Function$2 = null,
         a$144 = 0;
      var Module$2 = null,
         a$145 = 0;
      var Class$1 = null,
         a$146 = 0;
      var Variable$1 = null;
      var a$147 = [],
          a$148 = [];
      a$148 = Self.Functions;
      var $temp12;
      for(a$143=0,$temp12=a$148.length;a$143<$temp12;a$143++) {
         Function$2 = a$148[a$143];
         Result+=TCustomDeclaration.GetAsCode$(Function$2);
      }
      a$147 = Self.Modules;
      var $temp13;
      for(a$144=0,$temp13=a$147.length;a$144<$temp13;a$144++) {
         Module$2 = a$147[a$144];
         Result+=TCustomDeclaration.GetAsCode$(Module$2);
      }
      if (Self.Classes.length>0) {
         var a$149 = [];
         Result+="type"+"\r\n";
         TCustomDeclaration.BeginIndention(Self.ClassType);
         a$149 = Self.Classes;
         var $temp14;
         for(a$145=0,$temp14=a$149.length;a$145<$temp14;a$145++) {
            Class$1 = a$149[a$145];
            Result = Result+TCustomDeclaration.GetAsCode$(Class$1);
         }
         TCustomDeclaration.EndIndention(Self.ClassType);
      }
      if (Self.Variables.length>0) {
         var a$150 = [];
         Result+="var"+"\r\n";
         TCustomDeclaration.BeginIndention(Self.ClassType);
         a$150 = Self.Variables;
         var $temp15;
         for(a$146=0,$temp15=a$150.length;a$146<$temp15;a$146++) {
            Variable$1 = a$150[a$146];
            Result = Result+TCustomDeclaration.GetAsCode$(Variable$1);
         }
         TCustomDeclaration.EndIndention(Self.ClassType);
      }
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TAmbientClassDeclaration = {
   $ClassName:"TAmbientClassDeclaration",$Parent:TClassDeclaration
   ,$Init:function ($) {
      TClassDeclaration.$Init($);
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode:TClassDeclaration.GetAsCode
};
var TAmbientBinding = {
   $ClassName:"TAmbientBinding",$Parent:TCustomDeclaration
   ,$Init:function ($) {
      TCustomDeclaration.$Init($);
      $.BindingIdentifier = "";
      $.Type = null;
   }
   ,GetAsCode:function(Self) {
      var Result = "";
      return Result
   }
   ,Destroy:TObject.Destroy
   ,Create$4:TCustomDeclaration.Create$4
   ,GetAsCode$:function($){return $.ClassType.GetAsCode($)}
};
var TAccessibilityModifier = [ "amPublic", "amPrivate", "amProtected" ];
function ConvertFile(InputFile, OutputFile) {
   if (InputFile==(InputFile).split(".")[0]) {
      InputFile+=".d.ts";
   }
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

var TypeScriptExport = require("typescript");
var IndentionLevel = 0;
var FileSystem = fs();

var userArgs = process.argv.slice(2);
if (userArgs.length == 0) {
  return 'Usage: ts2pas inputfile [outputfile]';
} 
var inputFile = userArgs[0];
var outputfile = userArgs[0]+".pas"; 
if (userArgs.length == 2)
  outputfile = userArgs[1];

ConvertFile(inputFile, outputfile);