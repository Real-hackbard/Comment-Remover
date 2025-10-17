unit cppDeleter;

interface

{$HINTS OFF}

uses Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
     ComCtrls, ExtCtrls, StdCtrls;

type TPurifyEvent = procedure (EventID:Word; Param:integer) of object;

const PAS_Base      = $F00;
      PAS_Restart   = PAS_Base + 1;
      PAS_SetMax    = PAS_Base + 2;
      PAS_Increment = PAS_Base + 3;
      PAS_End       = PAS_Base + 4;

  procedure PAS_SetProgressionCpp(Eventer:TPurifyEvent);
   function PAS_NoCommentsCpp(RE:TStrings):real;

implementation

uses Unit1;

var ProgrssEventer : TPurifyEvent;

function OnlySpaces(R:string):boolean;
var x : integer;
begin
    OnlySpaces:=true;
    for x:=1 to Length(R) do
      if (R[x]<>' ') and (Pos(R[x],#13#10)=0) then
        begin
          OnlySpaces:=false;
          Break;
        end;
end;

procedure PAS_SetProgressionCpp(Eventer : TPurifyEvent);
begin
  if Assigned(Eventer) then ProgrssEventer := Eventer;
end;

function PAS_NoCommentsCpp(RE:TStrings):real;
const C_CtesChars              = '()*/';
var   s, r, TmpChars           : string;
      x, LenStart              : integer;
      Strng, Comment, CmtLine,
      Key, NwLine, Directive   : boolean;
      c, L1, L2                : string;
label Mark;
begin
  PAS_NoCommentsCpp := -1;
  s := RE.Text;
  LenStart:=Length(s);
  if LenStart = 0 then
    begin
      PAS_NoCommentsCpp := 100;
      Exit;
    end;
  r:='';
  if Assigned(ProgrssEventer) then
    begin
      ProgrssEventer(PAS_Restart,0);
      ProgrssEventer(PAS_SetMax,Length(s)+RE.Count);
    end;

  Comment := false;
  Strng:=false;
  CmtLine:=false;
  TmpChars:='';
  Key:=false;
  NwLine:=true;
  Directive:=false;

  for x:=1 to LenStart do
    begin
      if Assigned(ProgrssEventer) then ProgrssEventer(PAS_Increment,0);
      c:=s[x];

      Application.ProcessMessages;

      if (c='''') and (not Comment) and (not CmtLine) then
        Strng := not Strng;

      if (c=#13) or (c=#10) then
        if x < Length(s) then
          if Pos(s[x+1],#13#10)=0 then
            begin
              CmtLine:=false;
              Strng:=false;
              NwLine:=true;
              Goto Mark;
            end;

      if (not Strng) and (c<>'''') and (not CmtLine) then
        begin
          (*
          if c='{' then
            begin
              if x<Length(s) then
                if s[x+1]='$' then
                  Directive:=true;
              if not Directive then
                begin
                  c:='';
                  Comment := true;
                  Continue;
                end;
            end;

          if c='}' then
            begin
              if not Directive then
                begin
                  c:='';
                  Comment := false;
                  Continue;
                end
              else
                Directive:=false;
            end;
           *)

          L1:=Copy(r,1,Length(r)-2);
          L2:=Copy(r,Length(r)-1,2);
          if L2='//' then
            begin
              CmtLine:=true;
              r:=L1;
              Continue;
            end;
          if L2='/*' then
            begin
              r:=L1;
              Comment:=true;
              Key:=true;
              Continue;
            end;

          if Key then
            L2:=Copy(s,x-1,2);
          if (Comment) and (L2='*/') then
            begin
              Comment:=false;
              Key:=false;
              r:=L1;
              Continue;
            end;
        end;

    Mark:
      if (Form1.ComboBox3.ItemIndex = 0) then begin
        if (not Comment) and (not CmtLine) then
          begin
            if (NwLine) and (Length(r) > 1) then
              repeat
                if Pos(r[Length(r)],#10#13)<>0 then
                  r := Copy(r,1,Length(r)-1);
              until
              (r='') or (Pos(r[Length(r)],#10#13)=0);
            if c = #10 then r := r + #13 +  c
            else
            r := r + c;
            NwLine := false;
          end;
      end;

      if (Form1.ComboBox3.ItemIndex = 1) then begin
        if (not Comment) and (not CmtLine) then
          begin
            if (NwLine) and (Length(r) > 1) then
              repeat
                if Pos(r[Length(r)],#10#13)<>0 then
                  r := Copy(r,1,Length(r)-1);
              until
              (r='') or (Pos(r[Length(r)],#10)=0);
            if c = #10 then r := r + #13 +  c
            else
            r := r + c;
            NwLine := false;
          end;
      end;

    end;

  RE.Text := r;
  r := '';

  for x := RE.Count-1 downto 0 do
    begin
      if RE[x]<>'' then
        if OnlySpaces(RE[x]) then
          RE.Delete(x);
          Application.ProcessMessages;
      if Assigned(ProgrssEventer) then ProgrssEventer(PAS_Increment,0);
    end;


  if Assigned(ProgrssEventer) then ProgrssEventer(PAS_End,0);
  PAS_NoCommentsCpp := Length(RE.Text)/LenStart*100;
end;

initialization
  ProgrssEventer:=nil;

end.

