## A library for Delphi that provides more convenient alternatives to built in types.

### Ext.Types.Date
Types related to Date & Time, including replacement to TDateTime, TTime and TDate system types.
Also provide helpers and utilites related to date and time calculations.

### Ext.Types.List
Generic List\<T>, wrapping system TArray\<T>. Supports modern set of functions like Filter, Join, Map, Reduce etc.

##### Code sample
Iterate thorough days, from first day of month's start week, to last day of month's last week
* `TDate.Today - current date`
* `TDate.Today.StartOfMonth` - first day of month
* `TDate.Today.StartOfMonth.StartOfWeek` - first weekday of days week
* `TDate.Today.StartOfMonth.StartOfWeek` - first weekday of days week, where week starts from Monday
```pascal
for var D: TDate in TDate.Sequence(TDate.Today.StartOfMonth.StartOfWeek(Monday), TDate.Today.EndOfMonth.EndOfWeek(Monday)) do
begin
Writeln(D.Format('YYYY-MM-DD') + string(D.Weekday));
end;
```
