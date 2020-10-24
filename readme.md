## A library for Delphi that provides more convenient alternatives to built in types.

### Ext.Types.Date
Types related to Date & Time, including replacement to TDateTime, TTime and TDate system types.
Also provides helpers and utilites related to date and time calculations.

##### Code sample for Date unit
Iterates thorough days, from first day of month's first week, to last day of month's last week
* `TDate.Today - current date`
* `TDate.Today.Month` - month of the day
* `TDate.Today.Month.First` - first day of month
* `TDate.Today.Monht.First.StartOfWeek` - first day of the month's first week
* `TDate.Today.Month.First.StartOfWeek(Monday)` - first day of the month's first week, when week starts from Monday
```pascal
for var D: TDate in TDate.Sequence(TDate.Today.Month.First.StartOfWeek(Monday), TDate.Today.Month.Last.EndOfWeek(Monday)) do
begin
  Writeln(D.Format('YYYY-MM-DD') + string(D.Weekday));
end;
```
### Ext.Types.List
__very raw version, only for experiments__

Generic List\<T>, wrapping system TArray\<T> type. Supports modern set of functions like Filter, Join, Map, Reduce etc.

### Ext.Types.SmartPtr
Smart pointers

Uses ovverloading Assigment operator overloading, record Initialization and Finalization introduced in Delphi 10.4.
