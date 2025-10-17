program CommentRemover;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  PascalDeleter in 'PascalDeleter.pas',
  CppDeleter in 'CppDeleter.pas',
  htmlDeleter in 'htmlDeleter.pas',
  PythonDeleter in 'PythonDeleter.pas',
  Highlight in 'Highlight.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
