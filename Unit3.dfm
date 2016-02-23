object Form3: TForm3
  Left = 0
  Top = 0
  Caption = #46321#44592#48512#46321#48376' '#48156#44553#52285' '#52636#47141#48260#53948' '#53364#47533#54616#44592
  ClientHeight = 452
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnClickPrintButton: TButton
    Left = 24
    Top = 22
    Width = 169
    Height = 35
    Caption = #52636#47141#48260#53948' '#53364#47533
    TabOrder = 0
    OnClick = btnClickPrintButtonClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 86
    Width = 554
    Height = 347
    Lines.Strings = (
      'procedure TForm3.btnClickPrintButtonClick(Sender: TObject);'
      'const'
      '  MESSAGE_MODAL = '#39#46321#44592#49324#54637#51613#47749#49436' '#51312#54924' '#54868#47732' -- '#50937' '#54168#51060#51648' '#45824#54868' '#49345#51088#39';'
      '  CLASS_NAME_TRID = '#39'INTERNET EXPLORER_TRIDENTDLGFRAME'#39';'
      'var'
      '  hd : HWND;'
      '  ieWindow : HWND;'
      'begin'
      '  try'
      '    //'#51064#49604' '#47700#49884#51648' '#54869#51064#52285' '#51088#46041' '#45572#47492
      '    hd := FindWindowHandle(CLASS_NAME_TRID, MESSAGE_MODAL);'
      '    if hd > 0 then'
      '    begin'
      
        '      ieWindow := FindWindowEx(hd, 0, '#39'Internet Explorer_Server'#39 +
        ', nil);'
      '      POSTMESSAGE(ieWindow,WM_SETFOCUS,0,0);'
      
        '      POSTMESSAGE(ieWindow, WM_LBUTTONDOWN, MK_LBUTTON, 704 or (' +
        '21 shl 16));'
      
        '      POSTMESSAGE(ieWindow, WM_LBUTTONUP, 0, 703 or (21 shl 16))' +
        ';'
      
        '      POSTMESSAGE(ieWindow, WM_LBUTTONDOWN, MK_LBUTTON, 704 or (' +
        '21 shl 16));'
      
        '      POSTMESSAGE(ieWindow, WM_LBUTTONUP, 0, 703 or (21 shl 16))' +
        ';'
      '    end;'
      '  finally'
      ''
      '  end;'
      'end;')
    TabOrder = 1
  end
end
