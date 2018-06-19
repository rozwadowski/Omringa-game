unit Game;

interface

    uses
        Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
        Dialogs, StdCtrls, ExtCtrls, GR32, Players, Graphical_Interface, Engine,
        jpeg, LOAD_SAVE,AI;

    type
        TOmringa = class(TForm)
    OneVsOne: TButton;
    Board: TImage;
    BoardSizeEdit: TEdit;
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
    FirstPlayerAuctionButton: TButton;
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
    OpenFile: TOpenDialog;
    AuctionLabel: TLabel;
    CircleNameLabel: TLabel;
    CrossNameLabel: TLabel;
    StatsLabel: TLabel;
    HistoryGame: TMemo;
    RulesButton: TImage;
    Rules: TMemo;
    NoneCurrentPlayerButton: TButton;
    procedure OneVsOneClick(Sender: TObject);
    procedure BoardMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Start1vs1Click(Sender: TObject);
    procedure PassClick(Sender: TObject);
    procedure FirstPlayerAuctionButtonClick(Sender: TObject);
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
    procedure LoadGameButtonClick(Sender: TObject);
    procedure OnlyInteger(Sender: TObject; var Key: Char);
    procedure OnlySignedInteger(Sender: TObject; var Key: Char);
    procedure UndoClick(Sender: TObject);
    procedure HintClick(Sender: TObject);
    procedure RulesButtonClick(Sender: TObject);
    procedure NoneCurrentPlayerButtonClick(Sender: TObject);
  private
    procedure NewGameSetVisible;
    procedure AuctionSetVisible;
    procedure StartGameSetVisible;
    procedure EditorSetVisible;
  public
    { Public declarations }
  end;

////////////////////////////////////

var
  Omringa: TOmringa;
  n : integer;
  p : TBoard;
  gra : TGame;
  gracz1, gracz2 : TPlayer;
  loadMode : boolean;
implementation

{$R *.dfm}

    procedure TOmringa.NewGameSetVisible;
    begin
        Board.Visible := false;
        Background.Visible := true;

        Pass.Visible := false;
        Hint.Visible := false;
        Undo.Visible := false;
        SourceName.Visible := false;
        SaveButton.Visible := false;

        CurrentCircleButton.Visible := false;
        CurrentCrossButton.Visible := false;
        NoneCurrentPlayerButton.Visible := false;
        LabelCurrentPlayer.Visible := false;
        FirstAuction.Visible := false;
        SecondAuction.Visible := false;
        LonelyAuction.Visible := false;
        CircleScore.Visible := false;
        CrossScore.Visible := false;
        KomiLabel.Visible := false;
        KomiValue.Visible := false;
        FirstPlayerAuctionButton.Visible := false;
        Start1VsCpu.Visible := false;
        Start1Vs1.Visible := false;
        GenerateButton.Visible := false;
        CurrentPlayer.Visible := false;
        AuctionLabel.Visible := false;
        CircleNameLabel.Visible := false;
        CrossNameLabel.Visible := false;
        StatsLabel.Visible := false;

        OneVsOne.Visible := true;
        OneVsCpu.Visible := true;
        CpuVsCpu.Visible := true;
        LabelBoardSize.Visible := true;
        LabelParamK.Visible := true;
        LabelPlayer1.Visible := true;
        LabelPlayer2.Visible := true;
        BoardSizeEdit.Visible := true;
        ParamK.Visible := true;
        FirstName.Visible := true;
        SecondName.Visible := true;
        OneVsOne.Left := 440; OneVsOne.Top:= 264;
        OneVsCpu.Left := 528; OneVsCpu.Top:= 264;
        CpuVsCpu.Left := 616; CpuVsCpu.Top:= 264;

        Board.Canvas.Brush.Color := clBtnFace;
        Board.Canvas.Rectangle(-5,-5,390,390);

        HistoryGame.Clear;
    end;

    procedure TOmringa.AuctionSetVisible;
    begin
        NewGameSetVisible;
        LonelyAuction.Visible := false;
        FirstAuction.Visible := false;
        SecondAuction.Visible := false;
        FirstPlayerAuctionButton.Visible := false;
        Start1VsCpu.Visible := false;
        Start1Vs1.Visible := false;
        CurrentCircleButton.Visible := false;
        CurrentCrossButton.Visible := false;
        NoneCurrentPlayerButton.Visible := false;
        KomiValue.Visible := false;
        KomiLabel.Visible := false;
        LabelCurrentPlayer.Visible := false;
        CurrentPlayer.Visible := false;
        GenerateButton.Visible := false;
        LabelBoardSize.Visible := false;
        LabelParamK.Visible := false;
        LabelPlayer1.Visible := false;
        LabelPlayer2.Visible := false;
        BoardSizeEdit.Visible := false;
        ParamK.Visible := false;
        FirstName.Visible := false;
        SecondName.Visible := false;
        OneVsOne.Visible := false;
        OneVsCpu.Visible := false;
        CpuVsCpu.Visible := false;
        AuctionLabel.Visible := true;
    end;

    procedure TOmringa.StartGameSetVisible;
    begin
        Background.Visible := false;
        Board.Visible := true;

        FirstAuction.Visible := false;
        SecondAuction.Visible := false;
        LonelyAuction.Visible := false;
        FirstPlayerAuctionButton.Visible := false;
        Start1VsCpu.Visible := false;
        Start1Vs1.Visible := false;
        AuctionLabel.Visible :=false;

        LabelCurrentPlayer.Visible := true;
        CurrentPlayer.Visible := true;
        CircleScore.Visible := true;
        CrossScore.Visible := true;

        Pass.Visible := true;
        Hint.Visible := true;
        Undo.Visible := true;
        SourceName.Visible := true;
        SaveButton.Visible := true;
        CircleNameLabel.Caption := gra.getCirclePlayer.getName+ '(Kó³ko)';
        CrossNameLabel.Caption := gra.getCrossPlayer.getName+ '(Krzy¿yk)';
        CircleNameLabel.Visible := true;
        CrossNameLabel.Visible := true;
        StatsLabel.Visible := true;
    end;

    procedure TOmringa.OneVsOneClick(Sender: TObject);
    begin
    if (NOT loadMode) then
    begin
        AuctionSetVisible;
        FirstAuction.Visible := true;
        FirstPlayerAuctionButton.Visible := true;
        AuctionLabel.Caption := 'Licytacja: '+FirstName.Text;
    end
    else
    begin
        AuctionSetVisible;
        AuctionLabel.Visible := false;
        if OpenFile.Execute then
        begin
            load(gra,OpenFile.FileName,false,false);
            gra.startGame;
            Board.Visible := true;
            Background.Visible := false;
            NewGameSetVisible;
            AuctionSetVisible;
            StartGameSetVisible;
        end;
    end;
    end;

    procedure TOmringa.FirstPlayerAuctionButtonClick(Sender: TObject);
    begin
        FirstPlayerAuctionButton.Visible := false;
        FirstAuction.Visible := false;
        SecondAuction.Visible := true;
        Start1Vs1.Visible := true;
        AuctionLabel.Caption := 'Licytacja: '+SecondName.Text;
    end;

    procedure TOmringa.OneVsCpuClick(Sender: TObject);
    begin
    if NOT loadMode then
    begin
        AuctionSetVisible;
        LonelyAuction.Visible := true;
        Start1VsCpu.Visible := true;
        AuctionLabel.Caption := 'Licytacja: '+FirstName.Text;
    end
    else
    begin
        AuctionSetVisible;
        AuctionLabel.Visible := false;
        if OpenFile.Execute then
        begin
            load(gra,OpenFile.FileName,false,true);
            gra.startGame;
            Board.Visible := true;
            Background.Visible := false;
            NewGameSetVisible;
            AuctionSetVisible;
            StartGameSetVisible;
            CurrentPlayer.Caption := gra.getCurrentPlayer.getName;
        end;
    end;
    end;

    procedure TOmringa.Start1VsCpuClick(Sender: TObject);
    begin
        if LonelyAuction.Text = '' then
            LonelyAuction.Text := '0';
        if ParamK.Text = '' then
            ParamK.Text := '0';
        if BoardSizeEdit.Text = '' then
            BoardSizeEdit.Text := '0';
        gracz1 := THuman.Create(FirstName.Text,StrToInt(LonelyAuction.Text));
        gracz2 := TCpu.Create(SecondName.Text);
        gra := TGame.Create(StrToInt(ParamK.Text),StrToInt(BoardSizeEdit.Text),gracz1,gracz2,true);
        gra.auction;
        CurrentPlayer.Caption := gra.getCurrentPlayer.getName;
        StartGameSetVisible;
    end;

    procedure TOmringa.Start1vs1Click(Sender: TObject);
    begin
        if FirstAuction.Text = '' then
            FirstAuction.Text := '0';
        if SecondAuction.Text = '' then
            SecondAuction.Text := '0';
        if ParamK.Text = '' then
            ParamK.Text := '0';
        if BoardSizeEdit.Text = '' then
            BoardSizeEdit.Text := '0';
        gracz1 := THuman.Create(FirstName.Text,StrToInt(FirstAuction.Text));
        gracz2 := THuman.Create(SecondName.Text,StrToInt(SecondAuction.Text));
        gra := TGame.Create(StrToInt(ParamK.Text),StrToInt(BoardSizeEdit.Text),gracz1,gracz2,true);
        gra.auction;
        CurrentPlayer.Caption := gra.getCurrentPlayer.getName;
        StartGameSetVisible;
    end;

    procedure TOmringa.CpuVsCpuClick(Sender: TObject);
    begin
        if NOT loadMode then
        begin
        if ParamK.Text = '' then
            ParamK.Text := '0';
        if BoardSizeEdit.Text = '' then
            BoardSizeEdit.Text := '0';
        gracz1 := TCpu.Create(FirstName.Text);
        gracz2 := TCpu.Create(SecondName.Text);
        gra := TGame.Create(StrToInt(ParamK.Text),StrToInt(BoardSizeEdit.Text),gracz1,gracz2,true);
        gra.auction;
        CurrentPlayer.Caption := gra.getCurrentPlayer.getName;
        AuctionSetVisible;
        StartGameSetVisible;
        Pass.Visible := false;
        Hint.Visible := false;
        Undo.Visible := false;
        end
        else
    begin
        AuctionSetVisible;
        AuctionLabel.Visible := false;
        if OpenFile.Execute then
        begin
            load(gra,OpenFile.FileName,true,true);
            gra.startGame;
            Board.Visible := true;
            Background.Visible := false;
            NewGameSetVisible;
            AuctionSetVisible;
            StartGameSetVisible;
            CurrentPlayer.Caption := gra.getCurrentPlayer.getName;
        end;
    end;
    end;

    procedure TOmringa.NewGameButtonClick(Sender: TObject);
    begin
        NewGameSetVisible;
        gra.Free;
        gra := nil;
        loadMode := false;
    end;

    procedure TOmringa.CloseButtonClick(Sender: TObject);
    begin
        Application.Terminate;
    end;

    procedure TOmringa.FormCreate(Sender: TObject);
    begin
        NewGameSetVisible;
        loadMode := false;
    end;

    procedure  TOmringa.EditorSetVisible;
    begin
        NewGameSetVisible;
        AuctionSetVisible;
        CurrentCircleButton.Visible := true;
        CurrentCrossButton.Visible := true;
        NoneCurrentPlayerButton.Visible := true;
        SaveButton.Visible := true;
        SourceName.Visible := true;
        KomiLabel.Visible := true;
        KomiValue.Visible := true;
        LabelCurrentPlayer.Visible := true;
        CurrentPlayer.Caption := 'brak';
        CurrentPlayer.Visible := true;
        Background.Visible := false;
        Board.Visible := true;
        AuctionLabel.Visible := false;
    end;

    procedure TOmringa.EditorButtonClick(Sender: TObject);
    begin
        NewGameSetVisible;
        OneVsOne.Visible := false;
        OneVsCpu.Visible := false;
        CpuVsCpu.Visible := false;
        GenerateButton.Visible := true;
    end;

    procedure TOmringa.GenerateButtonClick(Sender: TObject);
    begin
        EditorSetVisible;
        gracz1 := THuman.Create(FirstName.Text,0);
        gracz2 := THuman.Create(SecondName.Text,0);
        gra := TGame.Create(StrToInt(ParamK.Text),StrToInt(BoardSizeEdit.Text),gracz1,gracz2,false);
        gra.setCirclePlayer(gracz1);
        gra.setCrossPlayer(gracz2);
        gra.setCurrentPlayer(nil);
    end;

    procedure TOmringa.PassClick(Sender: TObject);
    begin
        if NOT gra.getCurrentPlayer.automaticPlayer then
        begin
            HistoryGame.Lines.Add('pass');
            HistoryGame.Lines.Add('pass');
            gra.getCurrentPlayer.setPass;
            if gra.getCurrentPlayer = gra.getCirclePlayer then
                gra.setCurrentPlayer(gra.getCrossPlayer)
            else
                gra.setCurrentPlayer(gra.getCirclePlayer);
            CurrentPlayer.Caption := gra.getCurrentPlayer.getName;
        end;
    end;

    procedure TOmringa.CurrentCircleButtonClick(Sender: TObject);
    begin
        gra.setCurrentPlayer(gra.getCirclePlayer);
        CurrentPlayer.Caption := gra.getCurrentPlayer.getName;
    end;

    procedure TOmringa.CurrentCrossButtonClick(Sender: TObject);
    begin
        gra.setCurrentPlayer(gra.getCrossPlayer);
        CurrentPlayer.Caption := gra.getCurrentPlayer.getName;
    end;

    procedure TOmringa.SaveButtonClick(Sender: TObject);
    begin
        if KomiValue.Text = '' then
          KomiValue.Text := '0';
        save(gra,SourceName.Text,StrToInt(KomiValue.Text),HistoryGame);
    end;

    procedure TOmringa.LoadGameButtonClick(Sender: TObject);
    begin
            AuctionSetVisible;
            AuctionLabel.Visible := false;
            OneVsOne.Left := 520; OneVsOne.Top:= 128;
            OneVsCpu.Left := 520; OneVsCpu.Top:= 192;
            CpuVsCpu.Left := 520; CpuVsCpu.Top:= 256;
            OneVsCpu.Visible := true;
            OneVsOne.Visible := true;
            CpuVsCpu.Visible := true;
            loadMode := true;
    end;

    // akcja klikniêcia na planszê
    procedure TOmringa.BoardMouseDown(Sender: TObject; Button: TMouseButton;
                                          Shift: TShiftState; X, Y: Integer);
    var pole : TField;
    begin
        if gra<>nil then  //szukamy pola na które kliknêlismy
            pole := gra.getBoard.findField(X,Y,gra.duringGame)
        else
            pole := nil;
        //if pole.stan <> NONE then
         // pole := nil;

        if (pole <> nil)AND(gra.getCurrentPlayer<>nil)AND(gra.duringGame) then   //zagranie podczas rozgrywki
        begin
            gra.play(pole);
            HistoryGame.Lines.Add(IntToStr(pole.getX));
            HistoryGame.Lines.Add(IntToStr(pole.getY));
        end
        else if (pole <> nil)AND(NOT gra.duringGame) then   //zaznaczenie w edytorze
        begin
            gra.mark(pole);
            //if (gra.getCurrentPlayer<>nil) then
              //  gra.getCurrentPlayer.addPoint;
        end;
        if gra<>nil then  //zmiana nazwy aktualnego gracza
            if gra.getCurrentPlayer<>nil then
                CurrentPlayer.Caption := gra.getCurrentPlayer.getName
            else
                CurrentPlayer.Caption := 'brak';
    end;

    procedure TOmringa.Timer1Timer(Sender: TObject);
    var h : TField;
    begin
        if gra <> nil then
        begin
         if gra.duringGame then
         begin
            if gra.getCurrentPlayer.automaticPlayer then      //zrob lepiej bo nie dziala!!!!!!!!!!!!!
                h := hints(gra)
            else
                h := nil;
         end
         else
            h := nil;
                    gra.periodicOperations(Omringa,Board,BackGround,CircleScore,CrossScore,HistoryGame,
                                    Pass,Hint,Undo,h);
        end;

    end;

    procedure TOmringa.OnlyInteger(Sender: TObject; var Key: Char);
    begin
        if NOT(Ord(Key) in [48..57]) AND (Ord(Key)<>8) then          //liczby i backspace
          Key := #0;
    end;

    procedure TOmringa.OnlySignedInteger(Sender: TObject; var Key: Char);
    var edit : TEdit;
    begin
        edit := TEdit(Sender);
        if NOT(Ord(Key) in [48..57]) AND (Ord(Key)<>8) AND (Ord(Key)<>45) then  //liczby i backspace oraz '-'
          Key := #0;
        if (Ord(Key)=45) AND (Length(edit.Text)>0) then     //blokuje '-' gdy nie jest pierwszym znakiem
          Key := #0;
    end;

    procedure TOmringa.UndoClick(Sender: TObject);
    //var i,j : Integer;
    begin
        if (gra <> nil) AND (HistoryGame.Lines.Count > 0) then
        begin
            if gra.getCurrentPlayer = gra.getCirclePlayer then
                gra.setCurrentPlayer(gra.getCrossPlayer)
            else
                gra.setCurrentPlayer(gra.getCirclePlayer);

            if HistoryGame.Lines.Strings[HistoryGame.Lines.Count-1] <> 'pass' then
            begin
                gra.getBoard.getField(StrToInt(HistoryGame.Lines.Strings[HistoryGame.Lines.Count-2]),
                                 StrToInt(HistoryGame.Lines.Strings[HistoryGame.Lines.Count-1])).setState(NONE);
                gra.decMovements;
                gra.getCurrentPlayer.decPoint;
            end;

            CurrentPlayer.Caption := gra.getCurrentPlayer.getName;

            HistoryGame.Lines.Delete(HistoryGame.Lines.Count-1);
            HistoryGame.Lines.Delete(HistoryGame.Lines.Count-1);
        end;

    end;

procedure TOmringa.HintClick(Sender: TObject);
var x,y: String;
    h : TField;
begin
      h := hints(gra);
      if h <> nil then
      begin
          x := IntToStr(h.getX+1);
          y := IntToStr(h.getY+1);
          ShowMessage('Proponowany ruch: '+x+' kolumna, '+ y+ ' wiersz');
      end
      else
          ShowMessage('Proponowany ruch: Pas');
end;

procedure TOmringa.RulesButtonClick(Sender: TObject);
begin
    Rules.Lines.LoadFromFile('rules.txt');
    ShowMessage(Rules.Text);
end;

procedure TOmringa.NoneCurrentPlayerButtonClick(Sender: TObject);
begin
    if gra <> nil then
        gra.setCurrentPlayer(nil);
end;

end.
