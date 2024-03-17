flight(6711,815,1005,bos,ord).
flight(211,700,830,lga,ord).
flight(203,730,1335,lga,lax).
flight(92221,800,920,ewr,ord).
flight(2134,930,1345,ord,sfo).
flight(954,1655,1800,phx,dfw).
flight(1176,1430,1545,sfo,lax).
flight(205,1630,2211,lax,lga).

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

%Is there a flight to PHX?
to(X) :-   
    flight(_, _, _, Y, X),
    write(Y),
    write(" goes to "),
    write(X),nl.

%What time is does the flight from BOS land?
to(X) :-   
    \+(flight(_, _, _, _, X)),
    write("Nobody goes to "),
    write(X),nl.

%Does the flight from ORD to SFO depart after the flight from EWR to ORD lands?
which_first(X, Y, Z, W) :- 
    flight(_, A, _, X, Y),
    flight(_, B, _, Z, W),
    (   A > B -> true; false).

%What time do the flights to ORD arrive?
%flight(_, _, A, _, ord)

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
    path(P, Y),
   	write('part 2 newest start= '), write(P), write(' ------ '),nl,
	write('part 2 newest end= '), write(Y), write(' ------ '),nl.
%so you start at the end, get all incoming flights check incoming flights of all of them...
%keep going untill when... how do you stop loops... when you go back to yourself 


%so if I did this is a language i know... might not be worth it at the moment 

%i mean in sql you could just keep joing tables on arrival and departure... until nothing changes??
% and then what look at all the very end points not sure how that would be done exactly 
%similar for I what I did with david but not exactly the same.... should probably let 
% it be for the moment 