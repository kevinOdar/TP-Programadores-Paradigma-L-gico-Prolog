% Entrega 1

sabeProgramarEn(fernando,cobol).
sabeProgramarEn(fernando,visualBasic).
sabeProgramarEn(fernando,java).
sabeProgramarEn(julieta,java).
sabeProgramarEn(marcos,java).
sabeProgramarEn(santiago,java).
sabeProgramarEn(santiago,ecmaScript).
roles(fernando,analistaFuncional).
roles(andres,projectLeader).
roles(Alguien,programador):-
  sabeProgramarEn(Alguien,_).

/* Prueba
roles(marcos,projectLeader).
roles(santiago,projectLeader)
roles(julieta,projectLeader)*/


/*
Se pide que escriba las consultas necesarias para determinar:
a. ¿Qué lenguajes sabe programar Fernando?
a) sabeProgramarEn(fernando,LenguajeQueSabeProgramar).
b. ¿Quiénes programan en Java?
b) sabeProgramarEn(ElQueSabeJava,java).
c. ¿Existe algún programador de Assembler?
c) sabeProgramarEn(_,assembler).
d. Fernando, ¿es programador?
d) roles(fernando, programador).
e. ¿Qué roles cumple Fernando?
e) roles(fernando,rolQueCumple).
f. ¿Quiénes son programadores?
f) roles(Alguien,programador).
g. ¿Existe algún project leader?
g) roles(_,projectLeader).
*/

% Entrega 2

lenguajeEnElQueSeConstruyoElProyecto(sumatra, java).
lenguajeEnElQueSeConstruyoElProyecto(sumatra, net).
lenguajeEnElQueSeConstruyoElProyecto(prometeus, cobol).

proyectoEnElCualTrabaja(fernando, prometeus).
proyectoEnElCualTrabaja(santiago, prometeus).
proyectoEnElCualTrabaja(julieta, sumatra).
proyectoEnElCualTrabaja(marcos, sumatra).
proyectoEnElCualTrabaja(andres, sumatra).

estaCorrectamenteAsignada(Persona, Proyecto):-
	proyectoEnElCualTrabaja(Persona, Proyecto),
	esAnalistaOProyectManagerOLoOtro(Persona, Proyecto).

esAnalistaOProyectManagerOLoOtro(Persona, _):-
	roles(Persona,projectLeader).
esAnalistaOProyectManagerOLoOtro(Persona, _):-
	roles(Persona,analistaFuncional).
esAnalistaOProyectManagerOLoOtro(Persona, Proyecto):-
	sabeProgramarEn(Persona, LenguajeQueSabeProgramar),
	lenguajeEnElQueSeConstruyoElProyecto(Proyecto, LenguajeQueSabeProgramar).

elProyectoEstaBienDefinido(Proyecto):-
	proyectoEnElCualTrabaja(_, Proyecto),
	forall(proyectoEnElCualTrabaja(Persona, Proyecto), estaCorrectamenteAsignada(Persona, Proyecto)),
	soloHayUnproject(Proyecto).
soloHayUnproject(Proyecto):-
	proyectoEnElCualTrabaja(Persona, Proyecto),
	roles(Persona,projectLeader),
	not(hayMasDe1ProjectM(Proyecto)).

hayMasDe1ProjectM(Proyecto):-
	proyectoEnElCualTrabaja(Persona, Proyecto),
	roles(Persona,projectLeader),
	proyectoEnElCualTrabaja(OtraPersona, Proyecto),
	roles(OtraPersona,projectLeader),
	Persona\=OtraPersona.



/*
Por ejemplo, el proyecto “Prometeus” está mal definido, porque trabaja Santiago que
no sabe COBOL, y no tiene project leader. En cambio el proyecto “Sumatra” está bien
definido, ya que todos están bien asignados, y hay un único project leader. El
predicado debe ser totalmente inversible.
-not(elProyectoEstaBienDefinido(prometeus)).
-elProyectoEstaBienDefinido(sumatra).

*/

/* Casos de prueba
Punto 2: Proyectos

1. Al consultar los lenguajes del proyecto Sumatra deben estar en el
universo de soluciones los lenguajes Java y .Net
-lenguajeEnElQueSeConstruyoElProyecto(sumatra, Lenguaje).

2. No es cierto que haya otro lenguaje distinto de COBOL para el
proyecto Prometeus

-not((lenguajeEnElQueSeConstruyoElProyecto(prometeus,Lenguaje),Lenguaje
\=cobol)).

3. Fernando trabaja en el proyecto Prometeus
-proyectoEnElCualTrabaja(fernando, prometeus).


4.Santiago trabaja en el proyecto Prometeus
-proyectoEnElCualTrabaja(santiago, prometeus).


5. El universo de personas del proyecto Sumatra se compone de Julieta,
Marcos y Andrés.
-proyectoEnElCualTrabaja(Persona, sumatra).


6. En el proyecto Sumatra Julieta, Marcos y Andrés
están bien asignados.
-estaCorrectamenteAsignada(julieta, sumatra).
-estaCorrectamenteAsignada(marcos, sumatra).
-estaCorrectamenteAsignada(andres, sumatra).


7. En el proyecto Prometeus solo Fernando está bien asignado.
-estaCorrectamenteAsignada(Persona, prometeus).

8. El universo de personas bien asignadas a algún
proyecto se compone de Julieta, Marcos, Andrés y Fernando
-estaCorrectamenteAsignada(Persona, _).

9. Los proyectos que tienen a alguien bien asignado es el universo
conformado por Prometeus y Sumatra.
-estaCorrectamenteAsignada(_, Proyecto).

Punto 3: Proyectos bien definidos
10. El universo de proyectos bien definidos incluye al proyecto Sumatra
-elProyectoEstaBienDefinido(Proyecto).

11. El proyecto Prometeus está mal definido
-not(elProyectoEstaBienDefinido(prometeus)).

12. El universo de proyectos mal definidos está formado por un solo proyecto:
Prometeus
-(proyectoEnElCualTrabaja(_,Proyecto),not(elProyectoEstaBienDefinido(Proyecto))).

*/

%Entrega 3

/*
Punto 4: ¿Te copás?
Sabemos que: Fernando es copado con Santiago. Santiago es copado con Julieta y
con Marcos. Julieta es copada con Andrés.
Ahora necesitamos saber si alguien le puede enseñar un lenguaje a otra persona, si
el primero conoce ese lenguaje, el segundo no lo conoce, y además:
● el primero es copado con la otra persona,
● o bien el primero es copado con alguien que sea copado con esa persona.
*/

% Punto 4

esCopado(fernando, santiago).
esCopado(santiago, julieta).
esCopado(santiago, marcos).
esCopado(julieta, andres).

lePuedeEnseniarUnLenguaje(Persona, OtraPersona, Lenguaje):-
	sabeProgramarEn(Persona, Lenguaje),
	esCopadoRecursivamente(Persona,OtraPersona),
	not(sabeProgramarEn(OtraPersona, Lenguaje)).

esCopadoRecursivamente(Persona,OtraPersona):-
	esCopado(Persona,OtraPersona).

esCopadoRecursivamente(Persona,OtraPersona):-
	esCopado(Persona,PersonaConLaQueSeCopa),
	esCopadoRecursivamente(PersonaConLaQueSeCopa, OtraPersona).

/* Por ejemplo, Fernando le puede enseñar COBOL a Andrés, porque Fernando conoce
COBOL y es copado con Santiago, que es copado con Julieta, que es copado con
Andrés.
-lePuedeEnseniarUnLenguaje(fernando, andres,cobol).
*/

/*
Punto 5: Seniority
De cada programador se sabe las tareas que hizo. Las tareas posibles son:
● Evolutiva, que puede ser simple o compleja.
● Correctiva, donde se indican la cantidad de líneas modificadas y el lenguaje
(éste no tiene ninguna relación con los lenguajes que más conoce).
● Algorítmica, donde cuentan la cantidad de líneas.

Se pide que codifique la consulta que permite saber el grado de seniority de un
programador, donde:
● Las evolutivas complejas suman 5 puntos, las simples 3.
● Las correctivas suman 4 puntos si la cantidad de líneas supera las 50, o si la
tarea requería hacerse en lenguaje Brainfuck (sí, es real el nombre).
● Las algorítmicas suman (cantidad de líneas / 10) puntos de seniority.
El predicado debe ser totalmente inversible.
*/

%Punto 5: Seniority

tarea(fernando, evolutiva(compleja)).
tarea(fernando, correctiva(8, brainfuck)).
tarea(fernando, algorítmica(150)).
tarea(marcos, algorítmica(20)).
tarea(julieta, correctiva(412, cobol)).
tarea(julieta, correctiva(21, go)).
tarea(julieta, evolutiva(simple)).

gradoDeSeniorityDeUnProgramador(Fulano, 0):-   %DEBATIR
	not(tarea(Fulano,_)).

gradoDeSeniorityDeUnProgramador(Programador, Grado):-
	roles(Programador,_),
	findall(Puntaje,(tarea(Programador, Tarea),puntuarSegunTarea(Tarea, Puntaje)), ListaDePuntajes),
	sumlist(ListaDePuntajes,Grado).

puntuarSegunTarea(evolutiva(compleja), 5).
puntuarSegunTarea(evolutiva(simple), 3).

puntuarSegunTarea(correctiva(_,brainfuck),4).
puntuarSegunTarea(correctiva(CantLineas,_),4):-
       CantLineas>50.
puntuarSegunTarea(algorítmica(CantLineas),Puntaje):-
       Puntaje is CantLineas/10.


/*
Casos de prueba

Sobre el punto 4: ¿Te copás?
1. Saber si Fernando es copado con Santiago. Esto es correcto.
esCopado(fernando, santiago).

2. Fernando no es copado con Julieta.
not(esCopado(fernando, julieta)).

3. Fernando le puede enseñar COBOL a Santiago, Julieta, Marcos y Andrés.
lePuedeEnseniarUnLenguaje(fernando, santiago, cobol).
lePuedeEnseniarUnLenguaje(fernando, julieta, cobol).
lePuedeEnseniarUnLenguaje(fernando, marcos, cobol).
lePuedeEnseniarUnLenguaje(fernando, andres, cobol).

4. Es falso que Fernando le puede enseñar Haskell a alguien.
not(lePuedeEnseniarUnLenguaje(fernando, _, haskell)).

5. A Andrés le pueden enseñar Java Fernando, Julieta y Santiago.
lePuedeEnseniarUnLenguaje(fernando, andres, java).
lePuedeEnseniarUnLenguaje(julieta, andres, java).
lePuedeEnseniarUnLenguaje(santiago, andres, java).

6. Fernando puede enseñarle COBOL, Visual Basic y Java a alguna persona.
lePuedeEnseniarUnLenguaje(fernando, _, cobol).
lePuedeEnseniarUnLenguaje(fernando, _, visualBasic).
lePuedeEnseniarUnLenguaje(fernando, _, java).

7. Marcos no puede enseñar nada a nadie (¡¡perdón Marcos!!).
not(lePuedeEnseniarUnLenguaje(marcos, _, _)).

Sobre el Punto 5: Seniority
1. Fernando tiene 24 de seniority.
gradoDeSeniorityDeUnProgramador(fernando,24).

2. Se debe poder consultar quiénes tienen grado 0 de seniority, que es la lista
compuesta por Santiago y Andrés.
gradoDeSeniorityDeUnProgramador(Fulano, 0). DEBATIR

3. Julieta no tiene seniority 6.
not(gradoDeSeniorityDeUnProgramador(julieta, 6)).

4. Julieta tiene seniority 7.
gradoDeSeniorityDeUnProgramador(julieta, 7).
*/
