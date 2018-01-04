CREATE TRIGGER trigInsert_1_View ON MySchema.View_Work
  INSTEAD OF INSERT AS
   BEGIN

     IF (exists(SELECT * FROM inserted WHERE first_name IS NOT NULL ))
       BEGIN
         INSERT MySchema.Employees2 (first_name, last_name, hiredate, dismissal, specialty, phone_number)
          SELECT first_name, last_name, hiredate, dismissal, specialty, phone_number FROM inserted
--distinct
         INSERT MySchema.Work (work_name, cost, start_date, planned_date, end_date, work_status, emp_id)
           SELECT work_name, cost, start_date, planned_date, end_date, work_status,
            (SELECT emp_id FROM MySchema.Employees2 WHERE Employees2.phone_number = inserted.phone_number) FROM inserted
         END

      ELSE
        BEGIN
        INSERT MySchema.Work (work_name, cost, start_date, planned_date, end_date, work_status, emp_id)
            SELECT work_name, cost, start_date, planned_date, end_date, work_status,
              (SELECT emp_id FROM MySchema.Employees2 WHERE Employees2.phone_number = inserted.phone_number) FROM inserted
          END
    END
GO