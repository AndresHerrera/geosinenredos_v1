-- #######################################################
-- #	Document: (Geo .. Sin Enredos + Ejemplos y Extras)
-- #	Version: 0.1.1
-- #   Licence: GNU GPL
-- #	Autor: Andres Herrera
-- #   Contact: t763rm3n at gmail.com	
-- #######################################################


CREATE TABLE tabla1 ( gid serial NOT NULL, id int4, nombre varchar(20), CONSTRAINT tabla1_pkey PRIMARY KEY (gid) );
SELECT AddGeometryColumn('tabla1','the_geom',-1,'POINT',2);
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (1, 'Primer Punto', GeometryFromText('POINT(1 1)'));
SELECT gid, id, nombre, AsText(the_geom) AS geometria FROM tabla1;

-- Vertices de un Triangulo
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (1, 'Primer Punto', GeometryFromText('POINT(1 1)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (2, 'Segundo Punto', GeometryFromText('POINT(6 1)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (3, 'Tercero Punto', GeometryFromText('POINT(3 6)'));
SELECT gid, id, nombre, AsText(the_geom) AS geometria FROM tabla1;


-- Circulo :) 

INSERT INTO tabla1 (id, nombre, the_geom) VALUES (1, 'circulo', GeometryFromText('POINT(1 0)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (2, 'circulo', GeometryFromText('POINT(0.866025403784439 0.5)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (3, 'circulo', GeometryFromText('POINT(0.707106781186548 0.707106781186548)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (4, 'circulo', GeometryFromText('POINT(0.5 0.866025403784439)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (5, 'circulo', GeometryFromText('POINT(0 1)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (6, 'circulo', GeometryFromText('POINT(-0.5 0.866025403784439)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (7, 'circulo', GeometryFromText('POINT(-0.707106781186548 0.707106781186548)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (8, 'circulo', GeometryFromText('POINT(-0.866025403784439 0.5)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (9, 'circulo', GeometryFromText('POINT(-1 0)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (10, 'circulo', GeometryFromText('POINT(-0.866025403784439 -0.5)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (11, 'circulo', GeometryFromText('POINT(-0.707106781186548 -0.707106781186548)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (12, 'circulo', GeometryFromText('POINT(-0.5 -0.866025403784439)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (13, 'circulo', GeometryFromText('POINT(0 -1)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (14, 'circulo', GeometryFromText('POINT(0.5 -0.866025403784439)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (15, 'circulo', GeometryFromText('POINT(0.707106781186548 -0.707106781186548)'));
INSERT INTO tabla1 (id, nombre, the_geom) VALUES (16, 'circulo', GeometryFromText('POINT(0.866025403784439 -0.5)'));

--select -(sqrt(2)/2), -(sqrt(3)/2)   from tabla1 limit 1
-- 1 0 
-- 0.866025403784439 0.5
-- 0.707106781186548 0.707106781186548
-- 0.5 0.866025403784439
-- 0 1 
-- -0.5 0.866025403784439
-- -0.707106781186548 0.707106781186548
-- -0.866025403784439 0.5
-- -1 0
-- -0.866025403784439 -0.5
-- -0.707106781186548 -0.707106781186548
-- -0.5 -0.866025403784439
-- 0 -1
-- 0.5 -0.866025403784439
-- 0.707106781186548 -0.707106781186548
-- 0.866025403784439 -0.5

-- Eliminar registros
DELETE FROM tabla1 where id = 2;
DELETE FROM tabla1 where id = 3;
DELETE FROM tabla1 where id = 4;

-- Modificar Posicion id=5
UPDATE tabla1 set the_geom=GeometryFromText('POINT(0 0)') where id=5;

-- Crear indice espacial 

-- DROP INDEX geom_tabla1_idx
CREATE INDEX geom_tabla1_idx
  ON tabla1
  USING gist
  (the_geom); 


  

