CREATE DATABASE youcodedb ;

CREATE TABLE departments(
department_id BIGSERIAL NOT NULL PRIMARY KEY ,
department_name VARCHAR(50) NOT NULL,
location_add VARCHAR(100) NOT NULL
);




CREATE TABLE members(
    member_id BIGSERIAL NOT NULL PRIMARY KEY ,
    first_name VARCHAR(50) NOT NULL ,
    last_name VARCHAR(50) NOT NULL ,
    gender gender_enum NOT NULL,
    date_of_birth date NOT NULL ,
    phone_number VARCHAR(15) NOT NULL ,
    email VARCHAR(100)  

);




CREATE TABLE rooms(
    room_id BIGSERIAL NOT NULL PRIMARY KEY ,
    room_number VARCHAR(10) NOT NULL ,
    room_type room_enum NOT NULL,
    capacity int 
);



CREATE TABLE trainers(
    trainer_id BIGSERIAL NOT NULL PRIMARY KEY ,
    first_name VARCHAR(50) NOT NULL ,
    last_name VARCHAR(50) NOT NULL ,
    specialization VARCHAR(50) NOT NULL ,
    department_id BIGINT REFERENCES departments(department_id)
);


CREATE TABLE workout_plans(
    plan_id BIGSERIAL NOT NULL PRIMARY KEY ,
    member_id BIGINT REFERENCES members(member_id) ,
    trainer_id BIGINT REFERENCES trainers(trainer_id) ,
    instructions VARCHAR(250) NOT NULL ,
    supplements VARCHAR(250) NOT NULL 
);



CREATE TABLE appointments(
    appointment_id BIGSERIAL NOT NULL PRIMARY KEY ,
    appointment_date date NOT NULL ,
    appointment_time time NOT NULL ,
    appointment_status VARCHAR(10) NOT NULL ,
    member_id BIGINT REFERENCES members(member_id) ,
    trainer_id BIGINT REFERENCES trainers(trainer_id) 

);


CREATE TABLE memberships(
    membership_id BIGSERIAL NOT NULL PRIMARY KEY ,
    member_id BIGINT REFERENCES members(member_id) ,
    room_id BIGINT REFERENCES rooms(room_id),
    membership_start_date date NOT NULL

);



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


1:
INSERT INTO members(
    first_name,
    last_name,
    gender,
    email,
    date_of_birth,
    phone_number
    ) 
VALUES(
    'Alex',
    'Johnson',
    'Male' ,
    null ,
    date '1990-7-15',
    '1234567890'
);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

2:
SELECT * FROM departments ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


3:
 SELECT * FROM members ORDER BY date_of_birth ASC ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

4:

 SELECT DISTINCT gender FROM members ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

5:
 
  SELECT * FROM trainers WHERE trainer_id <4 ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

6:
  
   SELECT * FROM members WHERE date_of_birth > '2000-01-01' ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

7:

  SELECT * FROM trainers where specialization = 'Musculation' OR specialization = 'Cardio' ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

8:
  SELECT * FROM memberships WHERE membership_start_date BETWEEN '2024-12-01' AND '2024-12-07';


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

9:

ALTER TABLE members
ADD COLUMN age_category VARCHAR(20);

UPDATE members
SET age_category = 
    CASE 
        WHEN EXTRACT(YEAR FROM AGE(date_of_birth)) < 18 THEN 'Junior'
        WHEN EXTRACT(YEAR FROM AGE(date_of_birth)) BETWEEN 18 AND 40 THEN 'Adulte'
        ELSE 'Senior'
    END;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

10 :

    SELECT COUNT(*) FROM appointments ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

11:

SELECT department_id  , COUNT(*) from trainers GROUP BY department_id ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////



12 :
SELECT ROUND(AVG(EXTRACT(YEAR FROM AGE(date_of_birth))), 2) AS average_age
FROM members;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


13:
SELECT appointment_date, appointment_time
FROM appointments
ORDER BY appointment_date DESC, appointment_time DESC
LIMIT 1; 

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


14:

SELECT room_id ,COUNT(membership_id) AS total_abonnements FROM memberships GROUP BY room_id;
    

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

15 : 

    SELECT *  FROM members WHERE email IS NULL ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

16 :

 SELECT *  FROM appointments
 JOIN trainers ON appointments.trainer_id = trainers.trainer_id
 JOIN members ON appointments.member_id = members.member_id ;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

17:


 DELETE  FROM appointments WHERE EXTRACT(YEAR FROM (appointment_date))<2024 ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

18 :

    UPDATE departments
    SET department_name = 'Force et Conditionnement'
    WHERE department_name = 'Musculation';
    
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

19 :

SELECT gender , COUNT(*) FROM members GROUP BY gender HAVING COUNT(*) >1  ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

20 :
CREATE VIEW pending_apointement AS 
SELECT *  from appointments where appointments.appointment_status LIKE 'pending' ;


////////////////////////////////////////////////////////BONUS///////////////////////////////////////////////////


1:

SELECT members.first_name , members.last_name , trainers.first_name , trainers.last_name from members 
JOIN workout_plans ON members.member_id = workout_plans.member_id
JOIN trainers ON workout_plans.trainer_id =  trainers.trainer_id ; 

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

2:


SELECT appointment_id , department_name from appointments JOIN trainers ON appointments.trainer_id = trainers.trainer_id 
JOIN departments ON trainers.department_id = departments.department_id ;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

3:
SELECT trainers.first_name , trainers.last_name , workout_plans.supplements FROM trainers JOIN appointments ON trainers.trainer_id = appointments.trainer_id JOIN members ON appointments.member_id = members.member_id JOIN workout_plans ON members.member_id = workout_plans.member_id ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

4 :
SELECT memberships.membership_id , members.first_name , members.last_name  , departments.department_name FROM memberships JOIN members ON memberships.member_id = members.member_id JOIN workout_plans ON members.member_id = workout_plans.member_id JOIN trainers ON workout_plans.trainer_id = trainers.trainer_id JOIN departments ON trainers.department_id = departments.department_id ;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

5:



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////