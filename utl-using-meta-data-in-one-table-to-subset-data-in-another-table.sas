%let pgm=utl-using-meta-data-in-one-table-to-subset-data-in-another-table;

Using meta data in one table to subset data in another table

User upper and lower limits in the filter table to subset the have table

GitHub
https://tinyurl.com/nn3hdy8z
https://github.com/rogerjdeangelis/utl-using-meta-data-in-one-table-to-subset-data-in-another-table

StackOverflow
https://tinyurl.com/7ww2pata
https://stackoverflow.com/questions/66765880/how-to-use-a-value-that-comes-from-a-different-table

 _                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|

data filter;
 lower=3;
 upper=5;
run;quit;

data have;
input val;
cards4;
1
2
3
4
5
6
;;;;
run;quit;

 WORK.FILTER total obs=1

  LOWER    UPPER

    3        5

 WORK.HAVE total obs=6

  VAL

   1
   2
   3  -
   4  |   Keep just these three  3<=val<=5
   5  -
   6

             _               _
  ___  _   _| |_ _ __  _   _| |_ ___
 / _ \| | | | __| `_ \| | | | __/ __|
| (_) | |_| | |_| |_) | |_| | |_\__ \
 \___/ \__,_|\__| .__/ \__,_|\__|___/
                |_|

  WANT total obs=3

  VAL

   3
   4
   5

  LOG total obs=1

  LOWER    UPPER      FILTER       RC           STATUS

    3        5      3<= val <=5     0    Subsetted sucessfully

 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|

data log;
  set filter;
  filter=cats(lower,'<= val <=',upper);
  call symputx("filter",filter);
  rc=dosubl('
      data want;
          set have(where=(&filter));
      run;quit;
      %let cc=&syserr;
      ');

  if symgetn('cc')=0 then status="Subsetted sucessfully";
  else status="Subset Failed";

run;quit;
                _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|
