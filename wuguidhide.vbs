If Wscript.Arguments.Count = 0 Then
    WScript.Echo "Please enter update GUID(s) as arguments."
    WScript.Quit 1
End If

Dim updateSession, updateSearcher
Set updateSession = CreateObject("Microsoft.Update.Session")
Set updateSearcher = updateSession.CreateUpdateSearcher()

Dim idx, srString
srString = "UpdateID = '" & Wscript.Arguments(0) & "'"
For idx = 1 To Wscript.Arguments.Count - 1
	srString = srString & " OR UpdateID = '" & Wscript.Arguments(idx) & "'"
Next

Wscript.Echo srString
Wscript.Echo Wscript.Arguments.Count & " update IDs entered."
Wscript.Echo "Searching for pending updates..." 
Dim searchResult
Set searchResult = updateSearcher.Search(srString)

Dim update, index
WScript.Echo CStr(searchResult.Updates.Count) & " updates found."
For index = 0 To searchResult.Updates.Count - 1
    Set update = searchResult.Updates.Item(index)
    WScript.Echo "Hiding update: " & update.Title
    update.IsHidden = True
Next