<?php 
/*
	Document: (Geo .. Sin Enredos + Ejemplos y Extras)
	Version: 0.1.1
    Licence: GNU GPL
	Autor: Andres Herrera
    Contact: t763rm3n at gmail.com	
*/
?>

<?php
	if (!extension_loaded("MapScript"))
	{ 
		dl('php_mapscript.'.PHP_SHLIB_SUFFIX);
	}

	$mapObject = ms_newMapObj("");
	$mapObject->set("name","Pruebas");
	$mapObject->set("shapepath","/var/www/mfd_lin/shapes/");


	$mapObject->setSize(700,500);
	$mapObject->setExtent(-88 ,-5 ,-62 ,13);

	$mapObject->web->set( "imagepath" , "/var/www/mfd_lin/tmp/" );
	$mapObject->web->set( "imageurl", "tmp/" );

	// Creamos un Layer  y seteamos sus propiedades
	$layerPoligono = ms_newLayerObj($mapObject);
	$layerPoligono->set( "name", "Poligonos");
	$layerPoligono->set( "type", MS_LAYER_POLYGON);
	$layerPoligono->set( "status", MS_ON);
	
	$layerPoligono->set("connectiontype",MS_POSTGIS);
	$layerPoligono->set("connection","user=postgres password=fromsky dbname=tutopostgis host=192.168.1.11");
	$layerPoligono ->set("data","the_geom FROM poligono as poligono using unique gid using SRID=-1");
	

	
	$clasePoligono = ms_newClassObj($layerPoligono);
	$estiloPoligono = ms_newStyleObj($clasePoligono);
	$estiloPoligono->color->setRGB(255,123,0);
	$estiloPoligono->outlinecolor->setRGB(0, 0, 0);
	
	$layerLineas = ms_newLayerObj($mapObject);
	$layerLineas->set( "name", "Lineas");
	$layerLineas->set( "type", MS_LAYER_LINE);
	$layerLineas->set( "status", MS_ON);
	
	$layerLineas->set("connectiontype",MS_POSTGIS);
	$layerLineas->set("connection","user=postgres password=fromsky dbname=tutopostgis host=192.168.1.11");
	$layerLineas ->set("data","the_geom FROM lineas as lineas using unique gid using SRID=-1");
	
	$claseLineas = ms_newClassObj($layerLineas);
	$estiloLineas = ms_newStyleObj($claseLineas);
	$estiloLineas->color->setRGB(0,0,0);
	$estiloLineas->outlinecolor->setRGB(0, 0, 0);
	
	$layerPuntos = ms_newLayerObj($mapObject);
	$layerPuntos->set( "name", "Puntos");
	$layerPuntos->set( "type", MS_LAYER_POINT);
	$layerPuntos->set( "status", MS_ON);
	
	$layerPuntos->set("connectiontype",MS_POSTGIS);
	$layerPuntos->set("connection","user=postgres password=fromsky dbname=tutopostgis host=192.168.1.11");
	$layerPuntos ->set("data","the_geom FROM puntos as puntos using unique gid using SRID=-1");
	
	$clasePuntos = ms_newClassObj($layerPuntos);
	$estiloPuntos = ms_newStyleObj($clasePuntos);
	
	
    
	
	$symbolid = ms_newSymbolObj($mapObject, "star");
    $oSymbol = $mapObject->getsymbolobjectbyid($symbolid);
    $oSymbol->setpoints(Array(0 ,.375 , .35, .375,.5, 0,.65, .375,1 ,.375,.75, .625,.875 ,1,.5 ,.75,.125, 1,.25 ,.625));
    $oSymbol->set("filled",MS_TRUE);
    $oSymbol->set("inmapfile", MS_TRUE);
    
	
	$estiloPuntos->color->setRGB(0 ,34 ,125);
	$estiloPuntos->outlinecolor->setRGB(0 ,255, 0);	
	$estiloPuntos->set("symbolname", "star");
    $estiloPuntos->set("size", "10");
	
				
	$mapImage = $mapObject->draw();
	$urlImage = $mapImage->saveWebImage();

?>

<html>

	<head>
		<title>Ejemplo 10 - Geo .. Sin Enredos + Ejemplos y Extras  by: Andres Herrera</title>
	</head>
	
	<body>
		<img src="<?php echo $urlImage; ?>" border="1" >
	</body>
	
</html>