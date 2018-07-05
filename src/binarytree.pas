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
  procedure BinaryTreeDestroy(Root: PNode);
  function BinaryTreeAdd(Root: PNode; Value: Pointer; CompareFunction: TCompareFunction): PNode;
  function BinaryTreeToString(Root: PNode): String;
  procedure BinaryTreeEncode(Node: PNode; Structure: TBits; Data: TFPList);
  function BinaryTreeDecode(Structure: TBits; Data: TFPList; CurrentStructureIndex: Longint = 0): PNode;


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

procedure BinaryTreeDestroy(Root: PNode);
begin
  if (Root^.Left = Nil) and (Root^.Right = Nil) then
  begin
    Dispose(Root);
    Exit;
  end;

  if Root^.Left <> Nil then
    BinaryTreeDestroy(Root^.Left);

  if Root^.Right <> Nil then
    BinaryTreeDestroy(Root^.Right);

  Dispose(Root);

end;

function BinaryTreeAdd(Root: PNode; Value: Pointer;
  CompareFunction: TCompareFunction): PNode;
begin
  if CompareFunction(Value, Root^.Value) in [LessThan, Equal] then
  begin
    if Root^.Left = Nil then
    begin
      Result := BinaryTreeCreateNode(Value);
      if Result = Nil then
        Exit(Result);
      Root^.Left := Result;
    end
    else
      Result := BinaryTreeAdd(Root^.Left, Value, CompareFunction);
  end
  else
  begin
    if Root^.Right = Nil then
    begin
      Result := BinaryTreeCreateNode(Value);
      if Result = Nil then
        Exit(Result);
      Root^.Right := Result;
    end
    else
      Result := BinaryTreeAdd(Root^.Right, Value, CompareFunction);
  end;
end;

function BinaryTreeToString(Root: PNode): String;
var
  Value: Longint;
begin
  if Root = Nil then
  begin
    Exit('""');
  end;
  Value := PLongint(Root^.Value)^;
  Result := '{"Value":' + IntToStr(Value) + ',';
  Result := Result + '"Left":' + BinaryTreeToString(Root^.Left) + ',';
  Result := Result + '"Right":' + BinaryTreeToString(Root^.Right) + '}';

end;

procedure BinaryTreeEncode(Node: PNode; Structure: TBits; Data: TFPList);
begin
  if Node = Nil then
    Structure.Clear(Structure.Size)
  else
  begin
    Structure.SetOn(Structure.Size);
    Data.Add(Node^.Value);
    BinaryTreeEncode(Node^.Left, Structure, Data);
    BinaryTreeEncode(Node^.Right, Structure, Data);
  end;
end;

function BinaryTreeDecode(Structure: TBits; Data: TFPList;
  CurrentStructureIndex: Longint): PNode;
var
  b: Boolean;
  Node: PNode;
  Value: Pointer;
begin
  //Structure.b;
  b := Structure.Get(CurrentStructureIndex);
  Inc(CurrentStructureIndex);
  if b then
  begin
    Value := Data.Extract(Data.First());
    Node := BinaryTreeCreateNode(Value);
    Node^.Left := BinaryTreeDecode(Structure, Data, CurrentStructureIndex);
    Inc(CurrentStructureIndex);
    Node^.Right := BinaryTreeDecode(Structure, Data, CurrentStructureIndex);
    Result := Node;
  end
  else
    Result := Nil;
end;

end.

