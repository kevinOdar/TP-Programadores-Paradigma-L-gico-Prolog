# Trabajo práctico Paradigma Lógico - Programadores - Entrega 1

## 1 Relevamiento inicial
Queremos modelar el negocio de una consultora de sistemas, que en el relevamiento nos contó que:
* Fernando sabe programar COBOL[1], Visual Basic, y Java.
* Julieta y Marcos programan en Java.
* Aún no sabemos si Julieta programó en Go.
* Santiago programa en ECMAScript y en Java.
* Nadie programó en Assembler.        
* Fernando es analista funcional.
* Andrés es project leader pero no programa.
* Alguien es programador, si es que programa en algún lenguaje (no importa si además cumple otro rol).


## 2 Requerimientos
1. Codifique la base de conocimientos en base a lo anteriormente expuesto. En caso de no agregar nada justifique su decisión.
2. Se pide que escriba las consultas necesarias para determinar
   a. ¿Qué lenguajes sabe programar Fernando?
   b. ¿Quiénes programan en Java?
   c. ¿Existe algún programador de Assembler?
   d. Fernando, ¿es programador?
   e. ¿Qué roles cumple Fernando?
   f. ¿Quiénes son programadores?
   g. ¿Existe algún project leader?

# Trabajo práctico Paradigma Lógico - Programadores - Entrega 2

## 1 Agregados
## Punto 2: Proyectos
Un proyecto se construye en uno o más lenguajes: por ejemplo 
* el proyecto “Sumatra” necesita programarse una parte en Java y otra en .Net. 
* el proyecto “Prometeus” se hace únicamente en COBOL. 

Además sabemos en qué proyecto trabaja cada persona: por ejemplo 
* Fernando y Santiago trabajan en el proyecto “Prometeus”
* Julieta, Marcos y Andrés trabajan en el proyecto “Sumatra”. 

Se pide que 
1. Agregue los predicados que sean necesarios.
2. Queremos saber si una persona está correctamente asignada a un proyecto, esto ocurre si trabaja en ese proyecto y...
   1. programa en alguno de los lenguajes en los que se construye ese proyecto.
   2. O bien, es analista funcional.
   3. O bien, es project leader.
Resuelva cómo hacer la consulta y codifíquela.

## Punto 3: Validación de proyectos
Queremos saber si un proyecto está bien definido, esto ocurre:
* Si todos están bien asignados a ese proyecto.
* Y si además hay un solo project leader.

Por ejemplo, el proyecto “Prometeus” está mal definido, porque trabaja Santiago que no sabe COBOL, y no tiene project leader. En cambio el proyecto “Sumatra” está bien definido, ya que todos están bien asignados, y hay un único project leader. El predicado debe ser totalmente inversible.

## 2 Casos de prueba
## Punto 2: Proyectos
1. Al consultar los lenguajes del proyecto Sumatra deben estar en el universo de soluciones los lenguajes Java y .Net
2. No es cierto que haya otro lenguaje distinto de COBOL para el proyecto Prometeus
3. Fernando trabaja en el proyecto Prometeus
4. Santiago trabaja en el proyecto Prometeus
5. El universo de personas del proyecto Sumatra se compone de Julieta, Marcos y Andrés
6. En el proyecto Sumatra Julieta, Marcos y Andrés están bien asignados.
7. En el proyecto Prometeus solo Fernando está bien asignado.
8. El universo de personas bien asignadas a algún proyecto se compone de Julieta, Marcos, Andrés y Fernando
9. Los proyectos que tienen a alguien bien asignado es el universo conformado por Prometeus y Sumatra.

## Punto 3: Proyectos bien definidos
1. El universo de proyectos bien definidos incluye al proyecto Sumatra
2. El proyecto Prometeus está mal definido
3. El universo de proyectos mal definidos está formado por un solo proyecto: Prometeus

# Trabajo práctico Paradigma Lógico - Programadores - Entrega 3

## 1 Agregados
## Punto 4: ¿Te copás?
Sabemos que: Fernando es copado con Santiago. Santiago es copado con Julieta y con Marcos. Julieta es copada con Andrés.


Ahora necesitamos saber si alguien le puede enseñar un lenguaje a otra persona, si el primero conoce ese lenguaje, el segundo no lo conoce, y además:
* el primero es copado con la otra persona,
* o bien el primero es copado con alguien que sea copado con esa persona.
Por ejemplo, Fernando le puede enseñar COBOL a Andrés, porque Fernando conoce COBOL y es copado con Santiago, que es copado con Julieta, que es copado con Andrés. Hacer un predicado que funcione a n niveles.
## Punto 5: Seniority
De cada programador se sabe las tareas que hizo. Las tareas posibles son:
* Evolutiva, que puede ser simple o compleja.
* Correctiva, donde se indican la cantidad de líneas modificadas y el lenguaje (éste no tiene ninguna relación con los lenguajes que más conoce).
* Algorítmica, donde cuentan la cantidad de líneas.


Ejemplo:
tarea(fernando, evolutiva(compleja)).  
tarea(fernando, correctiva(8, brainfuck)).
tarea(fernando, algorítmica(150)).
tarea(marcos, algorítmica(20)).
tarea(julieta, correctiva(412, cobol)).
tarea(julieta, correctiva(21, go)).
tarea(julieta, evolutiva(simple)). 


Se pide que codifique la consulta que permite saber el grado de seniority de un programador, donde:
* Las evolutivas complejas suman 5 puntos, las simples 3.
* Las correctivas suman 4 puntos si la cantidad de líneas supera las 50, o si la tarea requería hacerse en lenguaje Brainfuck (sí, es real el nombre).
* Las algorítmicas suman (cantidad de líneas / 10)  puntos de seniority.
El predicado debe ser totalmente inversible.


## 2 Casos de prueba
## Sobre el punto 4: ¿Te copás?
1. Saber si Fernando es copado con Santiago. Esto es correcto.
2. Fernando no es copado con Julieta.
3. Fernando le puede enseñar COBOL a Santiago, Julieta, Marcos y Andrés.
4. Es falso que Fernando le puede enseñar Haskell a alguien.
5. A Andrés le pueden enseñar Java Fernando, Julieta y Santiago.
6. Fernando puede enseñarle COBOL, Visual Basic y Java a alguna persona.
7. Marcos no puede enseñar nada a nadie (¡¡perdón Marcos!!).

## Sobre el Punto 5: Seniority
1. Fernando tiene 24 de seniority.
2. Se debe poder consultar quiénes tienen grado 0 de seniority, que es la lista compuesta por Santiago y Andrés.
3. Julieta no tiene seniority 6.
4. Julieta tiene seniority 7.
