%----------------------------------------------------------
%FACTS

flight(6711,815,1005,bos,ord).
flight(211,700,830,lga,ord).
flight(203,730,1335,lga,lax).
flight(92221,800,920,ewr,ord).
flight(2134,930,1345,ord,sfo).
flight(954,1655,1800,phx,dfw).
flight(1176,1430,1545,sfo,lax).
flight(205,1630,2211,lax,lga).
flight(2013,730,1335,lga,phx).
flight(2018,730,1335,phx, lga).
flight(111,645,745,lga,bos).
flight(222,750,845,bos,ewr).

%----------------------------------------------------------
%RULES
/*

*/

%Does the flight from ORD to SFO depart after the flight from EWR to ORD lands?
%this assumes all flights happen on the same day, which is fine 
connection(X, Y, Z, W) :- 
    flight(_, A, _, X, Y),
    flight(_, _, B, Z, W),
    (A > B -> true; false).


%Does the flight from ORD to SFO depart after the flight from EWR to ORD lands?
% this has a more friendly output :) 
which_first(X, Y, Z, W) :- 
    (   connection(X, Y, Z, W) -> 
    write("flight "),
    write(X), write(" to "), write(Y),
    write(" departs after "),    
    write(Z), write(" to "), write(W), write(" lands"); 
    write("flight "),
    write(X), write(" to "), write(Y),
    write(" departs before "),    
    write(Z), write(" to "), write(W), write(" lands")    
    ).


%----------------------------------------------------------


%this was found online,
%https://stackoverflow.com/questions/69989726/slicing-the-list-in-prolog-between-two-indexes
slice(L, From, To, R):-
  length(LFrom, From),
  length([_|LTo], To),
  append(LTo, _, L),
  append(LFrom, R, LTo).

%this was the only way I know of get Arr[i] in prolog
first([E,_,_|_], E).
second([_,E,_|_], E).
third([_,_,E|_], E).


%after we have found a path we need to check it, this will go through all the 
%connecting flights and make sure they are possible to make
check_path(Start, Path):-
	%we get the length of our path 
    length(Path,Length),
    %if the length is more than two we need to check that connections can be made
    (Length - Start > 2 ->
    End is Start + 4,
    %we get the first two connecting flights
    slice(Path, Start, End, R),
    %we get the cities they start and end at 
    first(R, St),
    second(R, Mid),
    third(R, Last),
    %now we actually check that the flights are able to connect
    connection(Mid, Last, St, Mid),
    %we move our start place one up
    Newstart is Start + 1,
    %and try again    
    check_path(Newstart, Path)
    ;
    %here the length was two cities so just one flight and no need to check
    true).

%I borrowed heavily from this 
%https://stackoverflow.com/questions/3901250/traversing-a-graph-with-possible-loops-and-returning-the-path-in-prolog

%so this just makes it easier to run the program 
path(Start, End, Path) :-
    %gives us an empty acculmator
    path(Start, End, [], Path).

%this finds our last flight and checks that all flight connect
path(Now, End, Acc, Path) :-
    %looks for the next airport 
    flight(_,_,_,Now, Mid),
    %did we reach the end??
    Mid == End,
    %if so just add whever we are and the end to path, and return path
    append(Acc, [Now, End], Path),
    %now that we have the complete path in city order we can check to make sure the 
    %flights are able to connect 
    check_path(0, Path).
	
%this finds all flight except the last one	
path(Now, End, Acc, Path) :-
    %looks for the next airport
    flight(_,_,_,Now, Mid),
    %Checks that the next aorport is not already in our path 
    \+ member(Mid, Acc),
    %if it's not it gets added to path, this is enough to stop infinite loops :),
    append(Acc, [Now], X),
    %recursively calls itself from our new starting point 
    path(Mid, End, X, Path).


%----------------------------------------------------------

%Where does the flight from PHX go?
where(X) :-   
    flight(_, _, _, X, A),
    write(X),
    write(" goes to "),
    write(A),nl.
%if none
where(X) :-   
    \+(flight(_, _, _, X, _)),
    write(X),
    write(" goes to NOWHERE!!!"),nl.

%----------------------------------------------------------

%Is there a flight to PHX?
to(X) :-   
    flight(_, _, _, Y, X),
    write(Y),
    write(" goes to "),
    write(X),nl.

to(X) :-   
    \+(flight(_, _, _, _, X)),
    write("Nobody goes to "),
    write(X),nl.

%----------------------------------------------------------

%What time is does the flight from BOS land?
time(X) :-   
    flight(_, _, Y, X, _),
    write("The flight from "), write(X), write(" lands at "),
    write(Y),nl.

%----------------------------------------------------------

%What time do the flights to ORD arrive?
arrives(X):- 
    flight(_, _, A, _, X),
    write("Flights to "), write(X), write(" arrive at "), write(A),nl.

%----------------------------------------------------------

