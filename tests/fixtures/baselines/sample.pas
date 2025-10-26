unit JS_Sample;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: sample
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Person = interface
    property name: String;
    property age: Float;
    property isActive: Boolean;
  end;

  User = class external
    procedure Create(name: String; email: String);
    function getName: String;
    procedure setName(name: String);
    function createDefault: User; static
  end;

  function greet(person: Person): String;

  UserID = Variant;

  Status = (Active, Inactive, Pending);

implementation



end.
