program Test;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  TestExt.Types in 'TestExt.Types.pas',
  Ext.Types.Date in '..\Source\Ext.Types.Date.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

