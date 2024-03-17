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

%----------------------------------------------------------
%RULES

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
