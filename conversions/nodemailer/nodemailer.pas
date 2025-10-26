unit Nodemailer;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: nodemailer
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  SendMailOptions = Mail.Options;

  Transporter = Mail<T, D>;

  SentMessageInfo = Variant;

  Transport = interface
    property mailer: Transporter<T, D>;
    property name: String;
    property version: String;
    procedure send(mail: MailMessage<T>; callback: procedure);
    procedure verify(callback: procedure);
    function verify: Boolean;
    procedure close;
  end;

  TransportOptions = interface
    property component: String;
  end;

  TestAccount = interface
    property user: String;
    property pass: String;
    property smtp: Variant;
    property imap: Variant;
    property pop3: Variant;
    property web: String;
  end;

  function createTransport(transport: Variant; defaults?: SMTPPool.Options): Transporter<SMTPPool.SentMessageInfo, SMTPPool.Options>;

  function createTransport(transport: Variant; defaults?: SendmailTransport.Options): Transporter<SendmailTransport.SentMessageInfo, SendmailTransport.Options>;

  function createTransport(transport: Variant; defaults?: StreamTransport.Options): Transporter<StreamTransport.SentMessageInfo, StreamTransport.Options>;

  function createTransport(transport: Variant; defaults?: JSONTransport.Options): Transporter<JSONTransport.SentMessageInfo, JSONTransport.Options>;

  function createTransport(transport: Variant; defaults?: SESTransport.Options): Transporter<SESTransport.SentMessageInfo, SESTransport.Options>;

  function createTransport(transport?: Variant; defaults?: SMTPTransport.Options): Transporter<SMTPTransport.SentMessageInfo, SMTPTransport.Options>;

  function createTransport(transport: Variant; defaults?: TransportOptions): Transporter<SMTPTransport.SentMessageInfo, SMTPTransport.Options>;

  procedure createTestAccount(apiUrl: String; callback: procedure);

  procedure createTestAccount(callback: procedure);

  function createTestAccount(apiUrl?: String): TestAccount;

  function getTestMessageUrl(info: Variant): Variant;

implementation



end.
