unit Main;

interface

uses
  Game, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMenu = class(TForm)
    NewGame: TButton;
    Load: TButton;
    CreateGame: TButton;
    Close: TButton;
    procedure NewGameClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Menu: TMenu;

implementation

{$R *.dfm}

  procedure TMenu.NewGameClick(Sender: TObject);
  begin
      Omringa.ShowModal;
  end;

  procedure TMenu.CloseClick(Sender: TObject);
  begin
      Application.Terminate;
  end;

end.
