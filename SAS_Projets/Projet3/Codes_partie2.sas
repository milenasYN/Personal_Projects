data Titanic;
  infile 'Titanic.txt' firstobs=2;
  input Yi mi Age Sex Class;
run;
proc logistic data=Titanic;
  class Age Sex Class / param=ref;
  model Yi/mi = Age Sex Class Sex*Class Age*Class/scale=none;
run;
proc logistic data=Titanic;
  class Age Sex Class / param=ref;
  model Yi/mi = Age Sex Class Sex*Class Sex*Age/scale=none;
run;
proc logistic data=Titanic;
  class Age Sex Class / param=ref;
  model Yi/mi = Age Sex Class Age*Class Sex*Age/scale=none;
run;
proc logistic data=Titanic;
  class Age Sex Class / param=ref;
  model Yi/mi = Age Sex Class Sex*Class Age*Class Sex*Age/scale=none;
run;
/*c)*/
proc logistic data=Titanic;
  class Age Sex Class / param=ref;
  model Yi/mi = Age Sex Class Sex*Class Age*Class/scale=D;
run;
/*d)*/
proc logistic data=Titanic;
  class Age Sex Class / param=ref;
  model Yi/mi = Age Sex Class Sex*Class Age*Class/scale=D;
  oddratio class/at(Age='1');
run;