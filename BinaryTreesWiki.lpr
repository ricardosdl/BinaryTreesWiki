{$mode objfpc}{$H+}{$J-}
program BinaryTreesWiki;

uses Classes, sysutils, BinaryTree;

function CompareLongints(Longint1, Longint2: Pointer): TComparisonResult;
begin
  if PLongint(LongInt1)^ < PLongint(Longint2)^ then
    Result := LessThan
  else if PLongint(LongInt1)^ = PLongint(Longint2)^ then
    Result := Equal
  else
    Result := GreaterThan;
end;

var
  Root: PNode;
  MyArray: array of LongInt;
  i: Longint;
  Structure: TBits;
  Data: TFPList;
begin

  Structure := TBits.Create();
  Data := TFPList.Create();

  Randomize;

  SetLength(MyArray, 10);

  for i := Low(MyArray) to High(MyArray) do
  begin
    MyArray[i] := Random(10);
  end;

  Root := BinaryTreeCreateNode(@MyArray[0]);
  for i := Low(MyArray) + 1 to High(MyArray) do
  begin
    BinaryTreeAdd(Root, @MyArray[i], @CompareLongints);
  end;

  WriteLn(BinaryTreeToString(Root));

  BinaryTreeEncode(Root, Structure, Data);

  WriteLn('Structure size:', Structure.Size);
  WriteLn('Data size:', Data.Count);


  ReadLn;

  BinaryTreeDestroy(Root);
  FreeAndNil(Structure);
  FreeAndNil(Data);



end.

