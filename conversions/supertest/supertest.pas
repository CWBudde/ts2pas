unit Supertest;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: supertest
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Response = superagent.Response;

  Request = superagent.SuperAgentRequest;

  CallbackHandler = superagent.CallbackHandler;

  Test = interface(STest)
  end;

  Agent = interface(stAgent)
  end;

  Options = interface
    property http2: Boolean;
  end;

  AgentOptions = STAgentOptions;

  SuperTest = superagent.SuperAgent<Req>;

  SuperAgentTest = SuperTest<Test>;

  SuperTestStatic = interface
    property Test: Variant;
    property agent: Variant;
  end;

implementation



end.
