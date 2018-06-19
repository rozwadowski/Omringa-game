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
            procedure loadGame(cpu1,cpu2 : boolean);
    end;
var
    Omringa: TOmringa;
    contest : TGame;
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
        CircleNameLabel.Caption := contest.getCirclePlayer.getName+ '(Kó³ko)';
        CrossNameLabel.Caption := contest.getCrossPlayer.getName+ '(Krzy¿yk)';
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
            loadGame(false,false);
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
            loadGame(false,true);
    end;

    procedure TOmringa.Start1VsCpuClick(Sender: TObject);
    var player1,player2 : TPlayer;
    begin
        if LonelyAuction.Text = '' then
            LonelyAuction.Text := '0';
        if ParamK.Text = '' then
            ParamK.Text := '0';
        if BoardSizeEdit.Text = '' then
            BoardSizeEdit.Text := '0';
        HistoryGame.Clear;
        player1 := THuman.Create(FirstName.Text,StrToInt(LonelyAuction.Text));
        player2 := TCpu.Create(SecondName.Text);
        contest := TGame.Create(StrToInt(ParamK.Text),StrToInt(BoardSizeEdit.Text),
                                player1,player2,true);
        contest.auction;
        CurrentPlayer.Caption := contest.getCurrentPlayer.getName;
        StartGameSetVisible;
    end;

    procedure TOmringa.Start1vs1Click(Sender: TObject);
    var player1,player2: TPlayer;
    begin
        if FirstAuction.Text = '' then
            FirstAuction.Text := '0';
        if SecondAuction.Text = '' then
            SecondAuction.Text := '0';
        if ParamK.Text = '' then
            ParamK.Text := '0';
        if BoardSizeEdit.Text = '' then
            BoardSizeEdit.Text := '0';
        HistoryGame.Clear;
        player1 := THuman.Create(FirstName.Text,StrToInt(FirstAuction.Text));
        player2 := THuman.Create(SecondName.Text,StrToInt(SecondAuction.Text));
        contest := TGame.Create(StrToInt(ParamK.Text),StrToInt(BoardSizeEdit.Text),
                                player1,player2,true);
        contest.auction;
        CurrentPlayer.Caption := contest.getCurrentPlayer.getName;
        StartGameSetVisible;
    end;

    procedure TOmringa.loadGame(cpu1,cpu2 : boolean);
    begin
        AuctionSetVisible;
        AuctionLabel.Visible := false;
        if OpenFile.Execute then
        begin
            load(contest,OpenFile.FileName,cpu1,cpu2,HistoryGame);
            contest.startGame;
            Board.Visible := true;
            Background.Visible := false;
            NewGameSetVisible;
            AuctionSetVisible;
            StartGameSetVisible;
            CurrentPlayer.Caption := contest.getCurrentPlayer.getName;
        end;
    end;

    procedure TOmringa.CpuVsCpuClick(Sender: TObject);
    var player1,player2: TPlayer;
    begin
        if NOT loadMode then
        begin
            if ParamK.Text = '' then
                ParamK.Text := '0';
            if BoardSizeEdit.Text = '' then
                BoardSizeEdit.Text := '0';
            player1 := TCpu.Create(FirstName.Text);
            player2 := TCpu.Create(SecondName.Text);
            HistoryGame.Clear;
            contest := TGame.Create(StrToInt(ParamK.Text),StrToInt(BoardSizeEdit.Text),
                                    player1,player2,true);
            contest.auction;
            CurrentPlayer.Caption := contest.getCurrentPlayer.getName;
            AuctionSetVisible;
            StartGameSetVisible;
            Pass.Visible := false;
            Hint.Visible := false;
            Undo.Visible := false;
        end
        else
            loadGame(true,true);
    end;

    procedure TOmringa.NewGameButtonClick(Sender: TObject);
    begin
        NewGameSetVisible;
        contest := nil;
        loadMode := false;
    end;

    procedure TOmringa.CloseButtonClick(Sender: TObject);
    begin
        contest.Clean;
        if contest <> nil then
            contest.Destroy;
        Application.Terminate;
    end;

    procedure TOmringa.FormCreate(Sender: TObject);
    begin
        EnableMenuItem(GetSystemMenu(Omringa.Handle,LongBool(False)), SC_CLOSE,MF_BYCOMMAND or MF_GRAYED);
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
        HistoryGame.Clear;
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
    var player1,player2: TPlayer;
    begin
        EditorSetVisible;
        player1 := THuman.Create(FirstName.Text,0);
        player2 := THuman.Create(SecondName.Text,0);
        contest := TGame.Create(StrToInt(ParamK.Text),StrToInt(BoardSizeEdit.Text),player1,player2,false);
        contest.setCirclePlayer(player1);
        contest.setCrossPlayer(player2);
        contest.setCurrentPlayer(nil);
    end;

    procedure TOmringa.PassClick(Sender: TObject);
    begin
        if NOT contest.getCurrentPlayer.automaticPlayer then
        begin
            HistoryGame.Lines.Add('pass');
            HistoryGame.Lines.Add('pass');
            contest.getCurrentPlayer.setPass;
            if contest.getCurrentPlayer = contest.getCirclePlayer then
                contest.setCurrentPlayer(contest.getCrossPlayer)
            else
                contest.setCurrentPlayer(contest.getCirclePlayer);
            CurrentPlayer.Caption := contest.getCurrentPlayer.getName;
        end;
    end;

    procedure TOmringa.CurrentCircleButtonClick(Sender: TObject);
    begin
        contest.setCurrentPlayer(contest.getCirclePlayer);
        CurrentPlayer.Caption := contest.getCurrentPlayer.getName;
    end;

    procedure TOmringa.CurrentCrossButtonClick(Sender: TObject);
    begin
        contest.setCurrentPlayer(contest.getCrossPlayer);
        CurrentPlayer.Caption := contest.getCurrentPlayer.getName;
    end;

    procedure TOmringa.SaveButtonClick(Sender: TObject);
    begin
        if KomiValue.Text = '' then
            KomiValue.Text := '0';
        save(contest,SourceName.Text,StrToInt(KomiValue.Text),HistoryGame);
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
    var pole: TField;
    begin
        if contest<>nil then  //szukamy pola na które kliknêlismy
            pole := contest.getBoard.findField(X,Y,contest.duringGame)
        else
            pole := nil;
        if (pole <> nil) AND (contest.getCurrentPlayer <> nil)
            AND (contest.duringGame) then   //zagranie podczas rozgrywki
        begin
            contest.play(pole);
            HistoryGame.Lines.Add(IntToStr(pole.getX));
            HistoryGame.Lines.Add(IntToStr(pole.getY));
        end
        else if (pole <> nil) AND (NOT contest.duringGame) then   //tryb edytora
            contest.mark(pole);
        if contest<>nil then  //zmiana nazwy aktualnego gracza
            if contest.getCurrentPlayer<>nil then
                CurrentPlayer.Caption := contest.getCurrentPlayer.getName
            else
                CurrentPlayer.Caption := 'brak';
    end;

    procedure TOmringa.Timer1Timer(Sender: TObject);
    var tip : TField;
    begin
        if contest <> nil then
        begin
            if contest.duringGame then
            begin
                if contest.getCurrentPlayer.automaticPlayer then
                    tip := getClue(contest)
                else
                    tip := nil;
            end
            else
                tip := nil;
            contest.periodicOperations(Omringa,Board,BackGround,CircleScore,
                                      CrossScore,HistoryGame,Pass,Hint,Undo,tip);
        end;
    end;

    procedure TOmringa.OnlyInteger(Sender: TObject; var Key: Char);
    begin
        if NOT(Ord(Key) in [48..57]) AND (Ord(Key)<>8) then          //liczby i backspace
          Key := #0;
    end;

    procedure TOmringa.OnlySignedInteger(Sender: TObject; var Key: Char);  // filtr do TEdit
    var edit : TEdit;
    begin
        edit := TEdit(Sender);  // wiem, ze to nie³adnie, ale dzia³a!
        if NOT(Ord(Key) in [48..57]) AND (Ord(Key)<>8) AND (Ord(Key)<>45) then  //liczby i backspace oraz '-'
          Key := #0;
        if (Ord(Key)=45) AND (Length(edit.Text)>0) then     //blokuje '-' gdy nie jest pierwszym znakiem
          Key := #0;
    end;

    procedure TOmringa.UndoClick(Sender: TObject);
    begin
        if (contest <> nil) AND (HistoryGame.Lines.Count > 1) then
        begin
            if contest.getCurrentPlayer = contest.getCirclePlayer then
                contest.setCurrentPlayer(contest.getCrossPlayer)
            else
                contest.setCurrentPlayer(contest.getCirclePlayer);

            if (HistoryGame.Lines.Strings[HistoryGame.Lines.Count-1] <> 'pass') then
            begin
                contest.getBoard.getField(StrToInt(HistoryGame.Lines.Strings
                                                    [HistoryGame.Lines.Count-2]),
                                 StrToInt(HistoryGame.Lines.Strings
                                                    [HistoryGame.Lines.Count-1]))
                                 .setState(NONE);
                contest.decMovements;
                contest.getCurrentPlayer.decPoint;
            end;
            CurrentPlayer.Caption := contest.getCurrentPlayer.getName;
            HistoryGame.Lines.Delete(HistoryGame.Lines.Count-1);
            HistoryGame.Lines.Delete(HistoryGame.Lines.Count-1);
        end;
    end;

    procedure TOmringa.HintClick(Sender: TObject);
    var x,y: String;
        tip : TField;
    begin
        tip := getClue(contest);
        if tip <> nil then
        begin
            x := IntToStr(tip.getX+1);
            y := IntToStr(tip.getY+1);
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
        if contest <> nil then
            contest.setCurrentPlayer(nil);
    end;

end.
