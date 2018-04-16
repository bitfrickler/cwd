;#RequireAdmin
#AutoIt3Wrapper_Change2CUI=y

#include <Array.au3>
#include <WinAPIHObj.au3>
#include <WinAPIProc.au3>

Local $aAdjust = 0
Local $pid = $CmdLine[1]

; Enable "SeDebugPrivilege" privilege for obtain full access rights to another processes
Local $hToken = _WinAPI_OpenProcessToken(BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY))
_WinAPI_AdjustTokenPrivileges($hToken, $SE_DEBUG_NAME, $SE_PRIVILEGE_ENABLED, $aAdjust)

$value = _WinAPI_GetProcessWorkingDirectory($pid)

; Restore "SeDebugPrivilege" privilege by default
_WinAPI_AdjustTokenPrivileges($hToken, $aAdjust, 0, $aAdjust)
_WinAPI_CloseHandle($hToken)

ConsoleWrite($value & @CRLF)