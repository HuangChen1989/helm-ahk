WinGet windows, List
Loop %windows%
{
	id := windows%A_index%
	WinGetTitle wt, ahk_id %id%
	if (wt != "") {
		r .= wt . ","
	}
}
IniWrite, %r%, helm-ahk.ini,switch-windows,windows