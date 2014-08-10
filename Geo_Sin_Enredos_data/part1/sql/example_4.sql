-- #######################################################
-- #	Document: (Geo .. Sin Enredos + Ejemplos y Extras)
-- #	Version: 0.1.1
-- #   Licence: GNU GPL
-- #	Autor: Andres Herrera
-- #   Contact: t763rm3n at gmail.com	
-- #######################################################

-- AsBinary
SELECT  AsBinary(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))'));
-- Buffer
SELECT  buffer(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , 4 ), asText( buffer(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , 4 ) );
-- Test Buffer 
INSERT INTO polygon_prueba (id, nombre, the_geom) VALUES (4, 'Poligono 2', GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))'));
INSERT INTO polygon_prueba (id, nombre, the_geom) VALUES (6, 'Poligono Buffer 4', buffer(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , 2) );
-- Dimension
SELECT Dimension(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))'));
-- isEmpty
SELECT isEmpty(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))'));
-- isSimple
SELECT isSimple(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))'));
-- Boundary
SELECT boundary(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))'));
-- Test boundary : (Frontera)
SELECT asText(boundary(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))')));
-- Equals: (Son iguales)
SELECT equals(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') );
SELECT equals(GeomFromText('POLYGON((4 7,2 4,6 2,4 5,6 5,4 7))') , GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') );


-- Disjoint(Son distintos)
SELECT disjoint(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') );
SELECT disjoint(GeomFromText('POLYGON((0 0,2 4,6 2,4 5,6 5,0 0))') , GeomFromText('POINT(3 2)') );
SELECT disjoint(GeomFromText('POLYGON((0 0,2 4,6 2,4 5,6 5,0 0))') , GeomFromText('LINESTRING (3 8, 6 9 , 6 8)') );

-- Intersects: (Se interesectan)
SELECT intersects(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') );
SELECT intersects(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((0 0,4 4,6 2,6 3,6 1,0 0))') );

-- Touches: (Se tocan)
SELECT touches(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POINT(4 7)') );
SELECT touches(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('LINESTRING (0 0, 6 5 , 6 8)') );
SELECT touches(GeomFromText('LINESTRING (0 0, 6 5 , 6 8)') , GeomFromText('POINT(0 0)') );

-- crosses(Se cruzan)
SELECT crosses(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('LINESTRING(3 3 , 4 5)') );

SELECT crosses(GeomFromText('LINESTRING(3 3 , 4 5 , 5 4)') , GeomFromText('LINESTRING(2 3 , 4 4 , 4 5 )') );

SELECT crosses(GeomFromText('LINESTRING(3 3 , 4 5 , 5 4)') , GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') );

SELECT crosses(GeomFromText('LINESTRING(6 5, 7 4)') , GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') );

-- within: (Esta dentro de)
SELECT within(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') );
SELECT within(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((0 0,4 4,6 2,6 3,6 1,0 0))') );

-- Test within
SELECT within(( select the_geom from example_2_poligono where id=1 ) ,  envelope((SELECT geomunion( (select the_geom from example_3_poligono where id=4) , 
(select the_geom from example_3_poligono where id=3)))) );

SELECT within(( select the_geom from example_2_poligono where id=1 ) ,  convexhull((SELECT geomunion( (select the_geom from example_3_poligono where id=4) , (select the_geom from example_3_poligono where id=3)))) );

-- overlaps: (Se superpone)
SELECT overlaps(GeomFromText('POLYGON((0 0,4 4,6 2,6 3,6 1,0 0))') , GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') ); 

SELECT overlaps(GeomFromText('LINESTRING(3 38, 6 38, 5 40, 8 42, 8 42, 8 42)') , GeomFromText('LINESTRING(5 40, 8 42, 5 42, 4 40)') ); 

-- contains: (Esta contenido)
SELECT contains(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') );
SELECT contains(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((0 0,4 4,6 2,6 3,6 1,0 0))') ); 

SELECT contains(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('LINESTRING (0 0, 6 5 , 6 8)') );
SELECT contains(GeomFromText('POLYGON((10 7,2 4,6 45,45 5,6 9,10 7))') , GeomFromText('LINESTRING (9 25, 23 12)')   );

-- Test Contains:
SELECT contains( envelope((SELECT geomunion( (select the_geom from example_3_poligono where id=5) , (select the_geom from example_3_poligono where id=3)))) ,
( select the_geom from example_2_poligono where id=2 ));

-- intersects: (se interceptan)
SELECT intersects(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((0 0,4 4,6 2,6 3,6 1,0 0))') );
SELECT intersects(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') ); 
-- relate: returns the DE-9IM (dimensionally extended nine-intersection matrix)
SELECT relate(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') );
SELECT relate(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((0 0,4 4,6 2,6 3,6 1,0 0))') ); 

-- convexhull
SELECT convexhull(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))')); 

-- Convexhull Test:
SELECT asText(convexhull(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') )), 
	asText(convexhull(GeomFromText('POINT(1 5)') )) ,   
	asText(convexhull(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)') )), 
	asText(convexhull(GeomFromText('MULTILINESTRING((2 4, 8 9), (2 6, 5 9))') )), 
	asText(convexhull(GeomFromText('MULTIPOLYGON( (( 2 3, 8 5, 4 9, 3 6 , 2 3 )) , (( 4 6, 5 5, 3 2, 3 0 , 4 6 )) )') ));

-- Convexhull Test 2:
INSERT INTO polygon_prueba (id, nombre, the_geom) VALUES (1, 'convexhull 1 ', convexhull(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') ) ); 
INSERT INTO polygon_prueba (id, nombre, the_geom) VALUES (2, 'convexhull 2 ', convexhull(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)') ) ); 
INSERT INTO polygon_prueba (id, nombre, the_geom) VALUES (3, 'convexhull 3 ', convexhull(GeomFromText('MULTILINESTRING((2 4, 8 9), (2 6, 5 9))') ) ); 
INSERT INTO polygon_prueba (id, nombre, the_geom) VALUES (4, 'convexhull 4 ', convexhull(GeomFromText('MULTIPOLYGON( (( 2 3, 8 5, 4 9, 3 6 , 2 3 )) , (( 4 6, 5 5, 3 2, 3 0 , 4 6 )) )') ) ); 

-- intersection
SELECT intersection(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((4 7,2 4,7 5,6 5,6 5,4 7))') ); 
-- GeomUnion
SELECT geomunion(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((4 7,2 4,7 5,6 5,6 5,4 7))') );
-- difference 
SELECT difference(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') , GeomFromText('POLYGON((4 7,2 4,7 5,6 5,6 5,4 7))') ); 


-- Envelope
SELECT envelope(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') );
-- Envelope Test:
SELECT asText(envelope(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') )), 
	asText(envelope(GeomFromText('POINT(1 5)') )) ,   
	asText(envelope(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)') )), 
	asText(envelope(GeomFromText('MULTILINESTRING((2 4, 8 9), (2 6, 5 9))') )), 
	asText(envelope(GeomFromText('MULTIPOLYGON( (( 2 3, 8 5, 4 9, 3 6 , 2 3 )) , (( 4 6, 5 5, 3 2, 3 0 , 4 6 )) )') ));
-- Envelope Test 2:
INSERT INTO polygon_prueba (id, nombre, the_geom) VALUES (1, 'envelope 1 ', envelope(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))') ) ); 
INSERT INTO polygon_prueba (id, nombre, the_geom) VALUES (2, 'envelope 2 ', envelope(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)') ) ); 
INSERT INTO polygon_prueba (id, nombre, the_geom) VALUES (3, 'envelope 3 ', envelope(GeomFromText('MULTILINESTRING((2 4, 8 9), (2 6, 5 9))') ) ); 
INSERT INTO polygon_prueba (id, nombre, the_geom) VALUES (4, 'envelope 4 ', envelope(GeomFromText('MULTIPOLYGON( (( 2 3, 8 5, 4 9, 3 6 , 2 3 )) , (( 4 6, 5 5, 3 2, 3 0 , 4 6 )) )') ) ); 

-- NumPoints
SELECT numpoints(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)') );
-- PointN
SELECT PointN(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)'),1) , astext(PointN(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)'),1));
SELECT PointN(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)'),2) , astext(PointN(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)'),2));
SELECT PointN(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)'),3) , astext(PointN(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)'),3));
-- ExteriorRing
SELECT ExteriorRing(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))')), asText(ExteriorRing(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))')));  
--SELECT InteriorRingN(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))'), 1); 

-- Distance
SELECT Distance(GeomFromText('LINESTRING (0 0, 10 5 , 6 8)') ,GeomFromText('LINESTRING (3 4, 1 3 , 2 20)') );

-- EndPoint, StartPoint
SELECT endPoint(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)')) , astext(EndPoint(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)')));
SELECT startPoint(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)')) , astext(StartPoint(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)')));

-- PointOnSurface
SELECT PointOnSurface(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))')), asText(PointOnSurface(GeomFromText('POLYGON((4 7,2 4,6 5,6 5,6 5,4 7))')));

-- Length : Longitud
SELECT length(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)'));
-- Length : Longitud 2D
SELECT length2d(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)'));
-- Length : Longitud 3D
SELECT length3d(GeomFromText('LINESTRING (0 0, 1 5 , 6 8)'));

-- simplify : using a Douglas-Peuker algorithm.
SELECT simplify(GeomFromText('MULTILINESTRING((2 4, 8 9), (2 6, 5 9) , (4 2, 5 7), (2 6, 3 4) )'),5) , 
	astext(simplify(GeomFromText('MULTILINESTRING((2 9, 8 9), (2 6, 9 9) , (4 2, 5 7), (1 6, 3 4) )'),5) );

/*INSERT INTO puntos_prueba (id, nombre, the_geom)
select '1', 'cen', centroid(the_geom) from example_2_poligono;*/
