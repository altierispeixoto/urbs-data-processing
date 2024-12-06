MATCH (n) DETACH DELETE n;
MATCH ()-[r]-() DELETE r;

// create constraint on (y:Year) ASSERT y.value IS UNIQUE;
// CREATE INDEX ON :Month(value);
// CREATE INDEX ON :Day(value);
// CREATE INDEX ON :Hour(value);
// CREATE INDEX ON :Trip(line_way);
// CREATE INDEX ON :Line(line_code);
// CREATE INDEX ON :Event(vehicle, event_timestamp);

CREATE CONSTRAINT unique_year_value IF NOT EXISTS FOR (y:Year) REQUIRE y.value IS UNIQUE;
CREATE INDEX month_value_index IF NOT EXISTS FOR (m:Month) ON (m.value);
CREATE INDEX day_value_index IF NOT EXISTS FOR (d:Day) ON (d.value);
CREATE INDEX hour_value_index IF NOT EXISTS FOR (h:Hour) ON (h.value);
CREATE INDEX trip_line_way_index IF NOT EXISTS FOR (t:Trip) ON (t.line_way);
CREATE INDEX line_code_index IF NOT EXISTS FOR (l:Line) ON (l.line_code);
CREATE INDEX event_vehicle_timestamp_index IF NOT EXISTS FOR (e:Event) ON (e.vehicle, e.event_timestamp);


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
UNWIND range(0, size(years) - 2) AS i
WITH years[i] AS year1, years[i + 1] AS year2
MERGE (year1)-[:NEXT]->(year2);



//Connect Months Sequentially
MATCH (year:Year)-[:CONTAINS]->(month)
WITH year, month
ORDER BY year.value, month.value
WITH collect(month) AS months
UNWIND range(0, size(months) - 2) AS i
WITH months[i] AS month1, months[i + 1] AS month2
MERGE (month1)-[:NEXT]->(month2);


//Connect Days Sequentially
MATCH (year:Year)-[:CONTAINS]->(month)-[:CONTAINS]->(day)
WITH year, month, day
ORDER BY year.value, month.value, day.value
WITH collect(day) AS days
UNWIND range(0, size(days) - 2) AS i
WITH days[i] AS day1, days[i + 1] AS day2
MERGE (day1)-[:NEXT]->(day2);


// Connect Hours Sequentially
MATCH (year:Year)-[:CONTAINS]->(month)-[:CONTAINS]->(day)-[:CONTAINS]->(hour)
WITH year, month, day, hour
ORDER BY year.value, month.value, day.value, hour.value
WITH collect(hour) AS hours
UNWIND range(0, size(hours) - 2) AS i
WITH hours[i] AS hour1, hours[i + 1] AS hour2
MERGE (hour1)-[:NEXT]->(hour2);
