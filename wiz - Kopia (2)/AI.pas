unit AI;

interface
    uses
          Engine, Graphical_Interface, Players,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GR32;
    function hints(game :TGame) : TField;
implementation

    function test(a,b:Integer;g: TGame) : Integer;
    begin
        if g.getCurrentPlayer = g.getCirclePlayer then
        begin
            g.getBoard.getField(a,b).setState(CIRCLE);
            Result := g.numberOfGroups(CIRCLE);
        end
        else
        begin
            g.getBoard.getField(a,b).setState(CROSS);
            Result := g.numberOfGroups(CROSS);
        end;
        g.getBoard.getField(a,b).setState(NONE);
    end;

    function hints(game :TGame) : TField;
    var a,b,gr,newroz,stG : Integer;
        symulacja : TGame;
        ran : integer;
    begin
        if game.getMovesNumber< game.getBoard.getSize*game.getBoard.getSize then
        begin
            symulacja := TGame.Copy(game);
            Randomize;
            a:= Random(symulacja.getBoard.getSize);
            b:= Random(symulacja.getBoard.getSize);
            while (symulacja.getBoard.getField(a,b).getState <> NONE) do
            begin
                a:= Random(symulacja.getBoard.getSize);
                b:= Random(symulacja.getBoard.getSize);
            end;

            if symulacja.getCurrentPlayer = symulacja.getCirclePlayer then
                 stG := symulacja.numberOfGroups(CIRCLE)
            else
                 stG := symulacja.numberOfGroups(CROSS);

            gr := 1000;
            Result := game.getBoard.getField(a,b);
            ran := Random(2);
            if game.getMovesNumber > 1 then
                for a:=0 to game.getBoard.getSize-1 do
                    for b:=0 to game.getBoard.getSize-1 do
                        if game.getBoard.getField(a,b).getState = NONE then
                        begin
                            newroz := test(a,b,symulacja);
                            if (gr >= newroz) AND (ran=0) then
                            begin
                                gr := newroz;
                                Result := game.getBoard.getField(a,b);
                            end
                            else if gr > newroz then
                            begin
                                gr := newroz;
                                Result := game.getBoard.getField(a,b);
                            end;
                        end;

            if (gr>stG)AND(stG<>0)AND((game.getBoard.getSize*game.getBoard.getSize-game.getMovesNumber) div 2 < game.punishmentValue) then
                Result := nil;
        end
        else
          Result := nil;

    end;

end.
