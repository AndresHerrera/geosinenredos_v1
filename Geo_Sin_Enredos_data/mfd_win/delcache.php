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

		define('TMP_LONGPATH','C:\\ms4w\Apache\htdocs\mfd_win\tmp');
		define('TMP_BACTHDELCACHE','del_cache.bat');
		//Script Borrado de Cache en MapServer by: Andres Herrera
		// andres@hrglobalideas.com
		//TODO:  This Way Could be Dangerous but works
		//Try To remplace to a CGI-BIN Method or some automatization Task, maybe a Cron Job
		chdir(TMP_LONGPATH);
		system(TMP_BACTHDELCACHE);
		echo "<br><p>Cache Borrado Con Exito !!</p>";
?>