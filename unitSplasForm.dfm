object formSplasForm: TformSplasForm
  Left = 0
  Top = 0
  Caption = 'Posto ABC'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Image: TImage
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    ExplicitLeft = 48
    ExplicitTop = 176
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object StartupTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = StartupTimerTimer
    Left = 512
    Top = 280
  end
end
