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

  function BinaryTreeInit(Value: Pointer): PNode;
  function BinaryTreeAdd(Root: PNode; Value: Pointer; CompareFunction: TCompareFunction): Boolean;
  procedure PrintNode(Root: PNode);


implementation

function BinaryTreeInit(Value: Pointer): PNode;
begin
  New(Result);
  if Result = Nil then
    Exit;

  Result^.Left := Nil;
  Result^.Right := Nil;
  Result^.Value := Value;
end;

function BinaryTreeAdd(Root: PNode; Value: Pointer;
  CompareFunction: TCompareFunction): Boolean;
begin
  if Root = Nil then
  begin
    Root := BinaryTreeInit(Value);
    if Root = Nil then
    begin
      //error here
      Exit(False);
    end;

    Exit(True);

  end;

  if CompareFunction(Root^.Value, Value) in [LessThan, Equal] then
    Result := BinaryTreeAdd(Root^.Left, Value, CompareFunction)
  else
    Result := BinaryTreeAdd(Root^.Right, Value, CompareFunction);
end;

procedure PrintNode(Root: PNode);
begin
  Write('{Value:', Root^.Value);
end;

end.

