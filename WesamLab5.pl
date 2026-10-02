% ============================================================
%  ARTI 303 - Lab 5  |  Working with Rules
%  Name: Wesam Kamal Sanbo
%  The Simpsons Family Tree
% ============================================================

% --- Facts: male ---
male(abraham).
male(clancy).
male(herb).
male(homer).
male(bart).

% --- Facts: female ---
female(mona).
female(jackie).
female(marge).
female(patty).
female(selma).
female(lisa).
female(maggie).
female(ling).

% --- Facts: parent ---
% Abraham & Mona are parents of Homer and Herb
parent(abraham, homer).
parent(abraham, herb).
parent(mona, homer).
parent(mona, herb).

% Clancy & Jackie are parents of Marge, Patty, Selma
parent(clancy, marge).
parent(clancy, patty).
parent(clancy, selma).
parent(jackie, marge).
parent(jackie, patty).
parent(jackie, selma).

% Homer & Marge are parents of Bart, Lisa, Maggie
parent(homer, bart).
parent(homer, lisa).
parent(homer, maggie).
parent(marge, bart).
parent(marge, lisa).
parent(marge, maggie).

% Selma is parent of Ling
parent(selma, ling).

% ============================================================
%  RULES
% ============================================================

% father(F, C): F is the father of C
father(F, C) :-
    male(F),
    parent(F, C).

% mother(M, C): M is the mother of C
mother(M, C) :-
    female(M),
    parent(M, C).

% son(S, P): S is the son of P
son(S, P) :-
    male(S),
    parent(P, S).

% daughter(D, P): D is the daughter of P
daughter(D, P) :-
    female(D),
    parent(P, D).

% brother(B, S): B is the brother of S
brother(B, S) :-
    male(B),
    parent(P, B),
    parent(P, S),
    B \= S.

% sister(S, P): S is the sister of P
sister(S, P) :-
    female(S),
    parent(X, S),
    parent(X, P),
    S \= P.

% grandfather(G, C): G is the grandfather of C
grandfather(G, C) :-
    male(G),
    parent(G, P),
    parent(P, C).

% aunt(A, C): A is the aunt of C
% A is female, A is a sibling of C's parent
aunt(A, C) :-
    female(A),
    parent(P, C),
    parent(G, A),
    parent(G, P),
    A \= P.

% uncle(U, C): U is the uncle of C
uncle(U, C) :-
    male(U),
    parent(P, C),
    parent(G, U),
    parent(G, P),
    U \= P.

% cousin(C1, C2): C1 is a cousin of C2
% C1's parent and C2's parent are siblings
cousin(C1, C2) :-
    parent(P1, C1),
    parent(P2, C2),
    parent(G, P1),
    parent(G, P2),
    P1 \= P2,
    C1 \= C2.

% ancestor(A, D): A is an ancestor of D
% Base case: A is a parent of D
ancestor(A, D) :-
    parent(A, D).
% Recursive case: A is an ancestor of D if A is parent of someone
% who is an ancestor of D
ancestor(A, D) :-
    parent(A, X),
    ancestor(X, D).