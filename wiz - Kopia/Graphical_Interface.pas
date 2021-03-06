unit Graphical_Interface;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GR32;//, Players;
type
  TPole = class
  stan,x,y,grupa : Integer;
  rect : TRect;
  constructor Create(x,y,n:Integer);
  procedure rysuj(im: TImage;n:Integer);
  private
  public
  end;

type
  TPlansza = class
  constructor Create(n: Integer);
  procedure rysuj(im: TImage);
    function findPole(x,y : Integer): TPole;
  private
  public
    n : integer;
  pola : array of array of TPole;
  end;

implementation
  constructor TPole.Create(x,y,n: Integer);
var sk, left,right,top,bottom: Integer;
begin
     self.stan := 0;
     self.grupa := 0;
     self.x := x;
     self.y := y;
     sk := 385 div n;

     left := sk*x + 5 ;
     right :=sk*x + sk-5+ 5 ;// Round(sk* 1.5);
     top := sk*y+ 5 ;
     bottom :=sk*y + sk-5+ 5 ; //Round (sk*1.5);

     self.rect := MakeRect(left,top,right,bottom);

end;

constructor TPlansza.Create(n: Integer);
var i,j: integer;
begin
    self.n := n;
    SetLength(self.pola,n,n);
    for i:=0 to n-1 do
      for j:=0 to n-1 do
        self.pola[i,j] := TPole.Create(i,j,n);
end;

procedure TPole.rysuj(im: TImage;n:Integer);
begin
  //im.Picture := nil;
  if n > 12 then
    n:= Round((180/n)-7)
  else
    n:= Round((180/n)-10);
  im.Canvas.Pen.Color := clBlack;
  im.Canvas.Pen.Width := 1;
  im.Canvas.Brush.Color := clBtnFace;
  {case self.stan of
  0: im.Canvas.Brush.Color := clBtnFace;
  1: im.Canvas.Brush.Color := clBtnFace;//Color32(36,255,165,0);//clRed;
  2: im.Canvas.Brush.Color := clBtnFace;//clBlue;
  end;}

  case self.grupa of
  1:
      im.Canvas.Brush.Color := Color32(36,255,165,0);
  2:
      im.Canvas.Brush.Color := Color32(0,174,255,0);
  end;

  im.Canvas.Rectangle(self.rect);
  im.Canvas.Pen.Width := 3;

  if (self.stan = 1) then
  begin
    im.Canvas.Pen.Color := clGreen;
    im.Canvas.Ellipse(rect.Left+n,rect.Top+n,rect.Right-n,rect.Bottom-n);
  end
  else if (self.stan = 2) then
  begin
      im.Canvas.Pen.Color := clRed;
     // im.Canvas.Draw(rect.Left,rect.Right,T);
     im.Canvas.MoveTo(rect.Left+n,rect.Top+n);
     im.Canvas.LineTo(rect.Right-n,rect.Bottom-n);
     im.Canvas.MoveTo(rect.Right-n,rect.Top+n);
     im.Canvas.LineTo(rect.Left+n,rect.Bottom-n);
       //im.Canvas.Draw(rect.Left,rect.Right,);
      //im.Canvas.LineTo(rect.Left,rect.Top);
  end;
  //im.Canvas.Ellipse(self.rect);
end;

procedure TPlansza.rysuj(im: TImage);
var i,j : integer;
rect : TRect;
begin
    for i:=0 to self.n-1 do
      for j:=0 to self.n-1 do
        self.pola[i,j].rysuj(im,self.n);
end;

function TPlansza.findPole(x,y : Integer): TPole;
var i,j: Integer;
begin
     Result := nil;
     if (self<>nil) then
      for i:=0 to self.n-1 do
        for j:=0 to self.n-1 do
          if ((x > self.pola[i,j].rect.Left) AND (x < self.pola[i,j].rect.Right) AND
              (y > self.pola[i,j].rect.Top) AND (y < self.pola[i,j].rect.Bottom)) then
              Result := self.pola[i,j];
end;

end.
