program Project1;

uses
  Forms,
  Game in 'Game.pas' {Omringa},
  Players in 'Players.pas',
  Graphical_Interface in 'Graphical_Interface.pas',
  Engine in 'Engine.pas',
  LOAD_SAVE in 'LOAD_SAVE.pas',
  AI in 'AI.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TOmringa, Omringa);
  Application.Run;
end.
