/*
Present the number of devices per user and add a
category value from the following list: “single device”,
“multiple devices”, “no device”
*/

### mysql solution ###
SELECT username
       , device_number
       , CASE WHEN device_number > 1 THEN 'multiple devices'
            WHEN device_number > 0 THEN 'single device'
            ELSE 'no device'
       END AS device_category
FROM (
    SELECT username,
       count(DISTINCT device_token) AS device_number
    FROM madbox.users AS a
    LEFT JOIN madbox.devices AS d ON a.user_id = d.lead_user_id
     GROUP BY username
) AS user_device_grouping;

### bigquery solution ###
/*
 For bigquery we can use a quite similar solution but taking in account
 that count distinct is an approximation. For avoiding this case we can use EXACT_COUNT_DISTINCT function.
 */


/*
Return a list of usernames that played (had sessions) in
both of the following apps: “parkour”, “idle-ants”. (give 2
different ways)
*/
### mysql solution ###
SELECT username
       , count(CASE WHEN s.product_id = 'parkour' THEN 1 END) parkour_sessions,
       , count(CASE WHEN s.product_id = 'idle-ants' THEN 1 END) idle_ants_sessions
FROM madbox.session_start s
    LEFT JOIN madbox.devices d USING(device_token, product_id)
    LEFT JOIN madbox.users u ON u.user_id = d.lead_user_id
 GROUP BY u.username
HAVING parkour_sessions > 0 AND idle_ants_sessions > 0;

### bigquery solution ###
WITH parkour_and_ant_users AS (
    SELECT username
         , LOGICAL_AND(CASE WHEN s.product_id in ('parkour', 'idle-ants') THEN TRUE END) parkour_and_ant_user
    FROM madbox.session_start s
             LEFT JOIN madbox.devices d USING (device_token, product_id)
             LEFT JOIN madbox.users u ON u.user_id = d.lead_user_id
    GROUP BY u.username
)
SELECT username
FROM parkour_and_ant_users
WHERE parkour_and_ant_user

/*
What is the session_id of the last session per user? (the
session_id‘s are not necessarily ascending according to
the session start time)
*/
### mysql solution ###
SELECT username
     , session_id
     , session_start_ts
FROM (
    SELECT username
           , session_id
           , session_start_ts
           , ROW_NUMBER() OVER (PARTITION BY username ORDER BY session_start_ts DESC) AS session_order
    FROM madbox.users u
        LEFT JOIN madbox.devices d ON u.user_id = d.lead_user_id
        LEFT JOIN madbox.session_start s USING(device_token, product_id)
) AS ordered_sessions
WHERE session_order = 1;

### bigquery solution ###
SELECT username
     , session_id
     , session_start_ts
FROM madbox.users u
    LEFT JOIN madbox.devices d ON u.user_id = d.lead_user_id
    LEFT JOIN madbox.session_start s USING(device_token, product_id)
QUALIFY ROW_NUMBER() OVER (PARTITION BY username ORDER BY session_start_ts DESC)  = 1;

/*
Using pivot, return for each ‘app_id’ the number of
devices with a value in ‘idfa’ the number without and the
percentage as presented in the following output:
*/

### mysql solution ###
SELECT product_id
     , count(idfa) has_idfa
     , count(CASE WHEN idfa IS NULL THEN 1 END) no_idfa
     , count(idfa) / count(product_id) has_idfa_pct
FROM madbox.devices
GROUP BY product_id

### To be honest, utilizing pivot for this problem seems an overengineered solution and does not align with the typical use case for pivot, but using it will be something like this.

SELECT 
        product_id,
        has_idfa,
        no_idfa,
        has_idfa / (has_idfa + no_idfa) AS has_idfa_pct
FROM (
    product_id
     , (CASE WHEN idfa IS NULL THEN 'no_idfa' ELSE 'has_idfa' END) idfa
FROM madbox.devices
) as s
PIVOT
(
    count(product_id)
    FOR [idfa] IN ('no_idfa' , 'has_idfa')
)AS pvt


/*
Write a query that creates a ‘daily_user_activity’ table which is
calculated based on ‘session_start’ and holds a record for ALL
days after the installation date of each user (until yesterday). It
should have a column called ‘had_session’ that will return
‘True’ in case the user had a session on that day and ‘False’ in
case he didn’t.
*/

### DDL mysql ###
CREATE TABLE IF NOT EXISTS madbox.daily_user_activity
(
    user_id varchar(100)
    , install_date datetime
    , days_since_install int
    , had_session boolean
    , date date
);

### DDL bigquery, I'am not familiar with Bigquery, but probably works quite similar to Athena and Glue Catalog on AWS ###
CREATE TABLE madbox.daily_user_activity
(
      user_id            varchar(100)
    , install_date       datetime
    , days_since_install int
    , had_session        boolean
)
PARTITION BY
  _PARTITIONTIME
  OPTIONS (
    require_partition_filter = TRUE);

### pipeline query ###
WITH sessions AS (
    SELECT d.lead_user_id AS user_id,
           date(s.session_start_ts) session_date
        FROM madbox.session_start s
        LEFT JOIN madbox.devices d USING(device_token, product_id)
    WHERE s.session_start_ts >= date('${execution_date}') - INTERVAL 1 DAY
    AND s.session_start_ts < date('${execution_date}')
)
SELECT u.user_id,
       u.first_install_date AS install_date,
       datediff(coalesce(s.session_date, date('${execution_date}') - INTERVAL 1 DAY), u.first_install_date) AS days_since_install,
       IF(s.user_id IS NOT NULL, TRUE, FALSE) AS has_session,
       coalesce(s.session_date, date('${execution_date}') - INTERVAL 1 DAY) as date
FROM madbox.users u
    LEFT JOIN sessions s USING(user_id)
WHERE u.first_install_date < date('${execution_date}');

### pipeline explanation ###
/*
To process these data on a daily basis, we need to consider the following aspects:

    - The data should be processed for the previous day.
    - The execution should be incremental to prevent overloading
      the process as the data volume increases.
    - Design a solution tolerant to data reprocessing (UPSERT or MERGE in the case of bigquery)

Once we created a DML query with the MERGE statement configured for UPSERT we can schedule the query for running daily.
*/