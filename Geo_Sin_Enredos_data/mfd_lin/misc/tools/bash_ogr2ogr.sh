#!/bin/bash
# Copiar los shapefiles de un directorio a Postgis empleando ogr2ogr
# 20080814
#
# Germán Carrillo (carrillo.german@gmail.com)
#    GeoTux       (http://geotux.tuxfamily.org)
#
#
	echo;echo "Iniciando el cargue...";echo
	rm -f log.txt	
	bd="nombrebd";U="usuario"; #Parámetros
	Shapefiles=($(find -name "*.shp"));numShapefiles=${#Shapefiles[*]}	
	if [ $numShapefiles = 0 ]; then
		echo "No hay shapefiles en el directorio "`pwd`		
	else		
		for file in $( find -name "*.shp" )
		do
			filename=`basename $file`;fullname=`pwd`/$filename	
			echo;echo "Nombre: $filename"					
			ogr2ogr -f PostgreSQL PG:"host=localhost dbname=$bd user=$U port=5432" -overwrite $fullname >> log.txt 2>&1
		done
		echo;echo "Terminando el cargue..."
		echo "Más información del proceso en el archivo log.txt";echo 
	fi
	exit 0
#Fin del script
