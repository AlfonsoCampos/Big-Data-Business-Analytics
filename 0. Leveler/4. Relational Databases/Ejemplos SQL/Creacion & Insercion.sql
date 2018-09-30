drop table if exists Universidades;
drop table if exists Estudiantes;
drop table if exists Solicitudes;

create table Universidades(Nombre_Univ CHAR(35), Comunidad CHAR(35), Plazas INTEGER, PRIMARY KEY ( Nombre_Univ ),UNIQUE ( Nombre_Univ, Comunidad ));
create table Estudiantes(ID INTEGER, Nombre_Est CHAR(35), Nota REAL, Valor INTEGER, PRIMARY KEY ( ID ),UNIQUE ( ID ) );
create table Solicitudes(ID INTEGER, Nombre_Univ CHAR(35), Carrera CHAR(35), Decision CHAR(35),PRIMARY KEY ( ID, Nombre_Univ, Carrera),
    FOREIGN KEY ( ID ) REFERENCES Estudiantes ( ID ),
    FOREIGN KEY ( Nombre_Univ ) REFERENCES Universidades ( Nombre_Univ ),
    UNIQUE ( ID, Nombre_Univ,Carrera ) );

insert into Estudiantes values (123, 'Antonio', 8.9, 1000);
insert into Estudiantes values (234, 'Juan', 8.6, 1500);
insert into Estudiantes values (345, 'Isabel', 8.5, 500);
insert into Estudiantes values (456, 'Doris', 7.9, 1000);
insert into Estudiantes values (567, 'Eduardo', 6.9, 2000);
insert into Estudiantes values (678, 'Carmen', 5.8, 200);
insert into Estudiantes values (789, 'Isidro', 8.4, 800);
insert into Estudiantes values (987, 'Elena', 6.7, 800);
insert into Estudiantes values (876, 'Irene', 6.9, 400);
insert into Estudiantes values (765, 'Javier', 7.9, 1500);
insert into Estudiantes values (654, 'Alfonso', 7.9, 1000);
insert into Estudiantes values (543, 'Pedro', 5.4, 2000);

insert into Universidades values ('Universidad Complutense de Madrid', 'Madrid', 15000);
insert into Universidades values ('Universidad de Barcelona', 'Barcelona', 36000);
insert into Universidades values ('Universidad de Valencia', 'Valencia', 10000);
insert into Universidades values ('UPM', 'Madrid', 21000);

insert into Solicitudes values (123, 'Universidad Complutense de Madrid', 'Informatica', 'Si');
insert into Solicitudes values (123, 'Universidad Complutense de Madrid', 'Economia', 'No');
insert into Solicitudes values (123, 'Universidad de Barcelona', 'Informatica', 'Si');
insert into Solicitudes values (123, 'UPM', 'Economia', 'Si');
insert into Solicitudes values (234, 'Universidad de Barcelona', 'Biologia', 'No');
insert into Solicitudes values (345, 'Universidad de Valencia', 'Bioingenieria', 'Si');
insert into Solicitudes values (345, 'UPM', 'Bioingenieria', 'No');
insert into Solicitudes values (345, 'UPM', 'Informatica', 'Si');
insert into Solicitudes values (345, 'UPM', 'Economia', 'No');
insert into Solicitudes values (678, 'Universidad Complutense de Madrid', 'Historia', 'Si');
insert into Solicitudes values (987, 'Universidad Complutense de Madrid', 'Informatica', 'Si');
insert into Solicitudes values (987, 'Universidad de Barcelona', 'Informatica', 'Si');
insert into Solicitudes values (876, 'Universidad Complutense de Madrid', 'Informatica', 'No');
insert into Solicitudes values (876, 'Universidad de Valencia', 'Biologia', 'Si');
insert into Solicitudes values (876, 'Universidad de Valencia', 'Biologia Marina', 'No');
insert into Solicitudes values (765, 'Universidad Complutense de Madrid', 'Historia', 'Si');
insert into Solicitudes values (765, 'UPM', 'Historia', 'No');
insert into Solicitudes values (765, 'UPM', 'Psicologia', 'Si');
insert into Solicitudes values (543, 'Universidad de Valencia', 'Informatica', 'No');
