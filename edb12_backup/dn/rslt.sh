echo raw result

grep threads: $1/*log|awk '{print $4}'
grep includ $1/*log|awk '{print $3}'
