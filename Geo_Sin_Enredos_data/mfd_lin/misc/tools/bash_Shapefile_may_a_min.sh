#!/bin/bash
# Script para cambiar las extensiones de un Shapefile
# 	de mayúsculas a minúsculas
# 20080811
#
# Germán Carrillo (carrillo.german@gmail.com)
#    GeoTux       (http://geotux.tuxfamily.org)
#
#
	Shapefiles=($(find -name "*.SHP"));numShapefiles=${#Shapefiles[*]}	
	if [ $numShapefiles = 0 ]; then
		echo "No hay Shapefiles con extensión en mayúsculas en el directorio "`pwd`		
	else		
		for file in $( find -name "*.SHP" )
		do
			filename=`basename $file`;filename=${filename%SHP}
			mv ${filename}SHP ${filename}shp				
			if [ -e ${filename}SHX ]; then
				mv ${filename}SHX ${filename}shx
			fi
			if [ -e ${filename}DBF ]; then
				mv ${filename}DBF ${filename}dbf			
			fi			
			if [ -e ${filename}SBN ]; then
				mv ${filename}SBN ${filename}sbn
			fi	
			if [ -e ${filename}SBX ]; then
				mv ${filename}SBX ${filename}sbx
			fi	
			if [ -e ${filename}FBN ]; then
				mv ${filename}FBN ${filename}fbn
			fi	
			if [ -e ${filename}FBX ]; then
				mv ${filename}FBX ${filename}fbx
			fi	
			if [ -e ${filename}AIN ]; then
				mv ${filename}AIN ${filename}ain
			fi	
			if [ -e ${filename}AIH ]; then
				mv ${filename}AIH ${filename}aih
			fi	
			if [ -e ${filename}PRJ ]; then
				mv ${filename}PRJ ${filename}prj			
			fi	
			if [ -e ${filename}SHP.XML ]; then
				mv ${filename}SHP.XML ${filename}shp.xml			
			fi				
		done	
		echo "Se han cambiado las extensiones de los Shapefiles encontrados!"
	fi	
	exit 0
#Fin del script
