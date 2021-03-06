unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GR32, Players, Graphical_Interface;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    //procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TPole = class
  stan,x,y,grupa : Integer;
  rect : TRect;
  constructor Create(x,y,n:Integer);
  procedure rysuj(im: TImage);
  private
  public
  end;

type
  TPlansza = class
  constructor Create(n: Integer);
  procedure rysuj(im: TImage);
  private
  public
    n : integer;
  pola : array of array of TPole;
  end;
////////////////////////////////////

var
  Form1: TForm1;
  n : integer;
  p : TPlansza;

implementation

{$R *.dfm}
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

procedure TPole.rysuj(im: TImage);
begin
  case self.stan of
  0: im.Canvas.Brush.Color := clBtnFace;
  1: im.Canvas.Brush.Color := clRed;
  2: im.Canvas.Brush.Color := clBlue;
  end;
  case self.grupa of
  0:
    begin
      im.Canvas.Pen.Color:=clBlack;
      im.Canvas.Pen.Width := 1;
    end;
  1:
    begin
      im.Canvas.Pen.Color:=clPurple;
      im.Canvas.Pen.Width := 3;
    end;
  2:
    begin
        im.Canvas.Pen.Color:=clNavy;
        im.Canvas.Pen.Width := 3;
    end;
  end;
  im.Canvas.Ellipse(self.rect);
end;

procedure TPlansza.rysuj(im: TImage);
var i,j : integer;
rect : TRect;
begin
    for i:=0 to self.n-1 do
      for j:=0 to self.n-1 do
        self.pola[i,j].rysuj(im);
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
    p := TPlansza.Create(10);
    p.rysuj(Image1);
end;

function findPole(p: TPlansza; x,y : Integer): TPole;
var i,j: Integer;
begin
     Result := nil;
     if (p<>nil) then
      for i:=0 to p.n-1 do
        for j:=0 to p.n-1 do
          if ((x > p.pola[i,j].rect.Left) AND (x < p.pola[i,j].rect.Right) AND
              (y > p.pola[i,j].rect.Top) AND (y < p.pola[i,j].rect.Bottom)) then
              Result := p.pola[i,j];
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var pole : TPole;
begin
    pole := findPole(p,X,Y);

    if (pole <> nil) then
    begin
      pole.stan := 1;
      p.rysuj(Image1);
    end;
end;

end.
