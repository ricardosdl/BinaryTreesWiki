{$mode objfpc}{$H+}{$J-}
program BinaryTreesWiki;

uses BinaryTree;

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
begin

  SetLength(MyArray, 5);

  MyArray[0] := 4;
  MyArray[1] := 4;
  MyArray[2] := 1;
  MyArray[3] := 2;
  MyArray[4] := 5;

  Root := BinaryTreeCreateNode(@MyArray[0]);
  BinaryTreeAdd(Root, @MyArray[1], @CompareLongints);
  BinaryTreeAdd(Root, @MyArray[2], @CompareLongints);
  BinaryTreeAdd(Root, @MyArray[3], @CompareLongints);
  BinaryTreeAdd(Root, @MyArray[4], @CompareLongints);

  WriteLn(BinaryTreeToString(Root));

  ReadLn;



end.

