object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 516
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 764
    Height = 516
    ActivePage = WeekTab
    Align = alClient
    TabOrder = 0
    object WeekTab: TTabSheet
      Caption = 'Weekday && Week'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 16
        Top = 131
        Width = 74
        Height = 13
        Caption = 'Weekday name'
      end
      object Label2: TLabel
        Left = 16
        Top = 64
        Width = 84
        Height = 13
        Caption = 'Weekday number'
      end
      object Label3: TLabel
        Left = 16
        Top = 107
        Width = 130
        Height = 13
        Caption = 'Weekday := TWeekday(I);'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 16
        Top = 174
        Width = 132
        Height = 13
        Caption = 'Weekday := TWeekday(S);'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 328
        Top = 120
        Width = 31
        Height = 13
        Caption = 'Label5'
      end
      object Label6: TLabel
        Left = 16
        Top = 8
        Width = 75
        Height = 13
        Caption = 'FirstDayOWeek'
      end
      object WeekdayNumEdit: TEdit
        Left = 16
        Top = 80
        Width = 121
        Height = 21
        NumbersOnly = True
        TabOrder = 0
        Text = '1'
      end
      object WeekdayNameEdit: TComboBox
        Left = 16
        Top = 147
        Width = 121
        Height = 21
        TabOrder = 1
      end
      object Button1: TButton
        Left = 168
        Top = 145
        Width = 75
        Height = 25
        Caption = '>>'
        TabOrder = 2
        OnClick = WeekdayFromNameClick
      end
      object Button2: TButton
        Left = 168
        Top = 78
        Width = 75
        Height = 25
        Caption = '>>'
        TabOrder = 3
        OnClick = WeekdayFromNumberClick
      end
      object FirstDayOfWeekEdit: TComboBox
        Left = 16
        Top = 22
        Width = 145
        Height = 21
        TabOrder = 4
        Text = 'FirstDayOfWeekEdit'
      end
    end
  end
end
