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