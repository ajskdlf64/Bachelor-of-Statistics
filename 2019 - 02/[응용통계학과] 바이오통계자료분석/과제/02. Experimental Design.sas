
data one ;
do car = "1", "2", "3", "4" ;
do brand = "A", "B", "C", "D" ;
input abrasion @@ ;
output ;
end ;
end;
datalines ;
17 14 12 13
14 14 12 11
13 13 10 11
13 8 9 9
run;

proc glm data = one;
class car brand;
model abrasion = car brand/solution p;
run;

data two ;
do TypePatient = "Cardiac", "Cancer", "C.V.A.", "Tuberculosis" ;
do i = 1 to 5 ;
do AgeGroup = 1 to 4 ;
input stay @@;
output ;
end ;
end;
end;
datalines ;
20 25 24 28		25 30 28 31		22 29 24 26		27 28 25 29		21 30 30 32
30 30 39 40		45 29 42 45		30 31 36 50		35 30 42 45		36 30 40 60
31 32 41 42		30 35 45 50		40 30 40 40		35 40 40 55		30 30 35 45
20 23 24 29		21 25 25 30		20 28 30 28		20 30 26 27		19 31 23 30
run;

proc glm data = two ;
class TypePatient AgeGroup ;
model stay = TypePatient AgeGroup TypePatient * AgeGroup ;
run;
