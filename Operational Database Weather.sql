CREATE DATABASE "Operational_Database_Weather"
GO

USE "Operational_Database_Weather"
GO

CREATE TABLE "STATION"
(
	"StationID" varchar (20)
	, "elevation" numeric (20)
	, "callLetters" varchar (10)
	, "type" varchar (20)
	, "position.type" varchar (10)
	, "position.coor.long" numeric (20)
	, "position.coor.lat" numeric (20)
	CONSTRAINT Pk_STATION PRIMARY KEY
	(
		"StationID"
	)
)
GO

CREATE TABLE "STATION_SECTION"
(
	"Section" varchar (10)
	, "StationID" varchar (20) 
	CONSTRAINT Pk_STATION_SECTION PRIMARY KEY
	(
		"Section"
	),
	CONSTRAINT Fk_STATION_SECTION_STATION FOREIGN KEY 
	(
	"StationID" 
	) REFERENCES "STATION" ( 
	"StationID" 
	)
)
GO

CREATE TABLE "ATMOSPHERE" (
	"AtmosphereID" varchar (10)
	, "atmosPressChange.tend.code" varchar (20)
	, "atmosPressChange.tend.quality" varchar (5)
	, "atmosPressChange.quant3H.value" numeric (20)
	, "atmosPressChange.quant3H.quality" varchar (5)
	, "atmosPressChange.quant24H.quality" varchar (5)
	, "atmosPressChange.quant24H.value" numeric (20)
	, "atmosPressObs.altimetSettng.value" varchar (20)
	, "atmosPressObs.altimetSettng.qual" varchar (20)
	, "atmosPressObs.statPress.value" numeric (20)
	, "atmosPressObs.statPress.qual" varchar (10)
	, "StationID" varchar (20)
	CONSTRAINT Pk_ATMOSPHERE PRIMARY KEY
	(
		"AtmosphereID"
	),
	CONSTRAINT Fk_ATMOSPHERE_STATION FOREIGN KEY 
	(
	"StationID"
	) REFERENCES "STATION" ( 
	"StationID" 
	)
)
GO

CREATE TABLE "SKY"
(
	"SkyID" varchar (10)
	, "AtmosphereID" varchar (10)
	, "skyCond.ceilingHeight.value" varchar (10)
	, "skyCond.ceilingHeight.qual" varchar (10)
	, "sCond.ceilHeight.determination" varchar (10)
	, "skyCondition.cavok" varchar (10) 
	, "skyCondObstotalCoverage.value" numeric (10)
	, "sCondObstotalCoverage.opaque" varchar (10)
	, "skyCondObstotalCoverage.qual" varchar (10)
	, "sConO.lowetCldCov.value" numeric (10)
	, "sConO.lowestCloudCov.qual" varchar (10)
	, "sConOb.lowClGen.value" numeric (10)
	, "sConOb.lowClGen.qual" varchar (10)
	, "sConOb.lowClBheight.qual" numeric (10)
	, "sConOb.lowClBheight.value" varchar (10)
	, "sConOb.MidClGen.qual" numeric (10)
	, "sConOb.MidClGen.value" varchar (10)
	, "sConOb.HiClGen.qual" numeric (10)
	, "sConOb.HiClGen.value" varchar (10)
	CONSTRAINT Fk_SKY PRIMARY KEY
	(
		"SkyID"
	),
	CONSTRAINT Fk_SKY_ATMOSPHERE FOREIGN KEY 
	(
	"AtmosphereID" 
	) REFERENCES "ATMOSPHERE" ( 
	"AtmosphereID" 
	)
)
GO

CREATE TABLE "SKY_SkyCoverLayer"
(
	"coverage.value" numeric (10)
	, "coverage.quality" varchar (10)
	, "baseHeight.value" numeric (10)
	, "baseHeight.qual" varchar (10)
	, "cloudtype.value" numeric (10)
	, "cloudtype.qual" varchar (10)
	, "SkyID" varchar (10)
	CONSTRAINT Pk_SKY_SkyCoverLayer PRIMARY KEY
	(
		"coverage.value", "coverage.quality",
		"baseHeight.value", "cloudtype.value",
		"cloudtype.qual"
	),
	CONSTRAINT Fk_SKY_SkyCoverLayer_SKY FOREIGN KEY 
	(
	"SkyID" 
	) REFERENCES "SKY" ( 
	"SkyID" 
	)
)
GO

CREATE TABLE "AIR"
(
	"AirID" VARCHAR (10)
	, "dewPoint.value" numeric (20)
	, "dewPoint.quality" varchar (10)
	, "extremAirTemp.code" varchar (10)
	, "extremAirTemp.period" numeric (10)
	, "extremAirTemp.value" numeric (20)
	, "extremAirTemp.quantity" numeric (20)
	, "airTemperature.value" numeric (10)
	, "airTemperature.qual" varchar (10)
	, "AtmosphereID" varchar (10)
	CONSTRAINT Pk_AIR PRIMARY KEY
	(
		"AirID"
	),
	CONSTRAINT Fk_AIR_ATMOSPHERE FOREIGN KEY 
	(
	"AtmosphereID" 
	) REFERENCES "ATMOSPHERE" ( 
	"AtmosphereID" 
	)
)
GO

CREATE TABLE "WIND"
(
	"WinID" varchar (10)
	,"AirID" varchar (10)
	,"wind.direction.angle" numeric (10)
	,"wind.direction.quality" varchar (10)
	,"wind.type" varchar (10)
	,"wind.speed.rate" numeric (10)
	,"wind.speed.quality" varchar (10)
	CONSTRAINT Pk_ PRIMARY KEY
	(
		"WinID"
	),
	CONSTRAINT Fk_WIND FOREIGN KEY 
	(
	"AirID" 
	) REFERENCES "AIR" ( 
	"AirID" 
	)
)
GO

CREATE TABLE "PRECIPITATION" (
	"PrecipitationID" varchar (10) ,
	"EstiObs.Discrepancy" varchar (10) ,
	"EstiObs.estiWaterDepth" numeric (20) ,
	"AtmosphereID" varchar (10)
	CONSTRAINT Pk_PRECIPITATION PRIMARY KEY
	(
		"PrecipitationID"
	),
	CONSTRAINT Fk_PRECIPITATION_ATMOSPHERE FOREIGN KEY 
	(
	"AtmosphereID" 
	) REFERENCES "ATMOSPHERE" ( 
	"AtmosphereID" 
	)
)
GO

CREATE TABLE "PRECIPITATION_LIQUIDPRE" (
	"liquidPre.period" numeric (10) ,
	"liquidPre.depth" numeric (10) ,
	"liquidPre.condition" varchar (19) ,
	"liquidPre.quality" varchar (10) ,
	"PrecipitationID" varchar (10) ,
	CONSTRAINT Pk_PRECIPITATION_LIQUIDPRE PRIMARY KEY
	(
		"liquidPre.period" , "liquidPre.depth" , "liquidPre.condition" ,
		"liquidPre.quality"
	),
	CONSTRAINT Pk_PRECIPITATION_LIQUIDPRE_PRECIPITATION FOREIGN KEY
	(
		"PrecipitationID"
	) REFERENCES "PRECIPITATION" (
	"PrecipitationID"
	)
)
GO

CREATE TABLE "SEA" 
(
	"SeaID" varchar (10)
	, "SeaSurfaceTemp.value" numeric (10)
	, "SeaSurfaceTemp.qual" varchar (10)
	, "AtmosphereID" varchar (10)
	CONSTRAINT Pk_SEA PRIMARY KEY
	(
		"SeaID"
	),
	CONSTRAINT Fk_SEA_ATMOSPHERE FOREIGN KEY 
	(
	"AtmosphereID" 
	) REFERENCES "ATMOSPHERE" ( 
	"AtmosphereID" 
	)
)
GO

CREATE TABLE "WAVE"
(
	"WaveID" varchar (10)
	, "WaveMeas.method" varchar (10)
	, "WaveMeas.waves.period" numeric (10)
	, "waveMeas.waves.height" numeric (10)
	, "waveMeas.waves.quality" varchar (10)
	, "waveMeas.seaState.code" varchar (10)
	, "waveMeas.seaState.quality" varchar (10)
	, "SeaID" varchar (10)
	CONSTRAINT Pk_WAVE PRIMARY KEY
	(
		"WaveID"
	),
	CONSTRAINT Fk_WAVE_SEA FOREIGN KEY 
	(
	"SeaID" 
	) REFERENCES "SEA" ( 
	"SeaID" 
	)
)
GO

CREATE TABLE "WEATHER"
(
	"WeatherID" varchar (10)
	, "pastObsWeaManu.atmosCond.value" numeric (10)
	, "pastObsWeaManu.atmosCond.qual" varchar (10)
	, "pastObsWeaManu.period.value" numeric (10)
	, "pastObsWeaManu.period.qual" varchar (10)
	, "presweaObsManu.Condition" varchar (10)
	, "presweaObsManu.qual" varchar (10)
	, "AtmosphereID" varchar (10)
	CONSTRAINT Pk_WEATHER PRIMARY KEY
	(
		"WeatherID"
	),
	CONSTRAINT Fk_WEATHER_ATMOSPHERE FOREIGN KEY 
	(
	"AtmosphereID" 
	) REFERENCES "ATMOSPHERE" ( 
	"AtmosphereID" 
	)
)
GO

CREATE TABLE "VISIBILITY"
(
	"VisibilityID" varchar (10)
	, "visibility.distance.value" numeric (10)
	, "visibility.distance.quality" varchar (10)
	, "visibility.variability.value" numeric (10)
	, "visibility.variability.quality" varchar (10)
	, "WeatherID" varchar (10)
	CONSTRAINT Pk_VISIBILITY PRIMARY KEY
	(
		"VisibilityID"
	),
	CONSTRAINT Fk_VISIBILITY_WEATHER FOREIGN KEY 
	(
	"WeatherID" 
	) REFERENCES "WEATHER" ( 
	"WeatherID" 
	)
)
GO
