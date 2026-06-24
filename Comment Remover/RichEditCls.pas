unit RichEditCls;

interface

uses
  ComCtrls, Classes, Graphics;

type
  TWordDelimiter = set of Char;

var
  WordDelimiter: TWordDelimiter = [#1..#64, #91..#96, #123..#127];

type
  TRichEditHelper = class(TObject)
  private
    { Private-Deklarationen}
    FRichEdit: TRichEdit;
    function GetWords: Integer;
  public
    { Public-Deklarationen}
    constructor Create(RichEdit: TRichEdit);
    property CountWords: Integer read GetWords;
    function Find(StartPos: Integer; const SubStr: string; WholeWord: Boolean):
      Integer;
    function HighLightWords(Words: TStrings; FontStyle: TFontStyles; Color:
      TColor): Cardinal;
  end;

implementation

constructor TRichEditHelper.Create(RichEdit: TRichEdit);
begin
  inherited Create;
  FRichEdit := RichEdit;
end;

function TRichEditHelper.GetWords: Integer;
var
  p: PChar;
  CntWords: Cardinal;
begin
  CntWords := 0;
  p := PChar(FRichEdit.Text);
  while p^ <> #0 do
  begin
    if p^ in WordDelimiter then
      Inc(p)
    else
    begin
      while not (p^ in WordDelimiter) do
        Inc(p);
      Inc(CntWords);
    end;
  end;
  result := CntWords;
end;

function TRichEditHelper.Find(StartPos: Integer; const SubStr: string;
  WholeWord:
  Boolean): Integer;
begin
  if WholeWord then
    Result := FRichEdit.FindText(SubStr, StartPos, Length(FRichedit.Text) -
      StartPos, [stWholeWord])
  else
    Result := FRichEdit.FindText(SubStr, StartPos, Length(FRichedit.Text) -
      StartPos, []);
end;

function TRichEditHelper.HighlightWords(Words: TStrings; FontStyle:
  TFontStyles;
  Color: TColor): Cardinal;
var
  i: Integer;
  LastWordPos: Integer;
  HighLightedWords: Cardinal;
begin
  LastWordPos := 0;
  HighLightedWords := 0;
  FRichEdit.Lines.BeginUpdate;
  for i := 0 to Words.Count - 1 do
  begin
    while LastWordPos <> 1 do
    begin
      LastWordPos := Find(LastWordPos, Words[i], True);
      FRichEdit.SelStart := LastWordPos;
      FRichEdit.SelLength := length(Words[i]);
      FRichEdit.SelAttributes.Color := Color;
      FRichEdit.SelAttributes.Style := FontStyle;
      LastWordPos := LastWordPos + 2;
      Inc(HighLightedWords);
    end;
    LastWordPos := 0;
  end;
  FRichEdit.Lines.EndUpdate;
  result := HighLightedWords;
end;

end.

