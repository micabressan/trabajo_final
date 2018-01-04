CREATE TABLE demo.room_access2 (
    user text,
    room text,
    when timestamp,
    PRIMARY KEY (user, room)
) WITH CLUSTERING ORDER BY (room ASC)
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND dclocal_read_repair_chance = 0.1
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair_chance = 0.0
    AND speculative_retry = '99PERCENTILE';


create table room_access2 ( user text, room text, when timestamp, primary key (user, room) );
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_a');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_a');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_b');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_c');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_d');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_e');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_f');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_g');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_h');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_i');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_j');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_k');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_a');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_b');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_c');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_a');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_b');
INSERT INTO room_access2 (user, when, room) VALUES ( 'demo', toTimeStamp(now()), 'room_c');


SELECT user, room, when FROM room_access2 WHERE user='demo' ;

 user | room   | when
------+--------+---------------------------------
 demo | room_a | 2018-01-01 21:13:36.035000+0000
 demo | room_b | 2018-01-01 21:13:36.042000+0000
 demo | room_c | 2018-01-01 21:13:37.209000+0000
 demo | room_d | 2018-01-01 21:13:35.969000+0000
 demo | room_e | 2018-01-01 21:13:35.974000+0000
 demo | room_f | 2018-01-01 21:13:35.980000+0000
 demo | room_g | 2018-01-01 21:13:35.986000+0000
 demo | room_h | 2018-01-01 21:13:35.993000+0000
 demo | room_i | 2018-01-01 21:13:36.005000+0000
 demo | room_j | 2018-01-01 21:13:36.010000+0000
 demo | room_k | 2018-01-01 21:13:36.014000+0000

(11 rows)