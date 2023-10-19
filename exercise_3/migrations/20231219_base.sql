CREATE TABLE users
(user_id varchar(100)
, username varchar(100)
, first_platform varchar(100)
, first_install_date datetime
, first_cpn_id varchar(100)
, sessions_cnt int
, ltv numeric);

INSERT INTO users
(user_id, username, first_platform, first_install_date, first_cpn_id, sessions_cnt, ltv)
VALUES('u1', 'Oliver', 'ios', '2019-12-17', 'cpn1', null, null)
,('u2', 'Adrian', 'android', '2020-06-24', 'cpn3', null, null)
,('u3', 'Lucy', 'ios', '2020-01-05', 'cpn2', null, null)
,('u4', 'Sebastian', 'android', '2020-09-15', 'cpn2', null, null)
;

CREATE TABLE devices
(device_token varchar(100)
, product_id varchar(100)
, platform varchar(100)
, idfa varchar(100)
, gaid varchar(100)
, lead_user_id varchar(100)
, install_date datetime
, cpn_id varchar(100))
;

INSERT INTO devices
(device_token, product_id, platform, idfa, gaid, lead_user_id, install_date, cpn_id)
VALUES('ASG13DL', 'parkour', 'ios', '02358', null, 'u1', '2019-12-17', 'cpn1')
,('ASG13DL', 'idle-ants', 'ios', '02358', null, 'u1', '2020-05-01', 'cpn2')
,('GKLA34F', 'golf-race', 'android', null, '0194367', 'u1', '2020-02-27', 'cpn2')
,('ASG356SF', 'idle-ants', 'ios', '24576', null, 'u3', '2020-01-05', 'cpn2')
,('GKLA74B', 'idle-ants', 'android', null, '0194367', 'u2', '2020-06-24', 'cpn3')
,('GKL2346GL', 'parkour', 'android', null, '0934832', 'u4', '2019-09-15', 'cpn2')
,('ASG13DL', 'golf-race', 'ios', '34751', null, 'u4', '2020-10-17', 'cpn1')
;

CREATE TABLE products
(product_id varchar(100)
, product_name varchar(100)
, is_prod boolean
, release_date date)
;
INSERT INTO products
(product_id, product_name, is_prod, release_date)
VALUES('parkour', 'Parkour Race', true, '2019-01-01')
,('idle-ants', 'Idle Ants', true, '2019-01-01')
,('golf-race', 'Golf Race', true, '2019-01-01')
;
CREATE TABLE session_start
(session_id varchar(100)
, device_token varchar(100)
, product_id varchar(100)
, session_start_ts datetime)
;
INSERT INTO session_start
(session_id, device_token, product_id, session_start_ts)
VALUES('s1', 'ASG13DL', 'parkour', '2019-12-17 19:23:34')
,('s2', 'ASG13DL', 'parkour', '2019-12-18 19:23:34')
,('s3', 'ASG13DL', 'parkour', '2019-12-19 01:23:34')
,('s4', 'ASG13DL', 'parkour', '2019-12-20 15:23:34')
,('s5', 'ASG13DL', 'parkour', '2019-12-21 03:23:34')
,('s6', 'ASG13DL', 'parkour', '2019-12-25 07:23:34')
,('s7', 'ASG13DL', 'parkour', '2019-12-26 19:23:34')
,('s8', 'GKLA74B', 'idle-ants', '2020-06-24 19:23:34')
,('s9', 'GKLA74B', 'idle-ants', '2020-06-25 19:23:34')
,('s10', 'GKLA74B', 'idle-ants', '2019-06-26 19:23:34')
,('s11', 'ASG13DL', 'golf-race', '2020-10-17 19:23:34')
,('s12', 'ASG356SF', 'idle-ants', '2020-01-05 19:23:34')
;

CREATE TABLE game_events
(event_id varchar(100)
, device_token varchar(100)
, product_id varchar(100)
, platform varchar(100)
, event_type varchar(100)
, event_name varchar(100)
, event_ts datetime)
;