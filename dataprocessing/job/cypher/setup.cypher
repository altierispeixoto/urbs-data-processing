MATCH (n) DETACH DELETE n;
MATCH ()-[r]-() DELETE r;

create constraint on (y:Year) ASSERT y.value IS UNIQUE;
CREATE INDEX ON :Month(value);
CREATE INDEX ON :Day(value);
CREATE INDEX ON :Hour(value);
CREATE INDEX ON :Trip(line_way);
CREATE INDEX ON :Line(line_code);
CREATE INDEX ON :Event(vehicle, event_timestamp);


//Create Time Tree with Day Depth
WITH range(2019, 2020) AS years, range(1,12) AS months
FOREACH(year IN years |
  CREATE (y:Year {value: year})
  FOREACH(month IN months |
    CREATE (m:Month {value: month})
    MERGE (y)-[:CONTAINS]->(m)
    FOREACH(day IN (CASE
                      WHEN month IN [1,3,5,7,8,10,12] THEN range(1,31)
                      WHEN month = 2 THEN
                        CASE
                          WHEN year % 4 <> 0 THEN range(1,28)
                          WHEN year % 100 = 0 AND year % 400 = 0 THEN range(1,29)
                          ELSE range(1,28)
                        END
                      ELSE range(1,30)
                    END) |
      CREATE (d:Day {value: day})
      MERGE (m)-[:CONTAINS]->(d))));

//Create Time Tree with Hour Depth
match(y:Year)-[:CONTAINS]->(m:Month)-[:CONTAINS]->(d:Day)
WITH collect(d) AS days
  FOREACH(d IN days  |
     FOREACH (hour in range(0,23) |
       CREATE (h:Hour {value: hour})
       MERGE (d)-[:CONTAINS]->(h)));


//Connect Years Sequentially
MATCH (year:Year)
WITH year
ORDER BY year.value
WITH collect(year) AS years
  FOREACH(i in RANGE(0, length(years)-2) |
    FOREACH(year1 in [years[i]] |
      FOREACH(year2 in [years[i+1]] |
        CREATE UNIQUE (year1)-[:NEXT]->(year2))));


//Connect Months Sequentially
MATCH (year:Year)-[:CONTAINS]->(month)
WITH year, month
ORDER BY year.value, month.value
  WITH collect(month) AS months
    FOREACH(i in RANGE(0, length(months)-2) |
      FOREACH(month1 in [months[i]] |
        FOREACH(month2 in [months[i+1]] |
          CREATE UNIQUE (month1)-[:NEXT]->(month2))));


//Connect Days Sequentially
MATCH (year:Year)-[:CONTAINS]->(month)-[:CONTAINS]->(day)
WITH year, month, day
ORDER BY year.value, month.value, day.value
WITH collect(day) AS days
FOREACH(i in RANGE(0, length(days)-2) |
    FOREACH(day1 in [days[i]] |
        FOREACH(day2 in [days[i+1]] |
            CREATE UNIQUE (day1)-[:NEXT]->(day2))));


// Connect Hours Sequentially
MATCH (year:Year)-[:CONTAINS]->(month)-[:CONTAINS]->(day)-[:CONTAINS]->(hour)
WITH year, month, day, hour
ORDER BY year.value, month.value, day.value, hour.value
WITH collect(hour) AS hours
FOREACH(i in RANGE(0, length(hours)-2) |
    FOREACH(hour1 in [hours[i]] |
        FOREACH(hour2 in [hours[i+1]] |
            CREATE UNIQUE (hour1)-[:NEXT]->(hour2))));