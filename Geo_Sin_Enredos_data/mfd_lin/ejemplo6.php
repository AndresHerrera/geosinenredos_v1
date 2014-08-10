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

	$mapObject = ms_newMapObj("ejemplo6.map");
	$defSize=3;
	$checkPan="CHECKED";

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
		} 
	else 
		if ($zoomFactor < 0) 
		{
            $checkPan = "";
			$checkZout = "CHECKED";
			$checkZin = "";
		} 
	else 
		{
            $checkPan = "";
            $checkZout = "";
			$checkZin = "CHECKED";
		}

		$defSize = abs($zoomFactor);

		$mapObject->zoompoint($zoomFactor,$pointObject,$mapObject->width,$mapObject->height,$extentRectObject);
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

?>
<HTML>
<HEAD>
<title>Ejemplo 6 -  MapScript for Dummies</title>
<style type="text/css">
<!--
.style3 {font-size: 18px; font-weight: bold; }
-->
</style>
</HEAD>
<BODY>
<CENTER>
<FORM METHOD=POST ACTION=<?php echo $HTTP_SERVER_VARS['PHP_SELF']?>>
  <table width="900" height="544" border="1" cellpadding="1" cellspacing="1" bordercolor="#000000">
    <tr>
      <td width="22%" rowspan="2" scope="col"><table border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#000000">
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