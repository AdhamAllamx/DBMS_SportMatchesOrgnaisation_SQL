create database ms2 ;
EXEC createAllTables;

go
create procedure createAllTables
as

create table SystemUser
(
    username varchar(20)   ,
    password varchar(20),
    primary key (username)
)
create TABLE Club
(
    club_ID int IDENTITY(1,1) ,
    name varchar(20) ,
    location varchar(20),
    PRIMARY KEY (club_ID)
)
create table Stadium
(
    ID int IDENTITY(1,1) ,
    name varchar(20) ,
    location varchar(20) ,
    capacity int  ,
    status bit ,
    PRIMARY KEY (ID)

)
create table StadiumManager
(
    ID int IDENTITY(1,1) ,
    name varchar(20) ,
    stadium_ID int ,
    username varchar(20)   ,
    PRIMARY KEY (ID),
    FOREIGN KEY (username) REFERENCES SystemUser (username) ON DELETE CASCADE   ,
    FOREIGN KEY (username) REFERENCES SystemUser  (username) ON UPDATE  CASCADE   ,

    FOREIGN KEY (stadium_ID) REFERENCES Stadium (ID) on DELETE CASCADE,
    FOREIGN KEY (stadium_ID) REFERENCES Stadium (ID) on UPDATE  CASCADE

)
create table ClubRepresentative
(
    ID int IDENTITY(1,1) ,
    name varchar(20) ,
    club_ID int ,
    username VARCHAR(20),
    PRIMARY KEY (ID) ,

    FOREIGN KEY (username) REFERENCES SystemUser (username) ON DELETE CASCADE   ,
    FOREIGN KEY (username) REFERENCES SystemUser (username) ON UPDATE  CASCADE   ,
    FOREIGN KEY (club_ID) REFERENCES Club(club_ID) on DELETE CASCADE ,
    FOREIGN KEY (club_ID) REFERENCES Club(club_ID) on UPDATE  CASCADE


)
create table Fan
(
    national_ID int IDENTITY (1,1)   ,
    name VARCHAR(20) ,
    birth_date DATETIME ,
    address VARCHAR(20) ,
    phone_no VARCHAR(20),
    status BIT ,
    username varchar(20) ,
    PRIMARY KEY ( national_ID )  ,
    FOREIGN KEY (username) REFERENCES SystemUser (username) on delete cascade ,
    FOREIGN KEY (username) REFERENCES SystemUser (username) on update cascade
)

create table SportsAssociationManager
(
    ID int IDENTITY(1,1) ,
    name varchar(20) ,
    username varchar(20),
    PRIMARY KEY (ID) ,
    FOREIGN KEY (username) REFERENCES SystemUser (username) ON DELETE CASCADE ,
    FOREIGN KEY (username) REFERENCES SystemUser (username) ON UPDATE  CASCADE


)
create TABLE SystemAdmin
(
    ID int IDENTITY(1,1)  ,
    name VARCHAR(20)       ,
    username varchar(20),
    PRIMARY key (ID) ,
    FOREIGN KEY (username) REFERENCES SystemUser  (username) ON DELETE CASCADE ,
    FOREIGN KEY (username) REFERENCES SystemUser  (username) ON UPDATE  CASCADE

)
create table Match
(
    match_ID int IDENTITY(1,1) ,
    start_time datetime ,
    end_time datetime ,
    host_club_ID int ,
    guest_club_ID int ,
    stadium_ID int ,
    PRIMARY key (match_ID ) ,
    FOREIGN KEY (host_club_ID) REFERENCES Club(club_ID)  on update cascade ,
    FOREIGN KEY (host_club_ID) REFERENCES Club(club_ID)  on DELETE  cascade ,

    FOREIGN KEY (guest_club_ID) REFERENCES Club(club_ID) on update NO ACTION ,
    FOREIGN KEY (guest_club_ID) REFERENCES Club(club_ID) on DELETE NO ACTION ,

    FOREIGN KEY (stadium_ID) REFERENCES Stadium(ID) on update cascade ,
    FOREIGN KEY (stadium_ID) REFERENCES Stadium(ID) on DELETE cascade

)
create table Ticket
(
    ID int IDENTITY(1,1) ,
    status bit ,
    match_ID int ,
    primary key (ID) ,
    FOREIGN key (match_ID) REFERENCES Match (match_ID) on update cascade ,
    FOREIGN key (match_ID) REFERENCES Match (match_ID) on delete  cascade
)

create table TicketBuyingTransactions
(
    fan_national_ID int ,
    ticket_ID int ,
    FOREIGN key (fan_national_ID) REFERENCES Fan (national_ID) on delete cascade  ,
    FOREIGN key (fan_national_ID) REFERENCES Fan (national_ID) on update cascade  ,

    FOREIGN key (ticket_ID) REFERENCES Ticket (ID) on delete cascade ,
    FOREIGN key (ticket_ID) REFERENCES Ticket (ID) on update  cascade



)

--has a relation with statdum manger called Manges 
--has a relation with match called hosts 


--has a relation with stadium manger called handels
--has a relation with club represntive called asksfor
create TABLE HostRequest
(
    ID int IDENTITY(1,1) ,
    representative_ID int ,
    manager_ID int ,
    match_ID int ,
    status bit  ,
    PRIMARY KEY (ID) ,
    FOREIGN key (representative_ID) REFERENCES ClubRepresentative (ID) ON UPDATE CASCADE ,
    FOREIGN key (representative_ID) REFERENCES ClubRepresentative (ID) ON DELETE CASCADE ,

    FOREIGN key (manager_ID) REFERENCES StadiumManager(ID) ON UPDATE no action,
    FOREIGN key (manager_ID) REFERENCES StadiumManager(ID) ON DELETE no action,

    FOREIGN key (match_ID) REFERENCES Match (match_ID) ON UPDATE no action ,
    FOREIGN key (match_ID) REFERENCES Match (match_ID) ON DELETE no action
)

--has a relation with stadium  called Hosts
--has a relation with club  called playes as host
--has a relation with club  called playes as guest
--has a relation with ticket called asksfor


--has a relation with club represintitve  called Represents 



--has a relation with Fan called Buys 

go
;

create procedure dropAllTables
as
drop table HostRequest
drop table TicketBuyingTransactions
drop table Ticket
drop table Match
drop table SystemAdmin
drop table SportsAssociationManager
drop table Fan
drop table ClubRepresentative
drop table StadiumManager
drop table Stadium
drop table Club
drop table SystemUser
go
;
create procedure dropAllProceduresFunctionsViews as 
drop procedure createAllTables 
drop procedure dropAllTables 
drop procedure clearAllTables 
drop view allAssocManagers 
drop view allClubRepresentatives 
drop view allStadiumManagers 
drop view allFans
drop view allMatches 
drop view allTickets 
drop view allCLubs 
drop view allStadiums 
drop view allRequests 
drop procedure addAssociationManager
drop procedure addNewMatch
drop view clubsWithNoMatches
drop procedure deleteMatch
drop procedure deleteMatchesOnStadium
drop procedure addClub
drop procedure addTicket
drop procedure deleteClub
drop procedure addStadium
drop procedure deleteStadium
drop procedure blockFan
drop procedure unblockFan
drop procedure addRepresentative
drop function viewAvailableStadiumsOn
drop procedure addHostRequest
drop function allUnassignedMatches
drop procedure addStadiumManager
drop function allPendingRequests
drop procedure acceptRequest
drop procedure rejectRequest
drop procedure addFan
drop function upcomingMatchesOfClub
drop function availableMatchesToAttend
drop procedure purchaseTicket
drop procedure updateMatchHost
drop view matchesPerTeam
drop view clubsNeverMatched
drop function clubsNeverPlayed
drop function matchWithHighestAttendance
drop function matchesRankedByAttendance
drop function requestsFromClub

go ;

create procedure clearAllTables
as
truncate table HostRequest
truncate table TicketBuyingTransactions
truncate table Ticket
truncate table Match
truncate table SystemAdmin
truncate table SportsAssociationManager
truncate table Fan
truncate table ClubRepresentative
truncate table StadiumManager
truncate table Stadium
truncate table Club
truncate table SystemUser
go;
------------------------------------------------------------------------------------------------
create view allAssocManagers
as
    select sam.username , su.password , sam.name
    from SportsAssociationManager  as sam, SystemUser as su
    where sam.username = su.username ;

go
-----------------------------------------------------------------------------------------------------

create view allClubRepresentatives
as
    select cr7.username , su.password , cr7.name  as ClubRepresentative , c.name  as Club
    from Club as  c  , ClubRepresentative as cr7 , SystemUser as su
    where c.club_ID = cr7.club_ID and cr7.username = su.username ;
go
----------------------------------------------------------------------------------------------------
create view allStadiumManagers
as
    select sm.username , su.password , sm.name as StadiumManager  , s.name  as Stadium
    from StadiumManager as sm inner join Stadium as s on (sm.stadium_ID = s.ID)
        inner join SystemUser as su on (sm.username =su.username) ;


go
----------------------------------------------------------------------------------------------------


create view allFans
as
    select f.username , su.password , f.name , f.national_ID , f.birth_date , f.status
    from Fan as f , SystemUser as su
    where f.username = su.username ;

go


go
--------------------------------------------------------------------------------------------
create view allMatches
as
    select c1.name as HostClub, c2.name as GuestClub , m.start_time
    from Match as m inner join club as c1 on (m.host_club_ID =c1.club_ID)
        inner join club as c2 on (c2.club_ID = m.guest_club_ID )
    where  c1.club_ID <> c2.club_ID ;

go
-------------------------------------------------------------------------------------------


create view allTickets
as
    select c1.name as HostClub , c2.name as GuestClub, s.name as Stadium, m.start_time
    from Match as m inner join Club as c1 on (c1.club_ID = m.host_club_ID )
        inner join Club as c2 on (c2.club_ID = m.guest_club_ID)
        inner join Stadium as  s on(m.stadium_ID =s.ID )
        inner join Ticket as t on (t.match_ID = m.match_ID)
    where c1.club_ID <> c2.club_ID ;
go

------------------------------------------------------------------------------------------------
create view allClubs
as
    select name , location
    from Club ;
go

--------------------------------------------------------------------------------------------------
create view allStadiums
as
    select name , location , capacity , status
    from Stadium ;
go

---------------------------------------------------------------------------------------------------------
create view  allRequests
as
    select cr.username as ClubRepresentative , sm.username as StadiumManager , hr.status
    from HostRequest as hr inner join ClubRepresentative as cr on (hr.representative_ID = cr.ID)
        inner join StadiumManager as sm on (hr.manager_ID = sm.ID)
        inner join SystemUser as su1 on (su1.username = cr.username)
        inner join SystemUser as su2 on (su2.username = sm.username)
    where su1.username <> su2.username ;
go



create procedure addAssociationManager
    @name varchar(20) ,
    @username varchar (20),
    @password varchar (20)
as
insert into SystemUser
values
    ( @username , @password )
insert into SportsAssociationManager
values
    ( @name , @username ) 
go



create procedure addNewMatch
    @hostclub varchar(20) ,
    @guestclub varchar (20) ,
    @start_time datetime ,
    @end_time datetime
as
DECLARE @hostclubid int
declare @guestclubid int
declare @stadiumid int

--change this to amrs way

set  @hostclubid = (select c.club_ID
FROM Club as c 
 
WHERE c.name = @hostclub )

--change this to amrs way

set @guestclubid = (select c.club_ID
FROM Club as c 
where c.name = @guestclub
)

set @stadiumid = ( select s.ID
FROM Stadium s ,Club c 
WHERE c.name = @hostclub and c.location = s.location)

if @hostclubid is not null and @guestclubid is not null and @start_time is not null  and @end_time is not null
begin
INSERT INTO MATCH
values
    ( @start_time , @end_time , @hostclubid , @guestclubid , null )
    
   end
go
;

create view clubsWithNoMatches
as
            select name
        from Club
    except
        (
        select c2.name
        from club c2 , Match m2
        where c2.club_ID = m2.host_club_ID or c2.club_ID = m2.guest_club_ID and c2.club_ID <> club_ID )
go;

go
--------------------------------------------------------------------------------------------------------

create procedure deleteMatch
    @hostclub varchar (20) ,
    @guestclub varchar (20)

as
declare @guestclub_id int , @hostclub_id int

select @hostclub_id = (select c.club_id 
from club c
where c.name=@hostclub)

select @guestclub_id = (select c.club_id 
from club c
where c.name=@guestclub)

delete hostrequest 
from match m , hostrequest h 
where h.match_id = m.match_id and m.host_club_id= @hostclub_id and m.guest_club_id= @guestclub_id 

delete ticket 
from match m , ticket t
where t.match_id = m.match_id and m.host_club_id= @hostclub_id and m.guest_club_id= @guestclub_id  

delete 
from match 
where  host_club_id = @hostclub_id   
and   guest_club_id = @guestclub_id

go;
-----------------------------------------------------------------------------------------------------------
create procedure deleteMatchesOnStadium
    @stadiumname varchar (20)
as
declare @std_id int

select @std_id = s.id 
from stadium 
where s.name =@stadiumname

delete match from match 
where start_time >= current_timestamp and stadium_id= @std_id

delete ticket 
from ticket t , match m
where m.match_id = t.match_id and start_time >= current_timestamp and m.stadium_id= @std_id

delete HostRequest 
from HostRequest t , match m
where m.match_id = t.match_id and start_time >= current_timestamp and m.stadium_id= @std_id

--------------------------------------------------------------------------------------------------------
go
create procedure addClub
    @clubname varchar(20) ,
    @location varchar (20)
as
insert into Club
values
    (@clubname , @location ) 

go
;
--------------------------------------------------------------------------------------------
create procedure addTicket
    @hostclubname varchar(20) ,
    @guestclubname varchar(20) ,
    @start_time datetime
as
declare @matchid int

set @matchid = (select m.match_ID
FROM Club as c inner join ClubRepresentative as cr on (c.club_ID = cr.club_ID )
    inner join HostRequest as hr on (cr.ID = hr.representative_ID )
    inner join StadiumManager as sm on (sm.ID = hr.manager_ID )
    inner join Stadium as s on (sm.stadium_ID = s.ID )
    inner join Match as m on (s.ID = m.stadium_ID and c.club_ID = m.host_club_ID )
    inner join SystemUser as su on ( su.username = cr.username )
    inner join SystemUser as su2 on (su2.username = sm.username )
    inner join Ticket as t on (t.match_ID = m.match_ID )
    inner join Club as c2 on (c2.club_ID = m.guest_club_ID )
where c.name = @hostclubname and c2.name = @guestclubname and c.club_ID <> c2.club_ID )

insert into Ticket
values
    (1 , @matchid) 

go
;
--------------------------------------------------------------------------------------------
--vii
create procedure deleteClub
    @clubname varchar(20)
as
declare @clubid int , @clubrep varchar(20)

select @clubid = (
select c.id 
from club c 
where c.name = @clubname )

select @clubrep  = (
select c.username
from ClubRepresentative c 
where c.club_id =@clubid)

DELETE FROM Club
WHERE name = @club_name

delete ticket 
from ticket t , match m
where m.match_id = t.match_id and m.host_club_id= @clubid or m.guest_club_id= @clubid

delete match 
from match m
where m.host_club_id= @clubid or m.guest_club_id= @clubid

delete 
from  systemuser
where username = @clubre

delete hostrequest
from hostrequest h , ClubRepresentative c
where c.club_id = h.representative_id and c.club_id= @clubid

delete 
from ClubRepresentative 
where club_id = @clubID




--------------------------------------------------------------------------------------------
--ix
go
create procedure addStadium
    @name varchar(20),
    @location varchar(20),
    @capacity  int
as

insert into Stadium
values
    (@name, @location , @capacity , 1 ) 

go
-----------------------------------------------------------------------------------------------
--x
create procedure deleteStadium
    @name VARCHAR(20)
AS
DECLARE @stad_ID int , @stdm_username varchar(20)


SELECT @stad_ID = (SELECT s.ID
    from Stadium s
    WHERE s.name = @stad_ID)

select  @stdm_username =(
select sm.username 
from stadiummanger sm 
where sm.stadium_id = @stad_ID)

delete stadium 
from stadium 
where stadium.name = @name

delete stadiumManger 
from StadiumManager
where stadium_id = @stad_ID

delete systemuser
from systemuser
WHERE username = @stdm_username

DELETE hostrequest
FROM hostrequest H, stadiumManager S
WHERE h.manager_id = s.id and s.stadium_id = @stad_ID

update match
set stadium_id = null
where stadium_id = @stad_ID

-----------------------------------------------------------------------------------------------------




--xi
go
create procedure blockFan
    @national_ID VARCHAR(20)
AS

UPDATE Fan 
set  status = 0 where national_ID = @national_ID go
;



-----------------------------------------------------------------------------------------------------
--xii
create procedure unblockFan
    @national_ID VARCHAR(20)
AS

UPDATE Fan 
set status = 1 
where national_ID = @national_ID go
;
--------------------------------------------------------------------------------------------------

--xiii
create procedure addRepresentative
    @name VARCHAR(20) ,
    @club_name VARCHAR(20) ,
    @user_name VARCHAR(20) ,
    @password VARCHAR(20)

AS
DECLARE @club_ID int
select @club_ID = (SELECT c.Club_ID
    from club c
    where c.name = @club_name)
INSERT INTO SystemUser
values(@user_name, @password)
INSERT INTO ClubRepresentative
values(@name , @club_ID , @user_name) go;

-----------------------------------------------------------------------------------------------------
go 
create function viewAvailableStadiumsOn (@time datetime)
returns table 
as 
return 
select s.name , s.capacity , s.location
from  stadium s
where s.status<>0 and 
not exists(
select s1.name , s1.capacity , s1.location
from  stadium s , match m1
where s1.id =s.id and m1.start_time=@time and s1.id= m1.stadium_id
)
go


-----------------------------------------------------------------------------------------------------
create procedure addHostRequest 
@clubName varchar(20), 
@stadiumName varchar(20), 
@date datetime

AS
declare @Rep_ID int , 
@manger_ID int ,
@matchID int

select @Rep_ID = 
(select CR.id  
from Club c , ClubRepresentative CR 
where c.club_ID = cr.club_ID AND @clubName = c.name)

select @manger_ID  =
(select m.id from stadium S , stadiumManager M 
where s.ID = m.stadium_ID AND 
@stadiumName = s.name) 

select @match_ID  =
(select m.match_ID 
from Match m , Club c 
where m.host_club_ID = c.id and m.start_time = @date AND 
m.stadium_ID is NULL 
)

insert into HostRequest values (@rep_ID , 
manager_ID , @matchID , null) ;
go 
------------------------------------------------------------------------------------------------------

create Function allUnassignedMatches 
(@clubName varcahr(20))

returns table 
as 
return 
(select c1.name , m.start_time  from 
match m , club c , club c1  
where m.host_club_ID = c.club_ID AND @clubname = c.name 
AND m.stadium_ID is NULL and c1.club_ID = m.guest_club_ID)



------------------------------------------------------------------------------------------------------

go
drop function viewAvailableStadiumsOn

select * from dbo.viewAvailableStadiumsOn('2022/12/12 06:00:00 ')

select * from Stadium 
select * from Match
go
----------------------------------------------------------------------------------------------------
create procedure addStadiumManager
    @manger_name varchar(20) ,
    @stadium_name VARCHAR(20) ,
    @user_name VARCHAR(20) ,
    @password VARCHAR(20)
AS
DECLARE @stad_ID int

select @stad_ID = (SELECT stadium.ID
    from stadium
    where stadium.name = @stadium_name)

INSERT INTO SystemUser
values(@user_name , @password )
INSERT into StadiumManager
values(@manger_name , @stad_ID , @user_name) 
----------------------------------------------------------------------------------------------------
go
;

create procedure acceptRequest
    @user_name VARCHAR(20) ,
    @host_name VARCHAR(20) ,
    @guest_name VARCHAR(20) ,
    @start_time datetime

AS

declare 
@host_ID int ,
@guest_ID int , 
@rep_ID int , 
@match_ID int , 
@manager_ID int , 
@match_start_time datetime , 
@stad_ID int ,
@stad_Capacity int ,
@i int = 0 


SET @host_ID = (select c.Club_ID
    from Club c
    where c.name = @host_name)

SET @guest_ID = (select c.Club_ID
    from Club c
    where c.name = @guest_name)
SET @manager_ID = (select c.ID
    from stadiumManager s
    where s.username = @user_name)
SET @rep_ID = (SELECT s.ID
    from ClubRepresentative s
    where s.club_ID = @host_ID)

set @match_ID = (
select m.match_id 
from match m 
where m.host_club_id = @host_ID and
m.guest_club_id = @guest_ID and
m.start_time = @start_time and
m.stadium_id is null)

set @manager_id =
(
select s.id
from stadiumManager s
where S.username = @user_name 
)

select @match_start_time = 
(
select m.start_time
from match m
where m.match_id = @match_id
)

select @stadium_id =
(
select SM.stadium_id
From StadiumManager SM
Where SM.id = @manager_ID
)

select @stadium_capacity =
(
select capacity
from stadium
where id = @stad_ID
)

update hostrequest
set status = 'accepted'
where id = @host_ID

update match
set stadium_id = @stad_ID
where match_id = @match_id

WHILE @i < @stad_Capacity AND @match_start_time = @start_time
BEGIN
INSERT INTO Ticket VALUES (1, @match_id)
SET @i =@i + 1
END

------------------------------------------------------------------------
go
create procedure rejectRequest
    @user_name VARCHAR(20) ,
    @host_name VARCHAR(20) ,
    @guest_name VARCHAR(20) ,
    @start_time datetime

AS

declare @host_ID int , @guest_ID int ,@rep_ID int , @match_ID int , @manager_ID int

SET @host_ID = (select c.club_ID
    from Club c
    where c.name = @host_name)

SELECT @guest_ID = (select c.Club_ID
    from Club c
    where c.name = @guest_name)

select @manager_ID = (select c.ID
    from StadiumManager c
    where c.username = @user_name)

select @rep_ID = (SELECT s.ID
    from ClubRepresentative s
    where s.club_id = @host_id)

select @match_ID = (SELECT m.ID
    from match
    where m.host_club_ID = @host_ID and m.guest_club_ID = @guest_ID and start_time =  @start_time and m.stadium_id is null)  

UPDATE HostRequest 
set status
= 'rejected' where HostRequest.representative_ID =@rep_ID and HostRequest.manager_ID = @manager_ID and HostRequest.match_ID = @match_ID
go;
------------------------------------------------------------------------------------------------------------------------------------------------------

create procedure addFan 
@fan_name varchar(20) , @user_name VARCHAR(20) , 
@password VARCHAR  , @national_ID varchar(20) , 
@birth_date DATETIME , @address varchar(20) ,
@phone_no int 

AS 

insert into SystemUser values(@user_name , @password ) 

INSERT into Fan values(@national_ID,@name , @birth_date , @address , @phone_no , '1' , @user_name) go ;
------------------------------------------------------------------------------------------------------------------------------------------------------
create procedure purchaseTicket 
@national_ID varchar(20) ,  @host_name varchar(20) , @guest_name VARCHAR(20) ,
@start datetime  

as 

declare @ticket_ID int , @match_ID int , @host_ID int , @guest_ID int 

SET @host_ID = (select c.club_ID from Club c where c.name = @host_name) 
SET @guest_ID = (select c.club_ID from Club c where c.name = @guest_name) 
SET @match_ID = (select m.match_ID from match where m.host_club_ID = @host_ID and m.guest_club_ID = @guest_ID and m.start_time=@start)
SET @ticket_ID = (select t.ID from ticket where t.match_ID = @match_ID and t.status='1') 

INSERT INTO TicketBuyingTransactions VALUES (@national_ID,@ticket_ID) 
update ticket
set status=0 
where ticket.id = @ticket_ID

go;
--------------------------------------------------------------------------------------------------------------------------------------------------

create procedure updateMatchHost 

@host_club_name varchar(20), @guest_club_name varchar(20), @start_time datetime

as 
declare @match_id int, @host_club_id int , @guest_club_id int ,@stadium_id int 

SET @guest_club_id = (select c.club_ID
from club as c inner join Match as m on (c.club_ID  = m.guest_club_ID) 
where c.name = @guest_club_name )

SET @host_club_id = (select c.club_ID
from club as c inner join Match as m on (c.club_ID  = m.host_club_ID) 
where c.name = @host_club_name )

set @match_id = (select m.match_id from match m where m.start_time =@start_time and 
m.host_club_id= @host_club_id and  m.guest_club_id= @guest_club_id)


SET @stadium_id = (select s.ID
    from Stadium as s inner join club as c on (s.location = c.location)
    where c.name = @guest_club_name)


update match
set host_club_id = @guest_club_id , guest_club_id = @host_club_id , stadium_id = @stadium_id --why null 
where match_id = @match_id 

go;
----------------------------------------------------------------------------------------------------------------

create view matchesPerTeam 
as
select c.name , count (m.match_ID )
FROM Club c , Match m 
where m.end_time<=current_timestamp and c.club_ID = m.host_club_ID or c.club_ID = m.guest_club_ID 
group by c.name 

--------------------------------------------------------------------------------------------------------

go ;
CREATE VIEW clubsNeverMatched AS
(
Select DISTINCT C1.name as firstclub_name, C2.name as secondclub_name
From Club C1, Club C2, Match M
Where C1.club_ID <> C2.club_ID
AND Not Exists
(
Select *
From Club C3, Club C4, Match M1
Where C3.club_ID = C1.club_ID AND C4.club_ID = C2.club_ID
AND C3.club_ID = M1.host_club_id AND C4.club_ID = M1.guest_club_ID
)
AND Not Exists
(
Select *
From Club C3, Club C4, Match M1
Where C3.club_ID = C1.club_ID AND C4.club_ID = C2.club_ID
AND C3.club_ID= M1.guest_club_id AND C4.club_ID = M1.host_club_id
)
AND C1.club_ID < C2.club_ID
)

-------------------------------------------------------------------------------------------------------------------

go



create function [clubsNeverPlayed]
(@club_named varchar(20)) 

returns table 
as 
return 
select c.name from club c
where not exists 

( Select *
From Club C3, Club C4, Match M1
Where c3.name = @club_named and c4.Club_id=c.Club_id or c1.id = c2.id
AND C3.Club_id = M1.host_club_id AND C4.Club_id = M1.guest_club_id 
or  C3.Club_id = M1.guest_club_id AND C4.Club_id = M1.host_club_id
and m1.start_time <current_timestamp
)



-----------------------------------------------------------------------------------------------------------------------------------------------------
go
create function matchesRankedByAttendance()
returns table 
as 
return(
select c.name , c1.name from dbo.helper() A ,match m , club c , club c1 
where a.match_id= m.match_id and M.guest_club_id = C1.Club_id and M.host_club_id = C.Club_id
)
go

GO 
CREATE FUNCTION helper()
returns table
as 
return
select top (100) percent count(t.id) , t.match_id 
from match m2 , ticket t 
where t.status = 0 and m.match_id =t.match_id
group by t.match_id
order by count(t.id) desc 
go

----------------------------------------------------------------------------------------------------------------------------------------------
go
create function requestsFromClub( @stdname varchar(20) , @clubname varchar(20))
returns table
as 
return 
select c.name , c1.name
from club c , club c1 , match m 
where M.guest_club_id = C1.Club_id and M.host_club_id = C.Club_id

and exists(
select m1.match_id
from hostrequest h , match m2 , dbo.stdmanager(@stdname)  s , dbo.clubrep(@clubname) c
where m.match_id=m1.match_id and  h.representative_id=c.id and H.manager_id = s.id)

go

create function stdmanager(@stdname varchar (20)) 
returns table 
as 
return (
select sm.id
from stadium s , stadiumManager sm
where s.name = @stdname and sm.stadium_id =s.id)
go

go
create function clubrep(@clubname varchar(20))
returns table
as 
return 
(select cr.id
from club c , ClubRepresentative cr
where c..name = @clubname and cr.club_id=c.id)
go
---------------------------------------------------------------------------------------------------------


Create proc insertDummy
as
-- insert users -- 
insert into SystemUser values
-- Fan -- 
('yousef', '123'),
('ibrahim', '321'),
('mariam', '789'),
('akrm', '987'),
('samir', '456'),
('yaseen', '753'),
('mohamed', '357'),
-- SM --
('kareem', '159'),
('fares', '951'),
('fadel', '489'),
-- CR --
('hoda', '4897'),
('baraa', '657'),
('samy', '4568'),
('karam', '456'),
('nardi', '577'),
-- SA --
('omar', '657'),
('safwat', '26498'),
-- SystemAdmin --
('betengan', 'betengan123')
   
-- insert some fans --
insert into fan values
( 'Yousef', '2002/04/05 10:34:08', 'ma3adi', 010948956, 1, 'yousef'),
( 'Ibrahim', '2002/7/15', 'yasmeen', 1094598947, 1, 'ibrahim'),
( 'Akrm', '2002/8/26', 'rehab', 010958595, 1, 'akrm'),
( 'Yaseen', '2002/5/23', 'tagamo3', 10948987, 1, 'Yaseen'),
( 'Samir', '1999/8/24', 'rehab', 011944855, 0, 'Samir'),
( 'Mariam', '2004/6/14', 'banafseg', 0129784849, 0, 'mariam'),
( 'Mohamed', '2000/9/4', 'yasmeen', 01094789456, 0, 'mohamed')

-- insert SA -- 
insert into SportsAssociationManager values
('Omar', 'omar'),
('Safwat', 'safwat')

-- insert SystemAdmin -- 
insert into SystemAdmin values
('BigBetengan', 'betengan')

-- insert Clubs --
insert into Club values
('Barca', 'Spain'),
('Real', 'Portugal'),
('City', 'England'),
('Paris', 'France'),
('Liver', 'Europe')

-- insert Stadium -- 
insert into Stadium values
('QatarStad', 'Qatar', 100000, 1),
('EgyptStadium', 'Egypt', 50, 0),
('GermanyStadium', 'Germany', 50000, 1)

-- insert SM --
insert into StadiumManager values
('Kareem', 3, 'kareem'),
('Fadel', 1, 'fadel'),
('Fares', 2, 'fares')

-- insert CR --
insert into ClubRepresentative values
('Hoda', 1, 'hoda'),
('Baraa', 2, 'baraa'),
('Samy', 3, 'samy'),
('Karam', 4, 'karam'),
('Nardi', 5, 'nardi')

-- insert Match --
insert into Match values
('2022/12/18 05:00:00','2022/12/18 06:45:00', 1, 2, 1),
('2022/12/12 05:00:00','2022/12/12 06:30:00', 2, 3, 3),
('2022/12/15 09:00:00','2022/12/15 10:30:00', 1, 5, 1),
('2022/12/16 05:00:00','2022/12/16 06:30:00', 5, 3, 3)

-- insert some Tickets --
insert into Ticket values
(0, 1),
(1, 1),
(1, 2),
(1, 2)
go
select * from Ticket
select * from fan
exec dropAllTables
exec createAllTables
exec insertDummy









