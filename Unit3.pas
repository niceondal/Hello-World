unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MSHTML, ShDocVw, ActiveX;

type
  TObjectFromLResult = function(LRESULT: LRESULT; const IID: TGUID;
    wParam: wParam; out PObject): HRESULT; stdcall;

  TForm3 = class(TForm)
    btnClickPrintButton: TButton;
    Memo1: TMemo;
    procedure btnClickPrintButtonClick(Sender: TObject);
  private
    FStopFlag : Boolean;

    function FindWindowHandle(AClassName, AWindowText: String): THandle;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  EditHandle : hWnd;

implementation

uses
  IE;

{$R *.dfm}

function GetIEFromHWND(WHandle: HWND; var IE: IWebbrowser2): HRESULT;
var
  hInst: HWND;
  lRes: Cardinal;
  Msg: Integer;
  pDoc: IHTMLDocument2;
  ObjectFromLresult: TObjectFromLresult;
begin
  hInst := LoadLibrary('Oleacc.dll'); @ObjectFromLresult :=
    GetProcAddress(hInst, 'ObjectFromLresult');
  if @ObjectFromLresult<>nil then
  begin
    try
      Msg := RegisterWindowMessage('WM_HTML_GETOBJECT');
      SendMessageTimeOut(WHandle, Msg, 0, 0, SMTO_ABORTIFHUNG, 1000, lRes);
      Result := ObjectFromLresult(lRes, IHTMLDocument2, 0, pDoc);
      if Result = S_OK then
        (pDoc.parentWindow as IServiceprovider).QueryService(IWebbrowserApp,
          IWebbrowser2, IE);
    finally
      FreeLibrary(hInst);
    end;
  end;
end;


function TForm3.FindWindowHandle(AClassName, AWindowText: String): THandle;
var
	winHandle : HWND;
	szClassName, szWindowName: array[0..256] of Char; //title bar를 저장 할 buffer
  tmpClass : string;
  tmpName : string;
begin
  result := 0;

	winHandle := FindWindowEx(0, 0, nil, nil);
	while winHandle <> 0 do begin
		GetClassName(winHandle, szClassName, 255);
		GetWindowText(winHandle, szWindowName, 255);
    tmpClass := szClassName;
    tmpName := szWindowName;
    //if( tmpClass = '#32770' ) and ( tmpName <> '') then Memo2.Lines.Add( tmpClass + '<=====>' + tmpName);
		if (uppercase(tmpClass)=AClassName) and (uppercase(tmpName) = AWindowText) then
    begin
      result := winHandle;
      break;
    end;
		winHandle := GetNextWindow(winHandle, GW_HWNDNEXT);
	end;
end;

procedure TForm3.btnClickPrintButtonClick(Sender: TObject);
const
	MESSAGE_MODAL = '등기사항증명서 조회 화면 -- 웹 페이지 대화 상자';
  CLASS_NAME_TRID = 'INTERNET EXPLORER_TRIDENTDLGFRAME';
var
  hd : HWND;
  ieWindow : HWND;
begin
  try
    //인쇄 메시지 확인창 자동 누름
    hd := FindWindowHandle(CLASS_NAME_TRID, MESSAGE_MODAL);
    if hd > 0 then
    begin
      ieWindow := FindWindowEx(hd, 0, 'Internet Explorer_Server', nil);
      POSTMESSAGE(ieWindow,WM_SETFOCUS,0,0);
      POSTMESSAGE(ieWindow, WM_LBUTTONDOWN, MK_LBUTTON, 704 or (21 shl 16));
      POSTMESSAGE(ieWindow, WM_LBUTTONUP, 0, 703 or (21 shl 16));
      POSTMESSAGE(ieWindow, WM_LBUTTONDOWN, MK_LBUTTON, 704 or (21 shl 16));
      POSTMESSAGE(ieWindow, WM_LBUTTONUP, 0, 703 or (21 shl 16));
    end;
  finally

  end;
end;

end.
