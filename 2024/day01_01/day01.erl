-module(day01).

-export([totalDistance/0]).

totalDistance() ->
  {_, File} = file:read_file("./day01_input.txt"),
  Coordinates = binary:split(File, <<"\r\n">>, [trim_all, global]),
  SortedLists = sortList(Coordinates, [], []),
  [Head, Tail] = SortedLists,
  getDistance(lists:sort(Head), lists:sort(Tail), 0).

sortList([], AccL, AccR) ->
  Acc = [AccL, AccR],
  Acc;
sortList(UnsortList, AccL, AccR) ->
  Delimiter = <<" ">>,
  [Head | Tail] = UnsortList,
  [Start, End] = binary:split(Head, Delimiter, [trim_all, global]),
  sortList(Tail, AccL ++ [binary_to_integer(Start)], AccR ++ [binary_to_integer(End)]).

getDistance([],[], Acc) ->
  Acc;
getDistance(Start,End, Acc) ->
  [HeadL|TailL] = lists:sort(Start),
  [HeadR|TailR] = lists:sort(End),
  getDistance(TailL, TailR, Acc + abs(HeadL - HeadR)).
