-- #######################################################
-- #	Document: (Geo .. Sin Enredos + Ejemplos y Extras)
-- #	Version: 0.1.1
-- #   Licence: GNU GPL
-- #	Autor: Andres Herrera
-- #   Contact: t763rm3n at gmail.com	
-- #######################################################

-- Area
select area(the_geom) as "Area" from example_2_poligono;
-- Perimeter
select perimeter(the_geom) as "Perimetro" from example_2_poligono;
-- Centroide
select centroid(the_geom) as "Centroide WKB", 
       x(centroid(the_geom)) as " Coord X Centroide", 
       y(centroid(the_geom)) as " Coord Y Centroide"  from example_2_poligono;

-- Dimension
select dimension(the_geom) as "Dimension" from example_2_poligono;       

-- Tipo de Geometria
select geometrytype(the_geom)as "Tipo Geometria" from example_2_poligono; 

-- SRID
select getsrid(the_geom)as "SRID" from example_2_poligono;   

-- NPOINTS
select npoints(the_geom) as "NPOINTS" from example_2_poligono;  

-- REVERSE
select reverse(the_geom) as "Reverse WKB", asText(reverse(the_geom)) as "Reverse Text"  , asText((the_geom)) as "Normal" from example_2_poligono;


-- REVERSE LINE
select GeometryFromText('LINESTRING(1 0 , 5 0)') as "Linea WKB" ,   
        asText(GeometryFromText('LINESTRING(1 0 , 5 0)')) as "Linea Text", 
        reverse(GeometryFromText('LINESTRING(1 0 , 5 0)')) as "Reverse Linea WKB",
        asText(reverse(GeometryFromText('LINESTRING(1 0 , 5 0)'))) as "Reverse Linea Text";

-- ROTATE
select rotate(the_geom , 45 ) as "Rotate WKB" , astext(rotate(the_geom , 45 )) as "Rotate Text" from example_2_poligono; 

select asText(GeometryFromText('LINESTRING(0 0,5 0)')) as "Original Text", 
       astext(rotate(GeometryFromText('LINESTRING(0 0 , 5 0)') , pi()  )) as "Rotate Text";   

-- GeoJSON 
select st_asgeojson(the_geom) as "GeoJSON" from example_2_poligono; 

-- GML
select st_asgml(the_geom) as "GML" from example_2_poligono;

-- SVG
select st_assvg(the_geom) as "SVG" from example_2_poligono;  

-- TEXT
select st_astext(the_geom) as "TEXT" from example_2_poligono;   

-- DISTANCE
-- Selecciona todas las geometrias de la columna the_geom que esten a una distancia menor a 0.3 unidades del punto(0,0). 
SELECT the_geom , astext(the_geom) FROM example_2_poligono 
   WHERE ST_Distance(the_geom, GeomFromText('POINT(0 0)', -1)) < 0.3;

-- EXTEND

select st_extent(the_geom), xmin(st_extent(the_geom)) ,  ymin(st_extent(the_geom)) ,  
	xmax(st_extent(the_geom)) ,  ymax(st_extent(the_geom))from example_2_poligono;  

-- Mas Geometrias 

-- PUNTO
SELECT  GeomFromText('POINT(1 5)');

-- LINESTRING
SELECT  GeomFromText('LINESTRING (0 0, 1 5 , 6 8)');

-- MULTILINESTRING

SELECT  GeomFromText('MULTILINESTRING((2 4, 8 9), (2 6, 5 9))');

-- POLYGON
SELECT  GeomFromText('POLYGON(( 2 3, 8 5, 4 9, 3 6 , 2 3 ))');

-- MULTIPOLYGON
SELECT  GeomFromText('MULTIPOLYGON( (( 2 3, 8 5, 4 9, 3 6 , 2 3 )) , (( 4 6, 5 5, 3 2, 3 0 , 4 6 )) )'); 


-- PUNTO
CREATE TABLE puntos_prueba ( gid serial NOT NULL, id int4, nombre varchar(20), CONSTRAINT puntos_prueba_pkey PRIMARY KEY (gid) );
SELECT AddGeometryColumn('puntos_prueba','the_geom',-1,'POINT',2);
INSERT INTO puntos_prueba (id, nombre, the_geom) VALUES (1, 'Primer Punto', GeomFromText('POINT(1 5)'));
-- LINESTRING
CREATE TABLE linestring_prueba ( gid serial NOT NULL, id int4, nombre varchar(20), CONSTRAINT linestring_prueba_pkey PRIMARY KEY (gid) );
SELECT AddGeometryColumn('linestring_prueba','the_geom',-1,'LINESTRING',2);
INSERT INTO linestring_prueba (id, nombre, the_geom) VALUES (1, 'Primer LineString', GeomFromText('LINESTRING (0 0, 1 5 , 6 8)'));
-- MULTILINESTRING
CREATE TABLE multilinestring_prueba ( gid serial NOT NULL, id int4, nombre varchar(30), CONSTRAINT multilinestring_prueba_pkey PRIMARY KEY (gid) );
SELECT AddGeometryColumn('multilinestring_prueba','the_geom',-1,'MULTILINESTRING',2);
INSERT INTO multilinestring_prueba (id, nombre, the_geom) VALUES (1, 'Primer MultiLineString', GeomFromText('MULTILINESTRING((2 4, 8 9), (2 6, 5 9))'));
-- POLYGON
CREATE TABLE polygon_prueba ( gid serial NOT NULL, id int4, nombre varchar(20), CONSTRAINT polygon_prueba_pkey PRIMARY KEY (gid) );
SELECT AddGeometryColumn('polygon_prueba','the_geom',-1,'POLYGON',2);
INSERT INTO polygon_prueba (id, nombre, the_geom) VALUES (1, 'Primer Poligono', GeomFromText('POLYGON(( 2 3, 8 5, 4 9, 3 6 , 2 3 ))'));
-- MULTIPOLYGON
CREATE TABLE multipolygon_prueba ( gid serial NOT NULL, id int4, nombre varchar(30), CONSTRAINT multipolygon_prueba_pkey PRIMARY KEY (gid) );
SELECT AddGeometryColumn('multipolygon_prueba','the_geom',-1,'MULTIPOLYGON',2);
INSERT INTO multipolygon_prueba (id, nombre, the_geom) VALUES (1, 'Primer MultiPoligono', GeomFromText('MULTIPOLYGON( (( 2 3, 8 5, 4 9, 3 6 , 2 3 )) , (( 4 6, 5 5, 3 2, 3 0 , 4 6 )) )'));

      