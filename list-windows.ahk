WinGet windows, List
Loop %windows%
{
	id := windows%A_index%
	WinGetTitle wt, ahk_id %id%
	if (wt != "") {
		r .= wt . ","
	}
}
file := FileOpen("windows.txt", "w", "utf-8")
file.Write(r)
file.Close()