unit BinaryTree;

{$mode objfpc}{$H+}{$J-}

interface

uses
  Classes, SysUtils;

type
  PPNode = ^PNode;
  PNode = ^TNode;
  TNode = record
    Value: Pointer;
    Left: PNode;
    Right: PNode;
  end;

  TComparisonResult = (LessThan, Equal, GreaterThan);

  TCompareFunction = function(Item1, Item2: Pointer): TComparisonResult;

  function BinaryTreeCreateNode(Value: Pointer): PNode;
  function BinaryTreeAdd(Root: PNode; Value: Pointer; CompareFunction: TCompareFunction): PNode;
  function BinaryTreeToString(Root: PNode): String;


implementation

function BinaryTreeCreateNode(Value: Pointer): PNode;
begin
  New(Result);
  if Result = Nil then
    Exit;

  Result^.Left := Nil;
  Result^.Right := Nil;
  Result^.Value := Value;
end;

function BinaryTreeAdd(Root: PNode; Value: Pointer;
  CompareFunction: TCompareFunction): PNode;
begin
  if Root = Nil then
  begin
    Root := BinaryTreeCreateNode(Value);
    if Root = Nil then
    begin
      //error here
      Exit(Root);
    end;

    Exit(Root);

  end;

  if CompareFunction(Value, Root^.Value) in [LessThan, Equal] then
  begin
    Result := BinaryTreeAdd(Root^.Left, Value, CompareFunction);
    Root^.Left := Result;
  end
  else
  begin
    Result := BinaryTreeAdd(Root^.Right, Value, CompareFunction);
    Root^.Right := Result;
  end;
end;

function BinaryTreeToString(Root: PNode): String;
var
  Value: Longint;
begin
  if Root = Nil then
  begin
    Exit('');
  end;
  Value := PLongint(Root^.Value)^;
  Result := '{Value:' + IntToStr(Value) + ',';
  Result := Result + 'Left:' + BinaryTreeToString(Root^.Left) + ',';
  Result := Result + 'Right:' + BinaryTreeToString(Root^.Right) + '}';

end;

end.

