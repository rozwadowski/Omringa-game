unit Graphical_Interface;

interface
    uses
        Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
        Dialogs, StdCtrls, ExtCtrls, GR32;
    const MAX_SIZE = 19;
          MIN_SIZE = 2;
          NONE = 0;
          CIRCLE = 1;
          CROSS = 2;
    type
          Status = NONE..CROSS;
    type
        TField = class
        private
            x,y : Integer;
            state : Status;
            rect : TRect;
            procedure draw(im: TImage; n:Integer; left,top,right,bottom: TField);
            procedure drawGroup(im: TImage; n: Integer; left,top,right,bottom: TField);
            procedure drawCross(im: TImage;scale: Integer);
            procedure drawCircle(im: TImage;scale: Integer);
        public
            constructor Create(x,y,size: Integer);
            function getState : Status;
            procedure setState(st: Status);
            function getX : Integer;
            function getY : Integer;
    end;

    type
        TBoard = class
        private
            size : integer;
            fields : array of array of TField;
        public
            constructor Create(n: Integer);
            constructor Copy(board: TBoard);
            destructor Destroy; override;
            procedure draw(im: TImage);
            function getSize : Integer;
            function getField(i,j: Integer) : TField;
            function findField(x,y : Integer; duringGame: boolean) : TField;
    end;

implementation
    //KONSTRUKTORY
    constructor TBoard.Copy(board: TBoard);
    var i,j :integer;
    begin
        SetLength(self.fields,board.size,board.size);
        self.size := board.size;
        for i:=0 to board.size-1 do
            for j:=0 to board.size-1 do
            begin
                self.fields[i,j] := TField.Create(i,j,board.size);
                self.fields[i,j].state := board.fields[i,j].state;
            end;
    end;

    constructor TField.Create(x,y,size: Integer);
    var sk, left,right,top,bottom: Integer;
    begin
        self.state := 0;
        self.x := x;
        self.y := y;
        sk := 385 div size;
        left := sk*x ;
        right := sk*x + sk - 1;
        top := sk*y;
        bottom := sk*y + sk - 1;
        self.rect := MakeRect(left,top,right,bottom);
    end;

    constructor TBoard.Create(n: Integer);
    var i,j: integer;
    begin
        if n < MIN_SIZE then
          n := MIN_SIZE
        else if n > MAX_SIZE then
          n := MAX_SIZE;
        self.size := n;
        SetLength(self.fields,size,size);
        for i:=0 to n-1 do
            for j:=0 to n-1 do
                self.fields[i,j] := TField.Create(i,j,n);
    end;

    destructor TBoard.Destroy;
    var i,j: Integer;
    begin
        for i:=0 to self.size-1 do
          for j:=0 to self.size-1 do
              self.fields[i,j].Destroy;
    end;
    //GETTERY & SETTERY
    function TBoard.getField(i,j: Integer) : TField;
    begin
        Result := self.fields[i,j];
    end;

    function TBoard.getSize : Integer;
    begin
        Result := self.size;
    end;

    function TField.getX : Integer;
    begin
        Result := self.x;
    end;

    function TField.getY : Integer;
    begin
        Result := self.y;
    end;

    function TField.getState : Status;
    begin
        Result := self.state;
    end;

    procedure TField.setState(st : Status);
    begin
        self.state := st;
    end;
    // PROCEDURY RYSUJ¥CE
    procedure TField.drawGroup(im: TImage; n: Integer; left,top,right,bottom: TField);
    begin
        if n<10 then
            im.Canvas.Pen.Width := 4
        else
            im.Canvas.Pen.Width := 2;
        if (left.state <> self.state) OR (left=self) then
        begin
            im.Canvas.MoveTo(rect.Left+3,rect.Top+3);
            im.Canvas.LineTo(rect.Left+3,rect.Bottom-3);
        end;
        if (right.state <> self.state) OR (right=self) then
        begin
            im.Canvas.MoveTo(rect.Right-2,rect.Top+3);
            im.Canvas.LineTo(rect.Right-2,rect.Bottom-3);
        end;
        if (top.state <> self.state) OR (top=self) then
        begin
            im.Canvas.MoveTo(rect.Left+3,rect.Top+2);
            im.Canvas.LineTo(rect.Right-3,rect.Top+2);
        end;
        if (bottom.state <> self.state) OR (bottom=self) then
        begin
            im.Canvas.MoveTo(rect.Left+3,rect.Bottom-2);
            im.Canvas.LineTo(rect.Right-3,rect.Bottom-2);
        end;
    end;

    procedure TField.drawCross(im: TImage;scale: Integer);
    begin
        im.Canvas.Pen.Color := clRed;
        im.Canvas.MoveTo(rect.Left + scale,rect.Top+scale);
        im.Canvas.LineTo(rect.Right-scale,rect.Bottom-scale);
        im.Canvas.MoveTo(rect.Right-scale,rect.Top+scale);
        im.Canvas.LineTo(rect.Left+scale,rect.Bottom-scale);
    end;

    procedure TField.drawCircle(im: TImage;scale: Integer);
    begin
        im.Canvas.Pen.Color := clGreen;
        im.Canvas.Ellipse(rect.Left+scale,rect.Top+scale,rect.Right-scale,rect.Bottom-scale);
    end;

    procedure TField.draw(im: TImage;n:Integer;left,top,right,bottom: TField);
    var scale : Integer;
    begin
        if n > 12 then
            scale:= Round((180/n)-3)
        else
            scale:= Round((180/n)-10);
        im.Canvas.Pen.Color := clBlack;
        im.Canvas.Pen.Width := 1;
        im.Canvas.Brush.Color := clBtnFace;
        if self.state = CIRCLE then
            im.Canvas.Brush.Color := Color32(36,255,165,0)
        else if self.state = CROSS then
            im.Canvas.Brush.Color := Color32(0,174,255,0);
        im.Canvas.RoundRect(self.rect.Left,self.rect.Top,
                            self.rect.Right,self.rect.Bottom,5,5);
        im.Canvas.Pen.Width := 3;
        if (self.state = CIRCLE) then
            self.drawCircle(im,scale)
        else if (self.state = CROSS) then
            self.drawCross(im,scale);
        if self.state <> NONE then
             self.drawGroup(im,n,left,top,right,bottom);
    end;

    procedure TBoard.draw(im: TImage);
    var i,j : integer;
        left,top,right,bottom : TField;
    begin
        im.Canvas.Brush.Color := clBtnFace;
        im.Canvas.Rectangle(-5,-5,490,490);
        for i:=0 to self.size-1 do        
            for j:=0 to self.size-1 do
            begin
                if i<>0 then          
                    left:=self.fields[i-1,j]
                else
                    left:=self.fields[i,j];
                if i<>self.size-1 then
                    right:=self.fields[i+1,j]
                else
                    right:=self.fields[i,j];
                if j<>0 then
                    top := self.fields[i,j-1]
                else
                    top:=self.fields[i,j];
                if j<>self.size-1 then
                    bottom := self.fields[i,j+1]
                else
                    bottom:=self.fields[i,j];
                self.fields[i,j].draw(im,self.size,left,top,right,bottom);
            end;
    end;

    function TBoard.findField(x,y: Integer; duringGame: boolean) : TField;
    var i,j: Integer;
    begin
        Result := nil;
        if (self<>nil) then
            for i:=0 to self.size-1 do
                for j:=0 to self.size-1 do
                    if ((x > self.fields[i,j].rect.Left)
                        AND (x < self.fields[i,j].rect.Right)
                        AND (y > self.fields[i,j].rect.Top)
                        AND (y < self.fields[i,j].rect.Bottom)) then
                        if NOT duringGame then
                            Result := self.fields[i,j]
                        else if self.fields[i,j].state = NONE then
                            Result := self.fields[i,j];
    end;

end.
