BEGIN;
CREATE TABLE "puntos" (gid serial, "id" int4, "texto" varchar);
SELECT AddGeometryColumn('','puntos','the_geom','-1','POINT',2);
INSERT INTO "puntos" (gid,"id","texto","the_geom") VALUES ('0','0','punto0',GeometryFromText('POINT (-76.1134422003694 7.30859891978507)',-1) );
INSERT INTO "puntos" (gid,"id","texto","the_geom") VALUES ('1','1','punto1',GeometryFromText('POINT (-76.8876190793529 2.40547868622271)',-1) );
INSERT INTO "puntos" (gid,"id","texto","the_geom") VALUES ('2','2','punto2',GeometryFromText('POINT (-72.406777143418 3.34387490317244)',-1) );
INSERT INTO "puntos" (gid,"id","texto","the_geom") VALUES ('3','3','punto3',GeometryFromText('POINT (-73.5328526037576 10.4287663411429)',-1) );
INSERT INTO "puntos" (gid,"id","texto","the_geom") VALUES ('4','4','punto4',GeometryFromText('POINT (-70.6942040474847 -1.13696703276254)',-1) );
INSERT INTO "puntos" (gid,"id","texto","the_geom") VALUES ('5','5','punto5',GeometryFromText('POINT (-69.9669469793486 4.93914847198699)',-1) );
INSERT INTO "puntos" (gid,"id","texto","the_geom") VALUES ('6','6','punto6',GeometryFromText('POINT (-76.6295601196918 5.38488667503811)',-1) );
INSERT INTO "puntos" (gid,"id","texto","the_geom") VALUES ('7','7','punto7',GeometryFromText('POINT (-73.2747936440965 6.46404232453031)',-1) );

ALTER TABLE ONLY "puntos" ADD CONSTRAINT "puntos_pkey" PRIMARY KEY (gid);
SELECT setval ('"puntos_gid_seq"', 7, true);
END;
