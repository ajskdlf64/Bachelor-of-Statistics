DATA;
INPUT Severity $ gender $ survival $ count;
DATALINES;
Little man dead 2
Little man live 21
Little woman dead 0
Little woman live 10
Often man dead 2
Often man live 40
Often woman dead 0
Often woman live 18
Usually man dead 6
Usually man live 33
Usually woman dead 0
Usually woman live 10
Very man dead 17
Very man live 16
Very woman dead 0
Very woman live 4
;
PROC FREQ ORDER=DATA;
WEIGHT count;
TABLES severity*gender*survival / CMH;
RUN;
