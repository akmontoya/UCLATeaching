**indicator coding. 
compute d1 = (religion = 1).
compute d2 = (religion = 2). 
compute d3 = (religion = 3).
Regression /dep = included /method = enter d1 d2 d3. 

**sequential coding. 
compute s1 = (religion ~= 1).
compute s2 = (religion > 2). 
compute s3 = (religion = 4).
Regression /dep = included /method = enter s1 s2 s3. 

**helmert coding. 
compute h1 = -3/4*(religion = 1) + 1/4*(religion > 1). 
compute h2 = -2/3*(religion = 4) + 1/3*((religion = 2)|(religion = 3)). 
compute h3 = -1/2*(religion = 2) + 1/2*(religion = 3).
Regression /dep = included /method = enter h1 h2 h3. 

**testsofcoeffvsmodelcompare. 
compute d1xhours = d1*hours. 
regression /statistics = default change/dep = included /method = enter d1 hours /method = enter d1xhours. 

**noncontingent model. 
regression /dep = included /method = enter d1 d2 d3 hours. 

**contingent model. 
compute d2xhours = d2*hours. 
compute d3xhours = d3*hours. 
regression /dep = included /method = enter d1 d2 d3 hours d1xhours d2xhours d3xhours. 

**test of omnibus interaction. 
regression /statistics = default change /dep = included 
/method = enter d1 d2 d3 hours 
/method = enter d1xhours d2xhours d3xhours.

execute. 

DATASET ACTIVATE DataSet0.
REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Included
  /METHOD=ENTER d1 Hours
  /METHOD=ENTER d1xhours.
