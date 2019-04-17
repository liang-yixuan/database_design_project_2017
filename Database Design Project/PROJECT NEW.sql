#  1.CREATE TABLE BRIDGE
CREATE TABLE BridgeStructure AS
SELECT STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
				YEAR_BUILT_027,STRUCTURE_LEN_MT_049,SERVICE_ON_042A,SERVICE_UND_042B,
                STRUCTURE_KIND_043A,STRUCTURE_TYPE_043B
FROM ALLBRIDGE;



#    DELECT DATA
SET SQL_SAFE_UPDATES = 0;
delete  from BRIDGESTRUCTURE where true;
SET SQL_SAFE_UPDATES = 1;

select * from BRIDGESTRUCTURE;


#设置pk
ALTER TABLE BRIDGESTRUCTURE 
ADD PRIMARY KEY (`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`);




#location
create table location(
STATE_CODE_001   VARCHAR(255),
STRUCTURE_NUMBER_008   VARCHAR(255),
RECORD_TYPE_005A   VARCHAR(255),
FED_AGENCY   VARCHAR(255),
LAT_016 VARCHAR(255),
LONG_017 VARCHAR(255)
);

alter table location
add primary key( `STATE_CODE_001`, `STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`);

alter table location
add foreign key(`STATE_CODE_001`, `STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`)
references BridgeStructure(`STATE_CODE_001`, `STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`);


insert into location (STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
			LAT_016,LONG_017)
select  distinct STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
			LAT_016,LONG_017
from  allbridge;

delete  from location where true;

#LengthsOfSegment
create table LengthsOfSegment(
STATE_CODE_001   VARCHAR(255),
STRUCTURE_NUMBER_008   VARCHAR(255),
RECORD_TYPE_005A   VARCHAR(255),
FED_AGENCY   VARCHAR(255),
HORR_CLR_MT_047 VARCHAR(255),
MAX_SPAN_LEN_MT_048 VARCHAR(255),
STRUCTURE_LEN_MT_049 VARCHAR(255)
);

alter table LengthsOfSegment
add primary key(`STATE_CODE_001`, `STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`),
add foreign key(`STATE_CODE_001`, `STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`)
references BridgeStructure(`STATE_CODE_001`, `STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`);


insert into LengthsOfSegment (STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
			HORR_CLR_MT_047,MAX_SPAN_LEN_MT_048,STRUCTURE_LEN_MT_049)
select STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
			HORR_CLR_MT_047,MAX_SPAN_LEN_MT_048,STRUCTURE_LEN_MT_049
from  allbridge;



#    DELECT DATA
SET SQL_SAFE_UPDATES = 0;
delete  from LengthsOfSegment where true;
SET SQL_SAFE_UPDATES = 1;


# 建立#42子表，以结构的类型
create table TypeOfServiceOnBridge(
SERVICE_ON_042A   VARCHAR(11)   NOT NULL UNIQUE,
TypeOfServiceOnBridge   VARCHAR(225) NOT NULL,
PRIMARY KEY (SERVICE_ON_042A));



INSERT INTO TypeOfServiceOnBridge
VALUES 
('1','Highway'),
('2','Railroad'),
('3','Pedestrian - bicycle'),
('4','Highway - railroad'),
('5','Highway - pedestrian'),
('6','Overpass structure at an interchange or second level of a multilevel interchange'),
('7','Third level (Interchange)'),
('8','Fourth level (Interchange)'),
('9','Building or plaza'),
('0','Other')
;


create table TypeOfServiceUnderBridge(
SERVICE_UND_042B   VARCHAR(11)   NOT NULL UNIQUE,
TypeOfServiceOnBridge   VARCHAR(50) NOT NULL,
PRIMARY KEY (SERVICE_UND_042B));



INSERT INTO TypeOfServiceUnderBridge
VALUES 
('1','Highway, with or without pedestrian'),
('2','Railroad'),
('3','Pedestrian - bicycle'),
('4','Highway - railroad'),
('5','Water way'),
('6','Highway- waterway'),
('7','Railroad - waterway'),
('8','Highway-waterway - railroad'),
('9','Relief for waterway'),
('0','Other')
;



# 设置FK
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE BRIDGESTRUCTURE
ADD foreign key (`SERVICE_ON_042A`) references TypeOfServiceOnBridge(`SERVICE_ON_042A`);
drop index SERVICE_ON_042A on bridgeStructure;

ALTER TABLE bridgeStructure
ADD foreign key (`SERVICE_UND_042B`) references TypeOfServiceUnderBridge(`SERVICE_UND_042B`);
drop index SERVICE_UND_042B on bridgeStructure;


# 建立子表，以结构的类型
create table bridgeStructureMaterialType(
 STRUCTURE_KIND_043A    VARCHAR(11)   NOT NULL UNIQUE  , 
 MaterialType_DESCP     VARCHAR(50) NOT NULL, 
 PRIMARY KEY (STRUCTURE_KIND_043A));

INSERT INTO bridgeStructureMaterialType
VALUES 
('1','Concrete'),
('2','Concrete continuous'),
('3','Steel'),
('4','Steel continuous'),
('5','Prestressed concrete'),
('6','Prestressed concrete continuous'),
('7','Wood or Timber'),
('8','Masonry'),
('9','Aluminum, Wrought Iron, or Cast Iron'),
('0','Other')
;



select * from bridgeStructureMaterialType;

# 
create table bridgeStructureDesignType(
 STRUCTURE_TYPE_043B     VARCHAR(11)     NOT NULL UNIQUE, 
 DesignType_DESCP     VARCHAR(50) NOT NULL, 
 PRIMARY KEY (STRUCTURE_TYPE_043B));


INSERT INTO bridgeStructureDesignType
VALUES 
('01','Slab'),
('02','Stringer/Multi-beam or Girder'),
('03','Girder and Floorbeam System'),
('04','Tee Beam'),
('05','Box Beam or Girders - Multiple'),
('06','Box Beam or Girders - Single or Spread'),
('07','Frame (except frame culverts)'),
('08','Orthotropic'),
('09','Truss - Deck'),
('10','Truss - Thru'),
('11','Arch - Dech'),
('12','Arch - Thru'),
('13','Suspension'),
('14','Stayed Girder'),
('15','Movable - Lift'),
('16','Movable - Bascul'),
('17','Movable - Swin'),
('18','Tunnel'),
('19','Culvert ( inclueds frame sulverts'),
('20','Mixed types'),
('21','Segmental Box Girder'),
('22','Channel Beam'),
('00','Other')
;



# 设置FK
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE BridgeStructure
ADD foreign key (`STRUCTURE_KIND_043A`) references bridgeStructureMaterialType(`STRUCTURE_KIND_043A`);
drop index STRUCTURE_KIND_043A on bridgeStructure;

ALTER TABLE BridgeStructure
ADD foreign key (`STRUCTURE_TYPE_043B`) references bridgeStructureDesignType(`STRUCTURE_TYPE_043B`);
drop index STRUCTURE_TYPE_043B on bridgeStructure;




#################################===========================#################################===========================#################################===========================
#CREATE TABLE route

CREATE TABLE InventoryRoute AS
SELECT  STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
						FUNCTIONAL_CLASS_026
FROM allbridge;


#删除数据
SET SQL_SAFE_UPDATES = 0;
delete  from InventoryRoute where true;
SET SQL_SAFE_UPDATES = 1;




#设置PK fk
ALTER TABLE InventoryRoute 
ADD PRIMARY KEY (`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`),
ADD foreign key (`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`)
		 references BridgeStructure(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`);


# 建立#26子表，以结构的类型
create table FunctionalClassification(
FUNCTIONAL_CLASS_026   VARCHAR(11)   NOT NULL UNIQUE,
FunctionalClassification   VARCHAR(225) NOT NULL,
PRIMARY KEY (FUNCTIONAL_CLASS_026));

INSERT INTO FunctionalClassification
VALUES 
('1','Principal Arterial - Interstate'),
('2','Principal Arterial - Other'),
('6','Minor Arterial'),
('7','Major Collector'),
('8','Minor Collector'),
('9','Local'),
('11','Principal Arterial - Interstate'),
('12','Principal Arterial - Other Freeways or Expressways'),
('14','Other Principal Arterial'),
('16','Minor Arterial'),
('17','Collector'),
('19','Local')
;



# 设置FK
SET FOREIGN_KEY_CHECKS = 1;
ALTER TABLE InventoryRoute
ADD foreign key (`FUNCTIONAL_CLASS_026`) references FunctionalClassification(`FUNCTIONAL_CLASS_026`);


create table RouteTRAFFIC(
STATE_CODE_001   VARCHAR(255),
STRUCTURE_NUMBER_008   VARCHAR(255),
RECORD_TYPE_005A   VARCHAR(255),
FED_AGENCY   VARCHAR(255),
TRAFFIC_LANES_ON_028A VARCHAR(255),
TRAFFIC_LANES_UND_028B VARCHAR(255),
ADT_029 VARCHAR(255),
YEAR_ADT_030 VARCHAR(255),
PERCENT_ADT_TRUCK_109 VARCHAR(255),
TRAFFIC_DIRECTION_102 varchar(255)
);


#create directionoftraffic

# 建立#102子表，以结构的类型
create table DirectionOfTraffic(
TRAFFIC_DIRECTION_102   VARCHAR(11)   NOT NULL UNIQUE,
DirectionOfTraffic   VARCHAR(225) NOT NULL,
PRIMARY KEY (TRAFFIC_DIRECTION_102));

INSERT INTO DirectionOfTraffic
VALUES 
('0','Highway traffic not carried.'),
('1','1-way traffic'),
('2','2-way traffic'),
('3','One lane bridge for 2-way traffic')
;

alter table RouteTRAFFIC
add primary key(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`),
add foreign key(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`)
references InventoryRoute(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`),
ADD foreign key (`TRAFFIC_DIRECTION_102`) references DirectionOfTraffic(`TRAFFIC_DIRECTION_102`);


insert into RouteTRAFFIC (STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
			TRAFFIC_LANES_ON_028A,TRAFFIC_LANES_UND_028B,ADT_029,YEAR_ADT_030,PERCENT_ADT_TRUCK_109,TRAFFIC_DIRECTION_102)
select STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
			TRAFFIC_LANES_ON_028A,TRAFFIC_LANES_UND_028B,ADT_029,YEAR_ADT_030,PERCENT_ADT_TRUCK_109,TRAFFIC_DIRECTION_102
from  allbridge;


create table highway(
STATE_CODE_001   VARCHAR(255),
STRUCTURE_NUMBER_008   VARCHAR(255),
RECORD_TYPE_005A   VARCHAR(255),
FED_AGENCY   VARCHAR(255),
DETOUR_KILOS_019 VARCHAR(255),
NATIONAL_NETWORK_110 VARCHAR(255),
STRAHNET_HIGHWAY_100 VARCHAR(255),
HIGHWAY_SYSTEM_104 VARCHAR(255));

#create table 100 ,102

# 建立#100子表，以结构的类型
create table STRAHNET_HighwayDesign(
STRAHNET_HIGHWAY_100   VARCHAR(11)   NOT NULL UNIQUE,
STRAHNET_HighwayDesign   VARCHAR(225) NOT NULL,
PRIMARY KEY (STRAHNET_HIGHWAY_100));

INSERT INTO STRAHNET_HighwayDesign
VALUES 
('0','The inventory route is not a STRAHNET route.'),
('1','The inventory route is on a Interstate STRAHNET route.'),
('2','The inventory route is on a Non-Interstate STRAHNET route.'),
('3','The inventory route is on a STRAHNET connector route.')
;

# 建立#104子表，以结构的类型
create table HighwaySystemOfRoute(
HIGHWAY_SYSTEM_104   VARCHAR(11)   NOT NULL UNIQUE,
HighwaySystemOfRoute   VARCHAR(225) NOT NULL,
PRIMARY KEY (HIGHWAY_SYSTEM_104));

INSERT INTO HighwaySystemOfRoute
VALUES 
('0','Inventory Route is not on the NHS.'),
('1','Inventory Route is on the NHS')
;



alter table highway
add primary key(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`),
add foreign key(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`)
references InventoryRoute(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`),
ADD foreign key (`STRAHNET_HIGHWAY_100`) references STRAHNET_HighwayDesign(`STRAHNET_HIGHWAY_100`),
ADD foreign key (`HIGHWAY_SYSTEM_104`) references HighwaySystemOfRoute(`HIGHWAY_SYSTEM_104`);


insert into highway (STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
			DETOUR_KILOS_019,NATIONAL_NETWORK_110,STRAHNET_HIGHWAY_100,HIGHWAY_SYSTEM_104)
select STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
			DETOUR_KILOS_019,NATIONAL_NETWORK_110,STRAHNET_HIGHWAY_100,HIGHWAY_SYSTEM_104
from  allbridge;




####################################################################################################################################################################################

#建立subtype table
#CREATE TABLE OnBRIDGE
CREATE TABLE RouteOnBridge AS
SELECT STATE_CODE_001,STRUCTURE_NUMBER_008,FED_AGENCY,RECORD_TYPE_005A,
				DESIGN_LOAD_031,RAILINGS_036A,TRANSITIONS_036B,APPR_RAIL_036C,APPR_RAIL_END_036D,APPR_KIND_044A,APPR_TYPE_044B,
				IMP_LEN_MT_076,BRIDGE_IMP_COST_094,ROADWAY_IMP_COST_095,TOTAL_IMP_COST_096,YEAR_OF_IMP_097,OTHER_STATE_CODE_098A,
                OTHER_STATE_PCNT_098B,YEAR_RECONSTRUCTED_106,
                HISTORY_037,OPEN_CLOSED_POSTED_041,FEDERAL_LANDS_105,SURFACE_TYPE_108A,MEMBRANE_TYPE_108B,DECK_PROTECTION_108C
                FROM ALLBRIDGE;



#DELECT DATA
SET SQL_SAFE_UPDATES = 0;
delete  from RouteOnBridge where true;
SET SQL_SAFE_UPDATES = 1;


#设置pk
ALTER TABLE RouteOnBridge 
ADD PRIMARY KEY (`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`),
#设置fk
ADD foreign key (`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`)
		 references InventoryRoute(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`);


# 建立#37
create table HistorySignificance(
HISTORY_037   VARCHAR(1)   NOT NULL UNIQUE,
HistoryDescription   VARCHAR(225) NOT NULL,
PRIMARY KEY (HISTORY_037));

INSERT INTO HistorySignificance
VALUES 
('1','Bridge is on the National Register of Historic Places.'),
('2','Bridge is eligible for the National Register of Historic Places.'),
('3','Bridge is possibly eligible for the National Register of Historic Places (requires further investigation before determination can be made) or bridge is on a State or local historic register.'),
('4','Historical significance is not determinable at this time.'),
('5','Bridge is not eligible for the National Register of Historic Places.')
;

# 建立#41

#ITEM41
create table OpenPostedClosed(
OPEN_CLOSED_POSTED_041   VARCHAR(11)   NOT NULL UNIQUE,
OpenPostedClosed_Description  VARCHAR(225) NOT NULL,
PRIMARY KEY (OPEN_CLOSED_POSTED_041));

INSERT INTO OpenPostedClosed
VALUES 
('A','Open, no restriction'),
('B','Open, posting recommended but not legally implemented (all signs not in place or not correctly implemented)'),
('D','Open, would be posted or closed except for temporary shoring, etc. to allow for unrestricted traffic'),
('E','Open, temporary structure in place to carry legal loads while original structure is closed and awaiting replacement or rehabilitation'),
('G','Highway traffic not carried'),
('K','Bridge closed to all traffic'),
('P','restrictions such as temporary bridges which are load posted)'),
('R','Posted for other load-capacity restriction (speed, number of vehicles on bridge, etc.)')
;
# 建立#105
# ITEM105
create table FederalLandsHighways(
FEDERAL_LANDS_105   VARCHAR(1)   NOT NULL UNIQUE,
FederalHighwaysDescription   VARCHAR(225) NOT NULL,
PRIMARY KEY (FEDERAL_LANDS_105));

INSERT INTO FederalLandsHighways
VALUES 
('1','Indian Reservation Road (IRR)'),
('2','Forest Highway (FH)'),
('3','Land Management Highway System (LMHS)'),
('4','Both IRR and FH'),
('5','Both IRR and LMHS'),
('9','Combined IRR, FH and LMHS')
;

# 建立#108

create table TypeOfWearingSurface(
SURFACE_TYPE_108A   VARCHAR(11)   NOT NULL UNIQUE,
TypeOfWearingSurface   VARCHAR(225) NOT NULL,
PRIMARY KEY (SURFACE_TYPE_108A));

INSERT INTO TypeOfWearingSurface
VALUES 
('1','Monolithic Concrete (concurrently placed with structural deck)'),
('2','Integral Concrete (separate non-modified layer of concrete added to structural deck)'),
('3','Latex Concrete or similar additive'),
('4','LowSlump Concrete'),
('5','Epoxy Overlay'),
('6','Bituminous'),
('7','Wood or Timber'),
('8','Gravel'),
('9','Other'),
('0','None (no additional concrete thickness or wearing surface is included in the bridge deck)'),
('N','Not Applicable (applies only to structures with no deck)')
;


create table TypeOfMembrane(
MEMBRANE_TYPE_108B   VARCHAR(11)   NOT NULL UNIQUE,
TypeOfMembrane   VARCHAR(225) NOT NULL,
PRIMARY KEY (MEMBRANE_TYPE_108B));

INSERT INTO TypeOfMembrane
VALUES 
('1','Built-up'),
('2','Preformed Fabric'),
('3','Epoxy'),
('8','Unknown'),
('9','Other'),
('0','None'),
('N','Not Applicable (applies only to structures with no deck)')
;

create table DeckProtection(
DECK_PROTECTION_108C   VARCHAR(11)   NOT NULL UNIQUE,
DeckProtection   VARCHAR(225) NOT NULL,
PRIMARY KEY (DECK_PROTECTION_108C));

INSERT INTO DeckProtection
VALUES 
('1','Epoxy Coated Reinforcing'),
('2','Galvanized Reinforcing'),
('3','Other Coated Reinforcing'),
('4','Cathodic Protection'),
('6','Pol ymer I mpr egnat ed'),
('7','Internally Sealed'),
('8','Unknown'),
('9','Other'),
('0','None'),
('N','Not Applicable (applies only to structures with no deck)')
;



#建立fk
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE RouteOnBridge
ADD foreign key (`HISTORY_037`) references HistorySignificance(`HISTORY_037`),
ADD foreign key (`OPEN_CLOSED_POSTED_041`) references OpenPostedClosed(`OPEN_CLOSED_POSTED_041`),
ADD foreign key (`FEDERAL_LANDS_105`) references FederalLandsHighways(`FEDERAL_LANDS_105`),
ADD foreign key (`SURFACE_TYPE_108A`) references TypeOfWearingSurface(`SURFACE_TYPE_108A`),
ADD foreign key (`MEMBRANE_TYPE_108B`) references TypeOfMembrane(`MEMBRANE_TYPE_108B`),
ADD foreign key (`DECK_PROTECTION_108C`) references DeckProtection(`DECK_PROTECTION_108C`);


#rate
create table ConditionRate(
STATE_CODE_001   VARCHAR(255),
STRUCTURE_NUMBER_008   VARCHAR(255),
RECORD_TYPE_005A   VARCHAR(255),
FED_AGENCY   VARCHAR(255),
DECK_COND_058 VARCHAR(255),
SUPERSTRUCTURE_COND_059  VARCHAR(255),
SUBSTRUCTURE_COND_060  VARCHAR(255));


create table ratedesc(
Rating_Code  Varchar(1) not null unique,
ConditionRatingsDescription   VARCHAR(225) NOT NULL
);

ALTER TABLE ratedesc
ADD PRIMARY KEY (`Rating_Code`);

INSERT INTO ratedesc
VALUES 
('0','FAILED CONDITION'),
('1','"IMMINENT" FAILURE CONDITION'),
('2','CRITICAL CONDITION'),
('3','SERIOUS CONDITION'),
('4','POOR CONDITION'),
('5','FAIR CONDITION'),
('6','SATISFACTORY CONDITION'),
('7','GOOD CONDITION'),
('8','VERY GOOD CONDITION'),
('9','EXCELLENT CONDITION'),
('N','NOT APPLICABLE')
;

alter table ConditionRate
add primary key(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`),
add foreign key(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`)
references InventoryRoute(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`),
add foreign key(`DECK_COND_058`) references ratedesc ( `Rating_Code`),
add foreign key(`SUPERSTRUCTURE_COND_059`) references ratedesc ( `Rating_Code`),
add foreign key(`SUBSTRUCTURE_COND_060`) references ratedesc ( `Rating_Code`);


insert into ConditionRate (STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
			DECK_COND_058,SUPERSTRUCTURE_COND_059,SUBSTRUCTURE_COND_060)
select STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
			DECK_COND_058,SUPERSTRUCTURE_COND_059,SUBSTRUCTURE_COND_060
from  allbridge;


#Appraisal Ratings
create table AppraisalRate(
STATE_CODE_001   VARCHAR(255),
STRUCTURE_NUMBER_008   VARCHAR(255),
RECORD_TYPE_005A   VARCHAR(255),
FED_AGENCY   VARCHAR(255),
STRUCTURAL_EVAL_067 VARCHAR(255),
DECK_GEOMETRY_EVAL_068 VARCHAR(255),
UNDCLRENCE_EVAL_069 VARCHAR(255),
POSTING_EVAL_070 VARCHAR(255),
WATERWAY_EVAL_071 VARCHAR(255),
APPR_ROAD_EVAL_072 VARCHAR(255));


create table AppraisalRateDesc(
Rate_Code  Varchar(1) not null unique,
AppraisalRatingsDescription   VARCHAR(225) NOT NULL
);

ALTER TABLE AppraisalRateDesc
ADD PRIMARY KEY (`Rate_Code`);

INSERT INTO AppraisalRateDesc
VALUES 
('0','Bridge closed'),
('1','This value of rating code not used'),
('2','Basically intolerable requiring high priority of replacement'),
('3','Basically intolerable requiring high priority of corrective action'),
('4','Meets minimum tolerable limits to be left in place as is'),
('5','Somewhat better than minimum adequacy to tolerate being left in place as is'),
('6','Equal to present minimum criteria'),
('7','Better than present minimum criteria'),
('8','Equal to present desirable criteria'),
('9','Superior to present desirable criteria'),
('N','Not applicable')
;


alter table AppraisalRate
add primary key(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`),
add foreign key(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`)
references InventoryRoute(`STATE_CODE_001`,`STRUCTURE_NUMBER_008`,`RECORD_TYPE_005A`,`FED_AGENCY`),
add foreign key(`STRUCTURAL_EVAL_067`) references AppraisalRateDesc ( `Rate_Code`),
add foreign key(`DECK_GEOMETRY_EVAL_068`) references AppraisalRateDesc ( `Rate_Code`),
add foreign key(`UNDCLRENCE_EVAL_069`) references AppraisalRateDesc ( `Rate_Code`),
add foreign key(`POSTING_EVAL_070`) references AppraisalRateDesc ( `Rate_Code`),
add foreign key(`WATERWAY_EVAL_071`) references AppraisalRateDesc ( `Rate_Code`),
add foreign key(`APPR_ROAD_EVAL_072`) references AppraisalRateDesc ( `Rate_Code`);



insert into AppraisalRate (STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
			STRUCTURAL_EVAL_067,DECK_GEOMETRY_EVAL_068,UNDCLRENCE_EVAL_069,POSTING_EVAL_070,WATERWAY_EVAL_071,APPR_ROAD_EVAL_072)
select STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
			STRUCTURAL_EVAL_067,DECK_GEOMETRY_EVAL_068,UNDCLRENCE_EVAL_069,POSTING_EVAL_070,WATERWAY_EVAL_071,APPR_ROAD_EVAL_072
from  allbridge;

####################################################################################################################################################################################
insert into RouteOnBridge (STATE_CODE_001,STRUCTURE_NUMBER_008,FED_AGENCY,RECORD_TYPE_005A,
				DESIGN_LOAD_031,RAILINGS_036A,TRANSITIONS_036B,APPR_RAIL_036C,APPR_RAIL_END_036D,APPR_KIND_044A,APPR_TYPE_044B,
				IMP_LEN_MT_076,BRIDGE_IMP_COST_094,ROADWAY_IMP_COST_095,TOTAL_IMP_COST_096,YEAR_OF_IMP_097,OTHER_STATE_CODE_098A,
                OTHER_STATE_PCNT_098B,YEAR_RECONSTRUCTED_106,
                HISTORY_037,OPEN_CLOSED_POSTED_041,FEDERAL_LANDS_105,SURFACE_TYPE_108A,MEMBRANE_TYPE_108B,DECK_PROTECTION_108C)
select STATE_CODE_001,STRUCTURE_NUMBER_008,FED_AGENCY,RECORD_TYPE_005A,
				DESIGN_LOAD_031,RAILINGS_036A,TRANSITIONS_036B,APPR_RAIL_036C,APPR_RAIL_END_036D,APPR_KIND_044A,APPR_TYPE_044B,
				IMP_LEN_MT_076,BRIDGE_IMP_COST_094,ROADWAY_IMP_COST_095,TOTAL_IMP_COST_096,YEAR_OF_IMP_097,OTHER_STATE_CODE_098A,
                OTHER_STATE_PCNT_098B,YEAR_RECONSTRUCTED_106,
                HISTORY_037,OPEN_CLOSED_POSTED_041,FEDERAL_LANDS_105,SURFACE_TYPE_108A,MEMBRANE_TYPE_108B,DECK_PROTECTION_108C
from AllBridge
where RECORD_TYPE_005A='1';
####################################################################################################################################################################################

insert into InventoryRoute (STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
						FUNCTIONAL_CLASS_026)
select STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
						FUNCTIONAL_CLASS_026
from  allbridge;

####################################################################################################################################################################################


insert into BRIDGESTRUCTURE(STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
				YEAR_BUILT_027,STRUCTURE_LEN_MT_049,SERVICE_ON_042A,SERVICE_UND_042B,
                STRUCTURE_KIND_043A,STRUCTURE_TYPE_043B)
select STATE_CODE_001,STRUCTURE_NUMBER_008,RECORD_TYPE_005A,FED_AGENCY,
				YEAR_BUILT_027,STRUCTURE_LEN_MT_049,SERVICE_ON_042A,SERVICE_UND_042B,
                STRUCTURE_KIND_043A,STRUCTURE_TYPE_043B
from allbridge;







