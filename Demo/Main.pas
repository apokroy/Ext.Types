unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Ext.Types.Date, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TMainForm = class(TForm)
    PageControl1: TPageControl;
    WeekTab: TTabSheet;
    WeekdayNumEdit: TEdit;
    WeekdayNameEdit: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    FirstDayOfWeekEdit: TComboBox;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure WeekdayFromNumberClick(Sender: TObject);
    procedure WeekdayFromNameClick(Sender: TObject);
  private
    Weekday: TWeekday;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  for var S in FormatSettings.LongDayNames do
  begin
    WeekdayNameEdit.Items.Add(S);
    FirstDayOfWeekEdit.Items.Add(S);
  end;
  FirstDayOfWeekEdit.ItemIndex := FirstDayOfWeek - 1;
end;

procedure TMainForm.WeekdayFromNameClick(Sender: TObject);
begin
  Weekday := TWeekday(WeekdayNameEdit.Text);
end;

procedure TMainForm.WeekdayFromNumberClick(Sender: TObject);
begin
  Weekday := TWeekday(StrToInt(WeekdayNumEdit.Text));

  // Iterate thorough days, from first day of month's start week, to last day of month's last week
  // TDate.Today - current date
  // TDate.Today.StartOfMonth - first day of month
  // TDate.Today.StartOfMonth.StartOfWeek - first weekday of days week
  // TDate.Today.StartOfMonth.StartOfWeek - first weekday of days week, where week starts from Monday
  for var D: TDate in TDate.Sequence(TDate.Today.StartOfMonth.StartOfWeek(Monday), TDate.Today.EndOfMonth.EndOfWeek(Monday)) do
  begin
    Writeln(D.Format('YYYY-MM-DD') + string(D.Weekday));
  end;

  //Weekday.ToString
//  Weekday.Day
//Weekday.DayOfWeek
end;

end.
