unit Ext.Types.SmartPtr;

interface

uses
  System.Types, System.SysUtils;

type
  ///<summary>
  ///  Because of Delphi realisation of anonymous methods,
  ///  this type can be treated not only as Delegate,
  ///  but also as interface with Invoke method that returns generics type <T>
  ///</summary>
  AutoRef<T: class> = reference to function: T;

  Shared = class
  private
    class var FLock: TObject;
  protected
    class constructor Create;
    class destructor Destroy;
  public
    class procedure Initialize<T: class>(var Value: T; const Initializer: AutoRef<T>); static; inline;
  end;

  ///<summary>
  ///  This type realizes creating ARC owner of object instance type that freed
  ///  owned object when out of scope (reference count = 0)
  ///</summary>
  Ref<T: class> = record
  private type
    TAutoRef = class(TInterfacedObject, AutoRef<T>)
    private
      FValue: T;
    protected
      function  Invoke: T;
    public
      constructor Create(const Value: T);
      destructor Destroy; override;
    end;
  private
    FValue: T;
  public
    class function Create(const Value: T): AutoRef<T>; static; inline;
    class operator Implicit(const Value: Ref<T>): AutoRef<T>; static; inline;
    class operator Explicit(const Value: T): Ref<T>; static; inline;
  end;

  ///<summary>
  ///  This type same as Ref<T>, but with deferred creation of owned object.
  ///  Also, this type is thread safe.
  ///</summary>
  DeferredRef<T: class> = record
  private type
    TDeferredRef = class(TInterfacedObject, AutoRef<T>)
    private
      FCreator: AutoRef<T>;
      FValue: T;
    protected
      function  Invoke: T;
    public
      constructor Create(const Creator: AutoRef<T>);
      destructor Destroy; override;
    end;
  private
    FCreator: AutoRef<T>;
  public
    class function Create(const Creator: AutoRef<T>): AutoRef<T>; static; inline;
    class operator Implicit(const Value: DeferredRef<T>): AutoRef<T>; static; inline;
    class operator Explicit(const Value: AutoRef<T>): DeferredRef<T>; static; inline;
  end;

implementation

{ Shared }

class constructor Shared.Create;
begin
  FLock := TObject.Create;
end;

class destructor Shared.Destroy;
begin
  FreeAndNil(FLock);
end;

class procedure Shared.Initialize<T>(var Value: T; const Initializer: AutoRef<T>);
begin
  if not Assigned(Value) then
    System.TMonitor.Enter(FLock);
    try
      if not Assigned(Value) then
        Value := Initializer();
    finally
      System.TMonitor.Exit(FLock);
    end;
end;

{ Ref<T>.TAutoRef }

constructor Ref<T>.TAutoRef.Create(const Value: T);
begin
  FValue := Value;
end;

destructor Ref<T>.TAutoRef.Destroy;
begin
  FreeAndNil(FValue);
end;

function Ref<T>.TAutoRef.Invoke: T;
begin
  Result := FValue;
end;

{ Ref<T> }

class function Ref<T>.Create(const Value: T): AutoRef<T>;
begin
  Result := TAutoRef.Create(Value);
end;

class operator Ref<T>.Implicit(const Value: Ref<T>): AutoRef<T>;
begin
  Result := TAutoRef.Create(Value.FValue);
end;

class operator Ref<T>.Explicit(const Value: T): Ref<T>;
begin
  Result.FValue := Value;
end;

{ DeferredRef<T> }

class function DeferredRef<T>.Create(const Creator: AutoRef<T>): AutoRef<T>;
begin
  Result := TDeferredRef.Create(Creator);
end;

class operator DeferredRef<T>.Explicit(const Value: AutoRef<T>): DeferredRef<T>;
begin
  Result.FCreator := Value;
end;

class operator DeferredRef<T>.Implicit(const Value: DeferredRef<T>): AutoRef<T>;
begin
  Result := TDeferredRef.Create(Value.FCreator);
end;

{ DeferredRef<T>.TDeferredRef }

constructor DeferredRef<T>.TDeferredRef.Create(const Creator: AutoRef<T>);
begin
  FCreator := Creator;
  FValue := nil;
end;

destructor DeferredRef<T>.TDeferredRef.Destroy;
begin
  FreeAndNil(FValue);
end;

function DeferredRef<T>.TDeferredRef.Invoke: T;
begin
  Shared.Initialize<T>(FValue, FCreator);
  Result := FValue;
end;

end.
