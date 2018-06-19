object Menu: TMenu
  Left = 606
  Top = 159
  Width = 187
  Height = 309
  Caption = 'Menu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object NewGame: TButton
    Left = 48
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Graj'
    TabOrder = 0
    OnClick = NewGameClick
  end
  object Load: TButton
    Left = 48
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Wczytaj gr'#281
    TabOrder = 1
  end
  object CreateGame: TButton
    Left = 48
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Stw'#243'rz gr'#281
    TabOrder = 2
  end
  object Close: TButton
    Left = 48
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Zako'#324'cz'
    TabOrder = 3
    OnClick = CloseClick
  end
end
