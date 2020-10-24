unit Ext.Types.SmartPtr;

interface

uses System.SysUtils;

type
  ENilReference = class(Exception);

  ///<summary>
  ///  Ref<T> generic type holds an Object of T class and uses ARC to dispose object.
  ///  Ref<T> increment reference counter on Assignment operator and decrease when Ref<T> variable
  ///  leave his scope
  ///<summary>
  Ref<T: class> = record
  private type
    PSharedReference = ^TSharedReference;
    TSharedReference = record
      Count: Integer;
      Obj: T;
    end;
  private
    Ref: PSharedReference;
    function  GetObject: T; inline;
    procedure Release;
  public
    property  Obj: T read GetObject;
  public
    class operator Initialize(out A: Ref<T>);
    class operator Finalize(var A: Ref<T>);
    class operator Assign(var Result: Ref<T>; const [ref] Src: Ref<T>); static; inline;
    class operator Explicit(const R: T): Ref<T>; static; inline;
    class operator Implicit(const R: Ref<T>): T; static; inline;
    class operator Explicit(const R: Ref<T>): T; static; inline;
    class operator Equal(const L, R: Ref<T>): Boolean; static; inline;
    class operator Equal(const L: Ref<T>; const R: T): Boolean; static; inline;
    class operator Equal(const L: T; const R: Ref<T>): Boolean; static; inline;
    class operator NotEqual(const L, R: Ref<T>): Boolean; static; inline;
    class operator NotEqual(const L: Ref<T>; const R: T): Boolean; static; inline;
    class operator NotEqual(const L: T; const R: Ref<T>): Boolean; static; inline;
  end;

resourcestring
  SNilReferenceError = 'Access to a nil reference';

implementation

{ Ref<T> }

function Ref<T>.GetObject: T;
begin
  Result := Ref.Obj;
end;

procedure Ref<T>.Release;
begin
  if Ref <> nil then
  begin
    Dec(Ref.Count);
    if Ref.Count = 0 then
    begin
      if Ref.Obj <> nil then
        FreeAndNil(Ref.Obj);
      System.Finalize(Ref^);
      FreeMem(Ref);
      Ref := nil;
    end;
  end;
end;

class operator Ref<T>.Initialize(out A: Ref<T>);
begin
  A.Ref := nil;
end;

class operator Ref<T>.Finalize(var A: Ref<T>);
begin
  A.Release;
end;

class operator Ref<T>.Assign(var Result: Ref<T>; const [ref] Src: Ref<T>);
begin
  Result.Ref := Src.Ref;
  if Result.Ref <> nil then
    Inc(Result.Ref.Count);
end;

class operator Ref<T>.Explicit(const R: T): Ref<T>;
begin
  GetMem(Result.Ref, SizeOf(TSharedReference));
  FillChar(Result.Ref^, SizeOf(TSharedReference), 0);
  System.Initialize(Result.Ref^);
  Result.Ref.Count := 1;
  Result.Ref.Obj := R;
end;

class operator Ref<T>.Implicit(const R: Ref<T>): T;
begin
  if R.Ref = nil then
    raise ENilReference.Create(SNilReferenceError);

  Result := R.Ref.Obj;
end;

class operator Ref<T>.Explicit(const R: Ref<T>): T;
begin
  if R.Ref = nil then
    raise ENilReference.Create(SNilReferenceError);

  Result := R.Ref.Obj;
end;

class operator Ref<T>.Equal(const L, R: Ref<T>): Boolean;
begin
  Result := L.Ref = R.Ref;
end;

class operator Ref<T>.Equal(const L: Ref<T>; const R: T): Boolean;
begin
  Result := (L.Ref <> nil) and (L.Ref.Obj = R);
end;

class operator Ref<T>.Equal(const L: T; const R: Ref<T>): Boolean;
begin
  Result := (R.Ref <> nil) and (R.Ref.Obj = L);
end;

class operator Ref<T>.NotEqual(const L, R: Ref<T>): Boolean;
begin
  Result := L.Ref <> R.Ref;
end;

class operator Ref<T>.NotEqual(const L: Ref<T>; const R: T): Boolean;
begin
  Result := (L.Ref = nil) or (L.Ref.Obj <> R);
end;

class operator Ref<T>.NotEqual(const L: T; const R: Ref<T>): Boolean;
begin
  Result := (R.Ref = nil) or (R.Ref.Obj <> L);
end;

end.
