unit Bcrypt;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: bcrypt
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  function genSaltSync(rounds?: Float; minor?: String): String;

  function genSalt(rounds?: Float; minor?: String): String;

  procedure genSalt(callback: function: Variant);

  procedure genSalt(rounds: Float; callback: function: Variant);

  procedure genSalt(rounds: Float; minor: String; callback: function: Variant);

  function hashSync(data: Variant; saltOrRounds: Variant): String;

  function hash(data: Variant; saltOrRounds: Variant): String;

  procedure hash(data: Variant; saltOrRounds: Variant; callback: function: Variant);

  function compareSync(data: Variant; encrypted: String): Boolean;

  function compare(data: Variant; encrypted: String): Boolean;

  procedure compare(data: Variant; encrypted: String; callback: function: Variant);

  function getRounds(encrypted: String): Float;

implementation



end.
