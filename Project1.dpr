program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Port Scanner Example';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
