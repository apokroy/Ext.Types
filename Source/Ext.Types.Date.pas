unit Ext.Types.Date;

interface

uses System.Types, System.SysUtils, System.Variants;

{$R+}

type
  TMonthNum   = 1..12;
  TWeekdayNum = 1..7;

  ///<summary>
  ///  Represent day of the week, where first day is Sunday (1) to Saturday (7)
  ///</summary>
  TWeekday = record
  private
    FDay: TWeekdayNum;
    function  GetDayOfWeek(const FirstDayOfWeek: TWeekday): TWeekdayNum; inline;
    procedure SetDayOfWeek(const FirstDayOfWeek: TWeekday; const Value: TWeekdayNum);  inline;
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
    class operator Add(const a: TWeekday; b: Word): TWeekday; inline;
    class operator Subtract(const a, b: TWeekday): Integer; inline;
    class operator Subtract(const a: TWeekday; const b: Word): TWeekday; inline;
    class operator Implicit(const a: Word): TWeekday; inline;
    class operator Implicit(const a: TWeekday): Word; inline;
    class operator Explicit(const a: TWeekday): string; inline;
    class operator Explicit(const a: string): TWeekday; inline;
    class operator Equal(const a, b: TWeekday) : Boolean; inline;
    class operator NotEqual(const a, b: TWeekday) : Boolean; inline;
    class operator GreaterThan(const a, b: TWeekday) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TWeekday) : Boolean; inline;
    class operator LessThan(const a, b: TWeekday) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TWeekday) : Boolean; inline;
  end;

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

type
  ///<summary>
  ///  Type reperesenting day of month.
  ///  Type impilicitly compatible with Word
  ///</summary>
  TDay = record
  private
    FDay: Word;
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
    class operator Negative(const a: TDay): TDay; inline;
    class operator Positive(const a: TDay): TDay; inline;
    class operator Equal(const a, b: TDay) : Boolean; inline;
    class operator NotEqual(const a, b: TDay) : Boolean; inline;
    class operator GreaterThan(const a, b: TDay) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TDay) : Boolean; inline;
    class operator LessThan(const a, b: TDay) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TDay) : Boolean; inline;
  end;

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
    class operator Negative(const a: TYear): TYear; inline;
    class operator Positive(const a: TYear): TYear; inline;
    class operator Equal(const a, b: TYear) : Boolean; inline;
    class operator NotEqual(const a, b: TYear) : Boolean; inline;
    class operator GreaterThan(const a, b: TYear) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TYear) : Boolean; inline;
    class operator LessThan(const a, b: TYear) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TYear) : Boolean; inline;
  end;

  ///<summary>
  ///  Type reperesenting a month.
  ///  Type impilicitly compatible with Word
  ///</summary>
  TMonth = record
  private
    FMonth: Word;
  public
    ///<summary>
    ///  Name of the month as in LongMonthNames of system global FormatSettings
    ///</summary>
    function  ToString: string; overload; inline;
    ///<summary>
    ///  Name of the month as in LongMonthNames of FormatSettings parameter
    ///</summary>
    function  ToString(const FormatSettings: TFormatSettings): string; overload; inline;
    ///<summary>
    ///  Returns count of days in month of a Year
    ///</summary>
    function  Count(const Year: TYear): Word; inline;
  public
    class operator Add(const a: TMonth; b: Word): TMonth; inline;
    class operator Subtract(const a, b: TMonth): Integer; inline;
    class operator Subtract(const a: TMonth; const b: Word): TMonth; inline;
    class operator Implicit(const a: Word): TMonth; inline;
    class operator Implicit(const a: TMonth): Word; inline;
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
  ///<summary>
  ///  Type allows increment & decrement month to iterate through years and months
  ///</summary>
  TMonthOfYear = record
  private
    FYear: TYear;
    FMonth: TMonth;
    function  GetCount: Word; inline;
    procedure SetMonth(const Value: TMonth); inline;
    procedure SetYear(const Value: TYear); inline;
    function  GetIndex: Integer; inline;
    procedure SetIndex(const Value: Integer); inline;
    property  Index: Integer read GetIndex write SetIndex;
  public
    constructor Create(const Date: System.TDateTime); overload;
    constructor Create(const Year: TYear; const Month: TMonth); overload;
    class function Current: TMonthOfYear; static; inline;
    property  Year: TYear read FYear write SetYear;
    property  Month: TMonth read FMonth write SetMonth;
    property  Count: Word read GetCount;
  public
    class operator Explicit(const a: System.TDateTime): TMonthOfYear; inline;
    class operator Add(const a: TMonthOfYear; b: Word): TMonthOfYear; inline;
    class operator Subtract(const a, b: TMonthOfYear): Integer; inline;
    class operator Subtract(const a: TMonthOfYear; const b: Word): TMonthOfYear; inline;
    class operator Equal(const a, b: TMonthOfYear) : Boolean; inline;
    class operator NotEqual(const a, b: TMonthOfYear) : Boolean; inline;
    class operator GreaterThan(const a, b: TMonthOfYear) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TMonthOfYear) : Boolean; inline;
    class operator LessThan(const a, b: TMonthOfYear) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TMonthOfYear) : Boolean; inline;
  end;

type
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

    TSequence = record
    private
      FFirst, FLast: Integer;
    public
      constructor Create(const First, Last: TDate);
      function  GetEnumerator: TSequenceEnumerator; inline;
    end;
  private
    FDate: Integer; // Date stamp - number of days from 00001-01-01
    function  GetDay: TDay; inline;
    function  GetISO: string; inline;
    function  GetMonth: TMonth; inline;
    function  GetWeekday: TWeekday; inline;
    function  GetYear: TYear; inline;
    procedure SetDay(const Value: TDay); inline;
    procedure SetISO(const Value: string);
    procedure SetMonth(const Value: TMonth); inline;
    procedure SetWeekday(const Value: TWeekday); inline;
    procedure SetYear(const Value: TYear); inline;
    function  GetMonthOfYear: TMonthOfYear; inline;
    procedure SetMonthOfYear(const Value: TMonthOfYear); inline;
  public
    function  ToString: string; overload; inline;
    function  ToString(const FormatSettings: TFormatSettings): string; overload; inline;
    function  Format(const Format: string): string; overload; inline;
    function  Format(const Format: string; const FormatSettings: TFormatSettings): string; overload; inline;
    procedure Parse(const Value: string); overload; inline;
    procedure Parse(const Value: string; const FormatSettings: TFormatSettings); overload; inline;
    function  TryParse(const Value: string): Boolean; overload; inline;
    function  TryParse(const Value: string; const FormatSettings: TFormatSettings): Boolean; overload; inline;
    function  StartOfMonth: TDate; inline;
    function  EndOfMonth: TDate; inline;
    function  StartOfWeek: TDate; overload; inline;
    function  StartOfWeek(const FirstDayOfWeek: TWeekday): TDate; overload; inline;
    function  EndOfWeek: TDate; overload; inline;
    function  EndOfWeek(const FirstDayOfWeek: TWeekday): TDate; overload; inline;
    procedure Encode(const Year, Month, Day: Word); overload; inline;
    procedure Encode(const Year: TYear; const Month: TMonth; const Day: TDay); overload; inline;
    procedure Decode(var Year, Month, Day: Word); overload;
    procedure Decode(var Year: TYear; var Month: TMonth; var Day: TDay); overload; inline;
    property  Day: TDay read GetDay write SetDay;
    property  Month: TMonth read GetMonth write SetMonth;
    property  Year: TYear read GetYear write SetYear;
    property  Weekday: TWeekday read GetWeekday write SetWeekday;
    property  MonthOfYear: TMonthOfYear read GetMonthOfYear write SetMonthOfYear;
    property  ISO: string read GetISO write SetISO;
  public
    constructor Create(const Date: TDate); overload;
    constructor Create(const Date: System.TDateTime); overload;
    constructor Create(const Year: TYear; const Month: TMonth; const Day: TDay); overload;
    constructor Create(const Year, Month, Day: Word); overload;
    class function Today: TDate; static; inline;
    class function Range(const First, Last: TDate): TArray<TDate>; static;
    class function Sequence(const First, Last: TDate): TSequence; static;
  public
    class operator Add(const a: TDate; const b: Integer): TDate; inline;
    class operator Subtract(const a: TDate; const b: Integer): TDate; inline;
    class operator Subtract(const a, b: TDate): Integer; inline;
    class operator Implicit(const a: System.TDateTime): TDate; inline;
    class operator Implicit(const a: TDate): System.TDateTime; inline;
    class operator Explicit(const a: Integer): TDate; inline;
    class operator Explicit(const a: TDate): Integer; inline;
    class operator Explicit(const a: TDate): string; inline;
    class operator Explicit(const a: string): TDate; inline;
    class operator Inc(const a: TDate): TDate; inline;
    class operator Dec(const a: TDate): TDate; inline;
    class operator Negative(const a: TDate): TDate; inline;
    class operator Positive(const a: TDate): TDate;  inline;
    class operator Equal(const a, b: TDate) : Boolean; inline;
    class operator NotEqual(const a, b: TDate) : Boolean; inline;
    class operator GreaterThan(const a, b: TDate) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TDate) : Boolean; inline;
    class operator LessThan(const a, b: TDate) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TDate) : Boolean; inline;
  end;

  TTime = record
  private
    FTime: Integer;
    function  GetISO: string; inline;
    procedure SetISO(const Value: string);
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
    property  Hour: Word read GetHour write SetHour;
    property  Minute: Word read GetMinute write SetMinute;
    property  Second: Word read GetSecond write SetSecond;
    property  MSecond: Word read GetMSecond write SetMSecond;
  public
    constructor Create(const Time: TTime); overload;
    constructor Create(const Time: System.TDateTime); overload;
    class function Now: TTime; static; inline;
  public
    class operator Add(const a: TTime; b: Integer): TTime; inline;
    class operator Add(const a, b: TTime): TTime; inline;
    class operator Subtract(const a: TTime; b: Integer): TTime; inline;
    class operator Subtract(const a, b: TTime): Integer; inline;
    class operator Implicit(const a: System.TDateTime): TTime; inline;
    class operator Implicit(const a: TTime): System.TDateTime; inline;
    class operator Explicit(const a: Integer): TTime; inline;
    class operator Explicit(const a: TTime): Integer; inline;
    class operator Explicit(const a: TTime): string; inline;
    class operator Explicit(const a: string): TTime; inline;
    class operator Inc(const a: TTime): TTime; inline;
    class operator Dec(const a: TTime): TTime; inline;
    class operator Negative(const a: TTime): TTime; inline;
    class operator Positive(const a: TTime): TTime;  inline;
    class operator Equal(const a, b: TTime) : Boolean; inline;
    class operator NotEqual(const a, b: TTime) : Boolean; inline;
    class operator GreaterThan(const a, b: TTime) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TTime) : Boolean; inline;
    class operator LessThan(const a, b: TTime) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TTime) : Boolean; inline;
  end;

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
    constructor Create(const Value: TDate); overload;
    constructor Create(const Value: TTime); overload;
    constructor Create(const Value: System.TDateTime); overload;
    class function Now: TDateTime; static;
  public
    class operator Implicit(const a: System.TDateTime): TDateTime; inline;
    class operator Implicit(const a: TDateTime): System.TDateTime; inline;
    class operator Explicit(const a: TDateTime): string; inline;
    class operator Explicit(const a: string): TDateTime; inline;
    class operator Explicit(const a: TDateTime): TDate; inline;
    class operator Explicit(const a: TDate): TDateTime; inline;
    class operator Explicit(const a: TDateTime): TTime; inline;
    class operator Negative(const a: TDateTime): TDateTime; inline;
    class operator Positive(const a: TDateTime): TDateTime;  inline;
    class operator Equal(const a, b: TDateTime) : Boolean; inline;
    class operator NotEqual(const a, b: TDateTime) : Boolean; inline;
    class operator GreaterThan(const a, b: TDateTime) : Boolean; inline;
    class operator GreaterThanOrEqual(const a, b: TDateTime) : Boolean; inline;
    class operator LessThan(const a, b: TDateTime) : Boolean; inline;
    class operator LessThanOrEqual(const a, b: TDateTime) : Boolean; inline;
  end;

  // Need helpers, because record forward declaration is not allowed

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
    function  Sequence: TDate.TSequence; inline;
  end;

  TYearHelper = record helper for TYear
  public
    function  First: TDate; inline;
    function  Last: TDate; inline;
    function  Sequence: TDate.TSequence;
  end;

{$region 'fast calculation consts'}
const
  DaysOfWeekArray: array[TWeekdayNum] of array[TWeekdayNum] of TWeekdayNum = (
    (1, 2, 3, 4, 5, 6, 7), //Sunday
    (7, 1, 2, 3, 4, 5, 6),
    (6, 7, 1, 2, 3, 4, 5),
    (5, 6, 7, 1, 2, 3, 4),
    (4, 5, 6, 7, 1, 2, 3),
    (3, 4, 5, 6, 7, 1, 2),
    (2, 3, 4, 5, 6, 7, 1)
  );

  WeekdaysArray: array[TWeekdayNum] of array[TWeekdayNum] of TWeekdayNum = (
    (1, 2, 3, 4, 5, 6, 7), //Sunday
    (2, 3, 4, 5, 6, 7, 1),
    (3, 4, 5, 6, 7, 1, 2),
    (4, 5, 6, 7, 1, 2, 3),
    (5, 6, 7, 1, 2, 3, 4),
    (6, 7, 1, 2, 3, 4, 5),
    (7, 1, 2, 3, 4, 5, 6)
  );

  MonthOfDay: array[Boolean, 1..366] of Word = (
    (
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
      2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
      3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
      4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
      5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
      6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
      7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
      8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
      9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
      10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
      11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
      12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
      0
    ),
    (
      1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
      2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
      3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
      4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
      5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
      6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,
      7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
      8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
      9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
      10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
      11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
      12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12
    )
  );

  MonthDayOfDay: array[Boolean, 1..366] of Word = (
    (
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      0
    ),
    (
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    )
  );

  MonthOffset: array[Boolean, 1..12] of Word = (
    (0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334),
    (0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335)
  );

{$endregion}

const
  ISO8601FormatSettings: TFormatSettings = (
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

implementation

uses {$IFDEF MSWINDOWS}Winapi.Windows, {$ENDIF}System.SysConst, System.Math;

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

class operator TDate.Inc(const a: TDate): TDate;
begin
  Result.FDate := a.FDate + 1;
end;

class operator TDate.Dec(const a: TDate): TDate;
begin
  Result.FDate := a.FDate - 1;
end;

class operator TDate.Negative(const a: TDate): TDate;
begin
  Result.FDate := -a.FDate;
end;

class operator TDate.Positive(const a: TDate): TDate;
begin
  Result.FDate := +a.FDate;
end;

class operator TDate.Equal(const a, b: TDate): Boolean;
begin
  Result := a.FDate = b.FDate;
end;

class operator TDate.NotEqual(const a, b: TDate): Boolean;
begin
  Result := a.FDate <> a.FDate;
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
begin
  Result := System.SysUtils.Date;
end;

function TDate.GetISO: string;
begin
  Result := ToString(ISO8601FormatSettings);
end;

procedure TDate.SetISO(const Value: string);
begin
  Parse(Value, ISO8601FormatSettings);
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
  Month := MonthOfDay[TYear(Year).IsLeap, Day + 1];
  Day := MonthDayOfDay[TYear(Year).IsLeap, Day + 1];
end;

procedure TDate.Decode(var Year: TYear; var Month: TMonth; var Day: TDay);
begin
  Decode(Year.FYear, Month.FMonth, Day.FDay);
end;

procedure TDate.Encode(const Year, Month, Day: Word);
var
  I: Integer;
begin
  I := Year - 1;
  FDate := I * 365 + I div 4 - I div 100 + I div 400 + MonthOffset[TYear(Year).IsLeap, Month] + Day
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
  D: TDay;
begin
  Decode(Y, M, D);

  if M = Value then
    Exit;

  if Value.Count(Y) < D then
    D := Value.Count(Y);

  Encode(Y, Value, D);
end;

function TDate.GetYear: TYear;
var
  Y, M, D: Word;
begin
  Decode(Y, M, D);
  Result.FYear := Y;
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

function TDate.GetMonthOfYear: TMonthOfYear;
var
  Y: TYear;
  M: TMonth;
  D: TDay;
begin
  Decode(Y, M, D);
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

function TDate.StartOfMonth: TDate;
var
  Y: TYear;
  M: TMonth;
  D: TDay;
begin
  Decode(Y, M, D);
  Result := M.First(Y)
end;

function TDate.EndOfMonth: TDate;
var
  Y: TYear;
  M: TMonth;
  D: TDay;
begin
  Decode(Y, M, D);
  Result := M.Last(Y)
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

class function TTime.Now: TTime;
begin
  Result := System.SysUtils.Now;
end;

class operator TTime.Add(const a: TTime; b: Integer): TTime;
begin
  Result.FTime := a.FTime + b;
end;

class operator TTime.Add(const a, b: TTime): TTime;
begin
  Result.FTime := a.FTime + b.FTime;
end;

class operator TTime.Subtract(const a, b: TTime): Integer;
begin
  Result := a.FTime - b.FTime;
end;

class operator TTime.Subtract(const a: TTime; b: Integer): TTime;
begin
  Result.FTime:= a.FTime - b;
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
  Result := a.FTime / MSecsPerDay;
end;

class operator TTime.Implicit(const a: System.TDateTime): TTime;
begin
  Result.FTime := Abs(Round(a * MSecsPerDay)) mod MSecsPerDay;
end;

class operator TTime.Explicit(const a: TTime): Integer;
begin
  Result := a.FTime;
end;

class operator TTime.Explicit(const a: Integer): TTime;
begin
  Result.FTime := a;
end;

class operator TTime.Negative(const a: TTime): TTime;
begin
  Result.FTime := -a.FTime;
end;

class operator TTime.Positive(const a: TTime): TTime;
begin
  Result.FTime := +a.FTime;
end;

function TTime.GetISO: string;
begin
  Result := FormatDateTime('HH:NN:SS', Self);
end;

procedure TTime.SetISO(const Value: string);
begin
  Parse(Value, ISO8601FormatSettings);
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
  FDay := WeekdaysArray[Word(FirstDayOfWeek), FDay];
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

class operator TYear.Negative(const a: TYear): TYear;
begin
  Result.FYear := -a.FYear;
end;

class operator TYear.Positive(const a: TYear): TYear;
begin
  Result.FYear := +a.FYear;
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
  Result := (FYear mod 4 = 0) and ((FYear mod 100 <> 0) or (FYear mod 400 = 0));
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

{ TYearHelper }

function TYearHelper.First: TDate;
begin
  Result := TDate.Create(Self, 1, 1);
end;

function TYearHelper.Last: TDate;
begin
  Result := TDate.Create(Self, 12, 31);
end;

function TYearHelper.Sequence: TDate.TSequence;
begin
  Result := TDate.Sequence(First, Last);
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
begin
  if FormatSettings.LongMonthNames[1] = a then
    Result.FMonth := 1
  else if FormatSettings.LongMonthNames[2] = a then
    Result.FMonth := 2
  else if FormatSettings.LongMonthNames[3] = a then
    Result.FMonth := 3
  else if FormatSettings.LongMonthNames[4] = a then
    Result.FMonth := 4
  else if FormatSettings.LongMonthNames[5] = a then
    Result.FMonth := 5
  else if FormatSettings.LongMonthNames[6] = a then
    Result.FMonth := 6
  else if FormatSettings.LongMonthNames[7] = a then
    Result.FMonth := 7
  else if FormatSettings.LongMonthNames[8] = a then
    Result.FMonth := 8
  else if FormatSettings.LongMonthNames[9] = a then
    Result.FMonth := 9
  else if FormatSettings.LongMonthNames[10] = a then
    Result.FMonth := 10
  else if FormatSettings.LongMonthNames[11] = a then
    Result.FMonth := 11
  else if FormatSettings.LongMonthNames[12] = a then
    Result.FMonth := 12
  else
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

function TMonth.Count(const Year: TYear): Word;
begin
  Result := MonthDays[Year.IsLeap, FMonth];
end;

{ TMonthHelper }

function TMonthHelper.First(const Year: TYear): TDate;
begin
  Result := TDate.Create(Year, Self, TDay(1));
end;

function TMonthHelper.Last(const Year: TYear): TDate;
begin
  Result := TDate.Create(Year, Self, TDay(Count(Year)));
end;

function TMonthHelper.Sequence(const Year: TYear): TDate.TSequence;
begin
  Result := TDate.Sequence(First(Year), Last(Year));
end;

{ TDay }

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

class operator TDay.IntDivide(const a: TDay; const b: Word): TDay;
begin
  Result.FDay := a.FDay div b;
end;

class operator TDay.Multiply(const a: TDay; const b: Word): TDay;
begin
  Result.FDay := a.FDay * b;
end;

class operator TDay.Negative(const a: TDay): TDay;
begin
  Result.FDay := -a.FDay;
end;

class operator TDay.Positive(const a: TDay): TDay;
begin
  Result.FDay := +a.FDay;
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
  FDate := Value.Date;
  FTime := Value.Time;
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
  Result := System.TDateTime(a) = System.TDateTime(b);
end;

class operator TDateTime.NotEqual(const a, b: TDateTime): Boolean;
begin
  Result := System.TDateTime(a) <> System.TDateTime(b);
end;

class operator TDateTime.LessThan(const a, b: TDateTime): Boolean;
begin
  Result := System.TDateTime(a) < System.TDateTime(b);
end;

class operator TDateTime.LessThanOrEqual(const a, b: TDateTime): Boolean;
begin
  Result := System.TDateTime(a) <= System.TDateTime(b);
end;

class operator TDateTime.GreaterThan(const a, b: TDateTime): Boolean;
begin
  Result := System.TDateTime(a) > System.TDateTime(b);
end;

class operator TDateTime.GreaterThanOrEqual(const a, b: TDateTime): Boolean;
begin
  Result := System.TDateTime(a) > System.TDateTime(b);
end;

class operator TDateTime.Negative(const a: TDateTime): TDateTime;
begin
  Result := -System.TDateTime(a);
end;

class operator TDateTime.Positive(const a: TDateTime): TDateTime;
begin
  Result := +System.TDateTime(a);
end;

class function TDateTime.Now: TDateTime;
begin
  Result := System.SysUtils.Now;
end;

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
  FFirst := Integer(First);
  FLast := Integer(Last);
end;

function TDate.TSequence.GetEnumerator: TSequenceEnumerator;
begin
  Result := TDate.TSequenceEnumerator.Create(FFirst, FLast);
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
  Result.Create(Now);
end;

class operator TMonthOfYear.Explicit(const a: System.TDateTime): TMonthOfYear;
var
  D: TDay;
begin
  TDate(a).Decode(Result.FYear, Result.FMonth, D);
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

function TMonthOfYear.GetCount: Word;
begin
  Result := Month.Count(Year);
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
  Result.Encode(Year, Month, TDay(Count));
end;

function TMonthOfYearHelper.Sequence: TDate.TSequence;
begin
  Result := TDate.TSequence.Create(First, Last);
end;

{$IFDEF MSWINDOWS}
procedure Init;
const
  SysDOW: array[0..6] of Word = (2, 3, 4, 5, 6, 7, 1);
var
  A: array[0..1] of Char;
  DOW: Integer;
begin
  GetLocaleInfo(LOCALE_USER_DEFAULT, LOCALE_IFIRSTDAYOFWEEK, A, SizeOf(A));
  DOW := Ord(A[0]) - Ord('0');
  if DOW in [0..6] then
    FirstDayOfWeek := SysDOW[DOW]
end;
{$ENDIF}

initialization
  Init;

end.
