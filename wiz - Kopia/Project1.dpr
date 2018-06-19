program Project1;

uses
  Forms,
  Game in 'Game.pas' {Omringa},
  Players in 'Players.pas',
  Graphical_Interface in 'Graphical_Interface.pas',
  Engine in 'Engine.pas',
  LOAD_SAVE in 'LOAD_SAVE.pas';

//Unit2 in 'Unit2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
 // Application.CreateForm(TMenu, Menu);
  Application.CreateForm(TOmringa, Omringa);
  //Application.CreateForm(TForm2, Form2);
  //Application.
  //Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
