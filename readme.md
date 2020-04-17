## A library for Delphi that provides more convenient alternatives to built in types.

### Ext.Types.Date
Types related to Date & Time, including replacement to TDateTime, TTime and TDate system types.
Also provide helpers and utilites related to date and time calculations.

### Ext.Types.List
__very raw version, only for experiments__

Generic List\<T>, wrapping system TArray\<T> type. Supports modern set of functions like Filter, Join, Map, Reduce etc.

##### Code sample for Date unit
Iterates thorough days, from first day of month's first week, to last day of month's last week
* `TDate.Today - current date`
* `TDate.Today.Month` - dates month
* `TDate.Today.Month.First` - first day of month
* `TDate.Today.Monht.First.StartOfWeek` - first weekday of days week
* `TDate.Today.Month.First.StartOfWeek(Monday)` - first weekday of days week, where week starts from Monday
```pascal
for var D: TDate in TDate.Sequence(TDate.Today.Month.First.StartOfWeek(Monday), TDate.Today.Month.Last.EndOfWeek(Monday)) do
begin
  Writeln(D.Format('YYYY-MM-DD') + string(D.Weekday));
end;
```
