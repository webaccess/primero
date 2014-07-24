#!/bin/bash -xe

: ${CMD_RUNNER_JAR:=/opt/jmeter/lib/ext/CMDRunner.jar}

csv_files=()
for jtl_file in "$1" "$2"
do
  csv_file=/tmp/$(basename $jtl_file).csv
  java -jar ${CMD_RUNNER_JAR} --tool Reporter --generate-csv \
    ${csv_file} --input-jtl $jtl_file --plugin-type AggregateReport
  # Unfortunately this tool doesn't maintain a consistent row ordering
  (head -n1 ${csv_file} && cat ${csv_file} | tail -n +2 | sort) > ${csv_file}.sorted
  csv_files+=(${csv_file}.sorted)
done

gnuplot \
  -e "agg1_file='${csv_files[0]}'" \
  -e "agg1_title='$(basename ${csv_files[0]} .jtl.csv.sorted)'" \
  -e "agg2_file='${csv_files[1]}'" \
  -e "agg2_title='$(basename ${csv_files[1]} .jtl.csv.sorted)'" \
  graph.plot -p
