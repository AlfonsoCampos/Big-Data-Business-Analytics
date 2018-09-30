
-- Table: clientes
CREATE TABLE clientes ( 
    codigo_cli INTEGER,
    nombre_cli CHAR( 30 )  NOT NULL,
    nif        CHAR( 12 ),
    direccion  CHAR( 30 ),
    ciudad     CHAR( 20 ),
    telefono   CHAR( 12 ),
    PRIMARY KEY ( codigo_cli ),
    UNIQUE ( nif ) 
);


-- Table: departamentos
CREATE TABLE departamentos ( 
    nombre_dep CHAR( 20 ),
    ciudad_dep CHAR( 20 ),
    telefono   INTEGER     DEFAULT NULL,
    PRIMARY KEY ( nombre_dep, ciudad_dep ) 
);


-- Table: proyectos
CREATE TABLE proyectos ( 
    codigo_proyec  INTEGER,
    nombre_proyec  CHAR( 20 ),
    precio         REAL,
    fecha_inicio   DATE,
    fecha_prev_fin DATE,
    fecha_fin      DATE        DEFAULT NULL,
    codigo_cliente INTEGER,
    PRIMARY KEY ( codigo_proyec ),
    CHECK ( fecha_inicio < fecha_prev_fin ),
    CHECK ( fecha_inicio < fecha_fin ),
    FOREIGN KEY ( codigo_cliente ) REFERENCES clientes ( codigo_cli ) 
);


-- Table: empleados
CREATE TABLE empleados ( 
    codigo_empl   INTEGER,
    nombre_empl   CHAR( 20 ),
    apellido_empl CHAR( 20 ),
    sueldo        REAL        CHECK ( sueldo > 7000 ),
    nombre_dep    CHAR( 20 ),
    ciudad_dep    CHAR( 20 ),
    num_proyec    INTEGER,
    PRIMARY KEY ( codigo_empl ),
    FOREIGN KEY ( nombre_dep, ciudad_dep ) REFERENCES departamentos ( nombre_dep, ciudad_dep ),
    FOREIGN KEY ( num_proyec ) REFERENCES proyectos ( codigo_proyec ) 
);


-- View: proyectos_por_cliente
CREATE VIEW proyectos_por_cliente AS
       SELECT c.codigo_cli,
              COUNT( * )
         FROM proyectos p, 
              clientes c
        WHERE p.codigo_cliente = c.codigo_cli
        GROUP BY c.codigo_cli;
;

