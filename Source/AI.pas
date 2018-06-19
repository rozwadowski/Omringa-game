unit AI;

interface
    uses
        Engine, Graphical_Interface, Players,Windows, Messages, SysUtils,
        Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
        ExtCtrls, GR32;

    function getClue(game :TGame) : TField;

implementation

    function test(a,b: Integer; g: TGame) : Integer;
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

    procedure firstRandom(var a,b : Integer; g: TGame);
    begin
        Randomize;                     // losowanie pierwszego ruchu
        a := Random(g.getBoard.getSize);
        b := Random(g.getBoard.getSize);
        while (g.getBoard.getField(a,b).getState <> NONE) do
        begin
            a:= Random(g.getBoard.getSize);
            b:= Random(g.getBoard.getSize);
        end;
    end;

    function getClue(game :TGame) : TField;
    var a,b,numberOfGroup,newNumberOfGroup, numberOfGroupAtBeginning : Integer;
        simulateGame : TGame;
        randomV : integer;
    begin
        if game.getMovesNumber < game.getBoard.getSize*game.getBoard.getSize then
        begin
            simulateGame := TGame.Copy(game);
            firstRandom(a,b,simulateGame);
            if simulateGame.getCurrentPlayer = simulateGame.getCirclePlayer then
                 numberOfGroupAtBeginning := simulateGame.numberOfGroups(CIRCLE)
            else
                 numberOfGroupAtBeginning := simulateGame.numberOfGroups(CROSS);
            numberOfGroup := 1000;
            Result := game.getBoard.getField(a,b);
            randomV := Random(2);
            if game.getMovesNumber > 1 then
                for a:=0 to game.getBoard.getSize-1 do
                    for b:=0 to game.getBoard.getSize-1 do
                        if game.getBoard.getField(a,b).getState = NONE then
                        begin
                            newNumberOfGroup := test(a,b,simulateGame);
                            if (numberOfGroup >= newNumberOfGroup)
                                  AND (randomV=0) then     // ten if zapewnia pewn� nieprzewidywalnosc komputera :)
                            begin
                                numberOfGroup := newNumberOfGroup;
                                Result := game.getBoard.getField(a,b);
                            end
                            else if numberOfGroup > newNumberOfGroup then
                            begin
                                numberOfGroup := newNumberOfGroup;
                                Result := game.getBoard.getField(a,b);
                            end;
                        end;
            if (numberOfGroup > numberOfGroupAtBeginning)
                AND(numberOfGroupAtBeginning <> 0)
                AND((game.getBoard.getSize*game.getBoard.getSize - game.getMovesNumber)
                      div 2 < game.punishmentValue) then
                Result := nil;
        end
        else
            Result := nil;
    end;

end.
