## A library for Delphi that provides more convenient alternatives to built in types.

### Ext.Types.Date
Types related to Date & Time, including replacement to TDateTime, TTime and TDate system types.
Also provides helpers and utilites related to date and time calculations.

##### Code sample for Date unit
Iterates thorough days, from first day of month's first week, to last day of month's last week
* `TDate.Today - current date`
* `TDate.Today.Month` - month of the day
* `TDate.Today.MonthOfYear.First` - first day of month
* `TDate.Today.MonthOfYear.First.StartOfWeek` - first day of the month's first week
* `TDate.Today.MonthOfYear.First.StartOfWeek(Monday)` - first day of the month's first week, when week starts from Monday
```pascal
for var D in TDate.Sequence(TDate.Today.MonthOfYear.First.StartOfWeek(Monday), TDate.Today.MonthOfYear.Last.EndOfWeek(Monday)) do
begin
  Writeln(D.Format('YYYY-MM-DD') + string(D.Weekday));
end;
```
### Ext.Types.List
__very raw version, only for experiments__

Generic List\<T>, wrapping system TArray\<T> type. Supports modern set of functions like Filter, Join, Map, Reduce etc.

### Ext.Types.SmartPtr
Smart pointers


