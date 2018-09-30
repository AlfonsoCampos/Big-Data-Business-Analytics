--CONSULTAS GENERALES
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
--Consulta 1:Obtener los identificadores, nombres y notas de los estudiantes con una nota mayor de 7.
SELECT ID, Nombre_Est, Nota FROM ESTUDIANTES WHERE Nota > 7

--Consulta 2:Obtener los nombres de los estudiantes y las carreras que han solicitado.
SELECT DISTINCT Nombre_Est, Carrera FROM Estudiantes, Solicitudes
WHERE Estudiantes.ID = Solicitudes.ID;

--Consulta 3:Obtener los nombres y notas de los estudiantes así como el resultado de su solicitud de manera que tengan un valor de corrección menor que 1000 y hayan solicitado la carrera de Informática en la Universidad Complutense de Madrid.
SELECT Nombre_Est, Nota, Decision FROM Estudiantes,Solicitudes
WHERE Estudiantes.ID = Solicitudes.ID
  AND Valor < 1000 AND Carrera = 'Informatica' AND Nombre_Univ = 'Universidad Complutense de Madrid';

--Consulta 4:Obtener todas las universidades que tienen más de 20000 plazas e imparten la carrera de Informática.
SELECT DISTINCT  Universidades. Nombre_Univ
FROM Universidades, Solicitudes 
WHERE Universidades.Nombre_Univ = Solicitudes.Nombre_Univ  
AND Plazas > 20000 AND Carrera = 'Informatica';

--Consulta 5:Obtener la información sobre todas las solicitudes: ID y nombre del estudiante, nombre de la universidad, nota y plazas, ordenadas de forma decreciente por las notas y en orden creciente de plazas.
SELECT Estudiantes.ID, Nombre_Est, Nota, Solicitudes.Nombre_Univ, Plazas FROM Estudiantes, Universidades, Solicitudes 
WHERE Solicitudes.ID = Estudiantes.ID AND Solicitudes.Nombre_Univ = Universidades.Nombre_Univ
ORDER BY Nota DESC, Plazas;

--Consulta 6:Obtener todas las solicitudes a carreras que tengan relación con la biología.
SELECT * FROM Solicitudes WHERE Carrera like '%bio%';

--Consulta 7:Obtener la información del producto escalar de las tablas Estudiantes y Universidades.
SELECT * FROM Estudiantes, Universidades;

--Consulta 8:Obtener la información del estudiante junto a la nota ponderada usando la columna valor.
SELECT ID, Nombre_Est, Nota, Valor, Nota*(Valor/1000.0) AS Ponderacion FROM Estudiantes;

--Consulta 9:Contar el número de estudiantes con nota distinto de nulo.
SELECT COUNT(*) FROM Estudiantes WHERE Nota IS NOT NULL;

--Consulta 10:Contar el número de notas diferentes entre los estudiantes.
SELECT COUNT(DISTINCT Nota) FROM Estudiantes WHERE Nota IS NOT NULL;

--Consulta 11:Obtener los estudiantes cuya nota ponderada cambia en más de un punto respecto a la nota original.
SELECT ID, Nombre_Est, Nota, Nota*Valor/1000.0 as Ponderada FROM Estudiantes WHERE ABS(Nota*(Valor/1000.0) - Nota) > 1.0;

--Consulta 12:Obtener los pares nombre de universidad, comunidad autónoma y nota de las solicitudes con mayor nota.
SELECT DISTINCT Universidades.Nombre_Univ, Comunidad, Nota FROM Universidades, Solicitudes, Estudiantes
WHERE Universidades.Nombre_Univ = Solicitudes.Nombre_Univ AND Solicitudes.ID = Estudiantes.ID
  AND NOTA >= (SELECT NOTA FROM Estudiantes,Solicitudes WHERE Estudiantes.ID = Solicitudes.ID and Solicitudes.Nombre_Univ = Universidades.Nombre_Univ);

--Consulta 13:Obtener toda la información sobre las solicitudes.
SELECT E.ID, E.Nombre_Est, E.Nota, S.Nombre_Univ, U.Plazas
FROM Estudiantes E, Universidades U, Solicitudes S
WHERE S.ID = E.ID and S.Nombre_Univ = U.Nombre_Univ;

--Consulta 14:Estudiantes con la misma nota.
SELECT E1.ID, E1.Nombre_Est, E1.Nota, E2.ID, E2.Nombre_Est, E2.Nota
FROM Estudiantes E1, Estudiantes E2
WHERE E1.Nota = E2.Nota and E1.ID < E2.ID;

--Consulta 15:Lista de nombres de universidades y estudiantes.
SELECT Nombre_Univ AS Nombre FROM Universidades
UNION ALL
SELECT Nombre_Est AS Nombre FROM Estudiantes
ORDER BY Nombre;

--Consulta 16:IDS de estudiantes que solicitaron Informática y Económicas.
SELECT ID FROM Solicitudes WHERE Carrera = 'Informatica'
INTERSECT
SELECT ID FROM Solicitudes WHERE Carrera = 'Economicas';

--Consulta 17:IDS de estudiantes que solicitaron Informática pero no Económicas.
SELECT ID FROM Solicitudes WHERE Carrera = 'Informatica'
EXCEPT
SELECT ID FROM Solicitudes WHERE Carrera = 'Economicas';

--MODIFICACIÓN DE TABLAS
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
--Consulta 1:Insertar las siguientes filas en la tabla Estudiantes:
(432,”José”,null,1500) y (321,”María”,null,2500)
INSERT INTO Estudiantes VALUES (432, 'José', null, 1500);
INSERT INTO Estudiantes VALUES (321, 'Maria', null, 2500);

--Consulta 2:Insertar una nueva universidad: (“Universidad de Jaen”, “Andalucia”,11500)
INSERT INTO Universidades VALUES ('Universidad de Jaen', 'Andalucia', 11500);

--Consulta 3:Modificar la tabla solicitudes de forma que aquellos estudiantes que no solicitaron ninguna universidad, soliciten “Informática” en la “Universidad de Jaen”.
INSERT INTO Solicitudes SELECT ID, 'Universidad de Jaen', 'Informatica', null FROM Estudiantes
WHERE ID NOT IN (SELECT ID FROM Solicitudes);

--Consulta 4:Admitir en la “Universidad de Jaen” a todos los estudiantes de Económicas quienes no fueron admitidos en dicha carrera en otras universidades.
INSERT INTO Solicitudes SELECT ID, 'Universidad de Jaen', 'Economicas', 'Si' FROM Estudiantes
WHERE ID IN (SELECT ID FROM Solicitudes WHERE Carrera='Economicas' AND Decision='No');

--Consulta 5:Borrar a todos los estudiantes que solicitaron más de 2 carreras diferentes.
DELETE FROM Solicitudes WHERE ID IN (SELECT ID FROM Solicitudes GROUP BY ID HAVING COUNT(DISTINCT Carrera) >2);

--Consulta 6:Borrar las universidades que no tengan solicitudes de “Informatica”.
DELETE FROM Universidades WHERE Nombre_Univ NOT IN (SELECT Nombre_Univ FROM Solicitudes WHERE Carrera = 'Informatica');

--Consulta 7:Aceptar las solicitudes a la Universidad de Jaén con una nota menor de 7, cambiando la carrera solicitada a Economicas.
UPDATE Solicitudes SET Decision= 'Y', Carrera= 'Economicas' WHERE Nombre_Univ= 'Universidad de Jaen' AND ID IN
(SELECT  ID FROM Estudiantes WHERE Nota < 7);

--Consulta 8:Convertir la solicitud para la carrera de Economicas con la mayor nota en una solicitud para la carrera de Informatica.
UPDATE Solicitudes SET Carrera='Informatica' WHERE Carrera= 'Economicas' AND ID IN 
(SELECT ID FROM Estudiantes WHERE Nota >= (SELECT Nota FROM Estudiantes WHERE ID in (SELECT ID FROM Solicitudes WHERE 
Carrera='Economicas')));

--Consulta 9:Dar a todo el mundo la máxima nota y el más pequeño valor de ponderación.
UPDATE Estudiantes SET Nota=(SELECT MAX(Nota) FROM Estudiantes), Valor=(SELECT MIN(Valor) FROM Estudiantes);

--Consulta 10:Aceptar todas las solicitudes.
UPDATE Solicitudes SET Decision= 'Si';

--FUNCIONES DE AGREGACIÓN
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
--Consulta 1:Hallar la nota media de todos los estudiantes.
SELECT AVG(Nota) FROM Estudiantes

--Consulta 2:Obtener la nota más pequeña de los estudiantes que han solicitado la carrera de Informatica.
SELECT AVG(Nota) FROM Estudiantes WHERE ID IN (SELECT ID FROM Solicitudes WHERE Carrera= 'Informatica');

--Consulta 3:Obtener el número de Universidades que tienen más de 15000 plazas.
SELECT COUNT(*) FROM Universidades WHERE Plazas> 15000;

--Consulta 4:Obtener el número de estudiantes que han solicitado plaza en la “Universidad Complutense de Madrid”.
SELECT COUNT(DISTINCT ID) FROM Solicitudes WHERE Nombre_Univ= 'Universidad Complutense de Madrid';

--Consulta 5:Obtener el número de solicitudes a cada universidad.
SELECT Nombre_Univ, COUNT(*) FROM Solicitudes GROUP BY Nombre_Univ;

--Consulta 6:Obtener las carreras en las que la nota máxima de las solicitudes está por debajo de la media.
SELECT Carrera FROM Estudiantes, Solicitudes WHERE Estudiantes.ID= Solicitudes.ID GROUP BY Carrera 
HAVING MAX(Nota) < (Select AVG(Nota) FROM Estudiantes);

--Consulta 7:Obtener las universidades con menos de 5 solicitudes.
SELECT Nombre_Univ FROM Solicitudes GROUP BY Nombre_Univ HAVING COUNT(DISTINCT ID) < 5;

--Consulta 8:Obtener el número de universidades solicitadas por cada estudiante, incluyendo 0 en el caso de no haberse solicitado ninguna.
SELECT Estudiantes.ID, COUNT(DISTINCT Nombre_Univ) FROM Estudiantes, Solicitudes 
WHERE Estudiantes.ID = Solicitudes.ID GROUP BY Estudiantes.ID
UNION
SELECT ID,0
FROM Estudiantes
WHERE ID NOT IN (SELECT ID FROM Solicitudes);

--Consulta 9:Obtener los estudiantes tales que el número de los otros estudiantes con la misma nota es igual al número de los otros estudiantes con el mismo valor de ponderación.
SELECT * FROM Estudiantes E1 WHERE
(SELECT COUNT(*) FROM Estudiantes E2 WHERE E2.ID <> E1.ID AND E2.Nota = E1.Nota)=
(SELECT COUNT(*) FROM Estudiantes E2 WHERE E2.ID <> E1.ID AND E2.Valor = E1.Valor)

--Consulta 10:Obtener el número de universidades solicitadas por cada estudiante.
SELECT Estudiantes.ID, Nombre_Est, COUNT(DISTINCT Nombre_Univ), Nombre_Univ FROM Estudiantes, Solicitudes
WHERE Estudiantes.ID = Solicitudes.ID GROUP BY Estudiantes.ID

--Consulta 11:Obtener las plazas de universidad por comunidad autónoma.
SELECT Comunidad, SUM(Plazas) FROM Universidades GROUP BY Comunidad;

--Consulta 12:Obtener la máxima y mínima nota de las solicitudes por universidad y carrera.
SELECT Nombre_Univ, Carrera, MIN(Nota), MAX(Nota) FROM Estudiantes, Solicitudes 
WHERE Estudiantes.ID = Solicitudes.ID GROUP BY Nombre_Univ, Carrera;

--Consulta 13:Obtener la diferencia entre la media de las notas de los estudiantes que solicitaron Informática y la media de las notas de los estudiantes que no la solicitaron.
SELECT DISTINCT (SELECT AVG(Nota) AS NotaMedia FROM Estudiantes WHERE ID IN
(SELECT ID FROM Solicitudes WHERE Carrera='Informatica'))-
(SELECT AVG(Nota) AS NotaMedia FROM Estudiantes WHERE ID NOT IN (
SELECT ID FROM Solicitudes WHERE Carrera= ' Informatica')) AS d FROM Estudiantes;


--OPERACIONES ENTRE TABLAS
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--Consulta 1:Obtener los nombres de los estudiantes y las carreras que han solicitado.
SELECT DISTINCT Nombre_Est, Carrera FROM Estudiantes JOIN Solicitudes ON Estudiantes.ID = Solicitudes.ID;

--Consulta 2:Obtener el nombre de las notas de los estudiantes con valor de ponderación menor de 1000 que hayan solicitado Informatica en la “Universidad de Valencia”.
SELECT Nombre_Est, Nota FROM Estudiantes JOIN Solicitudes ON Estudiantes.ID = Solicitudes.ID 
AND Valor < 1000 AND Carrera='Informatica' AND Nombre_Univ= 'Universidad de Valencia';

--Consulta 3:Obtener la siguiente información de una solicitud: ID, nombre del estudiante, nota, nombre de la universidad y plazas de la universidad.
SELECT Solicitudes.ID, Nombre_Est, Nota, Solicitudes.Nombre_Univ, Plazas 
FROM Solicitudes JOIN Estudiantes JOIN Universidades ON Solicitudes. ID= Estudiantes.ID 
AND Solicitudes.Nombre_Univ = Universidades.Nombre_Univ;

--Consulta 4:Obtener los nombres de los estudiantes y las carreras que han solicitado.
SELECT DISTINCT Nombre_Est, Carrera FROM Estudiantes INNER JOIN Solicitudes ON Estudiantes.ID = Solicitudes.ID;

O bien

SELECT DISTINCT Nombre_Est, Carrera FROM Estudiantes NATURAL JOIN Solicitudes;

--Consulta 5:Obtener el nombre de las notas de los estudiantes con valor de ponderación menor de 1000 que hayan solicitado Informatica en la “Universidad de Valencia”.
SELECT Nombre_Est, Nota FROM Estudiantes JOIN Solicitudes USING(ID) WHERE Valor<1000 AND Carrera='Informatica'
AND Nombre_Univ='Universidad de Valencia';

--Consulta 6:Obtener los pares de estudiantes con la misma nota.
SELECT E1.ID, E1.Nombre_Est, E1.Nota, E2.ID,E2.Nombre_Est, E2.Nota FROM Estudiantes E1 JOIN Estudiantes E2 USING (Nota)
WHERE E1.ID < E2.ID;

--Consulta 7:Obtener la siguiente información de la solicitud de un estudiante:Nombre, ID, nombre de la universidad,y carrera.
SELECT Nombre_Est, ID, Nombre_Univ, Carrera FROM Estudiantes LEFT JOIN Solicitudes USING(ID);