create database traffic_accidents;

select * from traffic_accidents_python;
Describe traffic_accidents_python;


TRUNCATE TABLE traffic_accidents_python;
SHOW VARIABLES LIKE 'secure_file_priv';

    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/traffic_accidents_python.csv'
INTO TABLE traffic_accidents_python
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# How many accidents occurred per year/month/day?
select Year,count(crash_date) AS "No.of Accidents" from traffic_accidents_python
group by Year
ORDER BY Year ASC;

select crash_month , count(crash_date) AS "No.of Accidents" from traffic_accidents_python
group by crash_month
ORDER BY crash_month DESC;


select crash_day_of_week,count(crash_date) AS "No.of Accidents" from traffic_accidents_python
group by crash_day_of_week
ORDER BY crash_day_of_week ASC;

SELECT 
    DAYNAME(crash_date) AS Days,
    COUNT(crash_date) AS "No.of Accidents"
FROM traffic_accidents_python
GROUP BY DAYNAME(crash_date), (DAYOFWEEK(crash_date) + 5) % 7
ORDER BY (DAYOFWEEK(crash_date) + 5) % 7;


# Which day of the week has the highest number of accidents?
SELECT crash_day_of_week FROM traffic_accidents_python
GROUP BY crash_day_of_week
ORDER BY COUNT(crash_date) DESC
LIMIT 1;

# At what hour do most accidents occur?
select max(crash_hour) from traffic_accidents_python;

# Count of accidents by most_severe_injury
SELECT most_severe_injury, count(crash_date) AS "No.of Accidents" from traffic_accidents_python
group by most_severe_injury;

# What percentage of accidents involved fatalities (injuries_fatal)?
SELECT  (COUNT(CASE WHEN injuries_fatal > 0 THEN 1 END) * 100.0 / COUNT(*)) AS fatality_percentage
FROM traffic_accidents_python;

# Average number of injuries per crash.
select first_crash_type, avg(injuries_total) from traffic_accidents_python 
group by first_crash_type;


# Which prim_contributory_cause appears most frequently?
select prim_contributory_cause, count(prim_contributory_cause) as  "No.of Accidents" from traffic_accidents_python
group by prim_contributory_cause
order by count(prim_contributory_cause) DESC;

# Accidents by weather_condition (rain, snow, clear).
select weather_condition, count(*) AS "No.of Accidents" from traffic_accidents_python
group by weather_condition
order by count(*) desc;

# Accidents by lighting_condition (daylight vs dark).
select lighting_condition, count(*) AS "No.of Accidents" from traffic_accidents_python
group by lighting_condition
order by count(*) desc;

# Top 5 most common first_crash_type.
select first_crash_type, count(first_crash_type) AS "No.of Accidents" from traffic_accidents_python 
group by first_crash_type
order by count(first_crash_type) desc
limit 5;

# Which traffic_control_device (e.g., stop sign, signal) is most associated with accidents?
select traffic_control_device, count(traffic_control_device) AS "No.of Accidents" from traffic_accidents_python 
group by traffic_control_device
order by count(traffic_control_device) desc
limit 5;

# Accidents at intersections vs non-intersections.
select intersection_related_i,count(intersection_related_i) from traffic_accidents_python
group by intersection_related_i;

# Average num_units per crash.
select first_crash_type ,avg(num_units) from traffic_accidents_python
group by first_crash_type;

# what is the damage cost of the accidents 
select damage,count(first_crash_type) from traffic_accidents_python
group by damage
order by damage Desc;

