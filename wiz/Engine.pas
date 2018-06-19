unit Engine;

interface

    uses
        Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
        Dialogs, StdCtrls, ExtCtrls, GR32, Graphical_Interface, Players;

    const   MAX_PUNISHMENT = 100;
            MIN_PUNISHMENT = 1;
    type
        ArrayBool2D = array of array of boolean;
    type
        TGame = class
        private
            currentPlayer,circlePlayer,crossPlayer : TPlayer;
            board : TBoard;
            movements : integer;
            player1, player2 : TPlayer;
            online : boolean;             //oznacza czy rozgrywana jest teraz gra
            punishment : integer;
            komi : Real;
            procedure scoring(l1,l2: TLabel);

        public
            procedure Clean;
            function numberOfGroups(st: Status) : Integer;
            constructor Create(punishment,size: Integer;
                                player1,player2: TPlayer; online: boolean);
            constructor Copy(game: TGame);
            procedure periodicOperations(form: TForm; image,background: TImage;
                                        l1,l2: TLabel; history: TMemo;
                                        pass,hint,undo: TButton; hintField: TField);
            procedure auction();
            procedure play(pole: TField);
            procedure mark(pole: TField);
            function getBoard : TBoard;
            function getPlayer(st: Status) : TPlayer;
            function getCurrentPlayer : TPlayer;
            function getCirclePlayer : TPlayer;
            function getCrossPlayer : TPlayer;
            procedure setCurrentPlayer(player: TPlayer);
            procedure setCirclePlayer(player: TPlayer);
            procedure setCrossPlayer(player: TPlayer);
            procedure decMovements;
            function punishmentValue : Integer;
            function duringGame : boolean;
            procedure startGame;
            procedure endGame;
            function getMovesNumber : Integer;
            procedure addMove;
            function getKomi : Real;
            procedure setKomi(komi: real);
        end;

implementation
    // KONSTRUKTORY
    constructor TGame.Create(punishment,size:Integer;player1,player2: TPlayer; online: boolean);
    begin
        if punishment > MAX_PUNISHMENT then
            punishment := MAX_PUNISHMENT
        else if punishment < MIN_PUNISHMENT then
            punishment := MIN_PUNISHMENT;
        self.punishment := punishment;
        self.board := TBoard.Create(size);
        self.player1 := player1;
        self.player2 := player2;
        self.movements := 0;
        self.online := online;
    end;

    constructor TGame.Copy(game: TGame);
    begin
        self.punishment := game.punishmentValue;
        self.board := TBoard.Copy(game.getBoard);
        self.circlePlayer := TPlayer.Copy(game.getCirclePlayer);
        self.crossPlayer := TPlayer.Copy(game.getCrossPlayer);
        if game.getCurrentPlayer = game.getCirclePlayer then
            self.currentPlayer :=  self.circlePlayer
        else
            self.currentPlayer :=  self.crossPlayer;
        self.movements := game.movements;
    end;
    // GETTERY & SETTERY
    function TGame.getKomi : Real;
    begin
        Result := self.komi;
    end;

    procedure TGame.setKomi(komi: real);
    begin
        self.komi := komi;
    end;

    procedure TGame.addMove;
    begin
        inc(self.movements);
    end;
    function TGame.getMovesNumber : Integer;
    begin
        Result := self.movements;
    end;

    procedure TGame.decMovements;
    begin
        dec(self.movements);
    end;

    procedure TGame.setCirclePlayer(player: TPlayer);
    begin
        self.circlePlayer := player;
    end;

    procedure TGame.setCrossPlayer(player: TPlayer);
    begin
        self.crossPlayer := player;
    end;

    procedure TGame.setCurrentPlayer(player: TPlayer);
    begin                                
        self.currentPlayer := player;
    end;
    
    function TGame.getCurrentPlayer : TPlayer;
    begin
        Result := self.currentPlayer;
    end;

    function TGame.getCirclePlayer : TPlayer;
    begin
        Result := self.circlePlayer;
    end;

    function TGame.getCrossPlayer : TPlayer;
    begin
        Result := self.crossPlayer;
    end;

    function TGame.getBoard : TBoard;
    begin
        Result := self.board;
    end;

    function TGame.getPlayer(st: Status) : TPlayer;
    begin
        if st = 1 then
            Result := self.player1
        else
            Result := self.player2;
    end;

    procedure TGame.startGame;
    begin
        self.online := true;
    end;

    procedure TGame.endGame;
    begin
        self.online := false;
    end;

    function TGame.duringGame : boolean;
    begin
        Result := self.online;
    end;

    function TGame.punishmentValue : Integer;
    begin
        Result := self.punishment;
    end;
    // G��WNE FUNKCJE I PROCEDURY
    procedure TGame.Clean;
    begin
        if self <> nil then
        begin
            if self.player1 <> nil then
                self.player1.Destroy;
            if self.player2 <> nil then
                self.player2.Destroy;
            if self.board <> nil then
                self.board.Destroy;
            self.board := nil;
        end;
    end;

    function TGame.numberOfGroups(st: Status) : Integer;
        procedure visit(var visited : ArrayBool2D; i,j: Integer; st: Status);
        begin
            if (st=self.board.getField(i,j).getState) AND NOT visited[i,j] then
            begin
                visited[i,j] := true;
                if (i < self.board.getSize-1) then   //w prawo
                    visit(visited,i+1,j,st);
                if (i > 0) then                  //w lewo
                    visit(visited,i-1,j,st);
                if (j < self.board.getSize-1) then   // w g�r�
                    visit(visited,i,j+1,st);
                if (j > 0) then                  // w d�
                    visit(visited,i,j-1,st);
            end;
        end;
    var visited : ArrayBool2D;
        k,j: Integer;
    begin
        Result := 0;
        SetLength(visited,self.board.getSize,self.board.getSize);
        for k:=0 to self.board.getSize-1 do         //"wyzerowanie" tablicy odwiedzen
            for j:=0 to self.board.getSize-1 do
                visited[k,j] := false;
        for k:=0 to self.board.getSize-1 do
            for j:=0 to self.board.getSize-1 do
                if (st = self.board.getField(k,j).getState)AND (NOT visited[k,j]) then
                begin
                    inc(Result);
                    visit(visited,k,j,st);
                end;
    end;

    procedure TGame.scoring(l1,l2: TLabel);
    begin
        l1.Caption :=  IntToStr(numberOfGroups(CIRCLE))+'             '
                        + CurrToStr(self.circlePlayer.getScore)+'             '
                        + CurrToStr(self.circlePlayer.getScore
                              - self.punishment*self.numberOfGroups(CIRCLE));
        l2.Caption :=  IntToStr(numberOfGroups(CROSS))+'             '
                        + CurrToStr(self.crossPlayer.getScore)+'            '
                        + CurrToStr(self.crossPlayer.getScore
                              - self.punishment*self.numberOfGroups(CROSS)+komi+0.5);
    end;

    procedure TGame.auction();
    begin
         if self.player1.getScore > self.player2.getScore then
         begin
             self.circlePlayer := self.player1;
             self.crossPlayer := self.player2;
         end
         else if self.player1.getScore < Self.player2.getScore then
         begin
             self.circlePlayer := self.player2;
             self.crossPlayer := self.player1;
         end
         else
         begin
             Randomize;
             if (Random(1)=0) then
             begin
                  self.circlePlayer := self.player1;
                  self.crossPlayer := self.player2;
             end
             else
             begin
                  self.circlePlayer := self.player2;
                  self.crossPlayer := self.player1;
             end;
         end;
         self.currentPlayer := self.circlePlayer;
         self.circlePlayer.resetScore;
         self.komi := self.crossPlayer.getScore;
         self.crossPlayer.resetScore;
    end;

    procedure TGame.play(pole: TField);
    begin
        if (NOT self.currentPlayer.automaticPlayer) AND (pole.getState = NONE) then
        begin
            if (self.currentPlayer = self.circlePlayer) then
            begin
                pole.setState(CIRCLE);
                inc(self.movements);
                self.circlePlayer.addPoint;
                self.currentPlayer := self.crossPlayer;
            end
            else if(self.currentPlayer = self.crossPlayer) then
            begin
                pole.setState(CROSS);
                inc(self.movements);
                self.crossPlayer.addPoint;
                self.currentPlayer := self.circlePlayer;
            end
        end;
    end;

    procedure TGame.mark(pole: TField);
    begin
        if self.currentPlayer = self.circlePlayer then
            pole.setState(CIRCLE)
        else if self.currentPlayer = self.crossPlayer then
            pole.setState(CROSS)
        else
            pole.setState(NONE);
    end;

    procedure TGame.periodicOperations(form: TForm; image,background: TImage;
                                        l1,l2: TLabel; history: TMemo;
                                        pass,hint,undo: TButton; hintField: TField);
        procedure endGame;
        var wygrany : String;
        begin
            if (self.circlePlayer.getScore - self.punishment * self.numberOfGroups(1))
                >(self.crossPlayer.getScore-self.punishment*self.numberOfGroups(2)
                                                              + komi + 0.5) then
                wygrany := self.circlePlayer.getName
            else
                wygrany := self.crossPlayer.getName;
            inc(self.movements);
            self.player1.setUnpass;
            self.player2.setUnpass;
            ShowMessage('Wygral: ' + wygrany + ' '
                        + CurrToStr(self.circlePlayer.getScore - self.punishment * self.numberOfGroups(1))
                        + ':' +CurrToStr(self.crossPlayer.getScore - self.punishment * self.numberOfGroups(2)
                                          + komi + 0.5));
            self.currentPlayer := nil;
            self.online := false;
            pass.Visible := false;
            undo.Visible := false;
            hint.Visible := false;
            //self.Clean;
            self.Destroy;
        end;

        procedure autoPlay(hinti: TField);      //zagrania automatyczne: komputer gra po swojemu, a cz�owiek nic nie robi :)
        var st: Status;
        begin
            if (self.currentPlayer <> nil) AND (self.online) AND (hinti <> nil) then
            begin
                if self.currentPlayer = self.circlePlayer then
                    st := CIRCLE
                else
                    st := CROSS;
                if self.currentPlayer.play(self.board,st,history,hinti.getX,hinti.getY) then
                begin
                    self.currentPlayer.addPoint;
                    if self.currentPlayer = self.circlePlayer then
                        self.currentPlayer := self.crossPlayer
                    else
                        self.currentPlayer := self.circlePlayer;
                    inc(self.movements);
                end;
            end
            else if (self.currentPlayer <> nil) AND (self.online) AND (hinti = nil) then
            begin
                if self.currentPlayer.automaticPlayer then
                begin
                    history.Lines.Add('pass');
                    history.Lines.Add('pass');
                    if self.currentPlayer = self.circlePlayer then
                        self.currentPlayer := self.crossPlayer
                    else
                        self.currentPlayer := self.circlePlayer;
                end;
            end;
        end;
    begin
        if self.movements < self.board.getSize*self.board.getSize then
            autoPlay(hintField);               //zagrania automatyczne
        self.board.draw(image);     // rysowanie planszy
        if self.currentPlayer <> nil then      // wypisanie punktacji
            self.scoring(l1,l2);
        if (self.player1.passed AND self.player2.passed)
            OR(self.movements = self.board.getSize*self.board.getSize) then     // koniec gry
            endGame;
        if self<>nil then                             //resetowanie spasowanych ruch�w
           if (self.currentPlayer = self.circlePlayer)then
           begin
               self.player2.setUnpass;
               self.player1.setUnpass;
           end;
    end;
end.
