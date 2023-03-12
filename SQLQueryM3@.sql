CREATE PROCEDURE createAllTable
As

CREATE TABLE systemuser(
username VARCHAR(20) PRIMARY KEY ,
password VARCHAR(20)
);

CREATE TABLE stadium(
id int PRIMARY KEY IDENTITY,
name VARCHAR(20),
location VARCHAR(20),
capacity int,
status int
);
CREATE TABLE stadium_manager(
username VARCHAR(20) FOREIGN KEY REFERENCES systemuser(username) ,
id int PRIMARY KEY IDENTITY,
name VARCHAR(20),
stadium_id int FOREIGN KEY REFERENCES stadium(id)

);

CREATE TABLE fan(
national_id VARCHAR(20) PRIMARY KEY,
name VARCHAR(20),
birth_date datetime NOT NULL,
address VARCHAR(20),
phone_no int,
status int , 
username VARCHAR(20) FOREIGN KEY REFERENCES systemuser(username)

);


CREATE TABLE club(
club_id int PRIMARY KEY IDENTITY,
name VARCHAR(20),
location VARCHAR(20)

);


CREATE TABLE match(
match_id int PRIMARY KEY IDENTITY,
start_time DATETIME , 
end_time DATETIME ,
stadium_id int FOREIGN KEY REFERENCES  stadium(id),
host_club_id int FOREIGN KEY REFERENCES club(club_id) ,
guest_club_id int  FOREIGN KEY REFERENCES club(club_id)

);



CREATE TABLE ticket(
id int PRIMARY KEY IDENTITY,
status int,
match_id int FOREIGN KEY REFERENCES match(match_id)

);


CREATE TABLE ticket_buying_transaction(
fan_national_id VARCHAR(20) FOREIGN KEY REFERENCES fan(national_id ),
ticket_id int FOREIGN KEY REFERENCES ticket(id)

);

CREATE TABLE system_admin(
id int PRIMARY KEY IDENTITY,
name VARCHAR(20),
username VARCHAR(20) FOREIGN KEY REFERENCES systemuser(username)

);

CREATE TABLE  sports_association_manager(
id int PRIMARY KEY IDENTITY,
name VARCHAR(20),
username VARCHAR(20) FOREIGN KEY REFERENCES systemuser(username)

);


CREATE TABLE  club_representative(
id int PRIMARY KEY IDENTITY,
name VARCHAR(20),
username VARCHAR(20) FOREIGN KEY REFERENCES systemuser(username),
club_id int FOREIGN KEY REFERENCES club(club_id)

);



CREATE TABLE  host_request(
id int PRIMARY KEY IDENTITY,
representative_id int FOREIGN KEY REFERENCES club_representative(id) ,
 manager_id int FOREIGN KEY REFERENCES stadium_manager(id), 
match_id int FOREIGN KEY REFERENCES match(match_id) , 
status int 

);
GO

EXEC createAllTable

GO

CREATE PROCEDURE dropAllTables
AS
DROP TABLE system_admin
DROP TABLE sports_association_manager
DROP TABLE  host_request
DROP TABLE club_representative
DROP TABLE  ticket_buying_transaction
DROP TABLE ticket
DROP TABLE match
DROP TABLE club
DROP TABLE fan 
DROP TABLE stadium_manager
DROP TABLE stadium
DROP TABLE systemuser

GO

CREATE PROCEDURE DROPALLProceduresFunctionsViews
AS
DROP PROCEDURE createAllTables
DROP PROCEDURE dropAllTables
DROP PROCEDURE clearALlTables
DROP PROCEDURE addAssociationManager
DROP PROCEDURE addNewMatch
DROP PROCEDURE deleteMatch
DROP PROCEDURE deleteMatchesOnStadium
DROP PROCEDURE addClub
DROP PROCEDURE addTicket
DROP PROCEDURE  deleteClub
DROP PROCEDURE addStadium
DROP PROCEDURE deleteStadium
DROP PROCEDURE blockFan
DROP PROCEDURE unblockFan
DROP PROCEDURE addRepresentative
DROP PROCEDURE addHostRequest
DROP PROCEDURE addStadiumManager
DROP PROCEDURE acceptRequest
DROP PROCEDURE  rejectRequest
DROP PROCEDURE addFan
DROP PROCEDURE purchaseTicket
DROP PROCEDURE updateMatchTiming
DROP PROCEDURE deleteMatchesOn
DROP PROCEDURE clubWithTheMostSoldTickets

DROP VIEW allAssocManagers
DROP VIEW allClubRepresentatives
DROP VIEW allStadiumManagers
DROP VIEW allFans
DROP VIEW allMatches
DROP VIEW allTickets
DROP VIEW allCLubs
DROP VIEW allStadiums
DROP VIEW allRequests	
DROP VIEW clubsWithNoMatches
DROP VIEW matchesPerTeam
DROP VIEW matchWithMostSoldTickets
DROP VIEW matchesRankedBySoldTickets
DROP PROCEDURE clubsRankedBySoldTickets

DROP FUNCTION viewAvailableStadiumsOn
DROP FUNCTION  allUnassignedMatches
DROP FUNCTION  allPendingRequests
DROP FUNCTION  stadiumsNeverPlayedOn
DROP FUNCTION  upcomingMatchesOfClub
DROP FUNCTION  availableMatchesToAttend

GO


CREATE PROCEDURE clearALLTables
AS
TRUNCATE TABLE system_admin
TRUNCATE TABLE sports_association_manager
TRUNCATE TABLE  host_request
TRUNCATE TABLE club_representative
TRUNCATE TABLE  ticket_buying_transaction
TRUNCATE TABLE ticket
TRUNCATE TABLE match
TRUNCATE TABLE club
TRUNCATE TABLE fan 
TRUNCATE TABLE stadium_manager
TRUNCATE TABLE stadium
TRUNCATE TABLE systemuser

GO


CREATE VIEW allAssocManagers AS
SELECT a.name , a.username , c.password 
FROM sports_association_manager a , systemuser c
WHERE c.username = a.username;

GO

CREATE VIEW allClubRepresentatives AS
SELECT a.name , a.username , c.password , k.name AS cn
FROM club_representative a , systemuser c , club k
WHERE  c.username = a.username AND a.club_id = k.club_id


GO


CREATE VIEW allStadiumManagers AS 
SELECT stm.username , st.password , stm.name , sc.name as stadium_name
FROM  stadium_manager stm , systemuser st , stadium sc 
WHERE  stm.username = st.username AND sc.id = stm.stadium_id 

GO

CREATE VIEW allFans AS 
SELECT f.username , fs.password , f.name , f.national_id  , f.birth_date , f.status 
FROM  fan f , systemuser fs 
WHERE  fs.username = f.username

GO


CREATE VIEW allMatches AS 
SELECT  m.start_time  , hc.name AS host , gc.name  AS guest
FROM club hc , club gc , match m
WHERE m.host_club_id = hc.club_id AND m.guest_club_id = gc.club_id

GO
 
CREATE VIEW allTicket AS 
SELECT hc.name AS host , gc.name AS guest , st.name AS stadium , m.start_time 
FROM club hc , club gc , stadium st , match m , ticket s
WHERE s.match_id = m.match_id AND  gc.club_id = m.guest_club_id AND hc.club_id = m.host_club_id AND st.id = m.stadium_id

GO

CREATE VIEW allClubs AS 
SELECT c.name , c.location 
FROM club c

GO

CREATE VIEW allStadiums AS 
SELECT s.name , s.location , s.capacity , s.status 
FROM stadium s

GO

CREATE VIEW allRequests AS 
SELECT  cr.username , stm.username AS st_manager_user , hr.status
FROM  host_request hr , stadium_manager stm , club_representative cr
WHERE hr.representative_id = cr.id AND stm.id = hr.manager_id 

GO

CREATE PROCEDURE addAssociationManager
@name1 VARCHAR(20), @username1 VARCHAR(20), @password1 VARCHAR(20)
AS
INSERT INTO   systemuser VALUES (@username1 , @password1) 
INSERT INTO  sports_association_manager VALUES (@name1 , @username1)

GO

CREATE PROCEDURE addNEWMatch 
@host_club_name VARCHAR(20) , @guest_club_name VARCHAR(20) , @start_time DATETIME , @end_time  DATETIME
AS   
DECLARE @chId INT
DECLARE @cgId INT
DECLARE @st_id INT
SELECT @chId = club_id 
FROM club WHERE name = @host_club_name
SELECT @cgId = club_id 
FROM club WHERE name = @guest_club_name
SELECT @st_id = cn.id 
FROM stadium cn , club c
WHERE  cn.location = c.location AND c.club_id = @chId
INSERT INTO match  VALUES  (@start_time , @end_time, @st_id , @chId  , @cgId)

GO



CREATE VIEW clubsWithNoMatches  AS 
SELECT name FROM club 
WHERE name NOT IN (SELECT DISTINCT c.name
FROM  match v  , club c
WHERE v.host_club_id = c.club_id
UNION
SELECT DISTINCT c.name
FROM  match v  , club c
WHERE v.guest_club_id = c.club_id)

GO

CREATE PROCEDURE deleteMatch
@host_club_name VARCHAR(20) , @guest_club_name VARCHAR(20) 
AS
DECLARE @chId INT
DECLARE @cgId INT
SELECT @chId = club_id 
FROM club WHERE name = @host_club_name
SELECT @cgId = club_id 
FROM club WHERE name = @guest_club_name
DELETE FROM match WHERE host_club_id  = @chId  AND guest_club_id = @cgId

GO

CREATE PROCEDURE deleteMatchesOnStadium
@name_std VARCHAR(20)
AS
DECLARE @stId INT
SELECT @stId = id
FROM stadium WHERE @name_std = name
DELETE FROM match WHERE stadium_id = @stId AND start_time > CURRENT_TIMESTAMP


GO

CREATE PROCEDURE addClub 
@name_club VARCHAR(20) , @club_location VARCHAR(20)
AS
INSERT INTO club VALUES(@name_club , @club_location)


GO


CREATE PROCEDURE addTicket
@host_name VARCHAR(20) , @guest_name VARCHAR(20) , @start_time DATETIME 
AS 
DECLARE @chId INT
DECLARE @cgId INT
DECLARE @m_Id INT
SELECT @chId = club_id 
FROM club WHERE name = @host_name
SELECT @cgId = club_id 
FROM club WHERE name = @guest_name
SELECT @m_Id = match_id 
FROM match WHERE @chId = host_club_id   AND @cgId = guest_club_id   AND @start_time = start_time 
INSERT INTO ticket VALUES (1 , @m_Id)

GO

CREATE PROCEDURE deleteClub
@club_name VARCHAR(20)
AS 
DELETE FROM club WHERE name = @club_name  

GO

CREATE PROCEDURE addStadium  
@name_stad VARCHAR(20) , @St_location VARCHAR(20) , @st_capacity INT
AS 
INSERT INTO stadium VALUES (@name_stad , @St_location ,@st_capacity , 1 )

GO

CREATE PROCEDURE deleteStadium  
@std_name VARCHAR(20)
AS 
DELETE FROM stadium WHERE name = @std_name

GO

CREATE PROCEDURE blockFan 
@national_idd VARCHAR(20)
AS
UPDATE fan 
SET status = 0 
WHERE @national_idd = national_id 

GO

CREATE PROCEDURE unblockFan 
@national_idd VARCHAR(20)
AS
UPDATE fan 
SET status = 1
WHERE @national_idd = national_id 

GO

CREATE PROCEDURE addRepresentative
@name_rep VARCHAR(20) , @club_namee VARCHAR(20) , @usern VARCHAR(20) , @pass VARCHAR(20)
AS 
DECLARE @cId INT
INSERT INTO systemuser VALUES (@usern , @pass)
SELECT @cId = club_id  FROM club 
WHERE @club_namee =  name
INSERT INTO club_representative VALUES (@name_rep , @usern , @cId)

GO

CREATE FUNCTION  viewAvailableStadiumsOn (@dat DATETIME)
RETURNS  @xx TABLE 
(
   name varchar(20),
    location varchar(20),
    capacity  INT
)
AS 
BEGIN 
 INSERT INTO @xx
    SELECT name , location , capacity 
    FROM stadium 
    WHERE status = 1 AND id IN 
    (SELECT stadium_id FROM match   
    WHERE stadium_id NOT IN 
    (SELECT stadium_id  FROM match 
    WHERE @dat >= start_time AND @dat <= end_time ))
RETURN ;
END

GO

CREATE PROCEDURE addHostRequest
@cl_name VARCHAR(20) , @st_name VARCHAR(20) , @st_time DATETIME
AS 
DECLARE @rep_Id INT
DECLARE @man_ID INT 
DECLARE @match_id INT 
DECLARE @clu_id INT
DECLARE @st_ID INT 
SELECT @clu_id = club_id FROM club 
WHERE name = @cl_name
SELECT @match_id = match_id FROM match  
WHERE host_club_id = @clu_id AND @st_time = start_time 
SELECT @rep_Id = id FROM club_representative
WHERE club_id  = @clu_id
SELECT @st_ID FROM stadium 
WHERE  name = @st_name
SELECT @man_ID = id FROM stadium_manager 
WHERE stadium_id = @st_ID
INSERT INTO host_request VALUES (@rep_Id , @man_ID , @match_id , NULL)

GO

CREATE FUNCTION allUnassignedMatches (@namee VARCHAR(20))
RETURNS  @xxf TABLE 
(
   name_guest varchar(20),
    start_time DATETIME
)
AS 
BEGIN 
INSERT INTO @xxf 
SELECT s.name , m.start_time FROM club s , match m
WHERE s.club_id = m.host_club_id AND m.stadium_id  = NULL AND s.name = @namee
RETURN;
END
 
GO

CREATE PROCEDURE addStadiumManager 
@namee VARCHAR(20) , @std_name VARCHAR(20) , @user_n VARCHAR(20) , @pas VARCHAR(20)
AS 
DECLARE @std_i INT 
SELECT @std_i = id FROM stadium
WHERE  name = @std_name
INSERT INTO systemuser VALUES  (@user_n , @pas)
INSERT INTO stadium_manager VALUES(@user_n , @namee , @std_i)

GO


CREATE FUNCTION allPendingRequests (@user_std_mang VARCHAR(20))
RETURNS  @xxy TABLE 
(
name_clh varchar(20),
name_clg VARCHAR(20),
start_m DATETIME 
)
AS
BEGIN 
DECLARE @stdm_ID INT
SELECT @stdm_ID = id FROM stadium_manager
WHERE @user_std_mang = username
INSERT INTO @xxy
SELECT a.name , b.name , c.start_time FROM club a , club b , match c , host_request v 
WHERE   a.club_id = c.host_club_id  AND b.club_id = c.guest_club_id AND v.match_id = c.match_id AND v.manager_id = @stdm_ID

RETURN;
END

GO

CREATE PROCEDURE acceptRequest 
@userstdm VARCHAR(20) , @host_clup_name VARCHAR(20) , @guest_clup_name VARCHAR(20) , @startt DATETIME
AS
DECLARE @m_id INT 
DECLARE @hid  INT
DECLARE @gid  INT
SELECT @hid = club_id FROM club 
WHERE name = @host_clup_name
SELECT @gid = club_id FROM club 
WHERE name = @guest_clup_name
SELECT @m_id = match_id FROM match 
WHERE  host_club_id = @hid AND guest_club_id  = @gid
UPDATE host_request
SET status = 1

GO

CREATE PROCEDURE rejectRequest 
@userstdm VARCHAR(20) , @host_clup_name VARCHAR(20) , @guest_clup_name VARCHAR(20) , @startt DATETIME
AS
DECLARE @m_id INT 
DECLARE @hid  INT
DECLARE @gid  INT
SELECT @hid = club_id FROM club 
WHERE name = @host_clup_name
SELECT @gid = club_id FROM club 
WHERE name = @guest_clup_name
SELECT @m_id = match_id FROM match 
WHERE  host_club_id = @hid AND guest_club_id  = @gid
UPDATE host_request
SET status = 0

GO

CREATE  PROCEDURE addFan 
@name VARCHAR(20) , @userrn VARCHAR(20) , @pa VARCHAR(20) , @nation_id VARCHAR(20) , @birth_date DATETIME , @adds VARCHAR(20) , @phone INT
AS
INSERT INTO systemuser VALUES (@userrn , @pa)
INSERT INTO fan VALUES (@nation_id , @name , @birth_date , @adds , @phone , 1 , @userrn)

GO

CREATE FUNCTION upcomingMatchesOfClub (@c_n VARCHAR(20))
RETURNS  @abc TABLE 
(
clubname varchar(20),
competingclub VARCHAR(20),
start_m DATETIME ,
host_std VARCHAR(20)
)
AS 
BEGIN
INSERT INTO @abc
SELECT c.name , d.name , x.start_time ,st.name FROM match x , club c , club d , stadium st
WHERE (( c.club_id = x.guest_club_id  AND d.club_id = x.host_club_id) OR ( c.club_id = x.host_club_id  AND d.club_id = x.guest_club_id)) AND x.stadium_id = st.id AND c.name = @c_n AND x.start_time > CURRENT_TIMESTAMP

RETURN;
END

GO


CREATE FUNCTION availableMatchesToAttend (@date DATETIME)
RETURNS  @abcd TABLE 
(
hclubname varchar(20),
gclubname VARCHAR(20),
start_m DATETIME ,
host_std VARCHAR(20)
)
AS 
BEGIN
INSERT INTO @abcd 
SELECT c.name , g.name , m.start_time , st.name FROM club c , club g  , match m , stadium st , ticket k 
WHERE m.host_club_id  = c.club_id AND m.guest_club_id  = g.club_id  AND st.id = m.stadium_id  ANd m.start_time >= CURRENT_TIMESTAMP AND k.match_id = m.match_id AND k.status = 1 

RETURN;
END 

GO


CREATE PROCEDURE purchaseTicket 
@nation VARCHAR(20) ,@hostcn VARCHAR(20) , @guestcn VARCHAR(20) , @st_time DATETIME 
AS 
DECLARE @host_id  INT
DECLARE @guest_id INT  
DECLARE @match_id INT 
DECLARE @tic_id INT 
SELECT @host_id = club_id FROM club
WHERE name = @hostcn 
SELECT @guest_id = club_id FROM club
WHERE name = @guestcn
SELECT @match_id = match_id  FROM match 
WHERE start_time  = @st_time AND host_club_id  = @host_id AND guest_club_id  = @guest_id 
SELECT @tic_id = id FROM ticket
WHERE  match_id = @match_id AND status = 1 
INSERT INTO ticket_buying_transaction VALUES (@nation , @tic_id)

GO


CREATE PROCEDURE updateMatchTiming 
@name_host_c VARCHAR(20) , @name_guest_c VARCHAR(20) , @c_s_t DATETIME , @n_e_t DATETIME , @n_s_t DATETIME 
AS
DECLARE @host_id  INT
DECLARE @guest_id INT  
SELECT @host_id = club_id FROM club
WHERE name = @name_host_c
SELECT @guest_id = club_id FROM club
WHERE name = @name_guest_c
UPDATE match 
SET start_time = @n_s_t , end_time = @n_e_t
WHERE  host_club_id = @host_id AND  guest_club_id = @guest_id AND  start_time =  @c_s_t

GO

CREATE VIEW matchesPerTeam AS 
SELECT  c.name , COUNT(m.match_id) AS summ  FROM match m , club c
WHERE c.club_id = m.host_club_id  OR  c.club_id = m.guest_club_id
GROUP BY c.name;

GO

CREATE PROCEDURE deleteMatchesOn 
@cert_day DATETIME 
AS
DELETE FROM host_request 
WHERE match_id IN 
(SELECT match_id  FROM match WHERE start_time = @cert_day)
DELETE FROM ticket_buying_transaction  WHERE ticket_id IN (SELECT id FROM ticket WHERE match_id IN (SELECT match_id  FROM match WHERE start_time = @cert_day))
DELETE FROM ticket WHERE  match_id IN (SELECT match_id  FROM match WHERE start_time = @cert_day)
DELETE FROM  match WHERE  start_time = @cert_day


GO

CREATE VIEW matchWithMostSoldTickets
AS
SELECT TOP 1  c.name  AS host , b.name AS guest   FROM club c , club b , match x , ticket r
WHERE x.host_club_id  = c.club_id  AND x.guest_club_id  =  b.club_id AND x.match_id = r.match_id AND r.status = 0
GROUP BY c.name , b.name 
ORDER BY COUNT(r.id)  DESC

GO

CREATE VIEW matchesRankedBySoldTickets
AS
SELECT  TOP 100 c.name  AS host , b.name AS guest , COUNT(r.id) AS count   FROM club c , club b , match x , ticket r
WHERE x.host_club_id  = c.club_id  AND x.guest_club_id  =  b.club_id AND x.match_id = r.match_id AND r.status = 0
GROUP BY c.name , b.name 
ORDER BY COUNT(r.id)  DESC


GO


CREATE PROCEDURE clubWithTheMostSoldTickets
@name_cl VARCHAR(20)
AS

SELECT c.name  , COUNT(r.id) AS count
INTO  y
FROM club c ,  match x , ticket r
WHERE x.host_club_id  = c.club_id  OR x.guest_club_id  =  c.club_id AND x.match_id = r.match_id AND r.status = 0 AND x.end_time < CURRENT_TIMESTAMP

GROUP BY c.name 
ORDER BY COUNT(r.id)  DESC

SELECT SUM(count) AS summ , y.name 
INTO yy
FROM y 
GROUP BY y.name
ORDER BY SUM(count) DESC

SELECT TOP 1 @name_cl = yy.name  FROM yy

GO
CREATE PROCEDURE clubsRankedBySoldTickets
AS

SELECT c.name  , COUNT(r.id) AS count
INTO  y
FROM club c ,  match x , ticket r
WHERE x.host_club_id  = c.club_id  OR x.guest_club_id  =  c.club_id AND x.match_id = r.match_id AND r.status = 0 AND x.end_time < CURRENT_TIMESTAMP

GROUP BY c.name 
ORDER BY COUNT(r.id)  DESC

SELECT SUM(count) AS summ , y.name 
INTO yy
FROM y 
GROUP BY y.name
ORDER BY SUM(count) DESC

GO

CREATE FUNCTION stadiumsNeverPLayedOn (@C_N VARCHAR(20))
RETURNS  @abcdf TABLE 
(
stname varchar(20),
capacity INT
)
AS 
BEGIN
DECLARE @CID INT 
SELECT @CID = club_id FROM club 
WHERE @C_N = name 
INSERT INTO @abcdf
SELECT s.name , s.capacity FROM stadium s 
 WHERE s.name NOT IN (SELECT s.name FROM stadium s ,  match r 
WHERE (r.host_club_id = @CID  OR r.guest_club_id = @CID) AND  r.stadium_id = s.id )

RETURN;
END

GO



























