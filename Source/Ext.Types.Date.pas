unit Ext.Types.Date;

interface

uses
  System.Types, {$IFDEF MSWINDOWS}Winapi.Windows, {$ENDIF}System.SysUtils, System.Variants, System.Generics.Defaults, System.Generics.Collections;

type
  TMonthNum   = 1..12;
  TWeekdayNum = 1..7;
  TQuarterNum = 1..4;
  TMonthDay   = 1..31;
  TDayOfYear  = 1..366;

  TYears   = type Integer;
  TMonths  = type Integer;
  TDays    = type Integer;
  THours   = type Integer;
  TMinutes = type Integer;
  TSeconds = type Integer;

  TDatePart = (
    Year,
    Quarter,
    Month,
    Week,
    Day
  );

  TTimePart = (
    Second,
    Hour,
    Minute,
    Millisecond,
    Microsecond,
    Nanosecond
  );

  TDateParts = record
    Y: Word;
    M: Word;
    D: Word;
  end;

{$region 'Weeks'}

  PWeekday = ^TWeekday;

  ///<summary>
  ///  Represent day of the week, where first day is Sunday (1) to Saturday (7)
  ///</summary>
  TWeekday = record
  private
    FDay: TWeekdayNum;
    function  GetDayOfWeek(const FirstDayOfWeek: TWeekday): TWeekdayNum; inline;
    procedure SetDayOfWeek(const FirstDayOfWeek: TWeekday; const Value: TWeekdayNum); inline;
    function  GetDay: TWeekdayNum; inline;
    procedure SetDay(const Value: TWeekdayNum);  inline;
  public
    ///<summary>
    ///  Name of the day as in LongDayNames of system global FormatSettings
    ///</summary>
    function  ToString: string; overload; inline;
    ///<summary>
    ///  Name of the day as in LongDayNames of FormatSettings parameter
    ///</summary>
    function  ToString(const FormatSettings: TFormatSettings): string; overload; inline;
    ///<summary>
    ///  Name of the day as in LongDayNames of system global FormatSettings
    ///</summary>
    function  LongName: string; overload; inline;
    ///<summary>
    ///  Name of the day as in LongDayNames of FormatSettings parameter
    ///</summary>
    function  LongName(const FormatSettings: TFormatSettings): string; overload; inline;
    ///<summary>
    ///  Name of the day as in ShortDayNames of system global FormatSettings
    ///</summary>
    function  ShortName: string; overload; inline;
    ///<summary>
    ///  Name of the day as in ShortDayNames of FormatSettings parameter
    ///</summary>
    function  ShortName(const FormatSettings: TFormatSettings): string; overload; inline;
    ///<summary>
    ///  Try parse Value using system global FormatSettings properties LongDayNames and ShortDayNames.
    ///  Case insensitive
    ///</summary>
    procedure Parse(const Value: string); overload; inline;
    ///<summary>
    ///  Try parse Value using FormatSettings properties LongDayNames and ShortDayNames.
    ///  Case insensitive
    ///</summary>
    procedure Parse(const Value: string; const FormatSettings: TFormatSettings); overload; inline;
    function  TryParse(const Value: string): Boolean; overload; inline;
    function  TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean; overload; inline;
    ///<summary>
    ///  Get and Set number of day in week based on week started from FirstDayOfWeek parameter
    ///</summary>
    ///<code>
    ///  Monday.DayOfWeek[Monday] returns 1
    ///  Monday.DayOfWeek[Sunday] returns 2
    ///</code>
    property  DayOfWeek[const FirstDayOfWeek: TWeekday]: TWeekdayNum read GetDayOfWeek write SetDayOfWeek;
    ///<summary>
    ///  Get and Set number of day in week based on week started from FirstDayOfWeek global variable
    ///</summary>
    property  Day: TWeekdayNum read GetDay write SetDay;
  public
    function GetHashCode: Integer;
    class operator Add(const a: TWeekday; b: Word): TWeekday; inline;
    class operator Subtract(const a, b: TWeekday): Integer; inline;
    class operator Subtract(const a: TWeekday; const b: Word): TWeekday; inline;
    class operator Implicit(const a: Word): TWeekday; inline;
    class operator Implicit(const a: TWeekday): Word; inline;
    class operator Implicit(const a: TWeekdayNum): TWeekday; inline;
    class operator Implicit(const a: TWeekday): TWeekdayNum; inline;
    class operator Explicit(const a: TWeekday): string; inline;
    class operator Explicit(const a: string): TWeekday; inline;
    class operator Equal(const a, b: TWeekday) : Boolean; inline;
    class operator NotEqual(const a, b: TWeekday) : Boolean; inline;
    class operator GreaterThan(const a, b: TWeekday) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TWeekday) : Boolean; inline;
    class operator LessThan(const a, b: TWeekday) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TWeekday) : Boolean; inline;
  end;

  PWeek = ^TWeek;

  ///<summary>
  ///  Type to enumerate days in week, based on FirstDayOfWeek
  ///</summary>
  TWeek = record
  private type
    TEnumerator = class
    private
      FFirstDayOfWeek: TWeekday;
      FCurrentIndex: Integer;
    public
      function GetCurrent: TWeekday; inline;
      function MoveNext:   Boolean; inline;
      property Current:    TWeekday read GetCurrent;
    end;
  private
    FFirstDayOfWeek: TWeekday;
    function  Get(const Index: TWeekdayNum): TWeekday; inline;
  public
    constructor Create(const FirstDayOfWeek: TWeekday); overload;
    function  GetEnumerator: TEnumerator; inline;
    property  FirstDayOfWeek: TWeekday read FFirstDayOfWeek;
    property  DayOfWeek[const Index: TWeekdayNum]: TWeekday read Get; default;
  end;

  ///<summary>
  ///  Return week enumeration based on FirstDayOfWeek parameter
  ///</summary>
  function  WeekDays(const FirstDayOfWeek: TWeekday): TWeek; overload; inline;
  ///<summary>
  ///  Return week enumeration based on FirstDayOfWeek global variable
  ///</summary>
  function  WeekDays: TWeek; overload; inline;

const
  Sunday: TWeekday = (FDay: 1);
  Monday: TWeekday = (FDay: 2);
  Tuesday: TWeekday = (FDay: 3);
  Wednesday: TWeekday = (FDay: 4);
  Thursday: TWeekday = (FDay: 5);
  Friday: TWeekday = (FDay: 6);
  Saturday: TWeekday = (FDay: 7);

{$endregion}

{$region 'Day'}

type
  PDay = ^TDay;
  ///<summary>
  ///  Type reperesenting day of month
  ///</summary>
  TDay = record
  private
    FDay: Word;
  public
    function ToString: string;
    function GetHashCode: Integer;
  public
    class operator Implicit(const a: Word): TDay; inline;
    class operator Implicit(const a: TDay): Word; inline;
    class operator Explicit(const a: string): TDay; inline;
    class operator Explicit(const a: TDay): string; inline;
    class operator Add(const a: TDay; const b: Word): TDay; inline;
    class operator Subtract(const a: TDay; const b: Word): TDay; inline;
    class operator Multiply(const a: TDay; const b: Word): TDay; inline;
    class operator IntDivide(const a: TDay; const b: Word): TDay; inline;
    class operator Inc(const a: TDay): TDay; inline;
    class operator Dec(const a: TDay): TDay; inline;
    class operator Equal(const a, b: TDay) : Boolean; inline;
    class operator NotEqual(const a, b: TDay) : Boolean; inline;
    class operator GreaterThan(const a, b: TDay) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TDay) : Boolean; inline;
    class operator LessThan(const a, b: TDay) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TDay) : Boolean; inline;
  end;
{$endregion}

{$region 'Year'}
  PYear = ^TYear;

  ///<summary>
  ///  Type reperesenting year.
  ///  Type impilicitly compatible with Word
  ///</summary>
  TYear = record
  private
    FYear: Word;
  public
    ///<summary>
    ///  Return year of current system date
    ///</summary>
    class function Current: TYear; static; inline;
    ///<summary>
    ///  Return true if is leap year
    ///</summary>
    function  IsLeap: Boolean; inline;
    function  ToString: string;
    function  GetHashCode: Integer;
  public
    class operator Implicit(const a: Word): TYear; inline;
    class operator Implicit(const a: TYear): Word; inline;
    class operator Explicit(const a: string): TYear; inline;
    class operator Explicit(const a: TYear): string; inline;
    class operator Add(const a: TYear; const b: Word): TYear; inline;
    class operator Subtract(const a: TYear; const b: Word): TYear; inline;
    class operator Subtract(const a, b: TYear): Integer; inline;
    class operator Multiply(const a: TYear; const b: Word): TYear; inline;
    class operator IntDivide(const a: TYear; const b: Word): TYear; inline;
    class operator Inc(const a: TYear): TYear; inline;
    class operator Dec(const a: TYear): TYear; inline;
    class operator Equal(const a, b: TYear) : Boolean; inline;
    class operator NotEqual(const a, b: TYear) : Boolean; inline;
    class operator GreaterThan(const a, b: TYear) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TYear) : Boolean; inline;
    class operator LessThan(const a, b: TYear) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TYear) : Boolean; inline;
  end;

{$endregion}

{$region 'Quarter'}

  PQuarter = ^TQuarter;

  TQuarter = record
  private
    FQuarter: Word;
  private type
    TSequenceEnumerator = class
    private
      FLast, FCurrent: Word;
      function  GetCurrent: TQuarter; inline;
    public
      constructor Create(const First, Last: TQuarterNum);
      function  MoveNext: Boolean; inline;
      property  Current: TQuarter read GetCurrent;
    end;
  public type
    TSequence = record
    private
      FFirst: TQuarterNum;
      FLast: TQuarterNum;
      FCount: Integer;
    public
      constructor Create(const First, Last: TQuarter);
      function  GetEnumerator: TSequenceEnumerator; inline;
      property  Count: Integer read FCount;
    end;
  public const
    Roman: array[TQuarterNum] of string = ('I', 'II', 'III', 'IV');
    Arabic: array[TQuarterNum] of string = ('1', '2', '3', '4');
    Unicode: array[TQuarterNum] of string = (#2160, #2161, #2162, #2163);
  public
    class function Range(const First, Last: TQuarter): TSequence; static; inline;
  public
    class operator Add(const a: TQuarter; b: Word): TQuarter; inline;
    class operator Subtract(const a, b: TQuarter): Integer; inline;
    class operator Subtract(const a: TQuarter; const b: Word): TQuarter; inline;
    class operator Implicit(const a: Word): TQuarter; inline;
    class operator Implicit(const a: TQuarter): Word; inline;
    class operator Implicit(const a: TQuarterNum): TQuarter; inline;
    class operator Implicit(const a: TQuarter): TQuarterNum; inline;
    class operator Explicit(const a: string): TQuarter; inline;
    class operator Explicit(const a: TQuarter): string; inline;
    class operator Equal(const a, b: TQuarter) : Boolean; inline;
    class operator NotEqual(const a, b: TQuarter) : Boolean; inline;
    class operator GreaterThan(const a, b: TQuarter) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TQuarter) : Boolean; inline;
    class operator LessThan(const a, b: TQuarter) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TQuarter) : Boolean; inline;
  end;

  TQuarters = type TQuarter.TSequence;

const
  Quarter1: TQuarter = (FQuarter: 1);
  Quarter2: TQuarter = (FQuarter: 2);
  Quarter3: TQuarter = (FQuarter: 3);
  Quarter4: TQuarter = (FQuarter: 4);

type
  PQuarterOfYear = ^TQuarterOfYear;

  ///<summary>
  ///  Type allows increment & decrement Quarter to iterate through years and quarters
  ///</summary>
  TQuarterOfYear = record
  private
    FYear: TYear;
    FQuarter: TQuarter;
    procedure SetQuarter(const Value: TQuarter); inline;
    procedure SetYear(const Value: TYear); inline;
    function  GetIndex: Integer; inline;
    procedure SetIndex(const Value: Integer); inline;
    property  Index: Integer read GetIndex write SetIndex;
  public
    constructor Create(const Date: System.TDateTime); overload;
    constructor Create(const Year: TYear; const Quarter: TQuarter); overload;
    class function Current: TQuarterOfYear; static; inline;
    property  Year: TYear read FYear write SetYear;
    property  Quarter: TQuarter read FQuarter write SetQuarter;
  public
    class operator Explicit(const a: System.TDateTime): TQuarterOfYear; inline;
    class operator Add(const a: TQuarterOfYear; b: Word): TQuarterOfYear; inline;
    class operator Subtract(const a, b: TQuarterOfYear): Integer; inline;
    class operator Subtract(const a: TQuarterOfYear; const b: Word): TQuarterOfYear; inline;
    class operator Inc(const a: TQuarterOfYear): TQuarterOfYear; inline;
    class operator Dec(const a: TQuarterOfYear): TQuarterOfYear; inline;
    class operator Equal(const a, b: TQuarterOfYear) : Boolean; inline;
    class operator NotEqual(const a, b: TQuarterOfYear) : Boolean; inline;
    class operator GreaterThan(const a, b: TQuarterOfYear) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TQuarterOfYear) : Boolean; inline;
    class operator LessThan(const a, b: TQuarterOfYear) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TQuarterOfYear) : Boolean; inline;
  end;

{$endregion}

{$region 'Month'}

type
  PMonth = ^TMonth;

  ///<summary>
  ///  Type reperesenting a month
  ///</summary>
  TMonth = record
  private
    FMonth: Word;
  private type
    TSequenceEnumerator = class
    private
      FLast, FCurrent: Word;
      function  GetCurrent: TMonth; inline;
    public
      constructor Create(const First, Last: TMonthNum);
      function  MoveNext: Boolean; inline;
      property  Current: TMonth read GetCurrent;
    end;
  public type
    TSequence = record
    private
      FFirst: TMonthNum;
      FLast: TMonthNum;
      FCount: Integer;
    public
      constructor Create(const First, Last: TMonth);
      function  GetEnumerator: TSequenceEnumerator; inline;
      property  Count: Integer read FCount;
    end;
  public
    ///<summary>
    ///  Name of the month as in LongMonthNames of system global FormatSettings
    ///</summary>
    function  ToString: string; overload; inline;
    ///<summary>
    ///  Name of the month as in LongMonthNames of FormatSettings parameter
    ///</summary>
    function  ToString(const FormatSettings: TFormatSettings): string; overload; inline;
    function  ToString(Short: Boolean): string; overload; inline;
    function  ToString(Short: Boolean; const FormatSettings: TFormatSettings): string; overload; inline;
    ///<summary>
    ///  Returns count of days in month of a Year
    ///</summary>
    function  Days(const Year: TYear): TDays; inline;
  public
    class operator Add(const a: TMonth; b: Word): TMonth; inline;
    class operator Subtract(const a, b: TMonth): Integer; inline;
    class operator Subtract(const a: TMonth; const b: Word): TMonth; inline;
    class operator Implicit(const a: Word): TMonth; inline;
    class operator Implicit(const a: TMonth): Word; inline;
    class operator Implicit(const a: TMonth): TMonthNum; inline;
    class operator Explicit(const a: string): TMonth; inline;
    class operator Explicit(const a: TMonth): string; inline;
    class operator Equal(const a, b: TMonth) : Boolean; inline;
    class operator NotEqual(const a, b: TMonth) : Boolean; inline;
    class operator GreaterThan(const a, b: TMonth) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TMonth) : Boolean; inline;
    class operator LessThan(const a, b: TMonth) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TMonth) : Boolean; inline;
  end;

const
  January  : TMonth = (FMonth: 1);
  February : TMonth = (FMonth: 2);
  March    : TMonth = (FMonth: 3);
  April    : TMonth = (FMonth: 4);
  May      : TMonth = (FMonth: 5);
  June     : TMonth = (FMonth: 6);
  July     : TMonth = (FMonth: 7);
  August   : TMonth = (FMonth: 8);
  September: TMonth = (FMonth: 9);
  October  : TMonth = (FMonth: 10);
  November : TMonth = (FMonth: 11);
  December : TMonth = (FMonth: 12);

type
  PMonthOfYear = ^TMonthOfYear;

  ///<summary>
  ///  Type allows increment & decrement month to iterate through years and months
  ///</summary>
  TMonthOfYear = record
  private
    FYear: TYear;
    FMonth: TMonth;
    function  GetDays: TDays; inline;
    procedure SetMonth(const Value: TMonth); inline;
    procedure SetYear(const Value: TYear); inline;
    function  GetIndex: Integer; inline;
    procedure SetIndex(const Value: Integer); inline;
    property  Index: Integer read GetIndex write SetIndex;
  private type
    TSequenceEnumerator = class
    private
      FCurrent: Integer;
      FLast: TMonth;
      function  GetCurrent: TMonthOfYear; inline;
    public
      constructor Create(const FirstMonth: TMonth; const FirstYear: TYear; const LastMonth: TMonth; const LastYear: TYear);
      function  MoveNext: Boolean; inline;
      property  Current: TMonthOfYear read GetCurrent;
    end;
  public type
    TSequence = record
    private
      FFirstYear: TYear;
      FFirstMonth: TMonth;
      FLastYear: TYear;
      FLastMonth: TMonth;
      FCount: Integer;
    public
      constructor Create(const First, Last: TMonthOfYear);
      function  GetEnumerator: TSequenceEnumerator; inline;
    end;
  public
    constructor Create(const Date: System.TDateTime); overload;
    constructor Create(const Year: TYear; const Month: TMonth); overload;
    class function Current: TMonthOfYear; static; inline;
    function  ToString: string;
    function  GetHashCode: Integer;
    property  Year: TYear read FYear write SetYear;
    property  Month: TMonth read FMonth write SetMonth;
    property  Days: TDays read GetDays;
  public
    class operator Implicit(const a: TMonthOfYear): TMonth; inline;
    class operator Implicit(const a: TMonthOfYear): TMonthNum; inline;
    class operator Explicit(const a: System.TDateTime): TMonthOfYear; inline;
    class operator Add(const a: TMonthOfYear; b: Word): TMonthOfYear; inline;
    class operator Subtract(const a, b: TMonthOfYear): Integer; inline;
    class operator Subtract(const a: TMonthOfYear; const b: Word): TMonthOfYear; inline;
    class operator Inc(const a: TMonthOfYear): TMonthOfYear; inline;
    class operator Dec(const a: TMonthOfYear): TMonthOfYear; inline;
    class operator Equal(const a, b: TMonthOfYear) : Boolean; inline;
    class operator NotEqual(const a, b: TMonthOfYear) : Boolean; inline;
    class operator GreaterThan(const a, b: TMonthOfYear) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TMonthOfYear) : Boolean; inline;
    class operator LessThan(const a, b: TMonthOfYear) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TMonthOfYear) : Boolean; inline;
  end;

  TDayOfMonth = record
  private
    FMonth: TMonth;
    FDay: TDay;
    procedure SetDay(const Value: TDay);
    procedure SetMonth(const Value: TMonth);
  public
    function ToString: string;
    function GetHashCode: Integer;
  public
    class operator Equal(const a, b: TDayOfMonth) : Boolean; inline;
    class operator NotEqual(const a, b: TDayOfMonth) : Boolean; inline;
    class operator GreaterThan(const a, b: TDayOfMonth) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TDayOfMonth) : Boolean; inline;
    class operator LessThan(const a, b: TDayOfMonth) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TDayOfMonth) : Boolean; inline;
  public
    property  Month: TMonth read FMonth write SetMonth;
    property  Day: TDay read FDay write SetDay;
  end;

{$endregion}

{$region 'Date'}
type
  PDate = ^TDate;

  TDate = record
  private type
    TSequenceEnumerator = class
    private
      FStart, FLast: Integer;
      function  GetCurrent: TDate; inline;
    public
      constructor Create(const First, Last: Integer);
      function  MoveNext: Boolean; inline;
      property  Current: TDate read GetCurrent;
    end;
  public type
    TSequence = record
    private
      FFirst: Integer;
      FLast: Integer;
      FCount: Integer;
    public
      constructor Create(const First, Last: TDate);
      function  GetEnumerator: TSequenceEnumerator; inline;
      property  Count: Integer read FCount;
    end;
  private
    FDate: Integer; // Date stamp - number of days from 00001-01-01
    function  GetDay: TDay; inline;
    function  GetISO: string; inline;
    function  GetMonth: TMonth; inline;
    function  GetWeekday: TWeekday; inline;
    function  GetQuarter: TQuarter; inline;
    function  GetQuarterOfYear: TQuarterOfYear; inline;
    function  GetYear: TYear; inline;
    procedure SetDay(const Value: TDay); inline;
    procedure SetISO(const Value: string);
    procedure SetMonth(const Value: TMonth); inline;
    procedure SetWeekday(const Value: TWeekday); inline;
    procedure SetYear(const Value: TYear); inline;
    function  GetMonthOfYear: TMonthOfYear; inline;
    procedure SetMonthOfYear(const Value: TMonthOfYear); inline;
    function  GetDayOfYear: TDayOfYear;
    procedure SetDayOfYear(const Value: TDayOfYear);
    function  GetDayOfMonth: TDayOfMonth;
  public
    function  ToString: string; overload; inline;
    function  ToString(const FormatSettings: TFormatSettings): string; overload; inline;
    function  Format(const Format: string): string; overload; inline;
    function  Format(const Format: string; const FormatSettings: TFormatSettings): string; overload; inline;
    procedure Parse(const Value: string); overload; inline;
    procedure Parse(const Value: string; const FormatSettings: TFormatSettings); overload; inline;
    function  TryParse(const Value: string): Boolean; overload; inline;
    function  TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean; overload; inline;
    function  StartOfWeek: TDate; overload; inline;
    function  StartOfWeek(const FirstDayOfWeek: TWeekday): TDate; overload; inline;
    function  EndOfWeek: TDate; overload; inline;
    function  EndOfWeek(const FirstDayOfWeek: TWeekday): TDate; overload; inline;
    procedure Encode(const Year, Month, Day: Word); overload; inline;
    procedure Encode(const Year, Month: Word); overload; inline;
    procedure Encode(const Year: Word); overload; inline;
    procedure Encode(const Year: TYear; const Month: TMonth; const Day: TDay); overload; inline;
    procedure Decode(var Year, Month, Day: Word); overload;
    procedure Decode(var Year, Month: Word); overload; inline;
    procedure Decode(var Year: Word); overload; inline;
    procedure Decode(var Year: TYear; var Month: TMonth; var Day: TDay); overload; inline;
    property  Day: TDay read GetDay write SetDay;
    property  DayOfMonth: TDayOfMonth read GetDayOfMonth;
    property  DayOfYear: TDayOfYear read GetDayOfYear write SetDayOfYear;
    property  Month: TMonth read GetMonth write SetMonth;
    property  Quarter: TQuarter read GetQuarter;
    property  Year: TYear read GetYear write SetYear;
    property  Weekday: TWeekday read GetWeekday write SetWeekday;
    property  MonthOfYear: TMonthOfYear read GetMonthOfYear write SetMonthOfYear;
    property  QuarterOfYear: TQuarterOfYear read GetQuarterOfYear;
    property  ISO: string read GetISO write SetISO;
  public
    constructor Create(const Date: TDate); overload;
    constructor Create(const Date: System.TDateTime); overload;
    constructor Create(const Year: TYear; const Month: TMonth; const Day: TDay); overload;
    constructor Create(const Year, Month, Day: Word); overload;
    class function Today: TDate; overload; static; inline;
    class function Range(const First, Last: TDate): TArray<TDate>; static;
    class function Sequence(const First, Last: TDate): TSequence; static;
  public
    class operator Add(const a: TDate; const b: Integer): TDate; inline;
    class operator Subtract(const a: TDate; const b: Integer): TDate; inline;
    class operator Subtract(const a, b: TDate): Integer; inline;
    class operator Implicit(const a: System.TDateTime): TDate; inline;
    class operator Implicit(const a: TDate): System.TDateTime; inline;
    class operator Implicit(const a: TTimeStamp): TDate; inline;
    class operator Implicit(const a: TDate): TTimeStamp; inline;
    class operator Implicit(const a: Variant): TDate; inline;
    class operator Implicit(const a: TDate): Variant; inline;
    class operator Explicit(const a: Integer): TDate; inline;
    class operator Explicit(const a: TDate): Integer; inline;
    class operator Explicit(const a: TDate): string; inline;
    class operator Explicit(const a: string): TDate; inline;
    class operator Inc(const a: TDate): TDate; inline;
    class operator Dec(const a: TDate): TDate; inline;
    class operator Equal(const a, b: TDate) : Boolean; inline;
    class operator NotEqual(const a, b: TDate) : Boolean; inline;
    class operator GreaterThan(const a, b: TDate) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TDate) : Boolean; inline;
    class operator LessThan(const a, b: TDate) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TDate) : Boolean; inline;
  end;

  TDates = type TDate.TSequence;

{$endregion}

{$region 'Time'}
  PTime = ^TTime;
  TTime = record
  private
    FTime: Integer;
    function  GetISO: string; inline;
    procedure SetISO(const Value: string);
    function  GetMIME: string; inline;
    procedure SetMIME(const Value: string);
    function  GetHour: Word; inline;
    function  GetMinute: Word; inline;
    function  GetMSecond: Word; inline;
    function  GetSecond: Word; inline;
    procedure SetHour(const Value: Word); inline;
    procedure SetMinute(const Value: Word); inline;
    procedure SetMSecond(const Value: Word); inline;
    procedure SetSecond(const Value: Word); inline;
  public
    function  ToString: string; overload; inline;
    function  ToString(const FormatSettings: TFormatSettings): string; overload; inline;
    function  Format(const Format: string): string; overload; inline;
    function  Format(const Format: string; const FormatSettings: TFormatSettings): string; overload; inline;
    procedure Parse(const Value: string); overload; inline;
    procedure Parse(const Value: string; const FormatSettings: TFormatSettings); overload; inline;
    function  TryParse(const Value: string): Boolean; overload; inline;
    function  TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean; overload; inline;
    procedure Encode(Hour, Min, Sec: Word; MSec: Word = 0); inline;
    procedure Decode(var Hour, Min, Sec, MSec: Word); overload; inline;
    procedure Decode(var Hour, Min, Sec: Word); overload; inline;
    property  ISO: string read GetISO write SetISO;
    property  MIME: string read GetMIME write SetMIME;
    property  Hour: Word read GetHour write SetHour;
    property  Minute: Word read GetMinute write SetMinute;
    property  Second: Word read GetSecond write SetSecond;
    property  MSecond: Word read GetMSecond write SetMSecond;
  public
    constructor Create(const Time: TTime); overload;
    constructor Create(const Time: System.TDateTime); overload;
    constructor Create(Hour, Min, Sec: Word; MSec: Word = 0); overload;
    class function Now: TTime; static; inline;
  public
    class operator Add(const L: TTime; R: Integer): TTime; inline;
    class operator Add(const L, R: TTime): TTime; inline;
    class operator Add(const L: TTime; R: THours): TTime; inline;
    class operator Add(const L: TTime; R: TMinutes): TTime; inline;
    class operator Add(const L: TTime; R: TSeconds): TTime; inline;
    class operator Subtract(const L: TTime; R: Integer): TTime; inline;
    class operator Subtract(const L, R: TTime): Integer; inline;
    class operator Subtract(const L: TTime; R: THours): TTime; inline;
    class operator Subtract(const L: TTime; R: TMinutes): TTime; inline;
    class operator Subtract(const L: TTime; R: TSeconds): TTime; inline;
    class operator Implicit(const a: System.TDateTime): TTime; inline;
    class operator Implicit(const a: TTime): System.TDateTime; inline;
    class operator Implicit(const a: TTimeStamp): TTime; inline;
    class operator Implicit(const a: TTime): TTimeStamp; inline;
    class operator Implicit(const a: Variant): TTime; inline;
    class operator Implicit(const a: TTime): Variant; inline;
    class operator Explicit(const a: Integer): TTime; inline;
    class operator Explicit(const a: TTime): Integer; inline;
    class operator Explicit(const a: TTime): string; inline;
    class operator Explicit(const a: string): TTime; inline;
    class operator Inc(const a: TTime): TTime; inline;
    class operator Dec(const a: TTime): TTime; inline;
    class operator Equal(const a, b: TTime) : Boolean; inline;
    class operator NotEqual(const a, b: TTime) : Boolean; inline;
    class operator GreaterThan(const a, b: TTime) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TTime) : Boolean; inline;
    class operator LessThan(const a, b: TTime) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TTime) : Boolean; inline;
  end;

{$endregion}

{$region 'DateTime'}

  PDateTime = ^TDateTime;
  TDateTime = record
  private
    FDate: TDate;
    FTime: TTime;
    procedure SetDate(const Value: TDate); inline;
    procedure SetTime(const Value: TTime); inline;
  public
    function  ToString: string; overload; inline;
    function  ToString(const FormatSettings: TFormatSettings): string; overload; inline;
    function  Format(const Format: string): string; overload; inline;
    function  Format(const Format: string; const FormatSettings: TFormatSettings): string; overload; inline;
    procedure Parse(const Value: string); overload; inline;
    procedure Parse(const Value: string; const FormatSettings: TFormatSettings); overload; inline;
    function  TryParse(const Value: string): Boolean; overload; inline;
    function  TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean; overload; inline;
    property  Date: TDate read FDate write SetDate;
    property  Time: TTime read FTime write SetTime;
  public
    constructor Create(const Value: TDateTime); overload;
    constructor Create(const Date: TDate; const Time: TTime); overload;
    constructor Create(const Value: TDate); overload;
    constructor Create(const Value: TTime); overload;
    constructor Create(const Value: System.TDateTime); overload;
    class function Now: TDateTime; static;
  public
    class operator Implicit(const a: System.TDateTime): TDateTime; inline;
    class operator Implicit(const a: TDateTime): System.TDateTime; inline;
    class operator Implicit(const a: TTimeStamp): TDateTime; inline;
    class operator Implicit(const a: TDateTime): TTimeStamp; inline;
    class operator Implicit(const a: Variant): TDateTime; inline;
    class operator Implicit(const a: TDateTime): Variant; inline;
    class operator Explicit(const a: TDateTime): string; inline;
    class operator Explicit(const a: string): TDateTime; inline;
    class operator Explicit(const a: TDateTime): TDate; inline;
    class operator Explicit(const a: TDate): TDateTime; inline;
    class operator Explicit(const a: TDateTime): TTime; inline;
    class operator Equal(const a, b: TDateTime) : Boolean; inline;
    class operator NotEqual(const a, b: TDateTime) : Boolean; inline;
    class operator GreaterThan(const a, b: TDateTime) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TDateTime) : Boolean; inline;
    class operator LessThan(const a, b: TDateTime) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TDateTime) : Boolean; inline;
  end;
{$endregion}

{$region 'Time zone'}
  TTimeZoneBias = -24 * 60..24 * 60;

  TTimeZone = record
  private class var
    Timezones: TDictionary<string, TTimeZoneBias>;
    class constructor Create;
    class destructor Destroy;
    class function  SNum(const S: string; const Index: Integer): Integer; inline; static;
  private
    FBias: TTimeZoneBias;
    function  GetMIME: string;
  public
    class function System: TTimeZone; static;
    class procedure Register(const Code: string; Bias: TTimeZoneBias); static;
    property  MIME: string read GetMIME;
    property  Bias: TTimeZoneBias read FBias write FBias;
  public
    class operator Explicit(const A: TTimeZone): TTime; inline;
    class operator Explicit(const A: TTime): TTimeZone; inline;
    class operator Explicit(const A: TTimeZone): string;
    class operator Explicit(const A: string): TTimeZone;
    class operator Explicit(const A: TTimeZone): TTimeZoneBias; inline;
    class operator Explicit(const A: TTimeZoneBias): TTimeZone; inline;
    class operator Subtract(const L, R: TTimeZone): TMinutes; inline;
  end;
{$endregion}

{$region 'Helpers'}
  // Need helpers, because record forward declaration is not allowed

  TQuarterHelper = record helper for TQuarter
  public const
    Each: array[1..4] of TQuarter = ((FQuarter: 1), (FQuarter: 2), (FQuarter: 3), (FQuarter: 4));
  public
    function  First: TMonth; inline;
    function  Last: TMonth; inline;
    function  Dates(const Year: TYear): TDate.TSequence; inline;
    function  Months: TMonth.TSequence; inline;
  end;

  TQuarterSequenceHelper = record helper for TQuarter.TSequence
  public
    function  First: TQuarter; inline;
    function  Last: TQuarter; inline;
    function  Months: TMonth.TSequence; inline;
  end;

  TQuarterOfYearHelper = record helper for TQuarterOfYear
  public
    function  First: TMonthOfYear; inline;
    function  Last: TMonthOfYear; inline;
    function  Dates: TDate.TSequence; inline;
    function  Months: TMonthOfYear.TSequence; inline;
  end;

  TMonthHelper = record helper for TMonth
  public const
    Each: array[1..12] of TMonth = ((FMonth: 1), (FMonth: 2), (FMonth: 3), (FMonth: 4), (FMonth: 5), (FMonth: 6), (FMonth: 7), (FMonth: 8), (FMonth: 9), (FMonth: 10), (FMonth: 11), (FMonth: 12));
  public
    function  First(const Year: TYear): TDate; inline;
    function  Last(const Year: TYear): TDate; inline;
    function  Sequence(const Year: TYear): TDate.TSequence; inline;
  end;

  TMonthOfYearHelper = record helper for TMonthOfYear
  public
    function  First: TDate; inline;
    function  Last: TDate; inline;
    function  Dates: TDate.TSequence; inline;
  end;

  TYearHelper = record helper for TYear
  public
    function  First: TDate; inline;
    function  Last: TDate; inline;
    function  Dates: TDate.TSequence; inline;
  end;

  TDateSequenceHelper = record helper for TDate.TSequence
  private
    function  GetFirst: TDate; inline;
    function  GetLast: TDate; inline;
  public
    property  First: TDate read GetFirst;
    property  Last: TDate read GetLast;
  end;
{$endregion}

  ICalendarProvider = interface
    ['{12C1FBB9-A4DC-439B-B39F-5ACB6B3210F6}']
    function IsWorkDay(const Date: TDate): Boolean;
    function IsWeekEnd(const Date: TDate): Boolean;
    function IsHoliday(const Date: TDate): Boolean;
  end;

  TBasicCalendar = class(TInterfacedObject, ICalendarProvider)
  private
    FHolidays: TDictionary<Integer, Boolean>;
    FWorkDays: TDictionary<Integer, Boolean>;
    function  GetHoliday(const Date: TDate): Boolean;
    procedure SetHoliday(const Date: TDate; const Value: Boolean);
    function  GetWorkDay(const Date: TDate): Boolean;
    procedure SetWorkDay(const Date: TDate; const Value: Boolean);
  protected
    property  Holidays: TDictionary<Integer, Boolean> read FHolidays;
    property  WorkDays: TDictionary<Integer, Boolean> read FWorkDays;
  public
    constructor Create;
    destructor Destroy; override;
    function  IsWorkDay(const Date: TDate): Boolean; virtual;
    function  IsWeekEnd(const Date: TDate): Boolean; virtual;
    function  IsHoliday(const Date: TDate): Boolean; virtual;
    property  Holiday[const Date: TDate]: Boolean read GetHoliday write SetHoliday;
    property  WorkDay[const Date: TDate]: Boolean read GetWorkDay write SetWorkDay;
  end;

  /// Predefined constants for fast calculations
  {$include Ext.Types.Date.FastCalc.inc}
  {$include Ext.Types.Date.Leap.inc}
  {$include Ext.Types.Date.DateYMD.inc} //predefined for dates from 1970 to 2100 years
  {$include Ext.Types.Date.YMDDate.inc} //predefined for dates from 1970 to 2100 years

const
  S24: array[0..24] of string = (
    '00', '01', '02', '03', '04', '05', '06', '07', '08', '09',
    '10', '11', '12', '13', '14', '15', '16', '17', '18', '19',
    '20', '21', '22', '23', '24'
  );

  S60: array[0..60] of string = (
    '00', '01', '02', '03', '04', '05', '06', '07', '08', '09',
    '10', '11', '12', '13', '14', '15', '16', '17', '18', '19',
    '20', '21', '22', '23', '24', '25', '26', '27', '28', '29',
    '30', '31', '32', '33', '34', '35', '36', '37', '38', '39',
    '40', '41', '42', '43', '44', '45', '46', '47', '48', '49',
    '50', '51', '52', '53', '54', '55', '56', '57', '58', '59',
    '60'
  );

  MIMEWeekdays: array[1..7] of string = ('Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');
  MIMEMonths:   array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');

  ISO8601DateFormatSettings: TFormatSettings = (
    DateSeparator: '-';
    TimeSeparator: ':';
    ShortDateFormat: 'YYYY-MM-DD';
    LongDateFormat: 'YYYY-MM-DD';
    ShortTimeFormat: 'HH:NN:SS';
    LongTimeFormat: 'HH:NN:SS.ZZZ';
    ThousandSeparator: #0;
    DecimalSeparator: '.'
  );

var
  FirstDayOfWeek: TWeekday = (FDay: 1);

function Today: TDate; inline;
function Date: TDate; inline;
function Time: TTime; inline;
function Now: TDateTime; inline;

function DefaultCalendar: ICalendarProvider;

const
  FMSecsPerDay: Single  = MSecsPerDay;
  IMSecsPerDay: Integer = MSecsPerDay;

resourcestring
  SInvalidTimeZone = 'Invalid time zone "%s"';
  SInvalidQuarter  = 'Invalid quarter format "%s"';

implementation

uses
  System.SysConst, System.Math;

var
  gDefaultCalendar: ICalendarProvider;

function DefaultCalendar: ICalendarProvider;
begin
  Result := gDefaultCalendar;
end;

procedure SetDefaultCalendar(const Value: ICalendarProvider);
begin
  if Value = nil then
    gDefaultCalendar := TBasicCalendar.Create
  else
    gDefaultCalendar := Value;
end;

function Today: TDate;
begin
  Result := TDate.Today;
end;

function Date: TDate;
begin
  Result := TDate.Today;
end;

function Time: TTime;
begin
  Result := TTime.Now;
end;

function Now: TDateTime;
begin
  Result := TDateTime.Now;
end;

{ TTimeZone }

class constructor TTimeZone.Create;
begin
  Timezones := TDictionary<string, TTimeZoneBias>.Create;
  Register('UT',   0);
  Register('UTC',  0);
  Register('GMT',  0);
  Register('Z',    0);
  Register('A',    1 * 60);
  Register('B',    2 * 60);
  Register('C',    3 * 60);
  Register('D',    4 * 60);
  Register('E',    5 * 60);
  Register('F',    6 * 60);
  Register('G',    7 * 60);
  Register('H',    8 * 60);
  Register('I',    9 * 60);
  Register('K',    10 * 60);
  Register('L',    11 * 60);
  Register('M',    12 * 60);
  Register('N',   -1 * 60);
  Register('O',   -2 * 60);
  Register('P',   -3 * 60);
  Register('Q',   -4 * 60);
  Register('R',   -5 * 60);
  Register('S',   -6 * 60);
  Register('T',   -7 * 60);
  Register('U',   -8 * 60);
  Register('V',   -9 * 60);
  Register('W',   -10 * 60);
  Register('X',   -11 * 60);
  Register('Y',   -12 * 60);
end;

class destructor TTimeZone.Destroy;
begin
  FreeAndNil(Timezones);
end;

class procedure TTimeZone.Register(const Code: string; Bias: TTimeZoneBias);
begin
  Timezones.AddOrSetValue(Code, Bias);
end;

class function TTimeZone.System: TTimeZone;
var
  Info: TTimeZoneInformation;
begin
  case GetTimeZoneInformation(Info) of
    TIME_ZONE_ID_DAYLIGHT:
      Result.Bias := Info.Bias + Info.DaylightBias;
    TIME_ZONE_ID_UNKNOWN, TIME_ZONE_ID_STANDARD:
      Result.Bias := Info.Bias;
    else
      Result.Bias := 0;
  end;
end;

function TTimeZone.GetMIME: string;
begin
  if Bias > 0 then
    Result := '-' + S60[Bias div 60] + S60[Bias mod 60]
  else
    Result := '+' + S60[Bias div 60] + S60[Bias mod 60];
end;

class operator TTimeZone.Explicit(const A: TTimeZone): string;
begin
  if A.Bias > 0 then
    Result := '-' + S60[A.Bias div 60] + ':' + S60[A.Bias mod 60]
  else
    Result := '+' + S60[A.Bias div 60] + ':' + S60[A.Bias mod 60];
end;

class operator TTimeZone.Explicit(const A: string): TTimeZone;
const
  Sign: array['+'..'-'] of Integer = (-1, 0, 1);
  Signs: TSysCharSet = ['+', '-'];
begin
  case Length(A) of
    0:
      Exit(TTimeZone(0));
    3: //+HH
      case A[1] of
        '+': Exit(TTimeZone(-(SNum(A, 2) * 60)));
        '-': Exit(TTimeZone(+(SNum(A, 2) * 60)));
      end;
    5: //+HHMM
      case A[1] of
        '+': Exit(TTimeZone(-(SNum(A, 2) * 60 + SNum(A, 4))));
        '-': Exit(TTimeZone(+(SNum(A, 2) * 60 + SNum(A, 4))));
      end;
    6: //+HH:MM
      if A[4] = ':' then
        case A[1] of
          '+': Exit(TTimeZone(-(SNum(A, 2) * 60 + SNum(A, 5))));
          '-': Exit(TTimeZone(+(SNum(A, 2) * 60 + SNum(A, 5))));
        end;
  end;

  if not Timezones.TryGetValue(A, Result.FBias) then
    raise EConvertError.CreateResFmt(@SInvalidTimeZone, [A]);
end;

class operator TTimeZone.Explicit(const A: TTimeZone): TTime;
begin
  Result.Encode(A.Bias div 60, A.Bias mod 60, 0);
end;

class operator TTimeZone.Explicit(const A: TTime): TTimeZone;
var
  H, M, S: Word;
begin
  A.Decode(H, M, S);
  Result.FBias := H * 60 + M;
end;

class operator TTimeZone.Explicit(const A: TTimeZone): TTimeZoneBias;
begin
  Result := A.Bias;
end;

class operator TTimeZone.Explicit(const A: TTimeZoneBias): TTimeZone;
begin
  Result.Bias := A;
end;

class function TTimeZone.SNum(const S: string; const Index: Integer): Integer;
begin
  Result := (Ord(S[Index]) - 30) * 10 + (Ord(S[Index + 1]) - 30);
end;

class operator TTimeZone.Subtract(const L, R: TTimeZone): TMinutes;
begin
  Result := L.Bias - R.Bias;
end;

{$region 'Date routine'}

{ Date }

constructor TDate.Create(const Date: TDate);
begin
  FDate := Date.FDate;
end;

constructor TDate.Create(const Date: System.TDateTime);
begin
  FDate := Trunc(Date) + DateDelta;
end;

constructor TDate.Create(const Year: TYear; const Month: TMonth; const Day: TDay);
begin
  Encode(Year, Month, Day);
end;

constructor TDate.Create(const Year, Month, Day: Word);
begin
  Encode(Year, Month, Day);
end;

class operator TDate.Implicit(const a: System.TDateTime): TDate;
begin
  Result.FDate := Trunc(a) + DateDelta;
end;

class operator TDate.Implicit(const a: TDate): System.TDateTime;
begin
  Result := a.FDate - DateDelta;
end;

class operator TDate.Explicit(const a: Integer): TDate;
begin
  Result.FDate := a;
end;

class operator TDate.Explicit(const a: TDate): Integer;
begin
  Result := a.FDate;
end;

class operator TDate.Explicit(const a: TDate): string;
begin
  Result := a.ToString;
end;

class operator TDate.Explicit(const a: string): TDate;
begin
  Result.Parse(a);
end;

class operator TDate.Add(const a: TDate; const b: Integer): TDate;
begin
  Result.FDate := a.FDate + b;
end;

class operator TDate.Subtract(const a, b: TDate): Integer;
begin
  Result := a.FDate - b.FDate;
end;

class operator TDate.Subtract(const a: TDate; const b: Integer): TDate;
begin
  Result.FDate := a.FDate - b;
end;

class operator TDate.Implicit(const a: TTimeStamp): TDate;
begin
  Result.FDate := a.Date;
end;

class operator TDate.Implicit(const a: TDate): TTimeStamp;
begin
  Result.Time := 0;
  Result.Date := a.FDate;
end;

class operator TDate.Implicit(const a: Variant): TDate;
begin
  Result.FDate := Trunc(VarToDateTime(a)) + DateDelta;
end;

class operator TDate.Implicit(const a: TDate): Variant;
begin
  TVarData(Result).VType := varDate;
  TVarData(Result).VDate := a.FDate - DateDelta;
end;

class operator TDate.Inc(const a: TDate): TDate;
begin
  Result.FDate := a.FDate + 1;
end;

class operator TDate.Dec(const a: TDate): TDate;
begin
  Result.FDate := a.FDate - 1;
end;

class operator TDate.Equal(const a, b: TDate): Boolean;
begin
  Result := a.FDate = b.FDate;
end;

class operator TDate.NotEqual(const a, b: TDate): Boolean;
begin
  Result := a.FDate <> b.FDate;
end;

class operator TDate.GreaterThan(const a, b: TDate): Boolean;
begin
  Result := a.FDate > b.FDate;
end;

class operator TDate.GreaterThanOrEqual(const a, b: TDate): Boolean;
begin
  Result := a.FDate >= b.FDate;
end;

class operator TDate.LessThan(const a, b: TDate): Boolean;
begin
  Result := a.FDate < b.FDate;
end;

class operator TDate.LessThanOrEqual(const a, b: TDate): Boolean;
begin
  Result := a.FDate <= b.FDate;
end;

class function TDate.Range(const First, Last: TDate): TArray<TDate>;
var
  D, I: Integer;
begin
  SetLength(Result, Last - First + 1);
  I := 0;
  for D := Integer(First) to Integer(Last) do
  begin
    Result[I] := D;
    Inc(I);
  end;
end;

class function TDate.Sequence(const First, Last: TDate): TSequence;
begin
  Result := TSequence.Create(First, Last);
end;

class function TDate.Today: TDate;
{$IFDEF MSWINDOWS}
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result.Encode(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  T: time_t;
  UT: tm;
begin
  __time(T);
  localtime_r(T, UT);
  Result.Encode(UT.tm_year + 1900, UT.tm_mon + 1, UT.tm_mday);
end;
{$ENDIF POSIX}

function TDate.GetISO: string;
begin
  Result := ToString(ISO8601DateFormatSettings);
end;

procedure TDate.SetISO(const Value: string);
begin
  Parse(Value, ISO8601DateFormatSettings);
end;

procedure TDate.Decode(var Year, Month, Day: Word);
const
  D1 = 365;
  D4 = D1 * 4 + 1;
  D100 = D4 * 25 - 1;
  D400 = D100 * 4 + 1;
var
  I: Word;
  T: Integer;
begin
  if (FDate >= Low(DateYMD)) and (FDate <= High(DateYMD)) then
  begin
    Year := DateYMD[FDate].Y;
    Month := DateYMD[FDate].M;
    Day := DateYMD[FDate].D;
    Exit;
  end;

  T := FDate - 1;

  Year := (T div D400) * 400 + 1;
  T := T mod D400;

  DivMod(T, D100, I, Day);
  if I = 4 then
  begin
    Dec(I);
    Inc(Day, D100);
  end;
  Inc(Year, I * 100);
  DivMod(Day, D4, I, Day);
  Inc(Year, I * 4);
  DivMod(Day, D1, I, Day);
  if I = 4 then
  begin
    Dec(I);
    Inc(Day, D1);
  end;
  Inc(Year, I);
  Month := MonthOfDay[YearIsLeap[Year], Day + 1];
  Day := MonthDayOfDay[YearIsLeap[Year], Day + 1];
end;

procedure TDate.Decode(var Year, Month: Word);
var
  D: Word;
begin
  Decode(Year, Month, D);
end;

procedure TDate.Decode(var Year: Word);
var
  M, D: Word;
begin
  Decode(Year, M, D);
end;

procedure TDate.Decode(var Year: TYear; var Month: TMonth; var Day: TDay);
begin
  Decode(Year.FYear, Month.FMonth, Day.FDay);
end;

procedure TDate.Encode(const Year, Month, Day: Word);
var
  I: Integer;
begin
  if (Year >= Low(YMDDate)) and (Year <= High(YMDDate)) then
  begin
    FDate := YMDDate[Year, Month, Day];
    Exit;
  end;
  I := Year - 1;
  FDate := I * 365 + I div 4 - I div 100 + I div 400 + MonthOffset[TYear(Year).IsLeap, Month] + Day;
end;

procedure TDate.Encode(const Year, Month: Word);
var
  I: Integer;
begin
  if (Year >= Low(YMDDate)) and (Year <= High(YMDDate)) then
  begin
    FDate := YMDDate[Year, Month, 1];
    Exit;
  end;
  I := Year - 1;
  FDate := I * 365 + I div 4 - I div 100 + I div 400 + MonthOffset[TYear(Year).IsLeap, Month] + 1;
end;

procedure TDate.Encode(const Year: Word);
var
  I: Integer;
begin
  if (Year >= Low(YMDDate)) and (Year <= High(YMDDate)) then
  begin
    FDate := YMDDate[Year, 1, 1];
    Exit;
  end;

  I := Year - 1;
  FDate := I * 365 + I div 4 - I div 100 + I div 400 + 1;
end;

procedure TDate.Encode(const Year: TYear; const Month: TMonth; const Day: TDay);
begin
  Encode(Year.FYear, Month.FMonth, Day.FDay);
end;

function TDate.GetDay: TDay;
var
  Y, M, D: Word;
begin
  Decode(Y, M, D);
  Result.FDay := D;
end;

function TDate.GetDayOfYear: TDayOfYear;
begin
  Result := FDate - Year.First.FDate + 1;
end;

procedure TDate.SetDayOfYear(const Value: TDayOfYear);
begin
  FDate := Year.First.FDate + Value - 1;
end;

function TDate.GetDayOfMonth: TDayOfMonth;
begin
  Result.FMonth := Month;
  Result.FDay := Day;
end;

procedure TDate.SetDay(const Value: TDay);
var
  Y, M, D: Word;
begin
  Decode(Y, M, D);
  Encode(Y, M, Value.FDay);
end;

function TDate.GetMonth: TMonth;
var
  Y, M, D: Word;
begin
  Decode(Y, M, D);
  Result.FMonth := M;
end;

procedure TDate.SetMonth(const Value: TMonth);
var
  Y: TYear;
  M: TMonth;
  D, L: TDay;
begin
  Decode(Y, M, D);

  if M = Value then
    Exit;

  L := MonthDayCount[Y.IsLeap, Word(Value)];
  if L < D then
    D := L;

  Encode(Y, Value, D);
end;

function TDate.GetQuarter: TQuarter;
var
  Y, M, D: Word;
begin
  Decode(Y, M, D);
  Result.FQuarter := MonthQuarter[M];
end;

function TDate.GetYear: TYear;
begin
  Decode(Result.FYear);
end;

procedure TDate.SetYear(const Value: TYear);
var
  Y: TYear;
  M: TMonth;
  D: TDay;
begin
  Decode(Y, M, D);

  if Y = Value then
    Exit;

  if (M = 2) and (D = 29) and Y.IsLeap then
  begin
    if Value.IsLeap then
      Encode(Value, M, D)
    else
      Encode(Value, M, 28);
  end
  else
    Encode(Value, M, D);
end;

function TDate.GetWeekday: TWeekday;
begin
  Result.FDay := FDate mod 7 + 1;
end;

procedure TDate.SetWeekday(const Value: TWeekday);
begin
  FDate := FDate + Integer(Value - Weekday);
end;

function TDate.GetQuarterOfYear: TQuarterOfYear;
var
  Y, M: Word;
begin
  Decode(Y, M);
  Result.FYear := Y;
  Result.FQuarter := MonthQuarter[M];
end;

function TDate.GetMonthOfYear: TMonthOfYear;
var
  Y, M: Word;
begin
  Decode(Y, M);
  Result.FYear := Y;
  Result.FMonth := M;
end;

procedure TDate.SetMonthOfYear(const Value: TMonthOfYear);
begin
  Year := Value.Year;
  Month := Value.Month;
end;

function TDate.StartOfWeek: TDate;
begin
  Result := StartOfWeek(FirstDayOfWeek);
end;

function TDate.StartOfWeek(const FirstDayOfWeek: TWeekday): TDate;
begin
  Result.FDate := FDate - (Weekday.DayOfWeek[FirstDayOfWeek] - 1);
end;

function TDate.EndOfWeek: TDate;
begin
  Result := EndOfWeek(FirstDayOfWeek);
end;

function TDate.EndOfWeek(const FirstDayOfWeek: TWeekday): TDate;
begin
  Result.FDate := FDate + (7 - Weekday.DayOfWeek[FirstDayOfWeek]);
end;

function TDate.ToString: string;
begin
  Result := DateToStr(FDate - DateDelta);
end;

function TDate.ToString(const FormatSettings: TFormatSettings): string;
begin
  Result := DateToStr(FDate - DateDelta, FormatSettings);
end;

function TDate.Format(const Format: string): string;
begin
  Result := FormatDateTime(Format, FDate - DateDelta);
end;

function TDate.Format(const Format: string; const FormatSettings: TFormatSettings): string;
begin
  Result := FormatDateTime(Format, FDate - DateDelta, FormatSettings);
end;

procedure TDate.Parse(const Value: string);
begin
  FDate := Trunc(StrToDate(Value)) + DateDelta;
end;

procedure TDate.Parse(const Value: string; const FormatSettings: TFormatSettings);
begin
  FDate := Trunc(StrToDate(Value, FormatSettings)) + DateDelta;
end;

function TDate.TryParse(const Value: string): Boolean;
var
  D: System.TDateTime;
begin
  Result := TryStrToDate(Value, D);
  if Result then
    Self := D;
end;

function TDate.TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean;
var
  D: System.TDateTime;
begin
  Result := TryStrToDate(Value, D, FormatSettings);
  if Result then
    Self := D;
end;

{$endregion}

{$region 'Time routine'}

{ Time }

constructor TTime.Create(const Time: TTime);
begin
  FTime := Time.FTime;
end;

constructor TTime.Create(const Time: System.TDateTime);
begin
  Self := Time;
end;

constructor TTime.Create(Hour, Min, Sec, MSec: Word);
begin
  Encode(Hour, Min, Sec, MSec);
end;

class function TTime.Now: TTime;
{$IFDEF MSWINDOWS}
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result.Encode(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  T: time_t;
  TV: timeval;
  UT: tm;
begin
  gettimeofday(TV, nil);
  T := TV.tv_sec;
  localtime_r(T, UT);
  Result.Encode(UT.tm_hour, UT.tm_min, UT.tm_sec, TV.tv_usec div 1000);
end;
{$ENDIF POSIX}

class operator TTime.Add(const L: TTime; R: Integer): TTime;
begin
  Result.FTime := L.FTime + R;
end;

class operator TTime.Add(const L, R: TTime): TTime;
begin
  Result.FTime := L.FTime + R.FTime;
end;

class operator TTime.Subtract(const L, R: TTime): Integer;
begin
  Result := L.FTime - R.FTime;
end;

class operator TTime.Subtract(const L: TTime; R: Integer): TTime;
begin
  Result.FTime:= L.FTime - R;
end;

class operator TTime.Add(const L: TTime; R: TSeconds): TTime;
begin
  Result.FTime := L.FTime + R * MSecsPerSec;
end;

class operator TTime.Add(const L: TTime; R: TMinutes): TTime;
begin
  Result.FTime := L.FTime + R * SecsPerMin * MSecsPerSec;
end;

class operator TTime.Add(const L: TTime; R: THours): TTime;
begin
  Result.FTime := L.FTime + R * MinsPerHour * SecsPerMin * MSecsPerSec;
end;

class operator TTime.Subtract(const L: TTime; R: TSeconds): TTime;
begin
  Result.FTime := L.FTime - R * MSecsPerSec;
end;

class operator TTime.Subtract(const L: TTime; R: TMinutes): TTime;
begin
  Result.FTime := L.FTime - R * SecsPerMin * MSecsPerSec;
end;

class operator TTime.Subtract(const L: TTime; R: THours): TTime;
begin
  Result.FTime := L.FTime - R * MinsPerHour * SecsPerMin * MSecsPerSec;
end;

class operator TTime.Dec(const a: TTime): TTime;
begin
  Result.FTime := a.FTime - 1;
end;

class operator TTime.Inc(const a: TTime): TTime;
begin
  Result.FTime := a.FTime + 1;
end;

class operator TTime.Equal(const a, b: TTime): Boolean;
begin
  Result := a.FTime = b.FTime;
end;

class operator TTime.NotEqual(const a, b: TTime): Boolean;
begin
  Result := a.FTime <> b.FTime;
end;

class operator TTime.LessThan(const a, b: TTime): Boolean;
begin
  Result := a.FTime < b.FTime;
end;

class operator TTime.LessThanOrEqual(const a, b: TTime): Boolean;
begin
  Result := a.FTime <= b.FTime;
end;

class operator TTime.GreaterThan(const a, b: TTime): Boolean;
begin
  Result := a.FTime > b.FTime;
end;

class operator TTime.GreaterThanOrEqual(const a, b: TTime): Boolean;
begin
  Result := a.FTime >= b.FTime;
end;

class operator TTime.Explicit(const a: TTime): string;
begin
  Result := TimeToStr(a);
end;

class operator TTime.Explicit(const a: string): TTime;
begin
  Result := StrToTime(a);
end;

class operator TTime.Implicit(const a: TTime): System.TDateTime;
begin
  Result := a.FTime / FMSecsPerDay;
end;

class operator TTime.Implicit(const a: System.TDateTime): TTime;
begin
  Result.FTime := Abs(Round(a * FMSecsPerDay)) mod IMSecsPerDay;
end;

class operator TTime.Implicit(const a: TTimeStamp): TTime;
begin
  Result.FTime := a.Time;
end;

class operator TTime.Implicit(const a: TTime): TTimeStamp;
begin
  Result.Time := a.FTime;
  Result.Date := 0;
end;

class operator TTime.Implicit(const a: Variant): TTime;
begin
  Result := VarToDateTime(a);
end;

class operator TTime.Implicit(const a: TTime): Variant;
begin
  TVarData(Result).VType := varDate;
  TVarData(Result).VDate := a.FTime / FMSecsPerDay;
end;

class operator TTime.Explicit(const a: TTime): Integer;
begin
  Result := a.FTime;
end;

class operator TTime.Explicit(const a: Integer): TTime;
begin
  Result.FTime := a;
end;

function TTime.GetISO: string;
begin
  Result := FormatDateTime('HH:NN:SS', Self);
end;

procedure TTime.SetISO(const Value: string);
begin
  Parse(Value, ISO8601DateFormatSettings);
end;

function TTime.GetMIME: string;
var
  H, M, S: Word;
begin
  Decode(H, M, S);
  Result := S24[H] + S60[M] + S60[S];
end;

procedure TTime.SetMIME(const Value: string);
var
  pm, am: Integer;
  Src: string;
  H, M, S: Word;
begin
  Src := UpperCase(Value);
  pm := Pos('PM', Src);
  am := Pos('AM', Src);

  if pm > 0 then
    Src := Copy(Src, 1, pm - 1)
  else if am > 0 then
    Src := Copy(Src, 1, am - 1);
  Src := Trim(Src);

  var Parts := Src.Split([':']);
  case Length(Parts) of
    1: begin H := StrToIntDef(Parts[0], 0); M := 0; S := 0; end;
    2: begin H := StrToIntDef(Parts[0], 0); M := StrToIntDef(Parts[1], 0); S := 0; end;
    3: begin H := StrToIntDef(Parts[0], 0); M := StrToIntDef(Parts[1], 0); S := StrToIntDef(Parts[2], 0); end;
  else
    begin H := 0; M := 0; S := 0; end;
  end;

  if (pm > 0) and (H < 12) then
    H := H + 12
  else if (am > 0) and (H = 12) then
    H := 0;

  Encode(H, M, S);
end;

procedure TTime.Encode(Hour, Min, Sec, MSec: Word);
begin
  FTime :=  (Hour * (MinsPerHour * SecsPerMin * MSecsPerSec))
            + (Min * SecsPerMin * MSecsPerSec)
            + (Sec * MSecsPerSec)
            +  MSec;
end;

procedure TTime.Decode(var Hour, Min, Sec: Word);
var
  MinCount, MSecCount, MSec: Word;
begin
  DivMod(FTime, SecsPerMin * MSecsPerSec, MinCount, MSecCount);
  DivMod(MinCount, MinsPerHour, Hour, Min);
  DivMod(MSecCount, MSecsPerSec, Sec, MSec);
end;

procedure TTime.Decode(var Hour, Min, Sec, MSec: Word);
var
  MinCount, MSecCount: Word;
begin
  DivMod(FTime, SecsPerMin * MSecsPerSec, MinCount, MSecCount);
  DivMod(MinCount, MinsPerHour, Hour, Min);
  DivMod(MSecCount, MSecsPerSec, Sec, MSec);
end;

function TTime.GetHour: Word;
begin
  Result := FTime div (MinsPerHour * SecsPerMin * MSecsPerSec);
end;

function TTime.GetMinute: Word;
begin
  Result := (FTime div (MSecsPerSec * SecsPerMin)) mod MinsPerHour;
end;

function TTime.GetSecond: Word;
begin
  Result := (FTime mod (MSecsPerSec * SecsPerMin)) div MSecsPerSec;
end;

function TTime.GetMSecond: Word;
begin
  Result := (FTime mod (MSecsPerSec * SecsPerMin)) mod MSecsPerSec;
end;

procedure TTime.SetHour(const Value: Word);
begin
  Encode(Value, Minute, Second, MSecond);
end;

procedure TTime.SetMinute(const Value: Word);
begin
  Encode(Hour, Value, Second, MSecond);
end;

procedure TTime.SetSecond(const Value: Word);
begin
  Encode(Hour, Minute, Value, MSecond);
end;

procedure TTime.SetMSecond(const Value: Word);
begin
  Encode(Hour, Minute, Second, Value);
end;

function TTime.ToString: string;
begin
  Result := TimeToStr(Self);
end;

function TTime.ToString(const FormatSettings: TFormatSettings): string;
begin
  Result := TimeToStr(Self, FormatSettings);
end;

function TTime.Format(const Format: string): string;
begin
  Result := FormatDateTime(Format, Self);
end;

function TTime.Format(const Format: string; const FormatSettings: TFormatSettings): string;
begin
  Result := FormatDateTime(Format, Self, FormatSettings);
end;

procedure TTime.Parse(const Value: string; const FormatSettings: TFormatSettings);
begin
  Self := StrToDateTime(Value, FormatSettings);
end;

procedure TTime.Parse(const Value: string);
begin
  Self := StrToDateTime(Value);
end;

function TTime.TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean;
var
  D: System.TDateTime;
begin
  Result := TryStrToDateTime(Value, D, FormatSettings);
  if Result then
    Self := D;
end;

function TTime.TryParse(const Value: string): Boolean;
var
  D: System.TDateTime;
begin
  Result := TryStrToDateTime(Value, D);
  if Result then
    Self := D;
end;

{$endregion}

{ TWeekday }

function TWeekday.GetHashCode: Integer;
begin
  Result := FDay;
end;

class operator TWeekday.Implicit(const a: Word): TWeekday;
begin
  Result.FDay := a;
end;

class operator TWeekday.Implicit(const a: TWeekday): Word;
begin
  Result := a.FDay;
end;

class operator TWeekday.Explicit(const a: TWeekday): string;
begin
  Result := a.ToString;
end;

class operator TWeekday.Explicit(const a: string): TWeekday;
begin
  Result.Parse(a);
end;

class operator TWeekday.Equal(const a, b: TWeekday): Boolean;
begin
  Result := a.FDay = b.FDay;
end;

class operator TWeekday.LessThan(const a, b: TWeekday): Boolean;
begin
  Result := a.FDay < b.FDay;
end;

class operator TWeekday.LessThanOrEqual(const a, b: TWeekday): Boolean;
begin
  Result := a.FDay <= b.FDay;
end;

class operator TWeekday.NotEqual(const a, b: TWeekday): Boolean;
begin
  Result := a.FDay <> b.FDay;
end;

class operator TWeekday.GreaterThan(const a, b: TWeekday): Boolean;
begin
  Result := a.FDay > b.FDay;
end;

class operator TWeekday.GreaterThanOrEqual(const a, b: TWeekday): Boolean;
begin
  Result := a.FDay >= b.FDay;
end;

class operator TWeekday.Add(const a: TWeekday; b: Word): TWeekday;
begin
  Result.FDay := a.FDay + b;
end;

class operator TWeekday.Subtract(const a: TWeekday; const b: Word): TWeekday;
begin
  Result.FDay := a.FDay - b;
end;

class operator TWeekday.Subtract(const a, b: TWeekday): Integer;
begin
  Result := a.FDay - b.FDay;
end;

function TWeekday.ToString(const FormatSettings: TFormatSettings): string;
begin
  Result := FormatSettings.LongDayNames[FDay];
end;

function TWeekday.ToString: string;
begin
  Result := FormatSettings.LongDayNames[FDay];
end;

function TWeekday.ShortName(const FormatSettings: TFormatSettings): string;
begin
  Result := FormatSettings.ShortDayNames[FDay];
end;

function TWeekday.ShortName: string;
begin
  Result := FormatSettings.ShortDayNames[FDay];
end;

function TWeekday.LongName(const FormatSettings: TFormatSettings): string;
begin
  Result := FormatSettings.LongDayNames[FDay];
end;

function TWeekday.LongName: string;
begin
  Result := FormatSettings.LongDayNames[FDay];
end;

procedure TWeekday.Parse(const Value: string; const FormatSettings: TFormatSettings);
begin
  if not TryParse(Value, FormatSettings) then
    raise EConvertError.CreateResFmt(@System.SysConst.SInvalidDate, [Value]);
end;

procedure TWeekday.Parse(const Value: string);
begin
  Parse(Value, FormatSettings);
end;

function TWeekday.TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean;
var
  I: Integer;
begin
  for I := 1 to 7 do
    if AnsiSameText(Value, FormatSettings.LongDayNames[I]) then
    begin
      FDay := I;
      Exit(True);
    end;

  for I := 1 to 7 do
    if AnsiSameText(Value, FormatSettings.ShortDayNames[I]) then
    begin
      FDay := I;
      Exit(True);
    end;

  Result := False;
end;

function TWeekday.TryParse(const Value: string): Boolean;
begin
  Result := TryParse(Value, FormatSettings)
end;

function TWeekday.GetDay: TWeekdayNum;
begin
  Result := DaysOfWeekArray[Word(FirstDayOfWeek), FDay];
end;

procedure TWeekday.SetDay(const Value: TWeekdayNum);
begin
  FDay := WeekdaysArray[Word(FirstDayOfWeek), FDay];
end;

function TWeekday.GetDayOfWeek(const FirstDayOfWeek: TWeekday): TWeekdayNum;
begin
  Result := DaysOfWeekArray[Word(FirstDayOfWeek), FDay];
end;

procedure TWeekday.SetDayOfWeek(const FirstDayOfWeek: TWeekday; const Value: TWeekdayNum);
begin
  FDay := WeekdaysArray[Word(FirstDayOfWeek), Value];
end;

class operator TWeekday.Implicit(const a: TWeekday): TWeekdayNum;
begin
  Result := a.FDay;
end;

class operator TWeekday.Implicit(const a: TWeekdayNum): TWeekday;
begin
  Result.FDay := a;
end;

{ TWeek.TEnumerator }

function TWeek.TEnumerator.GetCurrent: TWeekday;
begin
  Result := WeekdaysArray[FFirstDayOfWeek.FDay, FCurrentIndex];
end;

function TWeek.TEnumerator.MoveNext: Boolean;
begin
  Result := FCurrentIndex < 7;
  if Result then
    Inc(FCurrentIndex);
end;

{ TWeek }

constructor TWeek.Create(const FirstDayOfWeek: TWeekday);
begin
  FFirstDayOfWeek := FirstDayOfWeek;
end;

function TWeek.Get(const Index: TWeekdayNum): TWeekday;
begin
  Result := WeekdaysArray[Word(FirstDayOfWeek), Index];
end;

function TWeek.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create;
  Result.FFirstDayOfWeek := FirstDayOfWeek;
  Result.FCurrentIndex := 0;
end;

function  WeekDays(const FirstDayOfWeek: TWeekday): TWeek;
begin
  Result := TWeek.Create(FirstDayOfWeek);
end;

function  WeekDays: TWeek;
begin
  Result := WeekDays(FirstDayOfWeek);
end;

{ TYear }

function TYear.GetHashCode: Integer;
begin
  Result := FYear;
end;

class function TYear.Current: TYear;
begin
  Result := TDate.Today.Year;
end;

class operator TYear.Explicit(const a: TYear): string;
begin
  Result := IntToStr(a);
end;

class operator TYear.Explicit(const a: string): TYear;
begin
  Result.FYear := StrToInt(a);
end;

class operator TYear.Implicit(const a: Word): TYear;
begin
  Result.FYear := a;
end;

class operator TYear.Implicit(const a: TYear): Word;
begin
  Result := a.FYear;
end;

class operator TYear.Equal(const a, b: TYear): Boolean;
begin
  Result := a.FYear = b.FYear;
end;

class operator TYear.NotEqual(const a, b: TYear): Boolean;
begin
  Result := a.FYear <> b.FYear;
end;

class operator TYear.GreaterThan(const a, b: TYear): Boolean;
begin
  Result := a.FYear > b.FYear;
end;

class operator TYear.GreaterThanOrEqual(const a, b: TYear): Boolean;
begin
  Result := a.FYear >= b.FYear;
end;

class operator TYear.LessThan(const a, b: TYear): Boolean;
begin
    Result := a.FYear < b.FYear;
end;

class operator TYear.LessThanOrEqual(const a, b: TYear): Boolean;
begin
    Result := a.FYear <= b.FYear;
end;

class operator TYear.Add(const a: TYear; const b: Word): TYear;
begin
  Result.FYear := a.FYear + b;
end;

class operator TYear.Dec(const a: TYear): TYear;
begin
  Result.FYear := a.FYear - 1;
end;

class operator TYear.Inc(const a: TYear): TYear;
begin
  Result.FYear := a.FYear + 1;
end;

class operator TYear.IntDivide(const a: TYear; const b: Word): TYear;
begin
  Result.FYear := a.FYear div b;
end;

function TYear.IsLeap: Boolean;
begin
  Result := YearIsLeap[FYear];
//  Result := (FYear mod 4 = 0) and ((FYear mod 100 <> 0) or (FYear mod 400 = 0));
end;

class operator TYear.Multiply(const a: TYear; const b: Word): TYear;
begin
  Result.FYear := a.FYear * b;
end;

class operator TYear.Subtract(const a: TYear; const b: Word): TYear;
begin
  Result.FYear := a.FYear - b;
end;

class operator TYear.Subtract(const a, b: TYear): Integer;
begin
  Result := a.FYear - b.FYear;
end;

function TYear.ToString: string;
begin
  Result := FYear.ToString;
end;

{ TYearHelper }

function TYearHelper.First: TDate;
begin
  Result.Encode(FYear);
end;

function TYearHelper.Last: TDate;
begin
  Result.Encode(FYear, 12, 31);
end;

function TYearHelper.Dates: TDate.TSequence;
begin
  Result := TDate.Sequence(First, Last);
end;

{ TQuarter.TSequenceEnumerator }

constructor TQuarter.TSequenceEnumerator.Create(const First, Last: TQuarterNum);
begin
  FCurrent := First - 1;
  FLast := Last;
end;

function TQuarter.TSequenceEnumerator.GetCurrent: TQuarter;
begin
  Result.FQuarter := FCurrent;
end;

function TQuarter.TSequenceEnumerator.MoveNext: Boolean;
begin
  Inc(FCurrent);
  Result := FCurrent <= FLast;
end;

{ TQuarter.TSequence }

constructor TQuarter.TSequence.Create(const First, Last: TQuarter);
begin
  FFirst := First;
  FLast := Last;
  FCount := FLast - FFirst + 1;
end;

function TQuarter.TSequence.GetEnumerator: TSequenceEnumerator;
begin
  Result := TQuarter.TSequenceEnumerator.Create(FFirst, FLast);
end;

{ TQuarter }

class operator TQuarter.Explicit(const a: string): TQuarter;
var
  L: Integer;
begin
  L := Length(a);
  if L > 0 then
  begin
    case a[1] of
      '1':   Exit(Quarter1);
      '2':   Exit(Quarter2);
      '3':   Exit(Quarter3);
      '4':   Exit(Quarter4);
      #2160: Exit(Quarter1);
      #2161: Exit(Quarter2);
      #2162: Exit(Quarter3);
      #2163: Exit(Quarter4);
      'I': if (L > 2) and (a[2] = 'I') and (a[3] = 'I') then
             Exit(Quarter3)
           else if (L > 1) and (a[2] = 'I') then
             Exit(Quarter2)
           else if (L > 1) and (a[2] = 'V') then
             Exit(Quarter4)
           else
             Exit(Quarter1);
    end;
  end;

  raise EConvertError.CreateResFmt(@SInvalidQuarter, [a]);
end;

class operator TQuarter.Explicit(const a: TQuarter): string;
begin
  Result := Roman[a.FQuarter];
end;

class operator TQuarter.Implicit(const a: TQuarter): Word;
begin
  Result := a.FQuarter;
end;

class operator TQuarter.Implicit(const a: Word): TQuarter;
begin
  Result.FQuarter := a;
end;

class operator TQuarter.Implicit(const a: TQuarterNum): TQuarter;
begin
  Result.FQuarter := a;
end;

class operator TQuarter.Implicit(const a: TQuarter): TQuarterNum;
begin
  Result := a.FQuarter;
end;

class operator TQuarter.Equal(const a, b: TQuarter): Boolean;
begin
  Result := a.FQuarter = b.FQuarter;
end;

class operator TQuarter.GreaterThan(const a, b: TQuarter): Boolean;
begin
  Result := a.FQuarter > b.FQuarter;
end;

class operator TQuarter.GreaterThanOrEqual(const a, b: TQuarter): Boolean;
begin
  Result := a.FQuarter >= b.FQuarter;
end;

class operator TQuarter.LessThan(const a, b: TQuarter): Boolean;
begin
  Result := a.FQuarter < b.FQuarter;
end;

class operator TQuarter.LessThanOrEqual(const a, b: TQuarter): Boolean;
begin
  Result := a.FQuarter <= b.FQuarter;
end;

class operator TQuarter.NotEqual(const a, b: TQuarter): Boolean;
begin
  Result := a.FQuarter <> b.FQuarter;
end;

class operator TQuarter.Add(const a: TQuarter; b: Word): TQuarter;
begin
  Result.FQuarter := a.FQuarter + b;
end;

class operator TQuarter.Subtract(const a: TQuarter; const b: Word): TQuarter;
begin
  Result.FQuarter := a.FQuarter - b;
end;

class operator TQuarter.Subtract(const a, b: TQuarter): Integer;
begin
  Result := a.FQuarter - b.FQuarter;
end;

class function TQuarter.Range(const First, Last: TQuarter): TSequence;
begin
  Result := TSequence.Create(First, Last);
end;

{ TQuarterHelper }

function TQuarterHelper.Dates(const Year: TYear): TDate.TSequence;
begin
  Result := TDate.TSequence.Create(Year.First, Year.Last);
end;

function TQuarterHelper.First: TMonth;
begin
  Result.FMonth := QuarterFirstMonth[FQuarter];
end;

function TQuarterHelper.Last: TMonth;
begin
  Result.FMonth := QuarterLastMonth[FQuarter];
end;

function TQuarterHelper.Months: TMonth.TSequence;
begin
  Result := TMonth.TSequence.Create(First, Last);
end;

{ TQuarterSequenceHelper }

function TQuarterSequenceHelper.First: TQuarter;
begin
  Result.FQuarter := FFirst;
end;

function TQuarterSequenceHelper.Last: TQuarter;
begin
  Result.FQuarter := FLast;
end;

function TQuarterSequenceHelper.Months: TMonth.TSequence;
begin
  Result := TMonth.TSequence.Create(First.First, Last.Last);
end;

{ TQuarterOfYear }

constructor TQuarterOfYear.Create(const Year: TYear; const Quarter: TQuarter);
begin
  FYear := Year;
  FQuarter := Quarter;
end;

constructor TQuarterOfYear.Create(const Date: System.TDateTime);
begin
  Self := TQuarterOfYear(Date);
end;

class function TQuarterOfYear.Current: TQuarterOfYear;
begin
  Result := TDate.Today.QuarterOfYear;
end;

class operator TQuarterOfYear.Explicit(const a: System.TDateTime): TQuarterOfYear;
begin
  Result := TDate(a).QuarterOfYear;
end;

class operator TQuarterOfYear.Equal(const a, b: TQuarterOfYear): Boolean;
begin
  Result := (a.FYear = b.FYear) and (a.FQuarter = b.FQuarter);
end;

class operator TQuarterOfYear.NotEqual(const a, b: TQuarterOfYear): Boolean;
begin
  Result := (a.FYear <> b.FYear) or (a.FQuarter <> b.FQuarter);
end;

class operator TQuarterOfYear.GreaterThan(const a, b: TQuarterOfYear): Boolean;
begin
  Result := a.Index > b.Index;
end;

class operator TQuarterOfYear.GreaterThanOrEqual(const a, b: TQuarterOfYear): Boolean;
begin
  Result := a.Index >= b.Index;
end;

class operator TQuarterOfYear.LessThan(const a, b: TQuarterOfYear): Boolean;
begin
  Result := a.Index < b.Index;
end;

class operator TQuarterOfYear.LessThanOrEqual(const a, b: TQuarterOfYear): Boolean;
begin
  Result := a.Index <= b.Index;
end;

class operator TQuarterOfYear.Add(const a: TQuarterOfYear; b: Word): TQuarterOfYear;
begin
  Result.Index := a.Index + b;
end;

class operator TQuarterOfYear.Subtract(const a, b: TQuarterOfYear): Integer;
begin
  Result := a.Index - b.Index;
end;

class operator TQuarterOfYear.Subtract(const a: TQuarterOfYear; const b: Word): TQuarterOfYear;
begin
  Result.Index := a.Index - b;
end;

class operator TQuarterOfYear.Inc(const a: TQuarterOfYear): TQuarterOfYear;
begin
  Result.Index := a.Index + 1;
end;

class operator TQuarterOfYear.Dec(const a: TQuarterOfYear): TQuarterOfYear;
begin
  Result.Index := a.Index - 1;
end;

function TQuarterOfYear.GetIndex: Integer;
begin
  Result := FYear.FYear * 3 + FQuarter.FQuarter - 1;
end;

procedure TQuarterOfYear.SetIndex(const Value: Integer);
begin
  FYear.FYear := Value div 3;
  FQuarter.FQuarter := (Value mod 3) + 1;
end;

procedure TQuarterOfYear.SetQuarter(const Value: TQuarter);
begin
  FQuarter := Value;
end;

procedure TQuarterOfYear.SetYear(const Value: TYear);
begin
  FYear := Value;
end;

{ TQuarterOfYearHelper }

function TQuarterOfYearHelper.First: TMonthOfYear;
begin
  Result := TMonthOfYear.Create(Year, QuarterFirstMonth[FQuarter.FQuarter]);
end;

function TQuarterOfYearHelper.Last: TMonthOfYear;
begin
  Result := TMonthOfYear.Create(Year, QuarterLastMonth[FQuarter.FQuarter]);
end;

function TQuarterOfYearHelper.Dates: TDate.TSequence;
begin
  Result := TDate.TSequence.Create(First.First, Last.Last);
end;

function TQuarterOfYearHelper.Months: TMonthOfYear.TSequence;
begin
  Result := TMonthOfYear.TSequence.Create(First, Last);
end;

{ TMonth.TSequenceEnumerator }

constructor TMonth.TSequenceEnumerator.Create(const First, Last: TMonthNum);
begin
  FCurrent := First - 1;
  FLast := Last;
end;

function TMonth.TSequenceEnumerator.GetCurrent: TMonth;
begin
  Result.FMonth := FCurrent;
end;

function TMonth.TSequenceEnumerator.MoveNext: Boolean;
begin
  Inc(FCurrent);
  Result := FCurrent <= FLast;
end;

{ TMonth.TSequence }

constructor TMonth.TSequence.Create(const First, Last: TMonth);
begin
  FFirst := First;
  FLast := Last;
  FCount := FLast - FFirst + 1;
end;

function TMonth.TSequence.GetEnumerator: TSequenceEnumerator;
begin
  Result := TMonth.TSequenceEnumerator.Create(FFirst, FLast);
end;

{ TMonth }

class operator TMonth.Add(const a: TMonth; b: Word): TMonth;
begin
  Result.FMonth := a.FMonth + b;
end;

class operator TMonth.Subtract(const a: TMonth; const b: Word): TMonth;
begin
  Result.FMonth := a.FMonth - b;
end;

class operator TMonth.Subtract(const a, b: TMonth): Integer;
begin
  Result := a.FMonth - b.FMonth;
end;

class operator TMonth.Explicit(const a: TMonth): string;
begin
  Result := FormatSettings.LongMonthNames[a.FMonth];
end;

class operator TMonth.Explicit(const a: string): TMonth;
var
  I: Word;
begin
  for I in [1..12] do
  begin
    if AnsiSameText(FormatSettings.LongMonthNames[I], a) then
    begin
      Result.FMonth := I;
      Exit;
    end;
  end;

  for I in [1..12] do
  begin
    if AnsiSameText(FormatSettings.ShortMonthNames[I], a) then
    begin
      Result.FMonth := I;
      Exit;
    end;
  end;

  raise EConvertError.Create('Invalid month name "' + a + '"');
end;

class operator TMonth.Equal(const a, b: TMonth): Boolean;
begin
  Result := a.FMonth = b.FMonth;
end;

class operator TMonth.GreaterThan(const a, b: TMonth): Boolean;
begin
  Result := a.FMonth > b.FMonth;
end;

class operator TMonth.GreaterThanOrEqual(const a, b: TMonth): Boolean;
begin
  Result := a.FMonth >= b.FMonth;
end;

class operator TMonth.LessThan(const a, b: TMonth): Boolean;
begin
  Result := a.FMonth < b.FMonth;
end;

class operator TMonth.LessThanOrEqual(const a, b: TMonth): Boolean;
begin
  Result := a.FMonth <= b.FMonth;
end;

class operator TMonth.NotEqual(const a, b: TMonth): Boolean;
begin
  Result := a.FMonth <> b.FMonth;
end;

class operator TMonth.Implicit(const a: TMonth): TMonthNum;
begin
  Result := a.FMonth;
end;

class operator TMonth.Implicit(const a: TMonth): Word;
begin
  Result := a.FMonth;
end;

class operator TMonth.Implicit(const a: Word): TMonth;
begin
  Result.FMonth := a;
end;

function TMonth.ToString: string;
begin
  Result := FormatSettings.LongMonthNames[FMonth];
end;

function TMonth.ToString(const FormatSettings: TFormatSettings): string;
begin
  Result := FormatSettings.LongMonthNames[FMonth];
end;

function TMonth.ToString(Short: Boolean): string;
begin
  if Short then
    Result := FormatSettings.ShortMonthNames[FMonth]
  else
    Result := FormatSettings.LongMonthNames[FMonth];
end;

function TMonth.ToString(Short: Boolean; const FormatSettings: TFormatSettings): string;
begin
  if Short then
    Result := FormatSettings.ShortMonthNames[FMonth]
  else
    Result := FormatSettings.LongMonthNames[FMonth];
end;

function TMonth.Days(const Year: TYear): TDays;
begin
  Result := MonthDays[Year.IsLeap, FMonth];
end;

{ TMonthHelper }

function TMonthHelper.First(const Year: TYear): TDate;
begin
  Result.Encode(Year, FMonth);
end;

function TMonthHelper.Last(const Year: TYear): TDate;
begin
  if FMonth = 12 then
    Result.Encode(Year.FYear, 12, 31)
  else
  begin
    Result.Encode(Year.FYear, FMonth + 1, 1);
    Dec(Result.FDate);
  end;
end;

function TMonthHelper.Sequence(const Year: TYear): TDate.TSequence;
begin
  Result := TDate.Sequence(First(Year), Last(Year));
end;

{ TDay }

function TDay.GetHashCode: Integer;
begin
  Result := FDay;
end;

class operator TDay.Explicit(const a: TDay): string;
begin
  Result := IntToStr(a.FDay);
end;

class operator TDay.Explicit(const a: string): TDay;
begin
  Result.FDay := StrToInt(a);
end;

class operator TDay.Implicit(const a: Word): TDay;
begin
  Result.FDay := a;
end;

class operator TDay.Implicit(const a: TDay): Word;
begin
  Result := a.FDay;
end;

class operator TDay.Equal(const a, b: TDay): Boolean;
begin
  Result := a.FDay = b.FDay;
end;

class operator TDay.NotEqual(const a, b: TDay): Boolean;
begin
  Result := a.FDay <> b.FDay;
end;

class operator TDay.GreaterThan(const a, b: TDay): Boolean;
begin
  Result := a.FDay > b.FDay;
end;

class operator TDay.GreaterThanOrEqual(const a, b: TDay): Boolean;
begin
  Result := a.FDay >= b.FDay;
end;

class operator TDay.LessThan(const a, b: TDay): Boolean;
begin
  Result := a.FDay < b.FDay;
end;

class operator TDay.LessThanOrEqual(const a, b: TDay): Boolean;
begin
  Result := a.FDay <= b.FDay;
end;

class operator TDay.Add(const a: TDay; const b: Word): TDay;
begin
  Result.FDay := a.FDay + b;
end;

class operator TDay.Subtract(const a: TDay; const b: Word): TDay;
begin
  Result.FDay := a.FDay - b;
end;

function TDay.ToString: string;
begin
  Result := FDay.ToString;
end;

class operator TDay.IntDivide(const a: TDay; const b: Word): TDay;
begin
  Result.FDay := a.FDay div b;
end;

class operator TDay.Multiply(const a: TDay; const b: Word): TDay;
begin
  Result.FDay := a.FDay * b;
end;

class operator TDay.Dec(const a: TDay): TDay;
begin
  Result.FDay := a.FDay - 1;
end;

class operator TDay.Inc(const a: TDay): TDay;
begin
  Result.FDay := a.FDay + 1;
end;

{ TDateTime }

constructor TDateTime.Create(const Value: TDateTime);
begin
  FDate := Value.FDate;
  FTime := Value.FTime;
end;

constructor TDateTime.Create(const Value: TDate);
begin
  FDate := Value;
  FTime := TTime.Now;
end;

constructor TDateTime.Create(const Value: TTime);
begin
  FDate := TDate.Today;
  FTime := Value;
end;

constructor TDateTime.Create(const Date: TDate; const Time: TTime);
begin
  FDate := Date;
  FTime := Time;
end;

constructor TDateTime.Create(const Value: System.TDateTime);
begin
  FDate := Value;
  FTime := Value;
end;

class operator TDateTime.Implicit(const a: System.TDateTime): TDateTime;
begin
  Result.Date := a;
  Result.Time := a;
end;

class operator TDateTime.Implicit(const a: TDateTime): System.TDateTime;
begin
  Result := System.TDateTime(a.Date) + System.TDateTime(a.Time);
end;

class operator TDateTime.Explicit(const a: TDateTime): string;
begin
  Result := a.ToString;
end;

class operator TDateTime.Explicit(const a: string): TDateTime;
begin
  Result.Parse(a);
end;

class operator TDateTime.Explicit(const a: TDateTime): TDate;
begin
  Result := a.Date;
end;

class operator TDateTime.Explicit(const a: TDate): TDateTime;
begin
  Result.FTime := 0;
  Result.FDate := a;
end;

class operator TDateTime.Explicit(const a: TDateTime): TTime;
begin
  Result := a.Time;
end;

class operator TDateTime.Equal(const a, b: TDateTime): Boolean;
begin
  Result := (a.Date = b.Date) and (a.Time = b.Time);
end;

class operator TDateTime.NotEqual(const a, b: TDateTime): Boolean;
begin
  Result := (a.Date <> b.Date) or (a.Time = b.Time);
end;

class operator TDateTime.LessThan(const a, b: TDateTime): Boolean;
begin
  if a.Date < b.Date then
    Result := True
  else if a.Date > b.Date then
    Result := False
  else
    Result := a.Time < b.Time;
end;

class operator TDateTime.LessThanOrEqual(const a, b: TDateTime): Boolean;
begin
  if a.Date < b.Date then
    Result := True
  else if a.Date > b.Date then
    Result := False
  else
    Result := a.Time <= b.Time;
end;

class operator TDateTime.GreaterThan(const a, b: TDateTime): Boolean;
begin
  if a.Date > b.Date then
    Result := True
  else if a.Date < b.Date then
    Result := False
  else
    Result := a.Time > b.Time;
end;

class operator TDateTime.GreaterThanOrEqual(const a, b: TDateTime): Boolean;
begin
  if a.Date > b.Date then
    Result := True
  else if a.Date < b.Date then
    Result := False
  else
    Result := a.Time >= b.Time;
end;

class operator TDateTime.Implicit(const a: TTimeStamp): TDateTime;
begin
  Result.FDate := a.Date;
  Result.FTime := a.Time;
end;

class operator TDateTime.Implicit(const a: TDateTime): TTimeStamp;
begin
  Result := DateTimeToTimeStamp(a);
end;

class operator TDateTime.Implicit(const a: Variant): TDateTime;
begin
  Result := DateTimeToTimeStamp(a);
end;

class operator TDateTime.Implicit(const a: TDateTime): Variant;
begin
  Result := TimeStampToDateTime(TTimeStamp(a));
end;

class function TDateTime.Now: TDateTime;
{$IFDEF MSWINDOWS}
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result.FDate.Encode(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay);
  Result.FTime.Encode(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
end;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
var
  T: time_t;
  TV: timeval;
  UT: tm;
begin
  gettimeofday(TV, nil);
  T := TV.tv_sec;
  localtime_r(T, UT);
  Result.FDate.Encode(UT.tm_year + 1900, UT.tm_mon + 1, UT.tm_mday);
  Result.FTime.Encode(UT.tm_hour, UT.tm_min, UT.tm_sec, TV.tv_usec div 1000);
end;
{$ENDIF POSIX}

function TDateTime.ToString: string;
begin
  Result := DateTimeToStr(Self);
end;

function TDateTime.ToString(const FormatSettings: TFormatSettings): string;
begin
  Result := DateTimeToStr(Self, FormatSettings);
end;

function TDateTime.Format(const Format: string): string;
begin
  Result := FormatDateTime(Format, Self);
end;

function TDateTime.Format(const Format: string; const FormatSettings: TFormatSettings): string;
begin
  Result := FormatDateTime(Format, Self, FormatSettings);
end;

procedure TDateTime.Parse(const Value: string; const FormatSettings: TFormatSettings);
begin
  Self := StrToDateTime(Value, FormatSettings);
end;

procedure TDateTime.Parse(const Value: string);
begin
  Self := StrToDateTime(Value);
end;

function TDateTime.TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean;
var
  D: System.TDateTime;
begin
  Result := TryStrToDateTime(Value, D, FormatSettings);
  if Result then
    Self := D;
end;

function TDateTime.TryParse(const Value: string): Boolean;
var
  D: System.TDateTime;
begin
  Result := TryStrToDateTime(Value, D);
  if Result then
    Self := D;
end;

procedure TDateTime.SetDate(const Value: TDate);
begin
  FDate := Value;
end;

procedure TDateTime.SetTime(const Value: TTime);
begin
  FTime := Value;
end;

{ TDate.TSequenceEnumerator }

constructor TDate.TSequenceEnumerator.Create(const First, Last: Integer);
begin
  FStart := First - 1;
  FLast := Last;
end;

function TDate.TSequenceEnumerator.GetCurrent: TDate;
begin
  Result.FDate := FStart;
end;

function TDate.TSequenceEnumerator.MoveNext: Boolean;
begin
  Inc(FStart);
  Result := FStart <= FLast;
end;

{ TDate.TSequence }

constructor TDate.TSequence.Create(const First, Last: TDate);
begin
  FFirst := First.FDate;
  FLast := Last.FDate;
end;

function TDate.TSequence.GetEnumerator: TSequenceEnumerator;
begin
  Result := TDate.TSequenceEnumerator.Create(FFirst, FLast);
end;

{ TMonthOfYear.TSequenceEnumerator }

constructor TMonthOfYear.TSequenceEnumerator.Create(const FirstMonth: TMonth; const FirstYear: TYear; const LastMonth: TMonth; const LastYear: TYear);
begin
  FCurrent := FirstYear.FYear * 12 + FirstMonth.FMonth - 1;
  FLast := LastYear.FYear * 12 + LastMonth.FMonth - 1;
end;

function TMonthOfYear.TSequenceEnumerator.GetCurrent: TMonthOfYear;
begin
  Result.Index := FCurrent;
end;

function TMonthOfYear.TSequenceEnumerator.MoveNext: Boolean;
begin
  Inc(FCurrent);
  Result := FCurrent <= FLast;
end;

{ TMonthOfYear.TSequence }

constructor TMonthOfYear.TSequence.Create(const First, Last: TMonthOfYear);
begin
  FFirstYear := First.Year;
  FFirstMonth := First.Month;
  FLastYear := Last.Year;
  FLastMonth := Last.Month;
  FCount := Last.Index - First.Index + 1;
end;

function TMonthOfYear.TSequence.GetEnumerator: TSequenceEnumerator;
begin
  Result := TMonthOfYear.TSequenceEnumerator.Create(FFirstMonth, FFirstYear, FLastMonth, FLastYear);
end;

{ TMonthOfYear }

constructor TMonthOfYear.Create(const Year: TYear; const Month: TMonth);
begin
  FYear := Year;
  FMonth := Month;
end;

constructor TMonthOfYear.Create(const Date: System.TDateTime);
begin
  Self := TMonthOfYear(Date);
end;

class function TMonthOfYear.Current: TMonthOfYear;
begin
  Result := TDate.Today.MonthOfYear;
end;

class operator TMonthOfYear.Implicit(const a: TMonthOfYear): TMonth;
begin
  Result := a.FMonth;
end;

class operator TMonthOfYear.Implicit(const a: TMonthOfYear): TMonthNum;
begin
  Result := a.Month;
end;

class operator TMonthOfYear.Explicit(const a: System.TDateTime): TMonthOfYear;
begin
  Result := TDate(a).MonthOfYear;
end;

class operator TMonthOfYear.Equal(const a, b: TMonthOfYear): Boolean;
begin
  Result := a.Index = b.Index;
end;

class operator TMonthOfYear.NotEqual(const a, b: TMonthOfYear): Boolean;
begin
  Result := a.Index <> b.Index;
end;

class operator TMonthOfYear.GreaterThan(const a, b: TMonthOfYear): Boolean;
begin
  Result := a.Index > b.Index;
end;

class operator TMonthOfYear.GreaterThanOrEqual(const a, b: TMonthOfYear): Boolean;
begin
  Result := a.Index >= b.Index;
end;

class operator TMonthOfYear.LessThan(const a, b: TMonthOfYear): Boolean;
begin
  Result := a.Index < b.Index;
end;

class operator TMonthOfYear.LessThanOrEqual(const a, b: TMonthOfYear): Boolean;
begin
  Result := a.Index <= b.Index;
end;

class operator TMonthOfYear.Add(const a: TMonthOfYear; b: Word): TMonthOfYear;
begin
  Result.Index := a.Index + b;
end;

class operator TMonthOfYear.Subtract(const a, b: TMonthOfYear): Integer;
begin
  Result := a.Index - b.Index;
end;

class operator TMonthOfYear.Subtract(const a: TMonthOfYear; const b: Word): TMonthOfYear;
begin
  Result.Index := a.Index - b;
end;

class operator TMonthOfYear.Inc(const a: TMonthOfYear): TMonthOfYear;
begin
  Result.Index := a.Index + 1;
end;

class operator TMonthOfYear.Dec(const a: TMonthOfYear): TMonthOfYear;
begin
  Result.Index := a.Index - 1;
end;

function TMonthOfYear.GetDays: TDays;
begin
  Result := Month.Days(Year);
end;

function TMonthOfYear.ToString: string;
begin
  Result := Month.ToString + ' ' + Year.ToString;
end;

function TMonthOfYear.GetHashCode: Integer;
begin
  Result := Year.FYear shl 8 + Month.FMonth;
end;

function TMonthOfYear.GetIndex: Integer;
begin
  Result := FYear.FYear * 12 + FMonth.FMonth - 1;
end;

procedure TMonthOfYear.SetIndex(const Value: Integer);
begin
  FYear := Value div 12;
  FMonth := (Value mod 12) + 1;
end;

procedure TMonthOfYear.SetMonth(const Value: TMonth);
begin
  FMonth := Value;
end;

procedure TMonthOfYear.SetYear(const Value: TYear);
begin
  FYear := Value;
end;

{ TMonthOfYearHelper }

function TMonthOfYearHelper.First: TDate;
begin
  Result.Encode(Year, Month, 1);
end;

function TMonthOfYearHelper.Last: TDate;
begin
  Result.Encode(Word(Year), Word(Month), MonthDayCount[Year.IsLeap, Word(Month)]);
end;

function TMonthOfYearHelper.Dates: TDate.TSequence;
begin
  Result := TDate.TSequence.Create(First, Last);
end;

{ TDateSequenceHelper }

function TDateSequenceHelper.GetFirst: TDate;
begin
  Result.FDate := FFirst;
end;

function TDateSequenceHelper.GetLast: TDate;
begin
  Result.FDate := FLast;
end;

{ TDayOfMonth }

function TDayOfMonth.GetHashCode: Integer;
begin
  Result := Integer(Self);
end;

function TDayOfMonth.ToString: string;
begin
  Result := Day.ToString + ' ' + Month.ToString;
end;

class operator TDayOfMonth.Equal(const a, b: TDayOfMonth): Boolean;
begin
  Result := (a.Month = b.Month) and (a.Day = b.Day);
end;

class operator TDayOfMonth.GreaterThan(const a, b: TDayOfMonth): Boolean;
begin
  Result := Cardinal(a) > Cardinal(b);
end;

class operator TDayOfMonth.GreaterThanOrEqual(const a, b: TDayOfMonth): Boolean;
begin
  Result := Cardinal(a) >= Cardinal(b);
end;

class operator TDayOfMonth.LessThan(const a, b: TDayOfMonth): Boolean;
begin
  Result := Cardinal(a) < Cardinal(b);
end;

class operator TDayOfMonth.LessThanOrEqual(const a, b: TDayOfMonth): Boolean;
begin
  Result := Cardinal(a) <= Cardinal(b);
end;

class operator TDayOfMonth.NotEqual(const a, b: TDayOfMonth): Boolean;
begin
  Result := Cardinal(a) <> Cardinal(b);
end;

procedure TDayOfMonth.SetDay(const Value: TDay);
begin
  FDay := Value;
end;

procedure TDayOfMonth.SetMonth(const Value: TMonth);
begin
  FMonth := Value;
end;

{ TBasicCalendar }

constructor TBasicCalendar.Create;
begin
  inherited;
  FHolidays := TDictionary<Integer, Boolean>.Create;
  FWorkDays := TDictionary<Integer, Boolean>.Create;
end;

destructor TBasicCalendar.Destroy;
begin
  FreeAndNil(FHolidays);
  FreeAndNil(FWorkDays);
  inherited;
end;

function TBasicCalendar.GetHoliday(const Date: TDate): Boolean;
begin
  if not Holidays.TryGetValue(Date.FDate, Result) then
    Result := False;
end;

function TBasicCalendar.IsHoliday(const Date: TDate): Boolean;
begin
  Result := GetHoliday(Date);
end;

procedure TBasicCalendar.SetHoliday(const Date: TDate; const Value: Boolean);
begin
  Holidays.AddOrSetValue(Date.FDate, Value);
end;

function TBasicCalendar.GetWorkDay(const Date: TDate): Boolean;
begin
  if not WorkDays.TryGetValue(Date.FDate, Result) then
    Result := False;
end;

function TBasicCalendar.IsWorkDay(const Date: TDate): Boolean;
begin
  if not WorkDays.TryGetValue(Date.FDate, Result) then
    Result := not IsWeekEnd(Date) and not IsHoliday(Date);
end;

procedure TBasicCalendar.SetWorkDay(const Date: TDate; const Value: Boolean);
begin
  WorkDays.AddOrSetValue(Date.FDate, Value);
end;

function TBasicCalendar.IsWeekEnd(const Date: TDate): Boolean;
begin
  Result := Date.Weekday in [1, 7];
end;

{$IFDEF MSWINDOWS}
procedure Init;
const
  SysDOW: array[0..6] of Word = (2, 3, 4, 5, 6, 7, 1);
var
  A: array[0..1] of Char;
  DOW: Integer;
begin
  try
    GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IFIRSTDAYOFWEEK, A, SizeOf(A));
    DOW := Ord(A[0]) - Ord('0');
    if DOW in [0..6] then
      FirstDayOfWeek := SysDOW[DOW];
  except
  end;
end;
{$ENDIF}

initialization
  Init;
  gDefaultCalendar := TBasicCalendar.Create;

end.
