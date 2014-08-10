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
	$connection = "host=localhost port=5432 dbname=tutopostgis user=postgres password=fromsky";
	$conecta=pg_connect($connection);
	
	if(!$conecta)
	{
		die("No se pude establecer la conexion con la base de datos.");	
	}
else
	{
		print("Conexion establecida con exito !!");
	}
?>