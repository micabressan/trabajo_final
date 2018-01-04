SELECT "v_tasks".* FROM "v_tasks" 
LEFT JOIN "tasks_teams" ON ("tasks_teams"."task_id" = "v_tasks"."id") 
WHERE ("v_tasks"."lang_id" = 'cs') 
AND ("tasks_teams"."team_id" IN (4, 5))
bizzione_dev=> select * from tasks_teams ;
 task_id | team_id 
---------+---------
       2 |       4
       3 |       4
       1 |       4
       1 |       5

bizzione_dev=> select id from tasks;
 id 
----
  1
  2
  3
(3 rows)

No a protoze task 1 je ve dvou tymech, tak kdyz dam ten prvni dotaz, tak dostanu 4 tasky (s id 1 je duplicitni), akorat bych potreboval mit jen unikatni zaznamy. Postgres ma DISTINCT BY (v_task.id), ale to nemuzu pouzit (to je jedno proc). Normalni DISTINCT taky ne, protoze v_tasks vraci nejake veci v JSONu a Postgres to neumi porovnat pro urceni duplicit. No takze urcite existuje nejake lepsi reseni, ale cumim do toho uz pul hodiny, ale nevim