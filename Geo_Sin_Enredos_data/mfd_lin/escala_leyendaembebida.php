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

	$mapObject = ms_newMapObj("escala_leyendaembebida.map");
	$mapImage = $mapObject->draw();
	$urlImage = $mapImage->saveWebImage();
?>

<html>

	<head>
		<title>Ejemplo Escala y Leyenda Embebida - Geo .. Sin Enredos + Ejemplos y Extras  by: Andres Herrera</title>
	</head>
	
	<body>
		<img src="<?php echo $urlImage; ?>" border="1" >
	</body>
	
</html>