unit Ext.Types.List;

interface

uses System.Types, System.SysUtils, System.Variants, System.Classes, System.Generics.Defaults, System.Generics.Collections;

type
  List<T> = record
  public type
    TMap<DstT> = reference to function(const Item: T; const Index: Integer): DstT;
    TTest = reference to function(const Item: T; const Index: Integer): Boolean;
    TReduce<TAccumulator> = reference to function(const Accumulator: TAccumulator; const Item: T; const Index: Integer): TAccumulator;
    TEnumerator = class
    private
      FList: Pointer;
      FIndex: Integer;
      function  GetCurrent: T; inline;
    protected
      constructor Create(const AList: Pointer);
    public
      function  MoveNext: Boolean; inline;
      property  Current: T read GetCurrent;
    end;
  private
    FItems: TArray<T>;
    function  GetElement(const Index: Integer): T; inline;
    procedure SetElement(const Index: Integer; const Value: T); inline;
    function  GetCount: Integer; inline;
  public
    class function AsString(const Elem: T): string; static;
    class procedure QuickSort(var Values: TArray<T>; const Comparer: IComparer<T>; L, R: Integer); static;
    function  Contains(const Value: T): Boolean;
    function  Copy(const Index, Count: Integer): List<T>; overload; inline;
    function  Every(const Callback: TTest): Boolean;
    function  Filter(const Callback: TTest): List<T>;
    function  Find(const Callback: TTest): T; overload;
    function  FindIndex(const Callback: TTest): Integer; overload;
    function  IndexOf(const Value: T; FromIndex: Integer = 0; ToIndex: Integer = MaxInt): Integer;
    function  Join(const Separator: string = ','; const Filter: TTest = nil): string;
    function  Map<DstT>(const Callback: TMap<DstT>): List<DstT>; overload;
    function  Map<DstT>(const Callback: TMap<DstT>; const Filter: TTest): List<DstT>; overload;
    function  Reduce<TAccumulator>(const Callback: TReduce<TAccumulator>; const InitValue: TAccumulator; const Filter: TTest = nil): TAccumulator;
    function  Reverse: List<T>;
    function  Slice(const FirstIndex: Integer): List<T>; overload; inline;
    function  Slice(FirstIndex, LastIndex: Integer): List<T>; overload;
    function  Some(const Callback: TTest): Boolean;
    function  Sort(const Comparer: IComparer<T> = nil): List<T>; inline;
  public
    function  GetEnumerator: TEnumerator;
    property  Count: Integer read GetCount;
    function  Low: Integer; inline;
    function  High: Integer; inline;
    property  Element[const Index: Integer]: T read GetElement write SetElement; default;
    property  Items: TArray<T> read FItems;
  public
//    class operator  Explicit(const A: List<T>): List<T>; inline;
    class operator  Implicit(const A: TArray<T>): List<T>; inline;
    class operator  Implicit(const A: array of T): List<T>;
    class operator  Implicit(const A: List<T>): TArray<T>; inline;
    class operator  Equal(const A, B: List<T>): Boolean;
    class operator  NotEqual(const A, B: List<T>): Boolean; inline;
    class operator  Add(const A, B: List<T>): List<T>; inline;
  end;

implementation

uses System.SysConst, System.Rtti;

{ List<T>.TEnumerator }

constructor List<T>.TEnumerator.Create(const AList: Pointer);
begin
  inherited Create;
  FList := AList;
  FIndex := -1;
end;

function List<T>.TEnumerator.GetCurrent: T;
begin
  Result := List<T>(FList^)[FIndex];
end;

function List<T>.TEnumerator.MoveNext: Boolean;
begin
  Inc(FIndex);
  Result := FIndex < List<T>(FList^).Count;
end;

{ List<T> }

function List<T>.GetCount: Integer;
begin
  Result := High - Low + 1;
end;

function List<T>.Low: Integer;
begin
  Result := System.Low(FItems);
end;

function List<T>.High: Integer;
begin
  Result := System.High(FItems);
end;

function List<T>.GetElement(const Index: Integer): T;
begin
  Result := FItems[Index];
end;

procedure List<T>.SetElement(const Index: Integer; const Value: T);
begin
  FItems[Index] := Value;
end;

function List<T>.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(@Self);
end;

{class operator List<T>.Explicit(const A: List<T>): List<T>;
begin
  Result.FItems := Copy(A.FItems, 0, Length(A.FItems));
end;}

class operator List<T>.Implicit(const A: List<T>): TArray<T>;
begin
  Result := System.Copy(A.FItems, 0, Length(A.FItems));
end;

class operator List<T>.Implicit(const A: TArray<T>): List<T>;
begin
  Result.FItems := System.Copy(A, 0, Length(A));
end;

class operator List<T>.Implicit(const A: array of T): List<T>;
begin
  SetLength(Result.FItems, Length(A));

  if Length(A) = 0 then
    Exit;

  if IsManagedType(T) then
    CopyArray(Pointer(Result.FItems), @A[0], TypeInfo(T), Length(A))
  else
    Move((@A[0])^, (@Result.FItems[0])^, Length(A) * SizeOf(T));
end;

class operator List<T>.Add(const A, B: List<T>): List<T>;
begin
  Result.FItems := A.FItems + B.FItems;
end;

class operator List<T>.Equal(const A, B: List<T>): Boolean;
var
  I: Integer;
  Comparer: IComparer<T>;
begin
  if (A.Low <> B.Low) or (A.High <> B.High) then
    Exit(False);

  Comparer := TComparer<T>.Default;

  for I := A.Low to A.High do
    if not Comparer.Compare(A[I], B[I]) <> 0 then
      Exit(False);

  Result := True;
end;

class operator List<T>.NotEqual(const A, B: List<T>): Boolean;
begin
  Result := not (A = B);
end;

function List<T>.Contains(const Value: T): Boolean;
var
  I: Integer;
  Comparer: IComparer<T>;
begin
  Comparer := TComparer<T>.Default;

  for I := Low to High do
    if Comparer.Compare(FItems[I], Value) = 0 then
      Exit(True);

  Result := False;
end;

function List<T>.IndexOf(const Value: T; FromIndex: Integer = 0; ToIndex: Integer = MaxInt): Integer;
var
  I: Integer;
  Comparer: IComparer<T>;
begin
  Comparer := TComparer<T>.Default;

  if FromIndex < Low then
    FromIndex := Low;

  if High < ToIndex then
    ToIndex := High;

  for I := FromIndex to ToIndex do
    if Comparer.Compare(FItems[I], Value) = 0 then
      Exit(I);

  Result := -1;
end;

class function List<T>.AsString(const Elem: T): string;
var
  Value: TValue;
  Context: TRttiContext;
  RecType: TRttiRecordType;
  Method: TRttiMethod;
begin
  Value := TValue.From<T>(Elem);

  if Value.IsEmpty then
    Exit('');

  if Value.TryAsType<string>(Result) then
    Exit;

  case Value.Kind of
    tkChar:
      Exit(Char(Value.AsOrdinal));
    tkInteger, tkInt64, tkEnumeration:
      Exit(IntToStr(Value.AsOrdinal));
    tkFloat:
      Exit(FloatToStr(Value.AsExtended));
    tkClass:
      Exit(Value.AsObject.ToString);
    tkVariant:
      Exit(VarToStr(Value.AsVariant));
    tkRecord, tkMRecord:
      begin
        Context := TRttiContext.Create;
        try
          RecType := Context.GetType(Value.TypeInfo).AsRecord;
          Method := RecType.GetMethod('ToString');
          if Method <> nil then
          begin
            Value := Method.Invoke(Value, []);
            Exit(Value.AsString);
          end;
        finally
          Context.Free;
        end;
      end;
  end;

  raise EInvalidCast.CreateRes(@SInvalidCast)
end;

function List<T>.Join(const Separator: string; const Filter: TTest): string;
var
  I: Integer;
  S: string;
begin
  Result := '';

  for I := Low to High do
    if not Assigned(Filter) or Filter(FItems[I], I) then
    begin
      S := AsString(FItems[I]);

      if Result <> '' then
        Result := Result + Separator + S
      else
        Result := S;
    end;
end;

function List<T>.Every(const Callback: TTest): Boolean;
var
  I: Integer;
begin
  for I := Low to High do
    if not Callback(FItems[I], I) then
      Exit(False);

  Result := True;
end;

function List<T>.Filter(const Callback: TTest): List<T>;
var
  I, C: Integer;
begin
  C := 0;
  SetLength(Result.FItems, Length(FItems));
  for I := Low to High do
    if Callback(FItems[I], I) then
    begin
      Result.FItems[C] := FItems[I];
      Inc(C);
    end;
  SetLength(Result.FItems, C);
end;

function List<T>.Find(const Callback: TTest): T;
var
  I: Integer;
begin
  for I := Low to High do
    if Callback(FItems[I], I) then
      Exit(FItems[I]);

  Result := default(T);
end;

function List<T>.FindIndex(const Callback: TTest): Integer;
var
  I: Integer;
begin
  for I := Low to High do
    if Callback(FItems[I], I) then
      Exit(I);

  Result := -1;
end;

function List<T>.Map<DstT>(const Callback: TMap<DstT>): List<DstT>;
var
  C, I: Integer;
begin
  C := 0;
  SetLength(Result.FItems, Length(FItems));
  for I := Low to High do
  begin
    Result.FItems[C] := Callback(FItems[I], I);
    Inc(C);
  end;
end;

function List<T>.Map<DstT>(const Callback: TMap<DstT>; const Filter: TTest): List<DstT>;
var
  C, I: Integer;
begin
  C := 0;
  SetLength(Result.FItems, Length(FItems));
  for I := Low to High do
    if Filter(FItems[I], I) then
    begin
      Result.FItems[C] := Callback(FItems[I], I);
      Inc(C);
    end;
  SetLength(Result.FItems, C);
end;

function List<T>.Reduce<TAccumulator>(const Callback: TReduce<TAccumulator>; const InitValue: TAccumulator; const Filter: TTest = nil): TAccumulator;
var
  I: Integer;
begin
  Result := InitValue;
  for I := Low to High do
    if not Assigned(Filter) or Filter(FItems[I], I) then
      Result := Callback(Result, FItems[I], I);
end;

function List<T>.Reverse: List<T>;
var
  I: Integer;
begin
  SetLength(Result.FItems, Length(FItems));
  for I := Low to High do
    Result.FItems[High - I] := FItems[I];
end;

function List<T>.Slice(const FirstIndex: Integer): List<T>;
begin
  Result := Slice(FirstIndex, High);
end;

function List<T>.Slice(FirstIndex, LastIndex: Integer): List<T>;
var
  I: Integer;
begin
  if FirstIndex < 0 then
    FirstIndex := High - FirstIndex;

  if LastIndex < 0 then
    LastIndex := High - LastIndex;

  if FirstIndex < Low then
    FirstIndex := Low;

  if LastIndex > High then
    LastIndex := High;

  if LastIndex < FirstIndex then
  begin
    SetLength(Result.FItems, 0);
    Exit;
  end;

  SetLength(Result.FItems, LastIndex - FirstIndex + 1);
  for I := FirstIndex to LastIndex do
    Result.FItems[I - FirstIndex] := FItems[I];
end;

function List<T>.Copy(const Index, Count: Integer): List<T>;
begin
  Result.FItems := System.Copy(FItems, Index, Count);
end;

function List<T>.Some(const Callback: TTest): Boolean;
var
  I: Integer;
begin
  for I := Low to High do
    if Callback(FItems[I], I) then
      Exit(True);

  Result := False;
end;

function List<T>.Sort(const Comparer: IComparer<T>): List<T>;
begin
  Result.FItems := System.Copy(FItems, 0, Count);
  if Comparer = nil then
    QuickSort(Result.FItems, TComparer<T>.Default, Low, High)
  else
    QuickSort(Result.FItems, Comparer, Low, High);
end;

class procedure List<T>.QuickSort(var Values: TArray<T>; const Comparer: IComparer<T>; L, R: Integer);
var
  I, J: Integer;
  pivot, temp: T;
begin
  if L < R then
  begin
    repeat
      if (R - L) = 1 then
      begin
        if Comparer.Compare(Values[L], Values[R]) > 0 then
        begin
          temp := Values[L];
          Values[L] := Values[R];
          Values[R] := temp;
        end;
        break;
      end;
      I := L;
      J := R;
      pivot := Values[L + (R - L) shr 1];
      repeat
        while Comparer.Compare(Values[I], pivot) < 0 do
          Inc(I);
        while Comparer.Compare(Values[J], pivot) > 0 do
          Dec(J);
        if I <= J then
        begin
          if I <> J then
          begin
            temp := Values[I];
            Values[I] := Values[J];
            Values[J] := temp;
          end;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if (J - L) > (R - I) then
      begin
        if I < R then
          QuickSort(Values, Comparer, I, R);
        R := J;
      end
      else
      begin
        if L < J then
          QuickSort(Values, Comparer, L, J);
        L := I;
      end;
    until L >= R;
  end;
end;

end.
