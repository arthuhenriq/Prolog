%Base de Fatos

% Definicao de continentes

continente(asia).
continente(america).
continente(europa).
continente(africa).
continente(antartica).
continente(oceania).

% Definicao do pais,seu continente e sua populacao

pais(portugal,europa,10).
pais(espanha,europa,46).
pais(franca,europa,65).
pais(belgica,europa,11).
pais(alemanha,europa,83).
pais(holanda,europa,17).
pais(eua,america,330).
pais(brasil,america,215).
pais(china,asia,1412).
pais(mongolia,asia,3).
pais(bolivia,america,12).
pais(argentina,america,46).
pais(colombia,america,52).
pais(guianafrancesa,america,1).
pais(guiana,america,1).
pais(paraguai,america,7).
pais(uruguai,america,3).
pais(peru,america,34).
pais(suriname,america,1).
pais(venezuela,america,28).
pais(novazelandia,oceania,5).
pais(noruega,europa,6).
pais(japao,asia,126).
pais(russia,asia,144).
pais(filipinas,asia,114).
pais(coreiadosul,asia,52).
pais(coreiadonorte,asia,26).


% Definicao das fronteiras de um pais

fronteira(portugal,espanha).
fronteira(franca,espanha).
fronteira(franca,belgica).
fronteira(belgica,alemanha).
fronteira(belgica,holanda).
fronteira(alemanha,holanda).
fronteira(alemanha,franca).
fronteira(china,mongolia).
fronteira(brasil,argentina).
fronteira(brasil,bolivia).
fronteira(brasil,colombia).
fronteira(brasil,guianafrancesa).
fronteira(brasil,guiana).
fronteira(brasil,paraguai).
fronteira(brasil,uruguai).
fronteira(brasil,peru).
fronteira(brasil,suriname).
fronteira(brasil,venezuela).
fronteira(japao,coreiadosul).
fronteira(japao,coreiadonorte).
fronteira(japao,filipinas).
fronteira(japao,china).
fronteira(japao,russia).

% Letra a

junto(X,Y) :- fronteira(X,Y).

% Letra b

paises_continente(L,Y) :- findall(X, pais(X,Y,_), L).

% Letra c

paises_grandes(L,Y) :- findall(X, (pais(X,Y,Z) , Z > 100), L).

%extra
paises_medios(L,Y) :- findall(X, (pais(X,Y,Z) , Z > 50, Z < 100), L).

paises_pequenos(L,Y) :- findall(X, (pais(X,Y,Z) , Z < 50), L).
