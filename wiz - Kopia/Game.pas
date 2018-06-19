unit Game;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GR32, Players, Graphical_Interface, Engine,
  jpeg, LOAD_SAVE;

type
  TOmringa = class(TForm)
    OneVsOne: TButton;
    Board: TImage;
    BoardSize: TEdit;
    ParamK: TEdit;
    OneVsCpu: TButton;
    CpuVsCpu: TButton;
    LabelBoardSize: TLabel;
    LabelParamK: TLabel;
    FirstName: TEdit;
    SecondName: TEdit;
    LabelPlayer1: TLabel;
    LabelPlayer2: TLabel;
    FirstAuction: TEdit;
    SecondAuction: TEdit;
    Start1vs1: TButton;
    CurrentPlayer: TLabel;
    LabelCurrentPlayer: TLabel;
    Pass: TButton;
    AuctionFirst: TButton;
    CircleScore: TLabel;
    CrossScore: TLabel;
    Start1VsCpu: TButton;
    LonelyAuction: TEdit;
    NewGameButton: TImage;
    Background: TImage;
    MenuBar: TImage;
    LoadGameButton: TImage;
    EditorButton: TImage;
    CloseButton: TImage;
    Hint: TButton;
    Undo: TButton;
    StatusBackground: TImage;
    ControlBackground: TImage;
    GenerateButton: TButton;
    CurrentCircleButton: TButton;
    CurrentCrossButton: TButton;
    SaveButton: TButton;
    SourceName: TEdit;
    KomiValue: TEdit;
    KomiLabel: TLabel;
    Timer1: TTimer;
    procedure OneVsOneClick(Sender: TObject);
    procedure BoardMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Start1vs1Click(Sender: TObject);
    procedure PassClick(Sender: TObject);
    procedure AuctionFirstClick(Sender: TObject);
    procedure OneVsCpuClick(Sender: TObject);
    procedure Start1VsCpuClick(Sender: TObject);
    procedure CpuVsCpuClick(Sender: TObject);
    procedure NewGameButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditorButtonClick(Sender: TObject);
    procedure GenerateButtonClick(Sender: TObject);
    procedure CurrentCircleButtonClick(Sender: TObject);
    procedure CurrentCrossButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
   // procedure LoadGameButtonClick(Sender: TObject);
    //procedure TForm1.ukryjUstawienia();
   //procedure Button2Click(Sender: TObject);
    //procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

////////////////////////////////////

var
  Omringa: TOmringa;
  n : integer;
  p : TPlansza;
  gra : TGame;
  gracz1, gracz2 : TGracz;
implementation

{$R *.dfm}


procedure TOmringa.OneVsOneClick(Sender: TObject);
//var rozmiar : String;
begin
    LabelBoardSize.Visible := false;
    LabelParamK.Visible := false;
    LabelPlayer1.Visible := false;
    LabelPlayer2.Visible := false;
    BoardSize.Visible := false;
    ParamK.Visible := false;
    FirstName.Visible := false;
    SecondName.Visible := false;
    OneVsOne.Visible := false;
    OneVsCpu.Visible := false;
    CpuVsCpu.Visible := false;

    FirstAuction.Visible := true;
    AuctionFirst.Visible := true;
    //Button4.Visible := false;
end;



procedure TOmringa.BoardMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var pole : TPole;
begin
    if gra<>nil then
      pole := gra.plansza.findPole(X,Y)
    else
      pole := nil;

    if (pole <> nil)AND(gra.aktualnyGracz<>nil)AND(gra.online) then
    begin
        if (NOT gra.aktualnyGracz.automat) AND(pole.stan=0) then
        begin
            //ShowMessage('llll');
            if gra.aktualnyGracz=gra.kolko then
            begin
                pole.stan := 1;
                inc(gra.wykonanychRuchow);
                gra.kolko.wynik := gra.kolko.wynik + 1;
                gra.aktualnyGracz := gra.krzyzyk;
            end
            else
            begin
                pole.stan := 2;
                inc(gra.wykonanychRuchow);
                gra.krzyzyk.wynik := gra.krzyzyk.wynik + 1;
                gra.aktualnyGracz := gra.kolko;
            end
        end
    end
    else if (pole <> nil)AND(NOT gra.online) then
    begin
        //ShowMessage('llolololo');
       if gra.aktualnyGracz=gra.kolko then
        begin
            gra.kolko.wynik := gra.kolko.wynik + 1;
            if pole.stan = 0 then
                inc(gra.wykonanychRuchow)
            else if pole.stan = 2 then
                gra.krzyzyk.wynik := gra.krzyzyk.wynik - 1;
            pole.stan := 1;
        end
        else if gra.aktualnyGracz=gra.krzyzyk then
        begin
            gra.krzyzyk.wynik := gra.krzyzyk.wynik + 1;
            if pole.stan = 0 then
                inc(gra.wykonanychRuchow)
            else if pole.stan = 1 then
                gra.kolko.wynik := gra.kolko.wynik - 1;
            pole.stan := 2;
        end;

    end;


    if gra<>nil then
      if gra.aktualnyGracz<>nil then
        CurrentPlayer.Caption := gra.aktualnyGracz.imie
      else
        CurrentPlayer.Caption := '';
end;



procedure TOmringa.Timer1Timer(Sender: TObject);
begin
    if gra <> nil then
    begin
                    //ShowMessage('kkakakak');
        if (gra.aktualnyGracz<> nil)AND(gra.online) then
        begin

            //if gra.aktualnyGracz = gra.gracz2 then
            //  ShowMessage('lolololo');
            if gra.aktualnyGracz.graj(gra.plansza) then
            begin
                gra.aktualnyGracz.wynik := gra.aktualnyGracz.wynik + 1;
                if gra.aktualnyGracz = gra.kolko then
                    gra.aktualnyGracz := gra.krzyzyk
                else
                    gra.aktualnyGracz := gra.kolko;
                inc(gra.wykonanychRuchow);
            end;
        end
        else if (NOT gra.online) then
        begin
            //ShowMessage('lol');
            Board.Visible := true;
            Background.Visible := false;
            gra.plansza.rysuj(Board);
            if gra.aktualnyGracz = nil then
                CurrentPlayer.Caption := 'brak';
        end
        else
        begin
            //ShowMessage('lol');
            LabelCurrentPlayer.Visible := false;
            CircleScore.Caption := '';
            CrossScore.Caption :='';
            CurrentPlayer.Caption := '';
            Pass.Visible := false;
            Hint.Visible := false;
            Undo.Visible := false;
        end;
        //ShowMessage('lol');
        gra.graj(Omringa,Board,BackGround,CircleScore,CrossScore);
    end;
    //else
  //    gra := nil;

  //  if gra = nil then

end;

procedure TOmringa.Start1vs1Click(Sender: TObject);
begin

    FirstAuction.Visible := false;
    SecondAuction.Visible := false;
    AuctionFirst.Visible := false;
    Start1vs1.Visible := false;
    Pass.Visible := true;
    Hint.Visible := true;
    Undo.Visible := true;

//TKomputer.Create(Edit4.Text);
     gracz1 := TUrzytkownik.Create(FirstName.Text,StrToInt(FirstAuction.Text));
    gracz2 := TUrzytkownik.Create(SecondName.Text,StrToInt(SecondAuction.Text));
    gra := TGame.Create(StrToInt(ParamK.Text),StrToInt(BoardSize.Text),gracz1,gracz2,true);

    gra.licytacja;
    CurrentPlayer.Caption := gra.aktualnyGracz.imie;
    CircleScore.Visible := true;
    CrossScore.Visible := true;
    LabelCurrentPlayer.Visible := true;

    BackGround.Visible := false;
    Board.Visible := true;
    //gra.graj(Form1,Image1);
    //p := TPlansza.Create(StrToInt(Edit1.Text));
    //p.rysuj(Image1);
end;

procedure TOmringa.PassClick(Sender: TObject);
begin       
    if NOT gra.aktualnyGracz.automat then
    begin
      gra.aktualnyGracz.pas := true;
      if gra.aktualnyGracz = gra.kolko then
        gra.aktualnyGracz := gra.krzyzyk
      else
        gra.aktualnyGracz := gra.kolko;
      CurrentPlayer.Caption := gra.aktualnyGracz.imie;
    end;

end;

procedure TOmringa.AuctionFirstClick(Sender: TObject);
begin
    AuctionFirst.Visible := false;
    FirstAuction.Visible :=false;
    SecondAuction.Visible := true;
    Start1Vs1.Visible := true;
end;


procedure TOmringa.OneVsCpuClick(Sender: TObject);
begin
    LabelBoardSize.Visible := false;
    LabelParamK.Visible := false;
    LabelPlayer1.Visible := false;
    LabelPlayer2.Visible := false;
    BoardSize.Visible := false;
    ParamK.Visible := false;
    FirstName.Visible := false;
    SecondName.Visible := false;
    OneVsOne.Visible := false;
    OneVsCpu.Visible := false;
    CpuVsCpu.Visible := false;

    LonelyAuction.Visible := true;
    //Button4.Visible := false;
    Start1VsCpu.Visible := true;
    //rozmiar := Edit1.Text;
    //gracz1 := TUrzytkownik.

end;

procedure TOmringa.Start1VsCpuClick(Sender: TObject);
begin
    LonelyAuction.Visible := false;
    Start1VsCpu.Visible := false;
    Pass.Visible := true;
    Hint.Visible := true;
    Undo.Visible := true;

//TKomputer.Create(Edit4.Text);
    gracz1 := TUrzytkownik.Create(FirstName.Text,StrToInt(LonelyAuction.Text));
    gracz2 := TKomputer.Create(SecondName.Text);
    gra := TGame.Create(StrToInt(ParamK.Text),StrToInt(BoardSize.Text),gracz1,gracz2,true);

    gra.licytacja;
    CurrentPlayer.Caption := gra.aktualnyGracz.imie;
    LabelCurrentPlayer.Visible := true;

    CircleScore.Visible := true;
    CrossScore.Visible := true;

    BackGround.Visible := false;
     Board.Visible := true;
end;

procedure TOmringa.CpuVsCpuClick(Sender: TObject);
begin

//TKomputer.Create(Edit4.Text);
    gracz1 := TKomputer.Create(FirstName.Text);
    gracz2 := TKomputer.Create(SecondName.Text);
    gra := TGame.Create(StrToInt(ParamK.Text),StrToInt(BoardSize.Text),gracz1,gracz2,true);

    gra.licytacja;
    CurrentPlayer.Caption := gra.aktualnyGracz.imie;
    LabelCurrentPlayer.Visible := true;
    CircleScore.Visible := true;
    CrossScore.Visible := true;

    LabelBoardSize.Visible := false;
    LabelParamK.Visible := false;
    LabelPlayer1.Visible := false;
    LabelPlayer2.Visible := false;
    BoardSize.Visible := false;
    ParamK.Visible := false;
    FirstName.Visible := false;
    SecondName.Visible := false;
    OneVsOne.Visible := false;
    OneVsCpu.Visible := false;
    CpuVsCpu.Visible := false;

    BackGround.Visible := false;
     Board.Visible := true;

end;

procedure TOmringa.NewGameButtonClick(Sender: TObject);
begin
    Background.Visible := true;
    Board.Visible := false;
    Board.Canvas.Brush.Color := clBtnFace;
    Board.Canvas.Rectangle(-5,-5,390,390);
    LabelCurrentPlayer.Visible := false;
    GenerateButton.Visible := false;
    //Pass.Visible := false;
    //Hint.Visible := false;
   // Undo.Visible := false;
   // CircleScore.Caption := '';
    //CrossScore.Caption := '';
    //CurrentPlayer.Caption := '';
    gra := nil;

    LabelBoardSize.Visible := true;
    LabelParamK.Visible := true;
    LabelPlayer1.Visible := true;
    LabelPlayer2.Visible := true;
    BoardSize.Visible := true;
    ParamK.Visible := true;
    FirstName.Visible := true;
    SecondName.Visible := true;
    OneVsOne.Visible := true;
    OneVsCpu.Visible := true;
    CpuVsCpu.Visible := true;
end;

procedure TOmringa.CloseButtonClick(Sender: TObject);
begin
    Application.Terminate;
end;

procedure TOmringa.FormCreate(Sender: TObject);
begin
    Background.Visible := true;
    Board.Canvas.Brush.Color := clBtnFace;
    Board.Canvas.Rectangle(-5,-5,390,390);
    Board.Visible := false;
end;

procedure TOmringa.EditorButtonClick(Sender: TObject);
begin
  Pass.Visible := false;
  Hint.Visible := false;
  Undo.Visible := false;
  OneVsOne.Visible := false;
  OneVsCpu.Visible := false;
  CpuVsCpu.Visible := false;
  FirstAuction.Visible := false;
  SecondAuction.Visible := false;
  LonelyAuction.Visible := false;
  AuctionFirst.Visible := false;
  Start1Vs1.Visible := false;
  Start1VsCpu.Visible := false;

  LabelBoardSize.Visible := true;
  BoardSize.Visible := true;
  LabelParamK.Visible := true;
  ParamK.Visible := true;
  GenerateButton.Visible := true;
  LabelPlayer1.Visible := true;
  LabelPlayer2.Visible := true;
  FirstName.Visible := true;
  SecondName.Visible := true;


end;

procedure TOmringa.GenerateButtonClick(Sender: TObject);
begin
  Background.Visible := false;
  Board.Visible := true;
  LabelBoardSize.Visible := false;
  BoardSize.Visible := false;
  LabelParamK.Visible := false;
  ParamK.Visible := false;
  GenerateButton.Visible := false;
  LabelPlayer1.Visible := false;
  LabelPlayer2.Visible := false;
  FirstName.Visible := false;
  SecondName.Visible := false;

  CurrentCircleButton.Visible := true;
  CurrentCrossButton.Visible := true;
  SaveButton.Visible := true;
  SourceName.Visible := true;
 KomiLabel.Visible := true;
 KomiValue.Visible := true;
  LabelCurrentPlayer.Visible := true;
  CurrentPlayer.Caption := 'brak';
  CurrentPlayer.Visible := true;

  gracz1 := TUrzytkownik.Create(FirstName.Text,0);
  gracz2 := TUrzytkownik.Create(SecondName.Text,0);
  gra := TGame.Create(StrToInt(ParamK.Text),StrToInt(BoardSize.Text),gracz1,gracz2,false);
  gra.kolko := gracz1;
  gra.krzyzyk := gracz2;
  gra.aktualnyGracz := nil;
end;

procedure TOmringa.CurrentCircleButtonClick(Sender: TObject);
begin
    gra.aktualnyGracz := gra.kolko;
    CurrentPlayer.Caption := gra.aktualnyGracz.imie;
end;

procedure TOmringa.CurrentCrossButtonClick(Sender: TObject);
begin
    gra.aktualnyGracz := gra.krzyzyk;
    CurrentPlayer.Caption := gra.aktualnyGracz.imie;
end;

procedure TOmringa.SaveButtonClick(Sender: TObject);
begin
    save(gra,SourceName.Text,StrToInt(KomiValue.Text));
end;

{procedure TOmringa.LoadGameButtonClick(Sender: TObject);
var nazwaPliku : String;
begin
     if OpenFile.Execute then
   begin
     nazwaPliku:=OpenFile.FileName;
     //Edytor.Lines.LoadFromFile(nazwaPliku);
      LoadedGame.Lines.LoadFromFile(nazwaPliku);
     end;
end;  }

end.
