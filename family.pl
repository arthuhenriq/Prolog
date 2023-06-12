man(arthur).
man(waldir).
man(satiro).
man(selio).
man(pedro).
man(lucas).
man(jonas).
man(tales).
man(maciel).
man(douglas).

woman(laura).
woman(diana).
woman(ana).
woman(tais).
woman(alexa).
woman(ingrid).
woman(samara).
woman(amanda).
woman(beatriz).
woman(giovana).
woman(amora).

parent(satiro, waldir).
parent(satiro, selio).
parent(satiro, lucas).
parent(satiro, maciel).
parent(satiro, giovana).
parent(laura, waldir).
parent(laura, selio).
parent(laura, lucas).
parent(laura, giovana).
parent(laura,jonas).
parent(diana,amanda).

parent(waldir, arthur).
parent(amanda, arthur).

parent(selio, pedro).
parent(ingrid, pedro).

parent(lucas, alexa).
parent(samara, alexa).
parent(samara, beatriz).

parent(amora, ana).
parent(jonas, ana).

parent(ana, tais).
parent(tales,tais).

married(arthur,laura).
married(lucas,samara).
married(douglas,giovana).
married(selio,ingrid).

% My Own Grandfather Rule

my_own_grandpa(X) :- man(X), married(X,Z), parent(Z,W),parent(W,X).

% A lógica para ser a própria avó seria a mesma utilizada para ser o próprio avô, 
% no caso teria que adicionar um outro predicado “casamento” 
% e então trocar o predicado “man()” para o predicado “woman()”.

my_own_grandmom(X) :- woman(X), married(Z,X), parent(Z,W),parent(W,X).

% Dad Rule

father(X,Y) :- man(X) , parent(X,Y), X \= Y.

% Mother Rule

mother(X,Y) :- woman(X) , parent(X,Y), X \= Y.

% Grandfather Rule

grandfather(X,Y) :- (man(X) , findall(W, (parent(X,Z) , parent(Z,W), X\=W),ALL),list_to_set(ALL,Y),!)
    		;   (findall(W, (man(W) , parent(Z,Y) , parent(W,Z), W\=Y), ALL) , list_to_set(ALL,X),!)
    		;   (man(X) , parent(X,Z), parent(Z,Y), X \=Y,!).

% Grandmother Rule

grandmother(X,Y) :- (woman(X) , findall(W, (parent(X,Z) , parent(Z,W), X\=W),ALL),list_to_set(ALL,Y),!)
    		;   (findall(W, (woman(W) , parent(Z,Y) , parent(W,Z), W\=Y), ALL) , list_to_set(ALL,X),!)
    		;   (woman(X), parent(X,Z) , parent(Z,Y), X \=Y,!).

% Brother Rule

brother(X,Y) :- man(X) , (findall(W, ((mother(Z,X) , mother(Z,W) ; father(H,X) , father(H,W)), X\=W), ALL),
    list_to_set(ALL,Y),!) ; (parent(H,X) , parent(H,Y) , X\=Y,!).

% Sister Rule

sister(X,Y) :- woman(X) , (findall(W, ((mother(Z,X) , mother(Z,W) ; father(H,X) , father(H,W)), X\=W), ALL),
    list_to_set(ALL,Y),!) ; (parent(H,X) , parent(H,Y) , X\=Y,!).

% Uncle Rule

uncle(X,Y) :- (findall(W, (man(W) , parent(Z,Y) , brother(W,Z) , W\=Y), ALL)  , list_to_set(ALL,X),!)
    		; (man(X) , findall(W, (parent(Z,W) , brother(X,Z) , W\=X), ALL)  , list_to_set(ALL,Y),!)
    		; (man(X) , parent(Z,Y) , brother(X,Z) , !)
    		; (man(X) , married(X,W) , aunt(W,Y) , !).

% Aunt Rule

aunt(X,Y) :- (findall(W, (woman(W) , parent(Z,Y) , sister(W,Z)  , W\=Y), ALL)  , list_to_set(ALL,X),!)
    		; (woman(X) , findall(W, (parent(Z,W) , sister(X,Z)  , W\=X), ALL)  , list_to_set(ALL,Y),!)
    		; (woman(X) , parent(Z,Y) , sister(X,Z) ,!)
    		; (woman(X) , married(W,X) , uncle(W,Y) ,!).

% Cousin Man Rule

cousin_man(X,Y) :- man(X) , (parent(Z,X) , findall(W, ((uncle(Z,W) ; aunt(Z,W)) , W\=X), ALL) , list_to_set(ALL,Y),!)
    		;   (parent(W,X), (uncle(W,Y); aunt(W,Y)), X \= Y,!).

% Cousin Woman Rule

cousin_woman(X,Y) :- woman(X) , (parent(Z,X) , findall(W, ((uncle(Z,W) ; aunt(Z,W)) , W\=X), ALL) , list_to_set(ALL,Y),!)
   			;	(parent(W,X) , (uncle(W,Y) ; aunt(W,Y)), X \= Y,!).