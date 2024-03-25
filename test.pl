%----------------------------------------------------------
%FACTS

flight(6711,815,1005,bos,ord).
flight(211,700,830,lga,ord).
%flight(203,730,1335,lga,lax).
flight(92221,800,920,ewr,ord).
flight(2134,930,1345,ord,sfo).
flight(954,1655,1800,phx,dfw).
flight(1176,1430,1545,sfo,lax).
%flight(205,1630,2211,lax,lga).
%flight(2013,730,1335,lga,phx).
%flight(2018,730,1335,phx, lga).

%----------------------------------------------------------
%RULES
/*
%Does the flight from ORD to SFO depart after the flight from EWR to ORD lands?
which_first(X, Y, Z, W) :- 
    flight(_, A, _, X, Y),
    flight(_, _, B, Z, W),
    (   A > B -> 
    write("flight "),
    write(X), write(" to "), write(Y),
    write(" departs after "),    
    write(Z), write(" to "), write(W), write(" lands"); 
    write("flight "),
    write(X), write(" to "), write(Y),
    write(" departs before "),    
    write(Z), write(" to "), write(W), write(" lands")).
*/

%Does the flight from ORD to SFO depart after the flight from EWR to ORD lands?
%this assumes all flights happen on the same day, which is fine 
connection(X, Y, Z, W) :- 
    flight(_, A, _, X, Y),
    flight(_, _, B, Z, W),
    (A > B -> true; false).


%----------------------------------------------------------

%https://stackoverflow.com/questions/3901250/traversing-a-graph-with-possible-loops-and-returning-the-path-in-prolog
%so this gets me a path no problem



/*
%this sees if our next stop is the end 
path(Now, End, Acc, Path) :-
    %looks for the next airport 
    flight(_,_,_,Now, Mid),
    %did we reach the end??
    Mid == End,
    %if so just add whever we are and the end to path, and return path
    append(Acc, [Now, End], Path).
	%maybe here I iterate through path??
	%so I would seen path to a function that would go through three items at a time and 
	%make sure they all made the connections?? that sounds right 
%https://www.swi-prolog.org/pldoc/man?predicate=length/2
%https://stackoverflow.com/questions/69989726/slicing-the-list-in-prolog-between-two-indexes
*/

slice(L, From, To, R):-
  length(LFrom, From),
  %write(LFrom),nl,  
  length([_|LTo], To),
  append(LTo, _, L),
  %write('----------'),nl,
  %write(L),nl,
  %write(LTo),nl,
  %write(LFrom),nl,  
  %write('----------'),nl,
  append(LFrom, R, LTo).

first([E,_,_|_], E). %:-
    %write('in first'),nl,
    %write(E).
second([_,E,_|_], E):-
   write('in 2'),nl,
    write(E).
third([_,_,E|_], E) :-
	write('in 3'),nl,    
	write(E).

check_path(Start, Path):-
    %write(Start),nl,
	%write(Path),nl,
    length(Path,Length),nl,
    %write(Length),nl,
    (Length - Start > 2 ->
    End is Start + 4,
    slice(Path, Start, End, R),
    write("slice"),nl,
    write(R),nl,
    write("1st"),nl,
    first(R, St),
    write(St),nl,
    second(R, Mid),nl,
    write(Mid),nl,
    third(R, Last),nl,
    write(Last),nl,
    connection(Mid, Last, St, Mid),
    Newstart is Start + 1,
    check_path(Newstart, Path)
    ;
    %write(F),nl;

    true).

%so this just makes it easier to run the program 
path(Start, End, Path) :-
    %gives us an empty acculmator
    path(Start, End, [], Path).

path(Now, End, Acc, Path) :-
    %looks for the next airport 
    flight(_,_,_,Now, Mid),
    %did we reach the end??
    Mid == End,
    %if so just add whever we are and the end to path, and return path
    append(Acc, [Now, End], Path),
    check_path(0, Path).
	%maybe here I iterate through path??
	%so I would seen path to a function that would go through three items at a time and 
	%make sure they all made the connections?? that sounds right 
%https://www.swi-prolog.org/pldoc/man?predicate=length/2
%https://stackoverflow.com/questions/69989726/slicing-the-list-in-prolog-between-two-indexes
	
path(Now, End, Acc, Path) :-
    %looks for the next airport
    flight(_,_,_,Now, Mid),
    %Checks that the next aorport is not already in our path 
    \+ member(Mid, Acc),
   %checking to make sure you can make the connection, without waiting for the next day 
%    connection(Mid, End, Now, Mid), that does not work 
    %if it's not it gets added to path, this is enough to stop infinite loops :),
    append(Acc, [Now], X),
%    write([Now|Acc]),nl,
    %write([X]),nl,
    %recursively calls itself from our new starting point 
    path(Mid, End, X, Path).




%so it gets path, it makes sure there are at least three more items till the end 
%it gets those three items, it sends them in the right order to connections
%then calls itself recursively to check on the next three... how does it stop we need
%an if else somewhere

%findall(Path, path(Start,End,Path), Paths).

%attempting the last questiion so this from teh book and kind works 
/*
go(X,X, T). 
go(X,Y,T):- flight(_,_,_,X,Z), legal(Z,T), go(Z,Y, [Z|T]), write(T).

legal(X, []).
legal(X, [H|T]):- \+X = H, legal(X,T).


go(X,X, T). 
go(X,Y,T):- flight(_,_,_,X,Z), legal(Z,T), go(Z,Y, [Z|T]), write(T).

legal(X, []).
legal(X, [H|T]):- \+X = H, legal(X,T).
*/

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

%so this sort of works but it pretty much luck 
predecessor(X, Z) :- flight(_, _, _, X, Z).
%kind of
predecessor(X, Z) :- flight(_, _, _, X, Y),predecessor(Y, Z),!.


%----------------------------------------------------------

/*
%does not work... 
%so we found it, but stops at the first one 
predecessor(X, Y, Z) :- write("1"),nl,flight(_, _, _, X, Y)!.
%we got back to the beginning, think it also stops on the  
predecessor(X, Y, Z) :- write("2"),nl,flight(_, _, _, Y, _)!.

%we keep looking??
predecessor(X, Y, Z) :- write("3"),nl,flight(_, _, _, X, Z),predecessor(Z, Y, P).
*/


%----------------------------------------------------------


/*
%What are all the ways to get from LGA to LAX?
% so super easy to check if there is a dirrect path 
path(X, Z) :- write('part 1 '),nl, flight(_, _, _, X, Z).
%if no direct path need to check from start flight or end flight... i would say from end flight 
%so we get the 
path(X, Z) :- %write('part 2 start= '), write(X),nl, write(' ----- '), 
    %so look for wher it starts
    flight(_, _, _, Y, Z),
    %write('part 2 new start= '), write(Y), write(' ----- '),nl,
	%then try and look for where those start 
    !,path(P, Y),
   	write('part 2 newest start= '), write(P), write(' ------ '),nl,
	write('part 2 newest end= '), write(Y), write(' ------ '),nl.
%so you start at the end, get all incoming flights check incoming flights of all of them...
%keep going untill when... how do you stop loops... when you go back to yourself 

*/



%------------------------------------------------------------------------------------


%where does F1 and F2 come from???
fib(0, 0) :- 
    write("in 0,0 "),nl,
    !.
fib(1, 1) :- 
    write("in 1,1 "),nl,!.
fib(N,F):-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fib(N1, F1),
    fib(N2, F2),
    write("N1 = "),
    write(N1),nl,
    write("F1 = "),
    write(F1),nl,
    write("N2 = "),
    write(N2),nl,
    write("F2 = "),
    write(F2),nl,
    write('-------------------------------------'),nl,
    F is F1 + F2,
	write("F = "),
    write(F),nl,
	write('-------------------------------------'),nl.
