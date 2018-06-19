unit LOAD_SAVE;

interface
   uses Engine,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GR32, Players;

   procedure save(game : TGame; fileName: String; komi: Integer; history:TMemo);
   procedure load(var game : TGame; fileName: String; cpu1,cpu2: boolean);

implementation

   procedure save(game : TGame; fileName : String; komi: Integer; history:TMemo);
   var
       TF : TextFile;
       i,j: Integer;
   begin
       AssignFile(TF, fileName+'.sav');
       ReWrite(TF);
       Writeln(TF, IntToStr(game.getBoard.getSize));
       Writeln(TF, IntToStr(game.punishmentValue));
       Writeln(TF, game.getPlayer(1).getName);
       Writeln(TF, game.getPlayer(2).getName);
       if game.getCurrentPlayer<>nil then
          Writeln(TF, game.getCurrentPlayer.getName)
       else
          Writeln(TF, game.getPlayer(1).getName);
       Writeln(TF, IntToStr(komi));
       for i:=0 to game.getBoard.getSize-1 do
       begin
           for j:=0 to game.getBoard.getSize-1 do
           begin
               Write(TF,IntToStr(game.getBoard.getField(i,j).getState));
           end;
           Writeln(TF,'');
       end;
       CloseFile(TF);
       ShowMessage('Zapis zakoñczony powodzeniem');
    end;

    procedure load(var game : TGame; fileName: String; cpu1,cpu2: boolean);
    var size,k,i,j:integer;
        player1,player2: TPlayer;
        TF : TextFile;
        tmp: String ;
    begin
        Assign(TF,fileName);
        Reset(TF);
        Readln(TF,tmp); // [0]
        size := StrToInt(tmp);
        Readln(TF,tmp); // [1]
        k := StrToInt(tmp);
        Readln(TF,tmp);  //[2]
        if cpu1 then
            player1 := TCpu.Create(tmp,0)
        else
            player1 := THuman.Create(tmp,0);
        Readln(TF,tmp);    //[3]
        if cpu2 then
            player2 := TCpu.Create(tmp,0)
        else
            player2 := THuman.Create(tmp,0);

        game := TGame.Create(k,size,player1,player2,false);

        Readln(TF,tmp); //[4]
        if (tmp=player1.getName) then
            game.setCurrentPlayer (player1)
        else
            game.setCurrentPlayer (player2);
        game.setCirclePlayer(player1);
        game.setCrossPlayer(player2);
        Readln(TF,tmp); //[5]
        game.setKomi(StrToCurr(tmp));

        for i:=0 to size-1 do
        begin
            Readln(TF,tmp);
            for j:=0 to size-1 do
                if tmp[j+1]='1' then
                begin
                    game.getBoard.getField(i,j).setState(CIRCLE);
                    game.getCirclePlayer.addPoint;
                    game.addMove;
                end
                else if tmp[j+1]='2' then
                begin
                    game.getBoard.getField(i,j).setState(CROSS);
                    game.getCrossPlayer.addPoint;
                    game.addMove;
                end
                else if tmp[j+1]='0' then
                    game.getBoard.getField(i,j).setState(NONE);
        end;
         Close(TF);
    end;
end.
