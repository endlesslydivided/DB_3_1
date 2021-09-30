LOAD DATA
INFILE '.\import_data.txt'
DISCARDFILE '.\import_data.dis'
INTO TABLE LAB18
FIELDS TERMINATED BY ","
(
id "round(:id, 2)",
text "upper(:text)",
date_value date "DD.MM.YYYY"
)