unit LOAD_SAVE;

interface
   uses Engine,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GR32;

   procedure save(gra : TGame; plik: String; komi: integer);

implementation

   procedure save(gra : TGame; plik : String; komi: integer);
   var
       TF : TextFile;
       i,j: Integer;
   begin
       AssignFile(TF, plik+'.sav');
      // if Not FileExists(plik) Then // Sprawdzenie, czy plik istnieje
       ReWrite(TF);
       Writeln(TF, IntToStr(gra.plansza.n)); // rozmiar planszy
       Writeln(TF, IntToStr(gra.k));
       Writeln(TF, gra.gracz1.imie);
       Writeln(TF, gra.gracz2.imie);
       if gra.aktualnyGracz<>nil then
          Writeln(TF, gra.aktualnyGracz.imie)
       else
          Writeln(TF, gra.gracz1.imie);
       Writeln(TF, IntToStr(komi));

       for i:=0 to gra.plansza.n-1 do
       begin
           for j:=0 to gra.plansza.n-1 do
           begin
               Write(TF,IntToStr(gra.plansza.pola[i,j].stan));
           end;
           Writeln(TF,'');
       end;
       CloseFile(TF);
       ShowMessage('Zapis zakoñczony powodzeniem');
    end;
end.
