unit Players;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GR32, Graphical_Interface;

//type
//  TPole = class;

//type
//  TPlansza = class;

type
  TGracz = class
       imie : String;
       wynik : real;
       pas : boolean;
       automat : boolean;
       stan : integer;
      function graj(var plansza: TPlansza):boolean; dynamic;
  end;

type
  TUrzytkownik = class(TGracz)
      constructor Create(name: String; lic : Integer);
      //procedure graj;
  end;

type
  TKomputer = class(TGracz)
      constructor Create(name: String);
      function graj(var plansza: TPlansza):boolean; override;
  end;
  
implementation

  constructor  TUrzytkownik.Create(name: String; lic : Integer);
  begin
      self.imie := name;
      self.wynik := lic;
      self.pas := false;
      self.automat := false;
  end;

  constructor  TKomputer.Create(name: String);
  begin
      self.imie := name;
      Randomize;
      self.wynik := Random(10);
      self.pas := false;
      self.automat := true;
  end;

  function TGracz.graj(var plansza: TPlansza):boolean;
  begin
      Result := false;
  end;

  function TKomputer.graj(var plansza: TPlansza):boolean;
  var i,j:integer;
  begin
     // ShowMessage('lol');
      Result := false;
      i:=0; j:=0;
      while(NOT Result AND(i<plansza.n)) do
      begin
        j:=0;
        while(NOT Result AND(j<plansza.n)) do
        begin
          if plansza.pola[i,j].stan=0 then
          begin
              Result := true;
              plansza.pola[i,j].stan := self.stan;
          end;
          inc(j);
        end;
        inc(i);
      end;
  end;
end.
