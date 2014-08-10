#!/bin/bash
# Copiar los shapefiles de un directorio a Postgis empleando shp2pgsql
# 20080811
#
# Germán Carrillo (carrillo.german@gmail.com)
#    GeoTux       (http://geotux.tuxfamily.org)
#
# 
	echo;echo "Iniciando el cargue...";echo
	rm -f log.txt	
	bd="nombrebd";U="usuario";esquema="public" #Parámetros
	Shapefiles=($(find -name "*.shp"));numShapefiles=${#Shapefiles[*]}	
	if [ $numShapefiles = 0 ]; then
		echo "No hay shapefiles en el directorio "`pwd`		
	else			
		for file in $( find -name "*.shp" )
		do			
			filename=`basename $file`;fullname=`pwd`/$filename						
			echo;echo "Nombre: $filename"
			shp2pgsql -s 4326 -d -g the_geom -D -i -I -S -N skip $fullname $esquema.${filename%.shp} | psql -d $bd -U $U >> log.txt 2>&1
		done		
		echo;echo "Terminando el cargue..."
		echo "Más información del proceso en el archivo log.txt";echo 
	fi
	exit 0
#Fin del script
