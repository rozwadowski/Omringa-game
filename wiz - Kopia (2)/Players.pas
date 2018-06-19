unit Players;

interface
    uses
        Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
        Dialogs, StdCtrls, ExtCtrls, GR32, Graphical_Interface;
    const    NONE = 0;
             CIRCLE = 1;
             CROSS = 2;
    type
          Status = NONE..CROSS;
    type
        TPlayer = class
        public
            constructor Copy(pl: TPlayer);
            function play(var board: TBoard; st: Status;history: TMemo;
                                x,y: Integer) : boolean; dynamic;
            function getName : String;
            function getScore : real;
            procedure resetScore;
            procedure addPoint;
            procedure addPoints(points: Integer);
            procedure decPoint;
            procedure setPass;
            procedure setUnpass;
            function passed : boolean;
            function automaticPlayer : boolean;
        protected
            name : String;
            score : real;
            pass : boolean;
            automatic : boolean;
        end;

    type
        THuman = class(TPlayer)
        public
            constructor Create(name: String; score : Integer);
        end;

    type
        TCpu = class(TPlayer)
        public
            constructor Create(name: String); overload;
            constructor Create(name: String; lic:integer); overload;
            function play(var board: TBoard; st: Status;
                          history: TMemo; x,y: Integer) : boolean; override;
        end;
  
implementation
    //KONSTRUKTORY
    constructor  THuman.Create(name: String; score: Integer);
    begin
        self.name := name;
        self.score := score;
        self.pass := false;
        self.automatic := false;
    end;

    constructor  TCpu.Create(name: String);
    begin
        self.name := name;
        Randomize;
        self.score := Random(40)-10;
        self.pass := false;
        self.automatic := true;
    end;

    constructor TPlayer.Copy(pl: TPlayer);
    begin
        self.name := pl.name;
        self.score := pl.score;
        self.pass := pl.pass;
    end;

    constructor  TCpu.Create(name: String;lic:integer);
    begin
        self.name := name;
        self.score := lic;
        self.pass := false;
        self.automatic := true;
    end;
    // GETTERY & SETTERY
    function TPlayer.automaticPlayer : boolean;
    begin
        Result := self.automatic;
    end;

    procedure TPlayer.setPass;
    begin
        self.pass := true;
    end;

    procedure TPlayer.setUnpass;
    begin
        self.pass := false;
    end;

    function TPlayer.passed : boolean;
    begin
        Result := self.pass;
    end;

    procedure TPlayer.addPoints(points: Integer);
    begin
        self.score := self.score + points;
    end;

    procedure TPlayer.addPoint;
    begin
        self.score := self.score + 1;
    end;

    procedure TPlayer.decPoint;
    begin
        self.score := self.score - 1;
    end;

    procedure TPlayer.resetScore;
    begin
        self.score := 0;
    end;

    function TPlayer.getScore : real;
    begin
        Result := self.score;
    end;

    function TPlayer.getName : String;
    begin
        Result := self.name;
    end;
    // ZAGRANIA GRACZY
    function TPlayer.play(var board: TBoard; st: Status; history: TMemo;
                                                        x,y: Integer) : boolean;
    begin
        Result := false;
    end;

    function TCpu.play(var board: TBoard; st: Status; history: TMemo;
                                                        x,y: Integer) : boolean;
    begin
        Result := true;
        board.getField(x,y).setState(st);
        history.Lines.Add(IntToStr(x));
        history.Lines.Add(IntToStr(y));
    end;
end.
