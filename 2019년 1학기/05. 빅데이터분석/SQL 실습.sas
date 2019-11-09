
/* ���� ���̺귯�� ����� */
libname sql "C:\Users\user\Desktop\University\�����ͺм�\Data";

/* SQL����� �⺻���� ���� */
proc sql;
title 'Population of Large Countries Grouped by Continent';
select Continent, sum(Population) as TotPop format=comma15.
from sql.countries
where Population gt 1000000
group by Continent
order by TotPop;
quit;

/* SELECT�� FROM�� �⺻ ���� */
/* "*"�� ��� ������ ��� */
proc sql;
select *
from sql.countries;
quit;

/* �α��� 500���� �̻��� ���� ��� */
proc sql;
select *
from sql.countries
where Population gt 5000000;
quit;

proc sql;
select *
from sql.countries
where Population > 5000000;
quit;

/* �α��� 500���� �̻��� �����߿��� �α��� ���� ������������ ����  */
proc sql;
select *
from sql.countries
where Population gt 5000000
order by Population desc;
quit;

/* ������� �� �α����� ���Ķ�. */
proc sql;
select Continent, sum(Population)
from sql.countries
group by Continent
order by Continent;
quit;

/* ������� �׷��� ����� ���� ����� ����, �ƽþƿ� ������ ����Ͽ���. */
proc sql;
select Continent, sum(Population)
from sql.countries
group by Continent
having Continent in ('Asia', 'Europe')
order by Continent;
quit;

/* SELECTING Columns 
libname sql 'SAS-library';
*/

/* uscitycoords ���Ͽ��� ��� ������  ��� */
proc sql outobs=12;
title 'U.S. Cities with Their States and Coordinates';
select *
from sql.uscitycoords;
quit ;

/* uscitycoords ���Ͽ��� City�� State ������ ��󳻼� ��� */
proc sql ;
title 'U.S. Cities with Their States and Coordinates';
select City, State
from sql.uscitycoords;
quit ;

/* distinct�� ����ϸ� �ߺ��� ���� �����Ͽ� �����ش� */
proc sql;
select distinct Continent
from sql.unitedstates;
quit ;

/* distinct�� ������� �ʾ��� �� */
proc sql;
select Continent
from sql.unitedstates;
quit ;

/*decribe�� �����Ϳ��� ������ ���� �ִ��� �� ������ Ư���� ���� �˷��ش�. */
proc sql;
describe table sql.unitedstates;
quit ;

/* ���ο� Į�� ����� */
proc sql outobs=12;
title 'U.S. Postal Codes';
select 'Postal code for', Name, 'is', Code
from sql.postalcodes;
quit ;

/* ����  ������ �� ���̱� */ 
/* #�̳� @�� ���� ����� �����ȴ�. */
proc sql outobs=12;
select 'Postal code for', Name label='@', 'is', Code label='#'
from sql.postalcodes;
quit ;

/* ���� ������ ����Ͽ� ���ο� ������ �� �����ϱ� */
proc sql outobs=12;
title 'Low Temperatures in Celsius';
select City, (AvgLow-32) * 5/9 format=4.1
from sql.worldtemps;
quit ;

/* ���� ������� ������ �̸� �ο��ϱ� */
proc sql outobs=12;
title 'Low Temperatures in Celsius';
select City, (AvgLow - 32) * 5/9 as LowCelsius format=4.1
from sql.worldtemps;
quit ;

/*���� ����� ���� */
/* calculated �� ����ϸ� ���� ������� ������ �Ǵٸ� ������ ���� �� �ִ�. */
proc sql outobs=12;
title 'Range of High and Low Temperatures in Celsius';
select City, (AvgHigh - 32) * 5/9 as HighC format=5.1,
(AvgLow - 32) * 5/9 as LowC format=5.1,
(calculated HighC-calculated LowC) as Range format=4.1
from sql.worldtemps;
quit;

/*�������� �ִ� ������ */
proc sql;
title 'Continental Low Points';
select Name, LowPoint as LowPoint
from sql.continents;
quit ;

/* ������ ó���ϱ� */
proc sql;
title 'Continental Low Points';
select Name, coalesce(LowPoint, 'Not Available') as LowPoint
from sql.continents;
quit ;


/* ����̶�� ���ο� ���� ����� gt, ge ���� ����!!! ������ ����!!! */
proc sql outobs=12;
title 'Climate Zones of World Cities';
select City, Country, Latitude,
case
when Latitude gt 67 then 'North Frigid'
when 67 ge Latitude ge 23 then 'North Temperate'
when 23 gt Latitude gt -23 then 'Torrid'
when -23 ge Latitude ge -67 then 'South Temperate'
else 'South Frigid'
end as ClimateZone
from sql.worldcitycoords
order by City;
quit ;

/* ���� ���� �ſ� ������ */
proc sql outobs=12;
title 'Assigning Regions to Continents';
select Name, Continent,
case Continent
when 'North America' then 'Continental U.S.'
when 'Oceania' then 'Pacific Islands'
else 'None'
end as Region
from sql.unitedstates;
quit;

/* Specifying Column Attributes(Format, informat, label, length): */
proc sql outobs=12;
title 'Assigning Regions to Continents';
select Name label='State', Area format=comma10.
from sql.unitedstates;
quit;

proc sql outobs=12;
title 'Assigning Regions to Continents';
select Name label='State', Area format=comma5.
from sql.unitedstates;
quit;

/*�����ϱ� */
proc sql outobs=12;
title 'Countries, Sorted by Continent and Name';
select Name, Continent
from sql.countries
order by Continent, Name;
quit;

/* ���ǿ� �´� �����͸� ��󳻱� */
proc sql;
title 'States with Populations over 5,000,000';
select Name, Population format=comma10.
from sql.unitedstates
where Population gt 5000000;
quit;

/* ���ǿ� �´� �����͸� ��󳻱� */
proc sql outobs=12;
title 'World Mountains and Waterfalls';
select Name, Type, Height format=comma10.
from sql.features
where Type in ('Mountain', 'Waterfall');
quit;

/* ������ ã�Ƴ��� */
proc sql;
title 'Countries with Missing Continents';
select Name, Continent
from sql.countries
where Continent is missing;
quit;

/* Between and or Operator */
proc sql outobs=12;
title 'Equatorial Cities of the World';
select City, Country, Latitude
from sql.worldcitycoords
where Latitude between -5 and 5;
quit;

/* Z�� �����ϰų� ____a �� ���Ե� ������ ã�� */
proc sql;
title1 'Country Names that Begin with the Letter "Z"';
title2 'or Are 5 Characters Long and End with the Letter "a"';
select Name
from sql.countries
where Name like 'Z%' or Name like '____a';
quit;

/* Using Truncated String Comparison Operators */
proc sql;
title '"New" U.S. States';
select Name
from sql.unitedstates
where Name EQT 'New ';
quit;

/* Using a WHERE Clause with Missing Values */
proc sql outobs=12;
title 'World Features with a Depth of Less than 500 Feet';
select Name, Depth
from sql.features
where Depth lt 500
order by Depth;
quit;

/* corrected output */
proc sql outobs=12;
title 'World Features with a Depth of Less than 500 Feet';
select Name, Depth
from sql.features
where Depth lt 500 and Depth is not missing
order by Depth;
quit ;

/* ============================================================================================================= */
/* ============================================================================================================= */
/* ============================================================================================================= */

proc sql outobs=12;
title 'Mean Temperatures for World Cities';
select City, Country, mean(AvgHigh, AvgLow) as MeanTemp
from sql.worldtemps
where calculated MeanTemp gt 75
order by MeanTemp desc;
quit;

proc sql;
title 'World Oil Reserves';
select sum(Barrels) format=comma18. as TotalBarrels
from sql.oilrsrvs;
quit;

proc sql outobs=12;
title 'Largest Country Populations';
select Name, Population format=comma20.,
max(Population) as MaxPopulation format=comma20.
from sql.countries
order by Population desc;
quit;

proc sql outobs=12;
title 'Percentage of World Population in Countries';
select Name, Population format=comma14.,
(Population / sum(Population) * 100) as Percentage
format=comma8.2
from sql.countries
order by Percentage desc;
quit;

proc sql;
title 'Number of Continents in the Countries Table';
select count(distinct Continent) as Count
from sql.countries;
quit;

proc sql;
title 'Number of Countries in the Sql.Countries Table';
select count(*) as Number
from sql.countries;
quit;

/* unexpected output */
proc sql;
title 'Average Length of Angel Falls, Amazon and Nile Rivers';
select Name, Length, avg(Length) as AvgLength
from sql.features
where Name in ('Angel Falls', 'Amazon', 'Nile');
quit;

proc sql;
title 'Total Populations of World Continents';
select Continent, sum(Population) format=comma14. as TotalPopulation
from sql.countries
where Continent is not missing
group by Continent;
quit;

proc sql outobs=12;
title 'High and Low Temperatures';
select City, Country, AvgHigh, AvgLow
from sql.worldtemps
group by Country;
quit;

proc sql ;
title 'Total Square Miles of Deserts and Lakes';
select Location, Type, sum(Area) as TotalArea format=comma16.
from sql.features
where type in ('Desert', 'Lake')
group by Location, Type;
quit;

proc sql;
title 'Total Square Miles of Deserts and Lakes';
select Location, Type, sum(Area) as TotalArea format=comma16.
from sql.features
where type in ('Desert', 'Lake')
group by Location, Type
order by Location desc;
quit;

/* unexpected output */
proc sql outobs=12;
title 'Areas of World Continents';
select Name format=$25., Continent,
sum(Area) format=comma12. as TotalArea
from sql.countries
group by Continent
order by Continent, Name;
quit;

proc sql outobs=12;
title 'Areas of World Continents';
select Name format=$25., Continent,
sum(Area) format=comma12. as TotalArea
from sql.countries
where Continent is not missing
group by Continent
order by Continent, Name;
quit;
