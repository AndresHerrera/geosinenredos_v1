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

	$mapObject = ms_newMapObj("generarsld.map");
	// Creo Objeto SLD
	$SLD = $mapObject->generateSLD();
	// Imprimo la Salida objeto SLD
	print($SLD);
	//debo ver codigo de fuente y grabar xml generado
?>
