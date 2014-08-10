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

	$mapObject = ms_newMapObj("ejemplo8.map");
	$defSize=3;
	$checkPan="CHECKED";
	
	$polLayer = $mapObject->getLayerByName("Poligonos");
	$polLayer->set("status",MS_ON); 
	 
	$punLayer = $mapObject->getLayerByName("Puntos");
	$punLayer->set("status",MS_ON); 
	
	$linLayer = $mapObject->getLayerByName("Lineas");
	$linLayer->set("status",MS_ON); 
	 
	
	if($_POST)
	{
		//Bloque que permite encender y apagar las capas
		$item = $_REQUEST["layerselector"];
		$allLayersObject=$mapObject->getAllLayerNames();
		foreach ($allLayersObject as $idx => $layer) 
		{								
			$layerObject=$mapObject->getLayerByName($layer);
			if( sizeof( $item ) > 0 )
			{
				if (in_array( $layerObject->name, $item ))
				{
					if(($layerObject->name != "Norte") )
					{
						$layerObject->set( "status", MS_ON );
					}
				}
			else
				{
					if(($layerObject->name != "Norte") )
					{
						$layerObject->set( "status", MS_OFF );
					}
				}
			}
		}
	}
		
		
	if ( isset($HTTP_POST_VARS["mapa_x"]) && isset($HTTP_POST_VARS["mapa_y"])&& !isset($HTTP_POST_VARS["full"]) ) 
	{
		$arrayExtent = explode(" ",$HTTP_POST_VARS["extent"]); 
		
		$mapObject->setextent($arrayExtent[0],$arrayExtent[1],$arrayExtent[2],$arrayExtent[3]);
		
		$pointObject = ms_newpointObj();
		$pointObject->setXY($HTTP_POST_VARS["mapa_x"],$HTTP_POST_VARS["mapa_y"]);

		$extentRectObject = ms_newrectObj();
		$extentRectObject->setextent($arrayExtent[0],$arrayExtent[1],$arrayExtent[2],$arrayExtent[3]);

		$zoomFactor = $HTTP_POST_VARS["zoom"]*$HTTP_POST_VARS["zsize"];
		
		if ($zoomFactor == 0) 
		{
			$zoomFactor = 1;
            $checkPan = "CHECKED";
			$checkZout = "";
			$checkZin = "";
			$checkClick = "";
		} 
	else 
		if ($zoomFactor < 0) 
		{
            $checkPan = "";
			$checkZout = "CHECKED";
			$checkZin = "";
			$checkClick = "";
		} 
	else 
		{
            $checkPan = "";
            $checkZout = "";
			$checkZin = "CHECKED";
			$checkClick = "";
		}

		$defSize = abs($zoomFactor);
		
		if( $_REQUEST["zoom"] != "click") 
		 {
			$mapObject->zoompoint($zoomFactor,$pointObject,$mapObject->width,$mapObject->height,$extentRectObject);
		 }
	else
		{ 
		}

		
	}

	$mapImage = $mapObject->draw();
	$urlImage = $mapImage->saveWebImage();
	
	$mapLegend = $mapObject->drawLegend();
	$urlLegend = $mapLegend->saveWebImage(MS_GIF, 0, 0, -1);
		
	$mapScale = $mapObject->drawScaleBar();
	$urlScale = $mapScale->saveWebImage(MS_GIF, 0, 0, -1);
	
	$keyMapImage = $mapObject->drawreferencemap();
	$urlKeyMap = $keyMapImage->saveWebImage(MS_GIF, 0, 0, -1);
		
	
	$printExtentHTML = $mapObject->extent->minx." ".$mapObject->extent->miny." " .$mapObject->extent->maxx." ".$mapObject->extent->maxy;
	
	
	if ( isset($_REQUEST["zoom"]) && $_REQUEST["zoom"]=="info") 
	{
		 	$checkClick = "CHECKED";
		 	$checkPan = "";
			$checkZout = "";
            $checkZin = "";
		 
			$dfKeyMapXMin = $mapObject->extent->minx;
			$dfKeyMapYMin = $mapObject->extent->miny;
			$dfKeyMapXMax = $mapObject->extent->maxx;
			$dfKeyMapYMax = $mapObject->extent->maxy;
	
			$dfWidthPix = doubleval($mapImage->width);
			$dfHeightPix = doubleval($mapImage->height);
			
			$nClickGeoX = GMapPix2Geo($_REQUEST['mapa_x'], 0, $dfWidthPix,  $dfKeyMapXMin, $dfKeyMapXMax, 0);
			$nClickGeoY = GMapPix2Geo($_REQUEST["mapa_y"], 0, $dfHeightPix, $dfKeyMapYMin, $dfKeyMapYMax, 1);
			
			$my_point = ms_newpointObj();
			$my_point->setXY($nClickGeoX,$nClickGeoY);
		     
			
		
		    //Query a Puntos
			if(@$punLayer->queryByPoint($my_point, MS_SINGLE, 200) == MS_SUCCESS)
			{
				$results = $punLayer->{resultcache};
				$punLayer->open();
				$rslt = $punLayer->getResult(0);
				$shape = $punLayer->getShape($rslt->tileindex, $rslt->shapeindex);
				$resultadoConsluta  = $shape->values["texto"];
				echo "<center><br><br>Resultado de la Consulta Sobre Capa Puntos: <b> ".$resultadoConsluta . "</b></center>";
			}
		else
			{
				echo "No pudo realizar la consulta, vuelva a intentar !!";
			}

			//Query a Poligonos
			if(@$polLayer->queryByPoint($my_point, MS_SINGLE, 200) == MS_SUCCESS)
			{
				$results = $polLayer->{resultcache};
				$polLayer->open();
				$rslt = $polLayer->getResult(0);
				$shape = $polLayer->getShape($rslt->tileindex, $rslt->shapeindex);
				$resultadoConsluta  = $shape->values["CNTRY_NAME"];
				echo "<center>Resultado de la Consulta Sobre Capa Poligonos:<b> ".$resultadoConsluta . "</b></center>";
			}
		else
			{
				echo "No pudo realizar la consulta, vuelva a intentar !!";
			}

			//Query a Lineas
			if(@$linLayer->queryByPoint($my_point, MS_SINGLE, 200) == MS_SUCCESS)
			{
				$results = $linLayer->{resultcache};
				$linLayer->open();
				$rslt = $linLayer->getResult(0);
				$shape = $linLayer->getShape($rslt->tileindex, $rslt->shapeindex);
				$resultadoConsluta  = $shape->values["texto"];
				echo "<center>Resultado de la Consulta Sobre Capa Lineas:<b> ".$resultadoConsluta . "</b><br><br></center>";
			}
		else
			{
				echo "No pudo realizar la consulta, vuelva a intentar !!";
			}			
	}
	
	

?>
<HTML>
<HEAD>
<title>Ejemplo 8 - Geo .. Sin Enredos + Ejemplos y Extras  by: Andres Herrera</title>
<style type="text/css">
<!--
.style3 {font-size: 18px; font-weight: bold; }
-->
</style>
</HEAD>
<BODY>
<CENTER>
<FORM METHOD="POST" id="myForm" name="frmlayerselector" ACTION="<?php echo $HTTP_SERVER_VARS['PHP_SELF']?>">
  <table width="900" height="544" border="1" cellpadding="1" cellspacing="1" bordercolor="#000000">
    <tr>
      <td width="22%" rowspan="2" scope="col"><table border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
        
		<tr>
          <td><h3><span class="style3"> Click </span></h3></td>
          <td><input type=RADIO name="zoom" value=info <?php echo $checkClick; ?>>          </td>
        </tr>
		
		<tr>
          <td><h3><span class="style3"> Pan </span></h3></td>
          <td><input type=RADIO name="zoom" value=0 <?php echo $checkPan; ?>>          </td>
        </tr>
        <tr>
          <td><h3><span class="style3"> Zoom In </span></h3></td>
          <td><input type=RADIO name="zoom" value=1 <?php echo $checkZin; ?>>          </td>
        </tr>
        <tr>
          <td><h3><span class="style3"> Zoom Out </span></h3></td>
          <td><input type=RADIO name="zoom" value=-1 <?php echo $checkZout; ?>>          </td>
        </tr>
        <tr>
          <td><h3><span class="style3"> Zoom Size </span></h3></td>
          <td><input type=TEXT name="zsize" value="<?php echo $defSize; ?>"  size=2>          </td>
        </tr>
        <tr>
          <td> <h3>Full Extent </h3></td>
          <td><input type=SUBMIT name="full" value="Go"   size=2>          </td>
        </table>
        <br>
        <table width="140" height="151" border="1" align="center" cellpadding="2" cellspacing="2" bordercolor="#000000">
          <tr>
            <th scope="col"><img src="<?php echo $urlLegend; ?>" alt="leyenda" border="0" ></th>
          </tr>
		  
		  <tr>
            <th scope="col"><img src="<?php echo $urlKeyMap; ?>" border="0" ></th>
          </tr>
		  
		  
		  	 <tr>
            <th scope="col">
							
							
							
														
							<?php 
							    //AQUI GENERO LAS CAJAS DE CHECKEO
								$allLayersObject=$mapObject->getAllLayerNames();
								foreach ($allLayersObject as $idx => $layer) 
								{
									$layerObject=$mapObject->getLayerByName($layer);
									if ($layerObject->status==MS_ON) 
									{
										if(($layerObject->name != "Norte") )
										{
											for($i=0;$layerObject->getClass($i);$i++)
											{
												$Class = $layerObject->getClass($i);												
												echo "<input type='checkbox' value='{$layerObject->name}'  name='layerselector[]' onClick='document.frmlayerselector.submit();' checked>";
												echo "<span>{$Class->name}</span><br /> ";
											}
										}
									}
								else
									{
										if(($layerObject->name != "Norte") )
										{
											for($i=0;$layerObject->getClass($i);$i++)
											{
												$Class = $layerObject->getClass($i);
												echo "<input type='checkbox' value='{$layerObject->name}'  name='layerselector[]' onClick='document.frmlayerselector.submit();'  > ";
												echo "<span>{$Class->name}</span><br /> ";
											}
										}
									}
								}
							
							?>
							
	
							
							
					</th>
          </tr>
		  
		  
		  
		  
        </table></td>
      <td width="78%" height="499" scope="col"><div align="center">
        <input type=IMAGE name="mapa" src="<?php echo $urlImage; ?>" border=1>
      </div></td>
    </tr>
    <tr>
      <td scope="col"><div align="center"><img src="<?php echo $urlScale; ?>" border="0" ></div></td>
    </tr>
  </table>
  <INPUT TYPE=HIDDEN NAME="extent" VALUE="<?php echo $printExtentHTML; ?>">
</FORM>

</CENTER>
</BODY>
</HTML>


<?php

function GMapPix2Geo($nPixPos, $dfPixMin, $dfPixMax, $dfGeoMin, $dfGeoMax, $nInversePix) 
{
    $dfWidthGeo = $dfGeoMax - $dfGeoMin;
    $dfWidthPix = $dfPixMax - $dfPixMin;
   	$dfPixToGeo = $dfWidthGeo / $dfWidthPix;

    if (!$nInversePix)
        $dfDeltaPix = $nPixPos - $dfPixMin;
    else
        $dfDeltaPix = $dfPixMax - $nPixPos;

    $dfDeltaGeo = $dfDeltaPix * $dfPixToGeo;
	$dfPosGeo = $dfGeoMin + $dfDeltaGeo;
	return ($dfPosGeo);
}

?>