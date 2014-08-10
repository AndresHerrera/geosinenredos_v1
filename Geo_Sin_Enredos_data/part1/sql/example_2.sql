-- #######################################################
-- #	Document: (Geo .. Sin Enredos + Ejemplos y Extras)
-- #	Version: 0.1.1
-- #   Licence: GNU GPL
-- #	Autor: Andres Herrera
-- #   Contact: t763rm3n at gmail.com	
-- #######################################################

BEGIN;
CREATE TABLE "example_2_poligono" (gid serial PRIMARY KEY,
"id" int8,
"nombre" varchar(80));
SELECT AddGeometryColumn('','example_2_poligono','the_geom','-1','MULTIPOLYGON',2);
INSERT INTO "example_2_poligono" ("id","nombre",the_geom) VALUES ('1','Poligono1','0106000000010000000103000000010000000A0000005980F65880F6ECBFB82C8FB62C8FEE3F23E83623E836DBBF81A71D80A71DE03FE94C74EA4C74CABFA4B5F0A1B5F0D13FE94C74EA4C74CABFA4B5F0A1B5F0D13F31FA4835FA48B5BFDA4AADD44AADB43F31FA4835FA48B5BFDA4AADD44AADB43F8D18B68E18B6CEBF156753186753B8BF8D18B68E18B6CEBF156753186753B8BF4B4B4B4B4B4BF1BF5C081C57081CB73F5980F65880F6ECBFB82C8FB62C8FEE3F');
INSERT INTO "example_2_poligono" ("id","nombre",the_geom) VALUES ('2','Poligono2','01060000000100000001030000000100000005000000B4B1B1B1B1B1D93F7A16EF7816EFE83F966DF7946DF7F23F5A081C57081CC73FEE4C74EA4C74CA3FB33CDAB23CDAE2BF23735F24735FC4BF5E0E225D0E22E53FB4B1B1B1B1B1D93F7A16EF7816EFE83F');
INSERT INTO "example_2_poligono" ("id","nombre",the_geom) VALUES ('3','Poligono3','010600000001000000010300000001000000070000007D923442610FF6BF3159CF31596FBBBF3AA435D67C55D2BF0B6E950B6E01D8BF3AA435D67C55D2BF0B6E950B6E01D8BF3AA435D67C55D2BF0B6E950B6E01D8BF47A66680573CD5BF3E5B00DC3356EEBFCD00AFF4F6BAF5BFE4B80D96CC20EFBF7D923442610FF6BF3159CF31596FBBBF');
INSERT INTO "example_2_poligono" ("id","nombre",the_geom) VALUES ('4','Poligono4','010600000001000000010300000001000000050000000A073980E952F6BF12D45488362EE43F7E77DB69BCC8F0BFAC2F3198F411E23F4FDADE1329C6E4BF642BE1297A7DCC3FB7CA05B74A4AF3BF2472F75F23CFDDBF0A073980E952F6BF12D45488362EE43F');
INSERT INTO "example_2_poligono" ("id","nombre",the_geom) VALUES ('5','Poligono5','010600000001000000010300000001000000060000007A46318F81A7E93FECE81A624BC0E0BF7A5D1FA0D303D1BF98FDF2219B8BEDBF7A5D1FA0D303D1BF98FDF2219B8BEDBF7A5D1FA0D303D1BF98FDF2219B8BEDBF3C6C6461931A85BFFE6B6461931AC5BF7A46318F81A7E93FECE81A624BC0E0BF');
END;