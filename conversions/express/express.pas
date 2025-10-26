unit Express;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: express
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  function e: core.Express;

  function Router(options?: RouterOptions): core.Router;

  RouterOptions = interface
    property caseSensitive: Boolean;
    property mergeParams: Boolean;
    property strict: Boolean;
  end;

  Application = interface(core.Application)
  end;

  CookieOptions = interface(core.CookieOptions)
  end;

  Errback = interface(core.Errback)
  end;

  ErrorRequestHandler = interface(core.ErrorRequestHandler)
  end;

  Express = interface(core.Express)
  end;

  Handler = interface(core.Handler)
  end;

  IRoute = interface(core.IRoute)
  end;

  IRouter = interface(core.IRouter)
  end;

  IRouterHandler = interface(core.IRouterHandler)
  end;

  IRouterMatcher = interface(core.IRouterMatcher)
  end;

  MediaType = interface(core.MediaType)
  end;

  NextFunction = interface(core.NextFunction)
  end;

  Locals = interface(core.Locals)
  end;

  Request = interface(core.Request)
  end;

  RequestHandler = interface(core.RequestHandler)
  end;

  RequestParamHandler = interface(core.RequestParamHandler)
  end;

  Response = interface(core.Response)
  end;

  Router = interface(core.Router)
  end;

  Send = interface(core.Send)
  end;

implementation



end.
