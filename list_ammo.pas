unit UserScript;

interface

implementation

var
  LastFileName: string;

function Initialize: integer;
begin
  LastFileName := '';
end;

function Process(e: IInterface): integer;
var
  currentFile, fullID, lastThree, edID, fullName: string;
begin
  // Only process Ammo records
  if Signature(e) <> 'AMMO' then
    Exit;

  // Get the name of the file currently being processed
  currentFile := GetFileName(GetFile(e));

  // Print the header for visual organization in the Messages tab
  if currentFile <> LastFileName then begin
    AddMessage('// ' + currentFile);
    LastFileName := currentFile;
  end;

  // Get the full 8-digit Hex FormID and extract the Last 3 characters
  fullID := IntToHex(FixedFormID(e), 8);
  lastThree := Copy(fullID, 6, 3);
  
  // Get the EditorID and the Full Name
  edID := EditorID(e);
  fullName := GetElementEditValues(e, 'FULL');

  // Output format: PluginName|Last3,EditorID,FullName
  AddMessage(Format('%s|%s,%s,%s', [currentFile, lastThree, edID, fullName]));
end;

end.
