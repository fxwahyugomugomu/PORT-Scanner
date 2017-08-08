unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp;

type
  TfrmMain = class(TForm)
    LblIPAddress: TLabel;
    txtIPAddress: TEdit;
    lblScanRange: TLabel;
    txtMinPort: TEdit;
    lblPorttoport: TLabel;
    txtMaxPort: TEdit;
    lblOpenPorts: TLabel;
    ListBox1: TListBox;
    cmdStart: TButton;
    WSsocket: TClientSocket;
    cmdStop: TButton;
    procedure cmdStartClick(Sender: TObject);
    procedure WSsocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure WSsocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure cmdStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  intPort: integer;
  intError: integer;
  intmaxport: integer;
  bRunning: boolean;
implementation

{$R *.dfm}

procedure TfrmMain.cmdStartClick(Sender: TObject);
var
        i: integer;
begin
      //did this to try to use more than one client sock
      //at a time.. if you know how to do it properly... email me
      //at worm@carolina.rr.com

       //start clicked
      // for i := 1 to 60 do
      //  begin
      //     TClientSocket.Create(wsSocket);
      //  end;
       listbox1.Items.Clear;
       wsSocket.Address := txtIPAddress.text;
       intPort := strtoint(txtminport.text);
       intmaxport := strtoint(txtmaxport.text);
       wsSocket.Port := intPort;
       wsSocket.Active := true;
       cmdStart.Enabled := false;
       cmdstop.Enabled := true;
       listbox1.Items.Add('Beginning scan on ' + txtIPAddress.text);
       bRunning := True;


end;

procedure TfrmMain.WSsocketConnect(Sender: TObject;
  Socket: TCustomWinSocket);
  label done;
  begin
        //socket connection made
        //port must be open!
        listbox1.Items.Add('Port: ' + inttostr(intPort) + '; Open!');
        //now try the next port...
        wsSocket.Active := false;
        intport := intport + 1;
        wsSocket.Port := intport;
        if bRunning = false then exit;
        if intPort > intMaxport then goto done else
                begin
                wsSocket.Address := txtipaddress.Text;
                wsSocket.Active := true;
                exit;
                end;
done: //clean stuff up a bit...
listbox1.Items.Add('Done Scanning ' + txtIPAddress.text);
bRunning :=False;
cmdstop.Enabled := false;
cmdstart.enabled := true;
end;

procedure TfrmMain.WSsocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  label done;
  begin
        //connection couldn't be made....
        //try next port here!
        errorcode:=0;
        listbox1.Items.Add('Port: ' + inttostr(intport) + '; closed.');
        wsSocket.Active := false;
        intport := intport + 1;
        wsSocket.Port := intport;
        if bRunning = false then exit;
        if intPort > intMaxport then goto done else
                begin
                wsSocket.Address := txtipaddress.Text;
                wsSocket.Active := true;
                exit;
                end;
done: // cleans up and exits the sub
listbox1.Items.Add('Done Scanning ' + txtIPAddress.text);
bRunning := false;
cmdstop.Enabled := false;
cmdstart.enabled := true;
end;

procedure TfrmMain.cmdStopClick(Sender: TObject);
begin
        //clicked stop
        bRunning := false;
        cmdstart.Enabled := true;
        cmdstop.Enabled := false;
        wssocket.Active := false;
        listbox1.Items.Add('Stoped scan on port ' + inttostr(IntPort) + '!')
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
bRunning := false;
end;

end.
