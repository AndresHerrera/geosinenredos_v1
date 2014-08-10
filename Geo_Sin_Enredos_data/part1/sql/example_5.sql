-- #######################################################
-- #	Document: (Geo .. Sin Enredos + Ejemplos y Extras)
-- #	Version: 0.1.1
-- #   Licence: GNU GPL
-- #	Autor: Andres Herrera
-- #   Contact: t763rm3n at gmail.com	
-- #######################################################

-- Creando tabla temporal para representar graficamente operaciones espaciales
CREATE TABLE overlay_prueba ( gid serial NOT NULL, id int4, nombre varchar(20), CONSTRAINT overlay_prueba_pkey PRIMARY KEY (gid) );
SELECT AddGeometryColumn('overlay_prueba','the_geom',-1,'POLYGON',2);

CREATE TABLE overlay_prueba2 ( gid serial NOT NULL, id int4, nombre varchar(20), CONSTRAINT overlay_prueba2_pkey PRIMARY KEY (gid) );
SELECT AddGeometryColumn('overlay_prueba2','the_geom',-1,'MULTIPOLYGON',2);


-- Union
SELECT astext(St_Union( ( SELECT the_geom FROM example_2_poligono where id=1) , 
(SELECT the_geom FROM example_2_poligono where id=4)));

-- Test Union
SELECT (St_Union( ( SELECT the_geom FROM example_2_poligono where id=1) , 
(SELECT the_geom FROM example_2_poligono where id=4)));

-- Test Union
INSERT INTO overlay_prueba (id, nombre, the_geom)
SELECT 1,'union',astext(St_Union( ( SELECT the_geom FROM example_2_poligono where id=1) , 
(SELECT the_geom FROM example_2_poligono where id=4)));


-- Interseccion

SELECT astext(ST_Intersection( ( SELECT the_geom FROM example_2_poligono where id=1) , 
(SELECT the_geom FROM example_2_poligono where id=4)));

-- Test Interseccion
INSERT INTO overlay_prueba (id, nombre, the_geom)
SELECT 2,'intersection',astext(ST_Intersection( ( SELECT the_geom FROM example_2_poligono where id=1) , 
(SELECT the_geom FROM example_2_poligono where id=4)));


-- ST_SymDifference

SELECT astext(ST_SymDifference( ( SELECT the_geom FROM example_2_poligono where id=1) , 
(SELECT the_geom FROM example_2_poligono where id=4)));

-- Test ST_SymDifference
INSERT INTO overlay_prueba2 (id, nombre, the_geom)
SELECT 3,'symdifference',astext(ST_SymDifference( ( SELECT the_geom FROM example_2_poligono where id=1) , 
(SELECT the_geom FROM example_2_poligono where id=4)));


-- ST_Difference
SELECT astext(ST_Difference( ( SELECT the_geom FROM example_2_poligono where id=1) , 
(SELECT the_geom FROM example_2_poligono where id=4)));

INSERT INTO overlay_prueba (id, nombre, the_geom)
SELECT 4,'difference',astext(ST_Difference( ( SELECT the_geom FROM example_2_poligono where id=1) , 
(SELECT the_geom FROM example_2_poligono where id=4)));

SELECT astext(ST_Difference( ( SELECT the_geom FROM example_2_poligono where id=4) , 
(SELECT the_geom FROM example_2_poligono where id=1)));

INSERT INTO overlay_prueba (id, nombre, the_geom)
SELECT 5,'difference2',astext(ST_Difference( ( SELECT the_geom FROM example_2_poligono where id=4) , 
(SELECT the_geom FROM example_2_poligono where id=1)));




CREATE TABLE overlay_prueba3 ( gid serial NOT NULL, id int4, nombre varchar(20), CONSTRAINT overlay_prueba3_pkey PRIMARY KEY (gid) );
SELECT AddGeometryColumn('overlay_prueba3','the_geom',-1,'MULTILINESTRING',2);

-- ST_Boundary
SELECT astext(ST_Boundary( ( SELECT the_geom FROM example_2_poligono where id=4 )));

INSERT INTO overlay_prueba3 (id, nombre, the_geom)
(SELECT 1,'bondary', ST_Boundary( ( SELECT the_geom FROM example_2_poligono where id=4)));

--

--- TRIGGER y PL/PGSQL

-- Creamos Tabla
CREATE TABLE tablatrigger
(
    gid serial NOT NULL, 
    x1 int4, 
    y1 int4, 
    x2 int4, 
    y2 int4, 
    geom1 geometry, 
    geom2 geometry, 
    buff_geom1 geometry, 
    buff_geom2 geometry,
    linegeom1_geom2 geometry,  
    buffdistance int4,
    distance_calc double precision,
    distance_postgis double precision,
    CONSTRAINT tablatrigger_pkey PRIMARY KEY (gid) 
);
-- Creamos Funcion
CREATE OR REPLACE FUNCTION funcionDisparadora()
  RETURNS "trigger" AS
  $BODY$
  BEGIN

    NEW.geom1:=SetSRID(MakePoint(new.x1, new.y1),-1) ;
    NEW.geom2:=SetSRID(MakePoint(new.x2, new.y2),-1) ;
    NEW.buff_geom1:=buffer(SetSRID(MakePoint(new.x2, new.y2),-1),new.buffdistance); 
    NEW.buff_geom2:=buffer(SetSRID(MakePoint(new.x2, new.y2),-1),new.buffdistance);
    NEW.linegeom1_geom2:= ST_MakeLine(SetSRID(MakePoint(new.x1, new.y1),-1) , SetSRID(MakePoint(new.x2, new.y2),-1) );
    NEW.distance_calc:=  sqrt( pow((new.x2 - new.x1),2) +  pow((new.y2 - new.y1),2));
    NEW.distance_postgis:=  length( ST_MakeLine(SetSRID(MakePoint(new.x1, new.y1),-1) , SetSRID(MakePoint(new.x2, new.y2),-1) ) );    
     
  RETURN NEW;
  END
  $BODY$
LANGUAGE 'plpgsql' VOLATILE;

-- Creamos el Trigger
CREATE TRIGGER triggerEjemplo
  BEFORE INSERT OR UPDATE
  ON tablatrigger
  FOR EACH ROW
EXECUTE PROCEDURE funcionDisparadora();

--Insertamos un Elemento
INSERT INTO tablatrigger(x1, y1, x2 , y2, buffdistance) VALUES (1,2,4,5,3);

--Probamos
SELECT * FROM tablatrigger ;  

SELECT x1,y1,x2,y2,astext(geom1),astext(geom2),astext(buff_geom1),astext(buff_geom2),astext(linegeom1_geom2),
       buffdistance,distance_calc,distance_postgis 
FROM tablatrigger;    




