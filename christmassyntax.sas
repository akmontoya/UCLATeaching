PROC IMPORT OUT= christmas
            DATAFILE= "C:\Users\montoya.29\Documents\Job Application Materials\UCLA Application\Interview Materials\christmasdata.sav" 
            DBMS=SPSS REPLACE;

RUN;

data christmas; set christmas; 
d1 = (religion = 1);
d2 = (religion = 2);
d3 = (religion = 3); run;
proc reg data = christmas; model included = d1 d2 d3; run;

data christmas; set christmas;
s1 = (religion ^= 1);
s2 = (religion > 2);
s3 = (religion = 4); run;
proc reg data = christmas; model included = s1 s2 s3; run;

data christmas; set christmas;
h1 = -3/4*(religion = 1) + 1/4*(religion > 1);
h2 = -2/3*(religion = 4) + 1/3*((religion = 2) | (religion = 3));
h3 = -1/2*(religion = 2) + 1/2*(religion = 3); run;
proc reg data = christmas; model included = h1 h2 h3; run;

data christmas; set christmas;
d1xhours = d1*hours; run;
proc reg data = christmas; model included = d1 hours; model included = d1 hours d1xhours; test d1xhours = 0; run;

data christmas; set christmas;
d2xhours = d2*hours; d3xhours = d3*hours; run;
Proc reg data = christmas; model included = d1 d2 d3 hours d1xhours d2xhours d3xhours; run;

Proc reg data = christmas; model included = d1 d2 d3 hours d1xhours d2xhours d3xhours; test d1xhours = 0, d2xhours = 0, d3xhours = 0; run;
