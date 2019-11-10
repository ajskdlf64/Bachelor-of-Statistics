

DATA ex6_1;
do market = 0.15, 0.22, 0.28, 0.35;
do money = 30 to 40 by 5;
do i = 1 to 3;
input sales @@;
output;
end; end; end;
cards;
74 64 60	92	 86 88	99 98 102
79 68 73	98 104 88	104 99 95
82 88 92	99 108 95	108 110 99
99 104 96	104 110 99	114 111 107
;
proc glm;
class market money;
model sales = market money market*money;
random market money market*money / test;
test h = market money e=market*money;

proc varcomp method=type1;
class market money;
model sales = market money market*money / fixed=0;
