/*
	HW 08: Prolog basic

	Samantha Barco Mejía A01196844

*/

/*
	in_list : Take two arguments, a list and an element, and determine if the element can be found inside the list.
	H = Head, first element in the list
	T = Tail, rest of the list
	E = Element to be found
*/

%Receives the list and checks, if the first element is not the one searched for, then calls the function again only eith the tail
in_list([H|T],E) :-
	H\=E,
	in_list(T,E).

%If the condition H\=E isn't true, means we have found the element, returns true
%Ya que no entró en la función anterior, podemos asumir que H==E y quitar esa línea?
in_list([H|_],E) :-
	H == E,
	true.

%When the received list is empty or all the elements have been compared, returns false
%Tanto en esta como en la función anterior, quisiera saber si es apropiado escribir directamente true/false o debe hacerse de otra manera
in_list([],_) :-
	false.


/*
	element_at : Take as argument an index and a list, and return the element at index n of the list. Indices start at 0. 
	P = position
	H = Head, first element in the list
	T = Tail, rest of the list
	E = Element to be found
*/

%User facing function, calls the same function adding Counter 0, meaning it will analise the list from the start
%If P isn't higher than zero, the following function is called
element_at(P, [H|T], E) :-
	P @>= 0,
	element_at(P,[H|T],E,0).

%If the index is smaller than zero, we have to reverse the list and change P to a positive number (-P) minus one, since we start our search at -1 not -0
element_at(P, L, E) :-
	P @< 0,
	P1 is -P - 1,
	reverse(L,L1),
	element_at(P1,L1,E,0).

%If C is smaller than the searched position, increases the counter and keeps reading the list
element_at(P,[_|T],E,C) :-
	C @< P,
	C1 is C + 1,
	element_at(P,T,E,C1).

%If C has reached P value, means we have found the element which is H
% Es necesaria la línea de C==P o podemos asumir que cumple con esta condición basandonos en funciones anteriores
element_at(P,[H|_],H,C) :-
	C == P.

/*
	range : Take as arguments a starting and ending number, as well as an increment and a list. The list will be a collection of numbers from start to finish, with the increment specified.
	B = Begin, lower limit and first element in produced list
	E= End, upper limit
	S= Step, step at which elements will grow
	L= List, final list
	TL = Temporal List, temporal list to add new elements
	C = Count, variable to track the growth of the list elements
*/

%User facing function, calls the same function adding an empty list (to append new values) and B as first value to be added
range(B,E,S,L) :-
	range(B,E,S,L,[],B).

%If the step is positive and the upper limit hasn't been reached keeps adding elements
range(B,E,S,L,TL,C) :-
	S @> 0,
	C @=< E,	
	C1 is C + S,
	append(TL,[C],NL),
	range(B,E,S,L,NL,C1).

%If the step is negative and the lower limit hasn't been reached keeps adding elements
range(B,E,S,L,TL,C) :-
	S @< 0,
	C @>= E,	
	C1 is C + S,
	append(TL,[C],NL),
	range(B,E,S,L,NL,C1).

%If the step is positive and the counter is greater than the upper limit returns the list
range(_,E,S,TL,TL,C) :-
	S @> 0,
	C @> E.

%If the step is negative and the counter is smaller than the lower limit returns the list
range(_,E,S,TL,TL,C) :-
	S @< 0,
	C @< E.

/*
	remove_doubles: Take as argument a list, and generate a list without contiguous elements that are duplicated. 
	H = Head, first element in the list
	T = Tail, rest of the list
	R = Array to store the list without repeated elements
	TL = Temporal List, temporal list to add non-repeated elements
	NL = Temporal list of appended values
*/

%User facing function, calls the same function adding the new list without doubles and the last value added 
remove_doubles([H|T],R) :-
	remove_doubles(T,R,[H],H).

%If the user inputs an empty list, returns an empty list
remove_doubles([],[]).

%Cmpares if the actual element is the same as the last one added, keeps reading the list
remove_doubles([H|T],R,TL,V) :-
	H = V,
	remove_doubles(T,R,TL,V).

%If the actual element is different than the last one added, appends it to the list and changes the variable to compare with the following elements
remove_doubles([H|T],R,TL,V) :-
	H \= V,
	append(TL, [H],NL),
	remove_doubles(T,R,NL,H).

%If the end of the list is reached, returns the list without doubles
remove_doubles([],TL,TL,_).