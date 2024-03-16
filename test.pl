flight(6711,815,1005,bos,ord).
flight(211,700,830,lga,ord).
flight(203,730,1335,lga,lax).
flight(92221,800,920,ewr,ord).
flight(2134,930,1345,ord,sfo).
flight(954,1655,1800,phx,dfw).
flight(1176,1430,1545,sfo,lax).
flight(205,1630,2211,lax,lga).

/*
Where does the flight from PHX go?

Is there a flight to PHX?

What time is does the flight from BOS land?

Does the flight from ORD to SFO depart after the flight from EWR to ORD lands?

What time do the flights to ORD arrive?

What are all the ways to get from LGA to LAX?
*/

where(X) :-   
    flight(_, _, _, X, A),
    write(X),
    write(" goes to "),
    write(A),nl.

where(X) :-   
    \+(flight(_, _, _, X, _)),
    write(X),
    write(" goes to NOWHERE!!!"),nl.


to(X) :-   
    flight(_, _, _, Y, X),
    write(Y),
    write(" goes to "),
    write(X),nl.

to(X) :-   
    \+(flight(_, _, _, _, X)),
    write("Nobody goes to "),
    write(X),nl.



which_first(X, Y, Z, W) :- 
    flight(_, A, _, X, Y),
    flight(_, B, _, Z, W),
    (   A > B -> true; false).


%arrival time
flight(_, _, A, _, ord)


/*
where(X) :-
    (   flight(_, _, _, X, A) ->  
    write(X),
    write(" goes to "),
    write(A);
    write("hhh")).
*/

%also recurion
%base case
f(0,1).
%what to do otherwise
f(A,B) :- 
    %if A is greater than zero 
      A > 0, 
    %Ax which is just a new varible is A -1 	
      Ax is A - 1,
    %get the factorial of that 
      f(Ax,Bx), 
    write('A = '), write(A),nl,
    write('Ax = '), write(Ax),nl,
    %B will be ???
    write('Bx = '), write(Bx),nl,
      B is A * Bx.



%recursion
parent(pam,bob).
parent(tom,bob).
parent(tom,liz).
parent(bob,ann).
parent(bob,pat).
parent(pat,jim).
parent(bob,peter).
parent(peter,jim).

predecessor(X, Z) :- write('part 1 '),nl, parent(X, Z).
%so get kids, then ask for kids kids?? I think that is what is happening, is this like searching a tree 
predecessor(X, Z) :- write('part 2 X= '), write(X),nl, write(' ----- '),parent(X, Y),
    write('part 2 Y= '), write(Y), write(' ----- '),nl,
    predecessor(Y, Z),
   	write('part 2 Z= '), write(Z), write(' ------ '),nl.





/*
name_age(alice, 20).
name_age(bob, 30).
name_age(eve, 40).
name_age(mallory, 30).

is_older(X, Y) :- 
    name_age(X,Z),
    name_age(Y,W),
    (   Z > W -> true; false).


personalized_greeting :- 
    write('Enter your name: '),
    nl,
    read(X),
    write('Hello '),
    write(X).
    
 */
