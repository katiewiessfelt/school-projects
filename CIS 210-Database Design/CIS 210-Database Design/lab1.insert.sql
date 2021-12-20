insert into dbo.employee values ('James','E','Borg','888665555','10-NOV-27','450 Stone, Houston, TX','M',55000,null,null);
insert into dbo.employee values ('Franklin','T','Wong','333445555','08-DEC-45','638 Voss, Houston, TX','M',40000,'888665555',null);
insert into dbo.employee values ('Jennifer','S','Wallace','987654321','20-JUN-31','291 Berry, Bellaire, TX','F',43000,'888665555',null);
insert into dbo.employee values ('Jared','D','James','111111100','10-OCT-1966','123 Peachtree, Atlanta, GA','M',85000,null,null);
insert into dbo.employee values ('Alex','D','Freed','444444400','09-OCT-1950','4333 Pillsbury, Milwaukee, WI','M',89000,null,null);

select * from employee;

insert into dbo.department values ('Research', 1, '333445555', '22-MAY-78');
insert into dbo.department values ('Administration', 2, '987654321', '01-JAN-85');

select * from department;

update dbo.employee set dno=1 where ssn=888665555;
update dbo.employee set dno=2 where ssn=333445555;
update dbo.employee set dno=1 where ssn=987654321;
update dbo.employee set dno=2 where ssn=111111100;
update dbo.employee set dno=1 where ssn=444444400;

select * from employee;

insert into dbo.project values ('ProductX',1,'Bellaire',1);
insert into dbo.project values ('ProductY',2,'Sugarland',2);

select * from project;

insert into dbo.dept_locations values (1,'Houston');
insert into dbo.dept_locations values (2,'Stafford');

select * from dept_locations;

insert into dependent values ('333445555','Alice','F','05-APR-76','Daughter');
insert into dependent values ('333445555','Theodore','M','25-OCT-73','Son');
insert into dependent values ('987654321','Abner','M','29-FEB-32','Spouse');

select * from dependent;

insert into works_on values ('333445555',1, 10.0);
insert into works_on values ('333445555',2, 10.0);
insert into works_on values ('987654321',1,20.0);
insert into works_on values ('444444400',2,40.0);

select * from works_on;

select * from employee;
select * from department;
select * from project;
select * from dept_locations;
select * from dependent;
select * from works_on;