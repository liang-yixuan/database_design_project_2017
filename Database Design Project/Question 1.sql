create index structureINX on BridgeStructure (YEAR_BUILT_027);
select YEAR_BUILT_027, count(distinct structure_number_008,state_code_001) as numberofbridge 
from BridgeStructure 
group by  YEAR_BUILT_027 
order by numberofbridge desc;
