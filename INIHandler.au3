#NoTrayIcon
#include <cmdline.au3>
#include <File.au3>

If $cmdlineraw == "" Then
	ConsoleWrite("INI Files Handler Win32 - ALBANESE Lab " & Chr(184) & " 2018-2020" & @CRLF & @CRLF)
	ConsoleWrite("Commands:" & @CRLF)
	ConsoleWrite(" -set: SET value" & @CRLF)
	ConsoleWrite(" -get: GET sections names/parameters/value" & @CRLF)
	ConsoleWrite(" -del: DELETE parameter/value" & @CRLF & @CRLF)
	ConsoleWrite("Flags:" & @CRLF)
	ConsoleWrite("   /s: SECTION" & @CRLF)
	ConsoleWrite("   /p: PATAMETER" & @CRLF)
	ConsoleWrite("   /v: VALUE" & @CRLF & @CRLF)
	ConsoleWrite("Usage: " & @ScriptName & " --set <config_file> /s <section> /p <param> /v <value>" & @CRLF)
	ConsoleWrite("   or: " & @ScriptName & " --get <config_file> /s [section] /p [param]" & @CRLF)
	ConsoleWrite("   or: " & @ScriptName & " --del <config_file> /s <section> /p [param]" & @CRLF & @CRLF)
	ConsoleWrite("   <> imperative, [] optative." & @CRLF & @CRLF)
	ConsoleWrite("Written by Pedro Albanese" & @CRLF)
	ConsoleWrite("http://albanese.atwebpages.com" & @CRLF)
	Exit
Else
	If _cmdline_keyexists("get") Then
		$file = _pathfull(_cmdline_get("get"))
		If NOT FileExists($file) Then
			ConsoleWrite("File " & _cmdline_get("get") & " doesn't exist.")
			Exit
		EndIf
	EndIf
	If _cmdline_keyexists("get") AND _cmdline_keyexists("s") AND _cmdline_keyexists("p") Then
		$file = _pathfull(_cmdline_get("get"))
		$section = _cmdline_get("s")
		$param = _cmdline_get("p")
		ConsoleWrite(IniRead($file, $section, $param, "Not found."))
	ElseIf _cmdline_keyexists("get") AND _cmdline_keyexists("s") Then
		$file = _pathfull(_cmdline_get("get"))
		$section = _cmdline_get("s")
		$param = _cmdline_get("p")
		$aarray = IniReadSection($file, $section)
		If @error Then
			ConsoleWrite("Section " & $section & " doesn't exist.")
			Exit
		EndIf
		For $i = 1 To $aarray[0][0]
			ConsoleWrite(StringFormat("%s", $aarray[$i][0]) & @CRLF)
		Next
	ElseIf _cmdline_keyexists("get") Then
		$file = _pathfull(_cmdline_get("get"))
		Local $aarray = IniReadSectionNames($file)
		If @error Then
			ConsoleWrite("Section " & $section & " doesn't exist.")
			Exit
		EndIf
		For $i = 1 To $aarray[0]
			ConsoleWrite(StringFormat("%s", $aarray[$i]) & @CRLF)
		Next
	ElseIf _cmdline_keyexists("set") AND _cmdline_keyexists("s") AND _cmdline_keyexists("p") AND _cmdline_keyexists("v") Then
		$file = _pathfull(_cmdline_get("set"))
		$section = _cmdline_get("s")
		$param = _cmdline_get("p")
		$value = _cmdline_get("v")
		IniWrite($file, $section, $param, $value)
	ElseIf _cmdline_keyexists("del") AND _cmdline_keyexists("s") AND _cmdline_keyexists("p") Then
		$file = _pathfull(_cmdline_get("del"))
		$section = _cmdline_get("s")
		$param = _cmdline_get("p")
		IniDelete($file, $section, $param)
	ElseIf _cmdline_keyexists("del") AND _cmdline_keyexists("s") Then
		$file = _pathfull(_cmdline_get("del"))
		$section = _cmdline_get("s")
		IniDelete($file, $section)
	Else
		ConsoleWrite("Very few arguments.")
	EndIf
EndIf
