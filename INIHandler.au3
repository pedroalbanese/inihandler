#NoTrayIcon
#include <cmdline.au3>
#include <File.au3>

If $CmdLineRaw == "" Then
   ConsoleWrite("INI Files Handler Win32 - ALBANESE Lab " & Chr(184) & " 2018-2020" & @CRLF & @CRLF);
   	  ConsoleWrite("Commands:" & @CRLF);
      ConsoleWrite(" -set: SET value" & @CRLF);
	  ConsoleWrite(" -get: GET sections names/parameters/value" & @CRLF);
	  ConsoleWrite(" -del: DELETE parameter/value" & @CRLF & @CRLF);
	  ConsoleWrite("Flags:" & @CRLF);
      ConsoleWrite("   /s: SECTION" & @CRLF);
	  ConsoleWrite("   /p: PATAMETER" & @CRLF);
	  ConsoleWrite("   /v: VALUE" & @CRLF & @CRLF);
   ConsoleWrite("Usage: " & @ScriptName & " --set <config_file> /s <section> /p <param> /v <value>" & @CRLF);
   ConsoleWrite("   or: " & @ScriptName & " --get <config_file> /s [section] /p [param]" & @CRLF);
   ConsoleWrite("   or: " & @ScriptName & " --del <config_file> /s <section> /p [param]" & @CRLF & @CRLF);
   ConsoleWrite("   <> imperative, [] optative." & @CRLF & @CRLF);
   ConsoleWrite("Written by Pedro Albanese" & @CRLF);
   ConsoleWrite("http://albanese.atwebpages.com" & @CRLF);
   Exit
Else
   If _CmdLine_KeyExists('get') Then
	  $file = _PathFull(_CmdLine_Get('get'))
	  If not FileExists($file) Then
			ConsoleWrite("File " & _CmdLine_Get('get') & " doesn't exist.")
			Exit
	  Endif
   Endif
   If _CmdLine_KeyExists('get') and _CmdLine_KeyExists('s') and _CmdLine_KeyExists('p') Then
	$file = _PathFull(_CmdLine_Get('get'))
	$section = _CmdLine_Get('s')
	$param = _CmdLine_Get('p')
	ConsoleWrite(IniRead($file, $section, $param, "Not found."))
   ElseIf _CmdLine_KeyExists('get') and _CmdLine_KeyExists('s') Then
	$file = _PathFull(_CmdLine_Get('get'))
	$section = _CmdLine_Get('s')
	$param = _CmdLine_Get('p')
    $aArray = IniReadSection($file, $section)
    If @error Then
	   ConsoleWrite("Section " & $section & " doesn't exist.")
	   Exit
	Endif
	For $i = 1 To $aArray[0][0]
	ConsoleWrite(StringFormat("%s", $aArray[$i][0]) & @CRLF)
    next
   ElseIf _CmdLine_KeyExists('get') Then
	$file = _PathFull(_CmdLine_Get('get'))
    Local $aArray = IniReadSectionNames($file)
    If @error Then
	   ConsoleWrite("Section " & $section & " doesn't exist.")
	   Exit
	Endif
	For $i = 1 To $aArray[0]
	ConsoleWrite(StringFormat("%s", $aArray[$i]) & @CRLF)
    next
   ElseIf _CmdLine_KeyExists('set') and _CmdLine_KeyExists('s') and _CmdLine_KeyExists('p') and _CmdLine_KeyExists('v') Then
	$file = _PathFull(_CmdLine_Get('set'))
	$section = _CmdLine_Get('s')
	$param = _CmdLine_Get('p')
	$value = _CmdLine_Get('v')
	IniWrite($file, $section, $param, $value)
   ElseIf _CmdLine_KeyExists('del') and _CmdLine_KeyExists('s') and _CmdLine_KeyExists('p') Then
	$file = _PathFull(_CmdLine_Get('del'))
	$section = _CmdLine_Get('s')
	$param = _CmdLine_Get('p')
	IniDelete($file, $section, $param)
   ElseIf _CmdLine_KeyExists('del') and _CmdLine_KeyExists('s') Then
	$file = _PathFull(_CmdLine_Get('del'))
	$section = _CmdLine_Get('s')
	IniDelete($file, $section)
   Else
	ConsoleWrite("Very few arguments.")
   Endif
Endif
