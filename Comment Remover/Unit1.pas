unit Unit1;

interface


uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, Graphics, Messages,
  Dialogs, ComCtrls, Gauges, ExtCtrls, Menus, Buttons, ShellCtrls,
  IniFiles, ShellApi, RichEditCls;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Quit1: TMenuItem;
    SaveDialog1: TSaveDialog;
    Save: TMenuItem;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    O1: TMenuItem;
    FontDialog1: TFontDialog;
    F1: TMenuItem;
    C1: TMenuItem;
    N2: TMenuItem;
    S1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    H1: TMenuItem;
    E1: TMenuItem;
    B1: TMenuItem;
    PopupMenu1: TPopupMenu;
    C2: TMenuItem;
    O2: TMenuItem;
    Save1: TMenuItem;
    N5: TMenuItem;
    ColorDialog1: TColorDialog;
    B2: TMenuItem;
    RichEdit1: TRichEdit;
    N6: TMenuItem;
    Panel3: TPanel;
    Gauge1: TGauge;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    Memo1: TMemo;
    Label1: TLabel;
    Highlight1: TMenuItem;
    N7: TMenuItem;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Label3: TLabel;
    ComboBox3: TComboBox;
    ComboBox1: TComboBox;
    Selectall1: TMenuItem;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Paste1: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    About1: TMenuItem;
    Unicode1: TMenuItem;
    UTF81: TMenuItem;
    UTF16LE1: TMenuItem;
    UTF16Be1: TMenuItem;
    ASCII1: TMenuItem;
    ANSI1: TMenuItem;
    Default1: TMenuItem;
    UTF8Boom1: TMenuItem;
    N10: TMenuItem;
    Search1: TMenuItem;
    All1: TMenuItem;
    FindDialog1: TFindDialog;
    Find1: TMenuItem;
    procedure BitBtn1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure Quit1Click(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure S1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure C2Click(Sender: TObject);
    procedure O2Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure B2Click(Sender: TObject);
    procedure H1Click(Sender: TObject);
    procedure RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RichEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RichEdit1Change(Sender: TObject);
    procedure Highlight1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure Selectall1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure All1Click(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure Find1Click(Sender: TObject);
  private
    procedure Progression(EventID:Word;Param:integer);
    procedure DropFiles(var msg: TMessage ); message WM_DROPFILES;

  public
    { Public-Deklarationen }
    procedure WriteOptions;
    procedure ReadOptions;
  end;

var
  Form1 : TForm1;
  TIF : TIniFile;
  Img: TImage;

implementation

uses
  Highlight, PascalDeleter, cppDeleter, htmlDeleter, pythonDeleter,
  TypeScriptDeleter, GoDeleter, RustDeleter, SwiftDeleter, CSharpDeleter,
  PowershellDeleter, RubyDeleter, AdaDeleter, RDeleter, MatlabDeleter;

{$R *.DFM}
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var
  OPT :string;
begin
   OPT := 'Options';

   if not DirectoryExists(MainDir + 'Data\Options\')
   then ForceDirectories(MainDir + 'Data\Options\');

   TIF := TIniFile.Create(MainDir + 'Data\Options\Options.ini');
   with TIF do
   begin
     WriteBool(OPT,'StayTop', S1.Checked);
     WriteBool(OPT,'Edit', E1.Checked);
     WriteBool(OPT,'Backup', B1.Checked);
     WriteInteger(OPT,'Style',ComboBox1.ItemIndex);
     WriteInteger(OPT,'Code',ComboBox2.ItemIndex);
     WriteInteger(OPT,'Compress',ComboBox3.ItemIndex);

     WriteBool(OPT,'Default1',Default1.Checked);
     WriteBool(OPT,'UTF81',UTF81.Checked);
     WriteBool(OPT,'UTF8Boom1',UTF8Boom1.Checked);
     WriteBool(OPT,'UTF16LE1',UTF16LE1.Checked);
     WriteBool(OPT,'UTF16Be1',UTF16Be1.Checked);
     WriteBool(OPT,'ASCII1',ASCII1.Checked);
     WriteBool(OPT,'ANSI1',ANSI1.Checked);
    Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var
  OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Options.ini') then
  begin
  TIF:=TIniFile.Create(MainDir + 'Data\Options\Options.ini');
    with TIF do
    begin
      S1.Checked:=ReadBool(OPT,'StayTop', S1.Checked);
      E1.Checked:=ReadBool(OPT,'Edit', E1.Checked);
      B1.Checked:=ReadBool(OPT,'Backup', B1.Checked);
      ComboBox1.ItemIndex:=ReadInteger(OPT,'Style',ComboBox1.ItemIndex);
      ComboBox2.ItemIndex:=ReadInteger(OPT,'Code',ComboBox2.ItemIndex);
      ComboBox3.ItemIndex:=ReadInteger(OPT,'Compress',ComboBox3.ItemIndex);
      Default1.Checked:=ReadBool(OPT,'Default1', Default1.Checked);
      UTF81.Checked:=ReadBool(OPT,'UTF81', UTF81.Checked);
      UTF8Boom1.Checked:=ReadBool(OPT,'UTF8Boom1', UTF8Boom1.Checked);
      UTF16LE1.Checked:=ReadBool(OPT,'UTF16LE1', UTF16LE1.Checked);
      UTF16Be1.Checked:=ReadBool(OPT,'UTF16Be1', UTF16Be1.Checked);
      ASCII1.Checked:=ReadBool(OPT,'ASCII1', ASCII1.Checked);
      ANSI1.Checked:=ReadBool(OPT,'ANSI1', ANSI1.Checked);
      Free;
    end;
  end;
end;

procedure FileCopy(von,nach:string);
var
  src,dest : tFilestream;
begin
  src := tFilestream.create(von,fmShareDenyNone or fmOpenRead);
  try
    dest := tFilestream.create(nach,fmCreate);
    try
      dest.copyfrom(src,src.size);
    finally
      dest.free;
    end;
  finally
    src.free;
  end;
end;

procedure TForm1.DropFiles(var msg: TMessage );
var
  i, count  : integer;
  dropFileName : array [0..511] of Char;
  MAXFILENAME: integer;
begin
  try
    Img.Visible := false;
    RichEdit1.Clear;
  except
  end;

  MAXFILENAME := 511;
  count := DragQueryFile(msg.WParam, $FFFFFFFF, dropFileName, MAXFILENAME);
  for i := 0 to count - 1 do
  begin
    DragQueryFile(msg.WParam, i, dropFileName, MAXFILENAME);
    RichEdit1.Lines.LoadFromFile(dropFileName);
  end;
  StatusBar1.Panels[0].Text := ExtractFileName(dropFileName);
  StatusBar1.Panels[2].Text := IntToStr(RichEdit1.Lines.Count);
  DragFinish(msg.WParam);
  RichEdit1.Color := clWhite;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i : integer;
begin
  RichEdit1.DoubleBuffered := true;

  DragAcceptFiles(Handle, True);
  RichEdit1.MaxLength := $7FFFFFF0;
  RichEdit1.PlainText:=true;

  Img:= TImage.Create(RichEdit1);
  Img.Transparent := true;
  Img.Height := RichEdit1.Height;
  Img.Width := RichEdit1.Width;
  Img.Left := (RichEdit1.Width div 2) - 50 ;
  Img.Top := (RichEdit1.Height div 2) - 50 ;
  Img.Picture.Bitmap.LoadFromFile(MainDir + 'Data\Plain\drag.bmp');
  Img.Parent := RichEdit1;
  RichEdit1.Invalidate;

  for i := 0 to 100 do
    begin
      Memo1.Lines.Add('|-');
    end;
end;

procedure TForm1.Paste1Click(Sender: TObject);
begin
  RichEdit1.PasteFromClipboard;
end;

procedure TForm1.Progression(EventID:Word;Param:integer);
begin
  case EventID of
    PAS_Base:;
    PAS_Restart, PAS_End:   Gauge1.Progress:=0;
    PAS_SetMax:             Gauge1.MaxValue:=Param;
    PAS_Increment:          Gauge1.Progress:=Gauge1.Progress+1;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  PerCent : real;
begin
  StatusBar1.SetFocus;

  if RichEdit1.Text = '' then begin
    Beep;
    MessageDlg('No Code to remove comments...',mtInformation, [mbOK], 0);
    RichEdit1.SetFocus;
    Exit;
  end;

  DragAcceptFiles(Handle, false);

  if B1.Checked = true then begin
    FileCopy(StatusBar1.Panels[0].Text, MainDir + 'Data\Backup\' +
                                  ExtractFileName(StatusBar1.Panels[0].Text));
  end;
  
  Screen.Cursor := crHourGlass;

  case ComboBox2.ItemIndex of
  0 : begin
        // pascal comment remover
        PAS_SetProgression(Progression);
        PerCent := PAS_NoComments(RichEdit1.Lines);
      end;

  1 : begin
        // c/c++ comment remover
        PAS_SetProgressionCpp(Progression);
        PerCent := PAS_NoCommentsCpp(RichEdit1.Lines);
      end;

  2 : begin
        // javascript comment remover
        PAS_SetProgressionCpp(Progression);
        PerCent := PAS_NoCommentsCpp(RichEdit1.Lines);
      end;

  3 : begin
        // html comment remover
        PAS_SetProgressionhtml(Progression);
        PerCent := PAS_NoCommentshtml(RichEdit1.Lines);
      end;

  4 : begin
        // python comment remover
        PAS_SetProgressionPython(Progression);
        PerCent := PAS_NoCommentsPython(RichEdit1.Lines);
      end;

  5 : begin
        // typescript comment remover
        PAS_SetProgressionTypeScript(Progression);
        PerCent := PAS_NoCommentsTypeScript(RichEdit1.Lines);
      end;

  6 : begin
        PAS_SetProgressionGo(Progression);
        PerCent := PAS_NoCommentsGo(RichEdit1.Lines);
      end;

  7 : begin
        // rust comment remover
        PAS_SetProgressionRust(Progression);
        PerCent := PAS_NoCommentsRust(RichEdit1.Lines);
      end;

  8 : begin
        // swift comment remover
        PAS_SetProgressionSwift(Progression);
        PerCent := PAS_NoCommentsSwift(RichEdit1.Lines);
      end;

  9 : begin
        // csharp comment remover
        PAS_SetProgressionCSharp(Progression);
        PerCent := PAS_NoCommentsCSharp(RichEdit1.Lines);
      end;

  10 : begin
        // powershell comment remover
        PAS_SetProgressionPowershell(Progression);
        PerCent := PAS_NoCommentsPowershell(RichEdit1.Lines);
      end;

  11 : begin
        // ruby comment remover
        PAS_SetProgressionRuby(Progression);
        PerCent := PAS_NoCommentsRuby(RichEdit1.Lines);
      end;

  12 : begin
        // ada comment remover
        PAS_SetProgressionAda(Progression);
        PerCent := PAS_NoCommentsAda(RichEdit1.Lines);
      end;

  13 : begin
        // R comment remover
        PAS_SetProgressionR(Progression);
        PerCent := PAS_NoCommentsR(RichEdit1.Lines);
      end;

  14 : begin
        // matlab comment remover
        PAS_SetProgressionMatlab(Progression);
        PerCent := PAS_NoCommentsMatlab(RichEdit1.Lines);
      end;
  end;


  if PerCent =-1 then
  begin
    MessageBox(Form1.Handle,Pchar('An error has probably occurred...'),Pchar('Failed'),
            MB_ICONINFORMATION + MB_SYSTEMMODAL + MB_SETFOREGROUND + MB_TOPMOST);

  end else begin
    Beep;
    MessageBox(Form1.Handle,Pchar('Final size relative to the starting one : '+
                FloatToStr(PerCent) + '%'),Pchar('Remove Comments finish!'),
              MB_ICONINFORMATION + MB_SYSTEMMODAL + MB_SETFOREGROUND + MB_TOPMOST);
    StatusBar1.Panels[2].Text := IntToStr(RichEdit1.Lines.Count);
  end;

  StatusBar1.Panels[2].Text := IntToStr(RichEdit1.Lines.Count);
  Screen.Cursor := crDefault;
  DragAcceptFiles(Handle, True);

  with RichEdit1 do
  begin
    SelStart := Perform(EM_LINEINDEX, 0, 0);
    Perform(EM_SCROLLCARET, 0, 0);
  end;
  RichEdit1.Color := clWhite;
end;

procedure TForm1.Open1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Screen.Cursor := crHourGlass;
    RichEdit1.Color := clWhite;

    try
      Img.Visible := false;
      RichEdit1.Clear;
    except
    end;

    RichEdit1.Lines.LoadFromFile(OpenDialog1.FileName);
    StatusBar1.Panels[0].Text := ExtractFileName(OpenDialog1.FileName);
    StatusBar1.Panels[2].Text := IntToStr(RichEdit1.Lines.Count);
  end;

  Screen.Cursor := crDefault;
end;

procedure TForm1.SaveClick(Sender: TObject);
begin
  BitBtn2.Click;
end;

procedure TForm1.Selectall1Click(Sender: TObject);
begin
  RichEdit1.SelectAll;
end;

procedure TForm1.Quit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  StatusBar1.SetFocus;

  if RichEdit1.Text = '' then begin
    Beep;
    MessageDlg('No Code to save...',mtInformation, [mbOK], 0);
    RichEdit1.SetFocus;
    Exit;
  end;

  SaveDialog1.FileName := StatusBar1.Panels[0].Text;

  if SaveDialog1.Execute then
  begin
    // unicode export
    if Default1.Checked = true then
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.Default);

    if UTF81.Checked = true then
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.UTF8);

    if UTF8Boom1.Checked = true then
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.UTF8);

    if UTF16LE1.Checked = true then
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.Unicode);

    if UTF16Be1.Checked = true then
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.BigEndianUnicode);

    if ASCII1.Checked = true then
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.ASCII);

    if ANSI1.Checked = true then
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.ANSI);

    if SaveDialog1.FilterIndex = 15 then
    begin
      RichEdit1.Lines.SaveToFile(SaveDialog1.FileName, TEncoding.Default);
    end;

  end;
end;

procedure TForm1.F1Click(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    RichEdit1.Font := FontDialog1.Font;
    RichEdit1.Update;
  end;
end;

procedure TForm1.Find1Click(Sender: TObject);
begin
  FindDialog1.Execute;
end;

procedure TForm1.FindDialog1Find(Sender: TObject);
const
  TWordSeperators: set of Char = ['A'..'Z', 'a'..'z', 'ö', 'Ö', 'Ä', 'ä', 'ü', 'Ü', 'ß',
  '´', '`', '@', '0'..'9'];
var
  Buffer: String;
  CmpText: String;
  Position: Integer;
  Counter: Integer;
  Left, Right: Boolean;
  Hit: Boolean;
begin
  if not (frMatchCase in Finddialog1.Options) then
  begin
    CmpText:=AnsiUpperCase(Finddialog1.FindText);
    Buffer := AnsiUpperCase(Copy(RichEdit1.Text, RichEdit1.SelStart+RichEdit1.SelLength+1,
      Length(RichEdit1.Text)))
  end
  else
  begin
    CmpText := Finddialog1.FindText;
    Buffer:=Copy(RichEdit1.Text,RichEdit1.SelStart+RichEdit1.SelLength+1,Length(RichEdit1.Text));
  end;

  Position:=AnsiPos(CmpText, Buffer);

  if Position > 0 then
  begin
    if frWholeWord in FindDialog1.Options then
    begin
      Counter:=0;
      Position:=AnsiPos(CmpText, Buffer);
      Hit:=False;
      while (Position > 0) and not Hit do
      begin
        Left:=(Position = 1) or (not (Buffer[Position-1] in TWordSeperators));
        Right:=(Position+Length(Finddialog1.FindText) >= Length(Buffer)) or
          (not (Buffer[Position+Length(Finddialog1.FindText)] in TWordSeperators));
        Hit:=Left and Right;
        Inc(Counter, Position);
        Delete(Buffer, 1, Position);
        Position:=Pos(CmpText, Buffer);
      end;

      if Hit then
      begin
        RichEdit1.SelStart:= RichEdit1.SelStart+RichEdit1.SelLength+Counter-1;
        RichEdit1.SelLength:= Length(Finddialog1.FindText);
      end
      else
        FindDialog1.CloseDialog;
    end
    else
    begin
      RichEdit1.SelStart:= RichEdit1.SelStart+RichEdit1.SelLength+Position-1;
      RichEdit1.SelLength:= Length(Finddialog1.FindText);
    end;
  end
  else
    FindDialog1.CloseDialog;
  RichEdit1.SetFocus;
end;

procedure TForm1.C1Click(Sender: TObject);
begin
  RichEdit1.Clear;
  StatusBar1.Panels[0].Text := '';
  StatusBar1.Panels[2].Text := '0';
  StatusBar1.Panels[4].Text := '0';

  //Img:= TImage.Create(RichEdit1);
  Img.Height := RichEdit1.Height;
  Img.Width := RichEdit1.Width;
  Img.Left := (RichEdit1.Width div 2) - 50 ;
  Img.Top := (RichEdit1.Height div 2) - 50 ;
  Img.Picture.Bitmap.LoadFromFile(MainDir + 'Data\Plain\drag.bmp');
  Img.Parent := RichEdit1;
  RichEdit1.Invalidate;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ReadOptions;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteOptions;
  Application.Terminate;
end;

procedure TForm1.S1Click(Sender: TObject);
begin
  if S1.Checked = true then begin
    SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
               SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end else begin
    SetWindowPos(Handle, HWND_NOTOPMOST, Left,Top, Width,Height,
               SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  S1.OnClick(sender);
  E1.OnClick(sender);
end;

procedure TForm1.E1Click(Sender: TObject);
begin
  if E1.Checked = true then begin
    RichEdit1.ReadOnly := false;
    RichEdit1.Color := clWhite;
  end else begin
    RichEdit1.ReadOnly := true;
    RichEdit1.Color := cl3DLight;
  end;
end;

procedure TForm1.C2Click(Sender: TObject);
begin
  C1.Click;
  E1.OnClick(sender);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  StatusBar1.SetFocus;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  StatusBar1.SetFocus;
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  StatusBar1.SetFocus;
end;

procedure TForm1.Copy1Click(Sender: TObject);
begin
  RichEdit1.Perform(WM_COPY,0,0);
end;

procedure TForm1.Cut1Click(Sender: TObject);
begin
  RichEdit1.CutToClipboard;
end;

procedure TForm1.O2Click(Sender: TObject);
begin
  Open1.Click;
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
  BitBtn2.Click;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  if Gauge1.Width < 2 then Gauge1.Width := 1;
  if RichEdit1.Lines.Count > 0 then Exit;

  try
    Img.Height := RichEdit1.Height;
    Img.Width := RichEdit1.Width;
    Img.Left := (RichEdit1.Width div 2) - 50 ;
    Img.Top := (RichEdit1.Height div 2) - 50 ;
    Img.Picture.Bitmap.LoadFromFile(MainDir + 'Data\Plain\drag.bmp');
    Img.Parent := RichEdit1;
  finally
    RichEdit1.Invalidate;
  end;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  MessageDlg('Comment Remover v1.1' +chr(10)+  chr(10)+
             'Code by hackbard'+chr(10)+
             'Copyright © 2026'+chr(10)+
             'github.com | Release',mtInformation, [mbOK], 0);
end;

procedure TForm1.All1Click(Sender: TObject);
var
  reh: TRichEditHelper;
  sl: TStringList;
  str : string;
begin
  str := InputBox('Find all Positions','Find :','...');
  reh := TRichEditHelper.Create(RichEdit1);
  sl := TStringList.Create;
  try
    sl.Add(str);
    StatusBar1.Panels[6].Text := IntToStr(reh.HighlightWords(sl,
                                          [fsBold, fsUnderline], clRed));
    RichEdit1.SelStart := 0;
  finally
    FreeAndNil(sl);
    FreeAndNil(reh);
  end;
end;

procedure TForm1.B2Click(Sender: TObject);
begin
  if ColorDialog1.Execute then begin
  RichEdit1.Color := ColorDialog1.Color;
  end;
end;

procedure TForm1.H1Click(Sender: TObject);
begin
  if RichEdit1.Text = '' then begin
    Beep;
    MessageDlg('No Code for highlighting...',mtInformation, [mbOK], 0);
    RichEdit1.SetFocus;
    Exit;
  end;

  CodeColors(Form1,'normal', RichEdit1, true);
end;

procedure TForm1.Highlight1Click(Sender: TObject);
begin
  H1.Click;
end;

procedure TForm1.RichEdit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  StatusBar1.Panels[4].Text := IntToStr(RichEdit1.CaretPos.Y);
end;

procedure TForm1.RichEdit1Change(Sender: TObject);
begin
  if RichEdit1.Text = ''  then
  begin
    Img:= TImage.Create(RichEdit1);
    Img.Height := RichEdit1.Height;
    Img.Width := RichEdit1.Width;
    Img.Left := (RichEdit1.Width div 2) - 50 ;
    Img.Top := (RichEdit1.Height div 2) - 50 ;
    Img.Picture.Bitmap.LoadFromFile(MainDir + 'Data\Plain\drag.bmp');
    Img.Parent := RichEdit1;
    RichEdit1.Invalidate;
    E1.OnClick(sender);
    Selectall1.Enabled := false;
    Copy1.Enabled := false;
    Cut1.Enabled := false;
    C1.Enabled := false;
    C2.Enabled := false;
    Find1.Enabled := false;
    All1.Enabled := false;
  end else begin
    Img.Visible := false;
    Selectall1.Enabled := true;
    Copy1.Enabled := true;
    Cut1.Enabled := true;
    C1.Enabled := true;
    C2.Enabled := true;
    Find1.Enabled := true;
    All1.Enabled := true;
  end;
  StatusBar1.Panels[2].Text := IntToStr(RichEdit1.Lines.Count);
end;

procedure TForm1.RichEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  StatusBar1.Panels[4].Text := IntToStr(RichEdit1.CaretPos.Y);
end;

end.
