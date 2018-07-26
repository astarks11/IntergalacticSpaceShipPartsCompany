create table Customer(
	CustNum integer not null,
	CustName varchar(30),
	primary key(CustNum)
);

create table Part(
	PartNum integer not null,
	PartName varchar(30),
	PartCost integer,
	IsLux integer,
	primary key(PartNum) 
);

create table Department(
	DeptName varchar(30) not null,
	ShipNum integer,
	primary key(DeptName)
);
create table Ship(
	ShipNum integer not null,
	ShipName varchar(30),
	MarkUp number(6, 3),
	primary key(ShipNum)
);
create table ShipPart(
	ShipNum integer not null,
	PartNum integer not null,
	constraint NecShipPartNums primary key(ShipNum, PartNum)
);

create table Contract(
	ContractNum integer not null,
	CustNum integer,
	DeptName varchar(30),
	ShipNum integer,
	Cost integer,
	constraint ContractNums primary key(ContractNum, CustNum)
);
create table MissingPart(
	ContractNum integer not null,
	PartNum integer not null,
	constraint MisPartKey primary key(ContractNum, PartNum)
);



-- Grant permissions to tables
grant select on Customer to public;
grant select on Part to public;
grant select on Department to public;
grant select on Ship to public;
grant select on ShipPart to public;
grant select on Contract to public;
grant select on MissingPart to public;

grant update on Customer to public;
grant update on Part to public;
grant update on Department to public;
grant update on Ship to public;
grant update on ShipPart to public;
grant update on Contract to public;
grant update on MissingPart to public;

grant insert on Customer to public;
grant insert on Part to public;
grant insert on Department to public;
grant insert on Ship to public;
grant insert on ShipPart to public;
grant insert on Contract to public;
grant insert on MissingPart to public;

grant delete on Customer to public;
grant delete on Part to public;
grant delete on Department to public;
grant delete on Ship to public;
grant delete on ShipPart to public;
grant delete on Contract to public;
grant delete on MissingPart to public;
