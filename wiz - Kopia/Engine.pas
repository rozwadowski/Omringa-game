unit Engine;

interface
uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GR32, Graphical_Interface, Players;
type
  Odwiedzone = array of array of boolean;
type
  TGame = class
    plansza : TPlansza;
    gracz1, gracz2 : TGracz;
    aktualnyGracz,kolko,krzyzyk : TGracz;
    k : integer;
    wykonanychRuchow : integer;
    online : boolean;
    constructor Create(k,n:Integer;gracz1,gracz2: TGracz;online : boolean);
    procedure graj(form : TForm; image,background : TImage;l1,l2:TLabel);
    procedure licytacja();
    procedure punktacja(l1,l2:TLabel);
    procedure odwiedz(var odw : Odwiedzone; i,j,color:Integer);
    function liczbaGrup(i: Integer) : Integer;
    function samotny(i,j:Integer) : boolean;
  end;
implementation

    constructor TGame.Create(k,n:Integer;gracz1,gracz2: TGracz; online : boolean);
    begin
         self.k := k;
         self.plansza := TPlansza.Create(n);
         self.gracz1 := gracz1;
         self.gracz2 := gracz2;
         self.wykonanychRuchow := 0;
         self.online := online;
    end;

    procedure TGame.odwiedz(var odw : Odwiedzone; i,j,color:Integer);
    begin
        if (color=self.plansza.pola[i,j].stan) AND NOT odw[i,j] then
        begin
          odw[i,j] := true;
          if (i<self.plansza.n-1) then   //w prawo
            self.odwiedz(odw,i+1,j,color);
          if (i>0) then //w lewo
            self.odwiedz(odw,i-1,j,color);
          if (j<self.plansza.n-1) then // w górê
            self.odwiedz(odw,i,j+1,color);
          if (j>0) then // w dó³
            self.odwiedz(odw,i,j-1,color);
        end;
    end;

    function TGame.samotny(i,j:Integer) : boolean;
    begin
        Result := true;
          if (i<self.plansza.n-1) then   //w prawo
            if (self.plansza.pola[i+1,j].stan = self.plansza.pola[i,j].stan) then
              Result := false;
          if (i>0) then //w lewo
            if (self.plansza.pola[i-1,j].stan = self.plansza.pola[i,j].stan) then
              Result := false;
          if (j<self.plansza.n-1) then // w górê
            if (self.plansza.pola[i,j+1].stan = self.plansza.pola[i,j].stan) then
              Result := false;
          if (j>0) then // w dó³
            if (self.plansza.pola[i,j-1].stan = self.plansza.pola[i,j].stan) then
              Result := false;
        //if NOT Result then
        //  self.plansza.pola[i,j].grupa := self.plansza.pola[i,j].stan;
    end;

    function TGame.liczbaGrup(i: Integer) : Integer;
    var odw : Odwiedzone;
        k,j: Integer;
    begin
        SetLength(odw,self.plansza.n,self.plansza.n);
        for k:=0 to self.plansza.n-1 do
          for j:=0 to self.plansza.n-1 do
            odw[k,j] := false;

        Result := 0;
        for k:=0 to self.plansza.n-1 do
          for j:=0 to self.plansza.n-1 do
          begin
             if (i=self.plansza.pola[k,j].stan)AND (NOT odw[k,j]) then
             begin
                 Result := Result + 1;
                 self.odwiedz(odw,k,j,i);
                 if self.samotny(k,j) then
                    Result := Result - 1;
                 //else
                  //  self.plansza.pola[k,j].grupa := self.plansza.pola[k,j].stan;
             end
             else if (i=self.plansza.pola[k,j].stan)AND NOT samotny(k,j) then
             begin
                self.plansza.pola[k,j].grupa := self.plansza.pola[k,j].stan;
                if (k>0) then
                  if (i=self.plansza.pola[k-1,j].stan) then
                       self.plansza.pola[k-1,j].grupa := self.plansza.pola[k,j].stan;
                if (j>0) then
                  if (i=self.plansza.pola[k,j-1].stan) then
                       self.plansza.pola[k,j-1].grupa := self.plansza.pola[k,j].stan;
             end;
          end
    end;

    procedure TGame.punktacja(l1,l2:TLabel);
    begin
        l1.Caption := CurrToStr(self.kolko.wynik-self.k*self.liczbaGrup(1));
        l2.Caption := CurrToStr(self.krzyzyk.wynik-self.k*self.liczbaGrup(2));
    end;

    procedure TGame.graj(form : TForm;image,background : TImage;l1,l2:TLabel);
    var wygrany : String;
    begin
            //if gra<> nil then
            //ShowMessage('haha');
            //background.Visible := false;
            self.plansza.rysuj(image);
            if self.aktualnyGracz <> nil then
              self.punktacja(l1,l2);
            //ShowMessage('haha');
            self.plansza.rysuj(image);

            if (self.gracz1.pas AND self.gracz2.pas)OR(self.wykonanychRuchow=self.plansza.n*self.plansza.n) then
            begin
                 if (self.kolko.wynik-self.k*self.liczbaGrup(1))>(self.krzyzyk.wynik-self.k*self.liczbaGrup(2)) then
                    wygrany := self.kolko.imie
                 else
                    wygrany := self.krzyzyk.imie;
                 self.wykonanychRuchow := 0;
                 self.gracz1.pas := false;
                 self.gracz2.pas := false;
                 ShowMessage('Wygral: '+wygrany+' '+CurrToStr(self.kolko.wynik-self.k*self.liczbaGrup(1))+':'+CurrToStr(self.krzyzyk.wynik-self.k*self.liczbaGrup(2)));
                 image.Visible := false;
                 background.Visible := true;
                 self.aktualnyGracz := nil;
                 self := nil;
                 //form.Close;
            end;

            if self<>nil then
              if (self.aktualnyGracz = self.kolko)then
               begin
                 self.gracz2.pas := false;
                 self.gracz1.pas := false;
               end;
    end;

    procedure TGame.licytacja();
    begin
         if (self.gracz1.wynik>self.gracz2.wynik) then
         begin
             self.kolko := self.gracz1;
             self.krzyzyk := self.gracz2;
         end
         else if (self.gracz1.wynik<Self.gracz2.wynik) then
         begin
             self.kolko := self.gracz2;
             self.krzyzyk := self.gracz1;
         end
         else
         begin
             Randomize;
             if (Random(1)=0) then
             begin
                  self.kolko := self.gracz1;
                  self.krzyzyk := self.gracz2;
             end
             else
             begin
                  self.kolko := self.gracz2;
                  self.krzyzyk := self.gracz1;
             end;
         end;
         self.kolko.stan := 1;
         self.krzyzyk.stan := 2;
         self.aktualnyGracz := self.kolko;
         self.kolko.wynik := 0;
         self.krzyzyk.wynik := self.krzyzyk.wynik + 0.5;
    end;
end.
