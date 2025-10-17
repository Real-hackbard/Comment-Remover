unit Unit1;

interface


uses
  Windows, SysUtils, Classes, Controls, Forms, StdCtrls, Graphics, Messages,
  Dialogs, ComCtrls, Gauges, ExtCtrls, Menus, Buttons, ShellCtrls,
  IniFiles, ShellApi, cppDeleter, htmlDeleter, pythonDeleter;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    Fichier1: TMenuItem;
    Ouvrir1: TMenuItem;
    N1: TMenuItem;
    Quitter1: TMenuItem;
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
    Image1: TImage;
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
    procedure BitBtn1Click(Sender: TObject);
    procedure Ouvrir1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
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
  private
    procedure Progression(EventID:Word;Param:integer);
    procedure DropFiles(var msg: TMessage ); message WM_DROPFILES;

  public
    { Public-Deklarationen }
    procedure WriteOptions;
    procedure ReadOptions;
  end;

var Form1 : TForm1;
    TIF : TIniFile;
    Img: TImage;

implementation

uses PascalDeleter, Highlight;

{$R *.DFM}
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var OPT :string;
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

   //WriteBool(OPT,'SaveOptions',CheckBox1.Checked);
   //WriteInteger(OPT,'Compress',Combobox1.ItemIndex);
   //WriteInteger(OPT,'Overlay',RadioGroup1.ItemIndex);
   Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var OPT:string;
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

  //CheckBox1.Checked:=ReadBool(OPT,'SaveOptions',CheckBox1.Checked);
  //Combobox1.ItemIndex:=ReadInteger(OPT,'Compress',combobox1.ItemIndex);
  //RadioGroup1.ItemIndex:=ReadInteger(OPT,'Overlay',RadioGroup1.ItemIndex);
  Free;
  end;
  end;
end;

procedure FileCopy(von,nach:string);
var src,dest : tFilestream;
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
  Img.Picture.Assign(Image1.Picture);
  Img.Parent := RichEdit1;
  RichEdit1.Invalidate;

  for i := 0 to 100 do
    begin
      Memo1.Lines.Add('|-');
    end;
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

  if StatusBar1.Panels[0].Text = '' then begin
    Beep;
    MessageDlg('No Code File loaded...',mtInformation, [mbOK], 0);
    RichEdit1.SetFocus;
    Exit;
  end;

  DragAcceptFiles(Handle, false);

  if B1.Checked = true then begin
    FileCopy(StatusBar1.Panels[0].Text, MainDir + 'Data\Backup\' + ExtractFileName(StatusBar1.Panels[0].Text));
  end;
  
  Screen.Cursor := crHourGlass;

  case ComboBox2.ItemIndex of
  0 : begin
      PAS_SetProgression(Progression);
      PerCent := PAS_NoComments(RichEdit1.Lines);
      end;

  1 : begin
      PAS_SetProgressionCpp(Progression);
      PerCent := PAS_NoCommentsCpp(RichEdit1.Lines);
      end;

  2 : begin
      PAS_SetProgressionCpp(Progression);
      PerCent := PAS_NoCommentsCpp(RichEdit1.Lines);
      end;

  3 : begin
      PAS_SetProgressionhtml(Progression);
      PerCent := PAS_NoCommentshtml(RichEdit1.Lines);
      end;

  4 : begin
      PAS_SetProgressionPython(Progression);
      PerCent := PAS_NoCommentsPython(RichEdit1.Lines);
      end;
  end;


  if PerCent =-1 then begin
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

procedure TForm1.Ouvrir1Click(Sender: TObject);
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

procedure TForm1.Quitter1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  StatusBar1.SetFocus;

  if RichEdit1.Text = '' then begin
    Beep;
    MessageDlg('No Code File loaded...',mtInformation, [mbOK], 0);
    RichEdit1.SetFocus;
    Exit;
  end;

  SaveDialog1.FileName := StatusBar1.Panels[0].Text;

  if SaveDialog1.Execute then begin
    RichEdit1.Lines.SaveToFile(SaveDialog1.FileName);
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
  Img.Picture.Assign(Image1.Picture);
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

procedure TForm1.O2Click(Sender: TObject);
begin
  Ouvrir1.Click;
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
    Img.Picture.Assign(Image1.Picture);
    Img.Parent := RichEdit1;
  finally
    RichEdit1.Invalidate;
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
  if StatusBar1.Panels[0].Text = '' then begin
    Beep;
    MessageDlg('No Code File loaded...',mtInformation, [mbOK], 0);
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
    Img.Picture.Assign(Image1.Picture);
    Img.Parent := RichEdit1;
    RichEdit1.Invalidate;
    E1.OnClick(sender);
  end else begin
    Img.Visible := false;
  end;
end;

procedure TForm1.RichEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  StatusBar1.Panels[4].Text := IntToStr(RichEdit1.CaretPos.Y);
end;

end.
