unit Highlight;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, StrUtils, Unit1;

procedure CodeColors(Form : TForm;Style : String; RichE : TRichedit;InVisible : Boolean);

implementation

procedure CodeColors(Form : TForm;Style : String; RichE : TRichedit; InVisible : Boolean);
const
  // symbols...
  CodeC1: array[0..20] of String = ('#','$','(',')','*',',',
          '.','/',':',';','[',']','{','}','<','>',
          '-','=','+','''','@');
  // These entries are highlighted by the style..
  // If there is a change, the loop must be adjusted
  CodeC2: array[0..44] of String = ('and','as','begin',
          'case','char','class','const','downto',
          'else','end','except','finally','for',
          'forward','function','if','implementation','interface',
          'is','nil','or','private','procedure','public','raise',
          'repeat','string','to','try','type','unit','uses','var',
          'while','external','stdcall','do','until','array','of',
          'in','shr','shl','cos','div');
var
  FoundAt : LongInt;
  StartPos, ToEnd, i : integer;
  OldCap, T : String;
  FontC, BackC, C1, C2 ,C3 ,strC, strC1, Gray : TColor;
begin
  OldCap := Form.Caption;
  with RichE do
  begin
    Font.Name := 'Courier New';
    Font.Size := 10;

    // Main style to the entire text
    if WordWrap then WordWrap := false;
      SelectAll;
      SelAttributes.color := clBlack;
      SelAttributes.Style := [];
      SelStart := 0;

    // Richedit is disabled for the processing time to speed up the process
    if InVisible then
      begin
        Visible := False;
        Form.Caption := 'Executing Code Highlighting, please wait...';
      end;
    end;

  // Colors for the basic setting
  BackC := clWhite;   // Background Color
  FontC := clBlack;   // Font Color
  C1 := clBlack;      // Integer Color
  C2 := clBlack;      // Comments Color
  C3 := clBlack;      // function Color
  strC := clBlue;     // parameter Color
  strC1 := clGreen;   // brace Color
  Gray := clGray;     // Comment Color

  // Styles
  case Form1.ComboBox1.ItemIndex of
  0 : style := 'Twilight';
  1 : style := 'Default';
  2 : style := 'Ocean';
  3 : style := 'Classic';
  4 : style := 'Oldskool';
  end;

  if Style = 'Twilight' then
  begin
    BackC := clBlack;
    FontC := clWhite;
    C1 := clLime;
    C2 := clSilver;
    C3 := clAqua;
    strC := clYellow;
    strC1 := clRed;
  end
  else
  if Style = 'Default' then
  begin
    BackC := clWhite;
    FontC := clBlack;
    C1 := clTeal;
    C2 := clMaroon;
    C3 := clBlue;
    strC := clMaroon;
    strC1 := clSilver;
  end
  else
  if Style = 'Ocean' then
  begin
    BackC := $00FFFF80;
    FontC := clBlack;
    C1 := clMaroon;
    C2 := clBlack;
    C3 := clBlue;
    strC := clTeal;
    strC1 := clBlack;
  end
  else
  if Style = 'Classic' then
  begin
    BackC := clNavy;
    FontC := clYellow;
    C1 := clLime;
    C2 := clSilver;
    C3 := clWhite;
    strC := clAqua;
    strC1 := clSilver;
  end
  else

  if Style = 'Oldskool' then
  begin
    BackC := $3288877;
    FontC := clYellow;
    C1 := clLime;
    C2 := clSilver;
    C3 := clWhite;
    strC := clAqua;
    strC1 := clSilver;
  end
  else

  begin
    // Highlighting the features
    with RichE do
    begin
      RichE.Lines.BeginUpdate;
      // Information for  different Styles Line intigrate when you want
      //T := '{'+Style+' = Invalid Style [Default,Classic,Twilight,Ocean] ONLY! ';
      //Lines.Insert(0,T);
      StartPos := 0;
      ToEnd := Length(Text) - StartPos;
      FoundAt := FindText(T, StartPos, ToEnd, [stWholeWord]);
      SelStart := FoundAt;
      SelLength := Length(T);
      SelAttributes.Color := clRed;
      SelAttributes.Style := [fsBold];
      StartPos := 0;
      ToEnd := Length(Text) - StartPos;
      FoundAt := FindText('ONLY!', StartPos, ToEnd, [stWholeWord]);
      SelStart := FoundAt;
      SelLength := 4;
      SelAttributes.Color := clRed;
      SelAttributes.Style := [fsBold,fsUnderLine];
      RichE.Lines.EndUpdate;
    end;
  end;

  RichE.SelectAll;
  RichE.color := BackC;
  RichE.SelAttributes.color := FontC;

  // Highlight all numbers in the code except those in parentheses
  for i := 0 to 100 do
  begin
    with RichE do
    begin
      RichE.Lines.BeginUpdate;
      StartPos := 0;
      ToEnd := Length(Text) - StartPos;
      FoundAt := FindText(IntToStr(i), StartPos, ToEnd, [stWholeWord]);
      while (FoundAt <> -1) do
      begin
        SelStart := FoundAt;
        SelLength := Length(IntToStr(i));
        SelAttributes.Color := C1;
        SelAttributes.Style := [];
        StartPos := FoundAt + Length(IntToStr(i));
        FoundAt := FindText(IntToStr(i), StartPos, ToEnd, [stWholeWord]);
      end;
      RichE.Lines.EndUpdate;
    end;
  end;

  // Highlighting all symbols defined as an array above
  for i := 0 to 20 do
  begin
    with RichE do
    begin
      RichE.Lines.BeginUpdate;
      StartPos := 0;
      ToEnd := Length(Text) - StartPos;
      FoundAt := FindText(CodeC1[i], StartPos, ToEnd, []);
      while (FoundAt <> -1) do
      begin
        SelStart := FoundAt;
        SelLength := Length(CodeC1[i]);
        SelAttributes.Color := C2;
        StartPos := FoundAt + Length(CodeC1[i]);
        FoundAt := FindText(CodeC1[i], StartPos, ToEnd, []);
      end;
      RichE.Lines.EndUpdate;
    end;
  end;

  // Highlight all functions defined as arrays.
  // When adding or removing words,
  // the number of loops must be adjusted.
  for i := 0 to 44 do
  begin
    with RichE do
    begin
      RichE.Lines.BeginUpdate;
      StartPos := 0;
      ToEnd := Length(Text) - StartPos;
      FoundAt := FindText(CodeC2[i], StartPos, ToEnd, [stWholeWord]);
      while (FoundAt <> -1) do
      begin
        SelStart := FoundAt;
        SelLength := Length(CodeC2[i]);
        SelAttributes.Color := C3;
        SelAttributes.Style := [fsBold];
        StartPos := FoundAt + Length(CodeC2[i]);
        FoundAt := FindText(CodeC2[i], StartPos, ToEnd, [stWholeWord]);
      end;
      RichE.Lines.EndUpdate;
    end;
  end;

  // Coloring all comments that are behind a "//" up to the line break
  Startpos := 0;
  with RichE do
  begin
    RichE.Lines.BeginUpdate;
    FoundAt := FindText('//', StartPos, Length(Text), []);
    while FoundAt <> -1 do
    begin
      SelStart := FoundAt;
      Startpos := FoundAt+1;
      FoundAt := FindText(#13#10, StartPos, Length(Text), []);
      if FoundAt <> -1 then
      begin
        SelLength := (FoundAt - selstart)+1;
        SelAttributes.Style := [];
        SelAttributes.Color := clGray;
        StartPos := FoundAt+1;
        FoundAt := FindText('//', StartPos, Length(Text), []);
      end;
    end;
    RichE.Lines.EndUpdate;
  end;

  // Color all characters inside the curly bracket
  Startpos := 0;
  with RichE do
  begin
    RichE.Lines.BeginUpdate;
    FoundAt := FindText('{', StartPos, Length(Text), []);
    while FoundAt <> -1 do
    begin
      SelStart := FoundAt;
      Startpos := FoundAt+1;
      FoundAt := FindText('}', StartPos, Length(Text), []);
      if FoundAt <> -1 then
      begin
        SelLength := (FoundAt - selstart)+1;
        SelAttributes.Style := [];
        SelAttributes.Color := strC1;
        StartPos := FoundAt+1;
        FoundAt := FindText('{', StartPos, Length(Text), []);
      end;
    end;
    RichE.Lines.EndUpdate;
  end;

  // Coloring all strings within the commercial
  Startpos := 0;
  with RichE do
  begin
    RichE.Lines.BeginUpdate;
    FoundAt := FindText('''', StartPos, Length(Text), []);
    while FoundAt <> -1 do
    begin
      SelStart := FoundAt;
      Startpos := FoundAt+1;
      FoundAt := FindText('''', StartPos, Length(Text), []);
      if FoundAt <> -1 then
      begin
        SelLength := (FoundAt - selstart)+1;
        SelAttributes.Style := [];
        SelAttributes.Color := strC1;
        StartPos := FoundAt+1;
        FoundAt := FindText('''', StartPos, Length(Text), []);
      end;
    end;
    RichE.Lines.EndUpdate;
  end;

  // Color all strings within the brackets and star
  Startpos := 0;
  with RichE do
  begin
    RichE.Lines.BeginUpdate;
    FoundAt := FindText('(*', StartPos, Length(Text), []);
    while FoundAt <> -1 do
    begin
      SelStart := FoundAt;
      Startpos := FoundAt+1;
      FoundAt := FindText('*)', StartPos, Length(Text), []);
      if FoundAt <> -1 then
      begin
        SelLength := (FoundAt - selstart)+1;
        SelAttributes.Style := [];
        SelAttributes.Color := clGray;
        StartPos := FoundAt+1;
        FoundAt := FindText('(*', StartPos, Length(Text), []);
      end;
    end;
    RichE.Lines.EndUpdate;
  end;

  // Color all strings within the corner brackets
  Startpos := 0;
  with RichE do
  begin
    RichE.Lines.BeginUpdate;
    FoundAt := FindText('[', StartPos, Length(Text), []);
    while FoundAt <> -1 do
    begin
      SelStart := FoundAt;
      Startpos := FoundAt+1;
      FoundAt := FindText(']', StartPos, Length(Text), []);
      if FoundAt <> -1 then
      begin
        SelLength := (FoundAt - selstart)+1;
        SelAttributes.Style := [];
        SelAttributes.Color := strC;
        StartPos := FoundAt+1;
        FoundAt := FindText('[', StartPos, Length(Text), []);
      end;
    end;
    RichE.Lines.EndUpdate;
  end;


  if InVisible then
  begin
    RichE.Visible := True;
    Form.Caption := OldCap;
  end;
  RichE.SelStart := 0;
end;



end.
