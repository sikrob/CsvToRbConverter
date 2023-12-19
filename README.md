# CSV to RB Converter
A simple ruby script to make life easier when parsing out big chunky CSV files.

It takes in CSVs and outputs `.rb`s, such that:

Input CSV:
```
column_a,…,column_n
value_a0,…,value_n0
…
value_am,…,value_nm,
```

Output `.rb`:
```
data = [
  {column_a: value_a0,…,column_n: value_n0},
  …
  {column_a: value_am,…,column_n: value_nm},
]
```

Usage is simple and supported flags can be found in the code.

The output file uses the same name and path as the input file but with the `.rb` extension.

Example usages:
`ruby csv-rb-converter.rb -a my_directory/my_csv.csv`

This will parse the CSV and output the results to `my_directory/my_csv.rb`, appending a new `data = […]` to that file; excluding the `-a` would have overwritten the file instead.

