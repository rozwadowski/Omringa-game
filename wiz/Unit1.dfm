object Form1: TForm1
  Left = 378
  Top = 122
  Width = 727
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 32
    Top = 32
    Width = 385
    Height = 385
    OnMouseDown = Image1MouseDown
  end
  object Button1: TButton
    Left = 544
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Rysuj'
    TabOrder = 0
    OnClick = Button1Click
  end
end
