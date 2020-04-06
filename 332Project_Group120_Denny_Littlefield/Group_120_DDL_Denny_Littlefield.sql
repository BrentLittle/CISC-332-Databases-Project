drop Database spcadb;
create database SPCADB;
use SPCADB;

create table organization(
    name varchar(32) not null,
    primary key (name));
    
create table animals(
    animal_id char(9) not null,
	species varchar(6) not null,
	arrival_loc varchar(32) not null,
	doa date not null,
	dod date,
	location varchar(32),
	primary key (animal_id),
    foreign key (arrival_loc) references organization (name),
    foreign key (location) references organization (name));

create table families(
	last_name varchar(32) not null,
	phone_number char(10) not null,
	address varchar(32),
	primary key (last_name, phone_number));
	
create table spcaBranch(
	name varchar(32) not null,
	address varchar(32) not null,
	phone_number char(10) not null,
	primary key (name, phone_number),
    foreign key (name) references organization (name));
    
create table rescueOrganization(
	name varchar(32) not null,
	address varchar(32) not null,
	phone_number char(10) not null,
	primary key (name, phone_number),
    foreign key (name) references organization (name));
    
create table shelter(
	name varchar(32) not null,
	address varchar(32) not null,
	phone_number char(10) not null,
    website_url varchar(64) not null,
    max_cats int,
    max_dog int,
    max_rabbits int,
    max_rodent int,
	primary key (name, phone_number),
    foreign key (name) references organization (name));
    
create table drivers(
	name varchar(32) not null,
	phone_number char(10) not null,
	plate_number varchar(8) not null,
	license_number char(15) not null,
	organization varchar(32) not null,
	primary key (license_number),
	foreign key (organization) references rescueOrganization (name));
    
create table employees(
    name varchar(32) not null,
    phone_number char(10) not null,
    address varchar(32),
    employee_rank varchar(16) not null,
    employer varchar(32) not null,
    primary key (phone_number),
    foreign key (employer) references organization (name));
	
create table donations(
	donator varchar(32) not null,
	receiver varchar(32) not null,
	donation_date date not null,
	amount decimal(9,2) not null,
	primary key (donator, receiver, donation_date),
	foreign key (receiver) references organization (name));
    
/* for animal weight justification see english mastiff Zorba */
create table vetRecords(
    vet_name varchar(32) not null,
    animal_id char(9) not null,
    animal_condition varchar(32) not null,
    animal_weight decimal(5,2), 
    dov date not null,
    primary key (dov, animal_id),
    foreign key (animal_id) references animals (animal_id));
    
create table spca_adopt(
    family_name varchar(32) not null,
    family_phone char(10) not null,
    branch_name varchar(32) not null,
    branch_phone char(10) not null, 
    animal_id char(9) not null,
    cost decimal(6,2),
    primary key (family_name, family_phone, branch_name, branch_phone),
    foreign key (family_name, family_phone) references families (last_name, phone_number),
    foreign key (branch_name, branch_phone) references spcaBranch (name, phone_number),
    foreign key (animal_id) references animals (animal_id));
    
create table shelter_adopt(
    family_name varchar(32) not null,
    family_phone char(10) not null,
    shelter_name varchar(32) not null,
    shelter_phone char(10) not null, 
    animal_id char(9) not null,
    cost decimal(6,2),
    primary key (family_name, family_phone, shelter_name, shelter_phone),
    foreign key (family_name, family_phone) references families (last_name, phone_number),
    foreign key (shelter_name, shelter_phone) references shelter (name, phone_number),
    foreign key (animal_id) references animals (animal_id));

create table animal_delivery(
    license_number char(15) not null,
    shelter_name varchar(32) not null,
    shelter_phone char(10) not null, 
    animal_id char(9) not null,
    primary key (license_number, shelter_name, shelter_phone, animal_id),
    foreign key (license_number) references drivers (license_number),
    foreign key (animal_id) references animals(animal_id),
    foreign key (shelter_name, shelter_phone) references shelter (name, phone_number));

create table rescues(
    rescue_name varchar(32) not null,
    rescue_phone char(10) not null,
    branch_name varchar(32) not null,
    branch_phone char(10) not null,
    animal_id char(9) not null,
    cost decimal (6,2),
    primary key (rescue_name, rescue_phone, branch_name, branch_phone, animal_id),
    foreign key (rescue_name, rescue_phone) references rescueOrganization (name, phone_number),
    foreign key (branch_name, branch_phone) references spcaBranch (name, phone_number),
    foreign key (animal_id) references animals (animal_id));
    
create table shelters(
    rescue_name varchar(32) not null,
    rescue_phone char(10) not null,
    shelter_name varchar(32) not null,
    shelter_phone char(10) not null,
    animal_id char(9) not null,
    primary key (rescue_name, rescue_phone, shelter_name, shelter_phone),
    foreign key (rescue_name, rescue_phone) references rescueOrganization (name, phone_number),
    foreign key (shelter_name, shelter_phone) references shelter (name, phone_number),
    foreign key (animal_id) references animals (animal_id));
    
create table has(
    animal_id char(9) not null,
    dov date not null,
    primary key (animal_id, dov),
    foreign key (animal_id) references animals (animal_id),
    foreign key (dov, animal_id) references vetRecords (dov, animal_id));
    
create table receives(
    donator varchar(32) not null,
    receiver varchar(32) not null,
    donation_date date not null,
    primary key (donator, receiver, donation_date),
    foreign key (donator, receiver, donation_date) references donations (donator, receiver, donation_date),
    foreign key (receiver) references organization (name));
    
create table employs(
    phone_number char(10) not null,
    name varchar(32) not null,
    primary key (phone_number, name),
    foreign key (phone_number) references employees (phone_number),
    foreign key (name) references organization (name));
    
create table adopter(
    animal_id char(9) not null,
    family_name varchar(32) not null,
    family_phone char(10) not null,
    primary key (animal_id, family_name, family_phone),
    foreign key (animal_id) references animals (animal_id),
    foreign key (family_name, family_phone) references families (last_name, phone_number));
    
create table hold(
    animal_id char(9) not null,
    org_name varchar(32) not null,
    primary key (animal_id, org_name),
    foreign key (animal_id) references animals (animal_id),
    foreign key (org_name) references organization (name));
    
create table drives(
    animal_id char(9) not null,
    license_number varchar(15) not null,
    from_location varchar(32) not null,
    shelter_name varchar(32) not null,
    shelter_phone char(10) not null,
    primary key (animal_id, license_number, from_location, shelter_name),
    foreign key (animal_id) references animals (animal_id),
    foreign key (license_number) references drivers (license_number),
    foreign key (from_location) references organization (name),
    foreign key (shelter_name, shelter_phone) references shelter (name, phone_number));
    
create table associated(
    license_number char(15) not null,
    shelter_name varchar(32) not null,
    shelter_phone char(10) not null,
    primary key (license_number, shelter_name, shelter_phone),
    foreign key (license_number) references drivers (license_number),
    foreign key (shelter_name, shelter_phone) references shelter (name, phone_number));
 

 
/* POPULATE TABLES */


/* populate organizations */
insert into organization (name) values ('SPCA - Kingston');
insert into organization (name) values ('SPCA - Guelph');
insert into organization (name) values ('Kingston Shelter');
insert into organization (name) values ('Guelph Shelter');
insert into organization (name) values ('Kingston Animal Rescue');
insert into organization (name) values ('Guelph Animal Rescue');


/* populate spcaBranch */
insert into spcaBranch (name, address, phone_number)
    select name, '123 Princess St', '6131112222' 
    from organization where name = 'SPCA - Kingston'
    limit 1;
insert into spcaBranch (name, address, phone_number)
    select name, '511 Stone Rd', '5192221111' 
    from organization where name = 'SPCA - Guelph'
    limit 1;

/* populate rescueOrganization */
insert into rescueOrganization (name, address, phone_number)
    select name, '200 Ontario St', '6139876543'
    from organization where name = 'Kingston Animal Rescue'
    limit 1;
insert into rescueOrganization (name, address, phone_number)
    select name, '100 Brock Road', '5192223333'
    from organization where name = 'Guelph Animal Rescue'
    limit 1;

/* populate shelter */
insert into shelter (name, address, phone_number, website_url, max_cats, max_dog)
    select name, '100 Brock Road', '6131212121', 'www.KingstonShelter.ca', 25, 10
    from organization where name = 'Kingston Shelter'
    limit 1;
insert into shelter (name, address, phone_number, website_url, max_cats, max_dog, max_rabbits, max_rodent)
    select name, '100 Brock Road', '5198778778', 'www.GuelphShelter.ca', 10, 15, 5, 5
    from organization where name = 'Guelph Shelter'
    limit 1;

/* populate families */
insert into families (last_name, phone_number, address) 
    values ('Littlefield', '6134453322', '17 Stuart St');
insert into families (last_name, phone_number, address) 
    values ('Denny', '5196167878', '125 Kerwood Rd');


/* populate animals */
insert into animals (animal_id, species, arrival_loc, doa, location)
    select '987654321', 'rabbit', name, '2020-02-02', name
    from organization where name = 'SPCA - Guelph';
insert into animals (animal_id, species, arrival_loc, doa, location)
    select '321654987', 'dog', name, '2020-01-31', name
    from organization where name = 'SPCA - Guelph';
insert into animals (animal_id, species, arrival_loc, doa, location)
    select '159487623', 'cat', name, '2020-03-25', name
    from organization where name = 'SPCA - Guelph';
insert into animals (animal_id, species, arrival_loc, doa, location)
    select '357412896', 'rodent', name, '2020-03-08', name
    from organization where name = 'SPCA - Guelph';

insert into animals (animal_id, species, arrival_loc, doa, location)
    select '123456789', 'dog', name, '2020-01-02', name
    from organization where name = 'SPCA - Kingston';
insert into animals (animal_id, species, arrival_loc, doa, location)
    select '111111111', 'cat', name, '2020-03-02', name
    from organization where name = 'SPCA - Kingston';
insert into animals (animal_id, species, arrival_loc, doa, location)
    select '789456123', 'rodent', name, '2020-03-29', name
    from organization where name = 'SPCA - Kingston';
insert into animals (animal_id, species, arrival_loc, doa, location)
    select '963258741', 'rabbit', name, '2020-02-02', name
    from organization where name = 'SPCA - Kingston';
    

insert into animals (animal_id, species, arrival_loc, doa, dod, location)
    values (
    '333333333', 
    'rabbit', 
    (select name from organization where name = 'SPCA - Guelph'), 
    '2017-12-02', 
    '2018-02-04', 
    (select name from organization where name = 'Guelph Shelter'));
insert into animals (animal_id, species, arrival_loc, doa, dod, location)
    values (
    '852963741', 
    'dog', 
    (select name from organization where name = 'SPCA - Guelph'), 
    '2017-09-27', 
    '2018-01-15', 
    (select name from organization where name = 'Guelph Shelter'));
insert into animals (animal_id, species, arrival_loc, doa, dod, location)
    values (
    '741852963', 
    'cat', 
    (select name from organization where name = 'SPCA - Guelph'), 
    '2017-12-13', 
    '2018-02-13', 
    (select name from organization where name = 'Guelph Shelter'));
    
    
insert into animals (animal_id, species, arrival_loc, doa, dod, location)
    values (
    '012345678', 
    'rodent', 
    (select name from organization where name = 'SPCA - Kingston'), 
    '2018-04-23', 
    '2018-04-24', 
    (select name from organization where name = 'Kingston Shelter'));
insert into animals (animal_id, species, arrival_loc, doa, dod, location)
    values (
    '913785264', 
    'rabbit', 
    (select name from organization where name = 'SPCA - Kingston'), 
    '2018-06-24', 
    '2018-09-01', 
    (select name from organization where name = 'Kingston Shelter'));
insert into animals (animal_id, species, arrival_loc, doa, dod, location)
    values (
    '731598462', 
    'dog', 
    (select name from organization where name = 'SPCA - Kingston'), 
    '2018-10-31', 
    '2018-11-10', 
    (select name from organization where name = 'Kingston Shelter'));
    
    
insert into animals (animal_id, species, arrival_loc, doa, dod, location)
    values (
    '222222222', 
    'cat', 
    (select name from organization where name = 'SPCA - Kingston'), 
    '2018-01-02', 
    '2018-02-02', 
    (select name from organization where name = 'Kingston Shelter'));
insert into animals (animal_id, species, arrival_loc, doa, dod, location)
    values (
    '444444444', 
    'rodent', 
    (select name from organization where name = 'SPCA - Guelph'), 
    '2017-08-11', 
    '2018-01-12', 
    (select name from organization where name = 'Guelph Animal Rescue'));
insert into animals (animal_id, species, arrival_loc, doa, dod, location)
    values (
    '555555555', 
    'dog', 
    (select name from organization where name = 'SPCA - Kingston'), 
    '2017-08-11', 
    '2018-01-12', 
    (select name from organization where name = 'Kingston Shelter'));
    
    
/* populate drivers */
insert into drivers (name, phone_number, plate_number, license_number, organization)
    values (
    'Devan Zuriel',
    '6661644739',
    'N1Driver',
    '817924949729572',
    (select name from organization where name = 'Guelph Animal Rescue'));
insert into drivers (name, phone_number, plate_number, license_number, organization)
    values (
    'Sibylle Suhail',
    '8487252145',
    'N2Driver',
    '500679869154701',
    (select name from organization where name = 'Guelph Animal Rescue'));
insert into drivers (name, phone_number, plate_number, license_number, organization)
    values (
    'Gunda Svein',
    '7214527137',
    'N3Driver',
    '402143465091112',
    (select name from organization where name = 'Guelph Animal Rescue'));
insert into drivers (name, phone_number, plate_number, license_number, organization)
    values (
    'Konstantyn Graciano',
    '4729465132',
    'N4Driver',
    '236856141139424',
    (select name from organization where name = 'Guelph Animal Rescue'));
insert into drivers (name, phone_number, plate_number, license_number, organization)
    values (
    'Philokrates Irena',
    '3257818748',
    'N5Driver',
    '986865749751415',
    (select name from organization where name = 'Guelph Animal Rescue'));
    
insert into drivers (name, phone_number, plate_number, license_number, organization)
    values (
    'Kiran Timo',
    '0387843985',
    'N6Driver',
    '597388788265741',
    (select name from organization where name = 'Kingston Animal Rescue'));
insert into drivers (name, phone_number, plate_number, license_number, organization)
    values (
    'Ali Asklepiades',
    '8061087770',
    'N7Driver',
    '226144973412335',
    (select name from organization where name = 'Kingston Animal Rescue'));
insert into drivers (name, phone_number, plate_number, license_number, organization)
    values (
    'Urban Radomil',
    '0319344032',
    'N8Driver',
    '647917855133293',
    (select name from organization where name = 'Kingston Animal Rescue'));
insert into drivers (name, phone_number, plate_number, license_number, organization)
    values (
    'Raghnall Izem',
    '8061087770',
    'N9Driver',
    '066503744435231',
    (select name from organization where name = 'Kingston Animal Rescue'));
insert into drivers (name, phone_number, plate_number, license_number, organization)
    values (
    'Sanja Nikolao',
    '0387843985',
    'N0Driver',
    '688425993954143',
    (select name from organization where name = 'Kingston Animal Rescue'));
    

/* populate employees */
insert into employees (name, phone_number, address, employee_rank, employer)
    values (
    'Jane Doe',
    '5196510002',
    '15 Indian Trail',
    'Groomer',
    (select name from organization where name = 'Guelph Animal Rescue'));
insert into employees (name, phone_number, address, employee_rank, employer)
    values (
    'John Doe',
    '5196510003',
    '15 Indian Trail',
    'Owner',
    (select name from organization where name = 'Guelph Animal Rescue'));
insert into employees (name, phone_number, address, employee_rank, employer)
    values (
    'John McDonald',
    '6132220001',
    '185 Ontario St',
    'Owner',
    (select name from organization where name = 'Kingston Shelter'));
    
    
/* populate donations */
insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Littlefields',
    (select name from organization where name = 'Guelph Animal Rescue'),
    '2018-09-27',
    1234.56);
insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Littles',
    (select name from organization where name = 'Guelph Animal Rescue'),
    '2018-12-25',
    56.12);
insert into donations (donator, receiver, donation_date, amount)
    values (
    'Dennys',
    (select name from organization where name = 'Guelph Animal Rescue'),
    '2018-06-08',
    100.00);

insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Dennys',
    (select name from organization where name = 'Guelph Shelter'),
    '2018-10-31',
    7890.12);
insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Johnstons',
    (select name from organization where name = 'Guelph Shelter'),
    '2018-04-05',
    5.00);
insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Quaids',
    (select name from organization where name = 'Guelph Shelter'),
    '2018-04-20',
    1000.00);
    
insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Wilsons',
    (select name from organization where name = 'Kingston Animal Rescue'),
    '2018-01-15',
    7852.25);
insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Smiths',
    (select name from organization where name = 'Kingston Animal Rescue'),
    '2018-04-04',
    7530.25);
insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Browns',
    (select name from organization where name = 'Kingston Animal Rescue'),
    '2018-08-21',
    5412.98);
    
insert into donations (donator, receiver, donation_date, amount)
    values (
    'Teh Wrights',
    (select name from organization where name = 'Kingston Shelter'),
    '2018-10-04',
    100.00);
insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Allens',
    (select name from organization where name = 'Kingston Shelter'),
    '2018-09-30',
    4512.84);
insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Woods',
    (select name from organization where name = 'Kingston Shelter'),
    '2018-07-02',
    5000.25);

insert into donations (donator, receiver, donation_date, amount)
    values (
    'Queens University',
    (select name from organization where name = 'SPCA - Guelph'),
    '2018-08-06',
    9180.65);
insert into donations (donator, receiver, donation_date, amount)
    values (
    'Ottawa University',
    (select name from organization where name = 'SPCA - Guelph'),
    '2018-11-04',
    7954.21);
insert into donations (donator, receiver, donation_date, amount)
    values (
    'University of Waterloo',
    (select name from organization where name = 'SPCA - Guelph'),
    '2018-12-12',
    1102.78);
    
insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Coronas',
    (select name from organization where name = 'SPCA - Kingston'),
    '2018-12-15',
    3185.96);
insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Johnsons',
    (select name from organization where name = 'SPCA - Kingston'),
    '2018-01-25',
    1043.44);
insert into donations (donator, receiver, donation_date, amount)
    values (
    'The Lopezs',
    (select name from organization where name = 'SPCA - Kingston'),
    '2018-08-28',
    2964.78);


/* populate vet records */
insert into vetRecords(vet_name, animal_id, animal_condition, animal_weight, dov)
    values (
    'Dr. Chia',
    (select animal_id from animals where animal_id = '111111111'),
    'severe obesity',
    156.5,
    '2020-02-02');
insert into vetRecords(vet_name, animal_id, animal_condition, animal_weight, dov)
    values (
    'Dr. Donald',
    (select animal_id from animals where animal_id = '333333333'),
    'seizure',
    2.1,
    '2020-01-01');
    
    
/* POPULATE RELATIONSHIPS */


/* populate spca_adopt */
insert into spca_adopt(family_name, family_phone, branch_name, branch_phone, animal_id, cost)
    values (
    (select last_name from families where last_name = 'Denny' and phone_number = '5196167878'),
    (select phone_number from families where last_name = 'Denny' and phone_number = '5196167878'),
    (select name from spcaBranch where name = 'SPCA - Kingston' and phone_number = '6131112222'),
    (select phone_number from spcaBranch where name = 'SPCA - Kingston' and phone_number = '6131112222'),
    (select animal_id from animals where animal_id = '111111111' and location = 'SPCA - Kingston'),
    25.00);

/* populate shelter_adopt */
insert into shelter_adopt(family_name, family_phone, shelter_name, shelter_phone, animal_id)
    values (
    (select last_name from families where last_name = 'Littlefield' and phone_number = '6134453322'),
    (select phone_number from families where last_name = 'Littlefield' and phone_number = '6134453322'),
    (select name from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'),
    (select phone_number from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'),
    (select animal_id from animals where animal_id = '555555555' AND location = 'Kingston Shelter'));
    
/* populate animal_delivery */
insert into animal_delivery(license_number, shelter_name, shelter_phone, animal_id)
    values (
    (select license_number from drivers where license_number = '817924949729572'),
    (select name from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'),
    (select phone_number from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'),
    (select animal_id from animals where animal_id = '333333333' and location = 'Guelph Shelter'));
insert into animal_delivery(license_number, shelter_name, shelter_phone, animal_id)
    values (
    (select license_number from drivers where license_number = '500679869154701'),
    (select name from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'),
    (select phone_number from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'),
    (select animal_id from animals where animal_id = '852963741' and location = 'Guelph Shelter'));
insert into animal_delivery(license_number, shelter_name, shelter_phone, animal_id)
    values (
    (select license_number from drivers where license_number = '402143465091112'),
    (select name from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'),
    (select phone_number from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'),
    (select animal_id from animals where animal_id = '741852963' and location = 'Guelph Shelter'));

insert into animal_delivery(license_number, shelter_name, shelter_phone, animal_id)
    values (
    (select license_number from drivers where license_number = '066503744435231'),
    (select name from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'),
    (select phone_number from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'),
    (select animal_id from animals where animal_id = '012345678' and location = 'Kingston Shelter'));
insert into animal_delivery(license_number, shelter_name, shelter_phone, animal_id)
    values (
    (select license_number from drivers where license_number = '066503744435231'),
    (select name from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'),
    (select phone_number from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'),
    (select animal_id from animals where animal_id = '913785264' and location = 'Kingston Shelter'));
insert into animal_delivery(license_number, shelter_name, shelter_phone, animal_id)
    values (
    (select license_number from drivers where license_number = '066503744435231'),
    (select name from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'),
    (select phone_number from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'),
    (select animal_id from animals where animal_id = '731598462' and location = 'Kingston Shelter'));

/* populate rescues */
insert into rescues(rescue_name, rescue_phone, branch_name, branch_phone, animal_id, cost)
    values (
    (select name from rescueOrganization where name = 'Guelph Animal Rescue'),
    (select phone_number from rescueOrganization where name = 'Guelph Animal Rescue'),
    (select name from spcaBranch where name = 'SPCA - Guelph'),
    (select phone_number from spcaBranch where name = 'SPCA - Guelph'),
    (select animal_id from animals where animal_id = '333333333' and location = 'Guelph Shelter'),
    32.50);
insert into rescues(rescue_name, rescue_phone, branch_name, branch_phone, animal_id, cost)
    values (
    (select name from rescueOrganization where name = 'Guelph Animal Rescue'),
    (select phone_number from rescueOrganization where name = 'Guelph Animal Rescue'),
    (select name from spcaBranch where name = 'SPCA - Guelph'),
    (select phone_number from spcaBranch where name = 'SPCA - Guelph'),
    (select animal_id from animals where animal_id = '852963741' and location = 'Guelph Shelter'),
    84.50);
insert into rescues(rescue_name, rescue_phone, branch_name, branch_phone, animal_id, cost)
    values (
    (select name from rescueOrganization where name = 'Guelph Animal Rescue'),
    (select phone_number from rescueOrganization where name = 'Guelph Animal Rescue'),
    (select name from spcaBranch where name = 'SPCA - Guelph'),
    (select phone_number from spcaBranch where name = 'SPCA - Guelph'),
    (select animal_id from animals where animal_id = '741852963' and location = 'Guelph Shelter'),
    50.50);
    
insert into rescues(rescue_name, rescue_phone, branch_name, branch_phone, animal_id, cost)
    values (
    (select name from rescueOrganization where name = 'Kingston Animal Rescue'),
    (select phone_number from rescueOrganization where name = 'Kingston Animal Rescue'),
    (select name from spcaBranch where name = 'SPCA - Kingston'),
    (select phone_number from spcaBranch where name = 'SPCA - Kingston'),
    (select animal_id from animals where animal_id = '012345678' and location = 'Kingston Shelter'),
    50.50);
insert into rescues(rescue_name, rescue_phone, branch_name, branch_phone, animal_id, cost)
    values (
    (select name from rescueOrganization where name = 'Kingston Animal Rescue'),
    (select phone_number from rescueOrganization where name = 'Kingston Animal Rescue'),
    (select name from spcaBranch where name = 'SPCA - Kingston'),
    (select phone_number from spcaBranch where name = 'SPCA - Kingston'),
    (select animal_id from animals where animal_id = '913785264' and location = 'Kingston Shelter'),
    60.00);
insert into rescues(rescue_name, rescue_phone, branch_name, branch_phone, animal_id, cost)
    values (
    (select name from rescueOrganization where name = 'Kingston Animal Rescue'),
    (select phone_number from rescueOrganization where name = 'Kingston Animal Rescue'),
    (select name from spcaBranch where name = 'SPCA - Kingston'),
    (select phone_number from spcaBranch where name = 'SPCA - Kingston'),
    (select animal_id from animals where animal_id = '731598462' and location = 'Kingston Shelter'),
    20.00);
 
 /* populate shelters */
 insert into shelters(rescue_name, rescue_phone, shelter_name, shelter_phone, animal_id)
    values (
    (select name from rescueOrganization where name = 'Kingston Animal Rescue'),
    (select phone_number from rescueOrganization where name = 'Kingston Animal Rescue'),
    (select name from shelter where name = 'Kingston Shelter'),
    (select phone_number from shelter where name = 'Kingston Shelter'),
    (select animal_id from animals where animal_id = '222222222'));
    
/* populate has */
insert into has(animal_id, dov)
    values (
    (select animal_id from animals where animal_id = '111111111'),
    (select dov from vetRecords where dov = '2020-02-02'));

/* populate receives */ 
insert into receives(donator, receiver, donation_date)
    values (
    (select donator from donations where donator = 'The Johnsons' and receiver = 'SPCA - Kingston'),
    (select name from organization where name = 'SPCA - Kingston'),
    (select donation_date from donations where donator = 'The Johnsons' and receiver = 'SPCA - Kingston'));
   
/* populate employs */
insert into employs(phone_number, name)
    values (
    (select phone_number from employees where phone_number = '5196510002'),
    (select name from organization where name = 'Guelph Animal Rescue'));
    
/* populate adopter */
insert into adopter(animal_id, family_name, family_phone)
    values (
    (select animal_id from animals where animal_id = '111111111'),
    (select last_name from families where last_name = 'Denny' and phone_number = '5196167878'),
    (select phone_number from families where last_name = 'Denny' and phone_number = '5196167878'));
    
/* populate hold */
insert into hold(animal_id, org_name)
    values (
    (select animal_id from animals where animal_id = '444444444'),
    (select name from rescueOrganization where name = "Guelph Animal Rescue" and phone_number = '5192223333'));
    
/* populate drives */
insert into drives(animal_id, license_number, from_location, shelter_name, shelter_phone)
    values (
    (select animal_id from animals where animal_id = '333333333' and location = 'Guelph Shelter'),
    (select license_number from drivers where license_number = '817924949729572'),
    (select name from spcaBranch where name = 'SPCA - Guelph'),
    (select name from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'),
    (select phone_number from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'));
insert into drives(animal_id, license_number, from_location, shelter_name, shelter_phone)
    values (
    (select animal_id from animals where animal_id = '852963741' and location = 'Guelph Shelter'),
    (select license_number from drivers where license_number = '500679869154701'),
    (select name from spcaBranch where name = 'SPCA - Guelph'),
    (select name from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'),
    (select phone_number from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'));
insert into drives(animal_id, license_number, from_location, shelter_name, shelter_phone)
    values (
    (select animal_id from animals where animal_id = '741852963' and location = 'Guelph Shelter'),
    (select license_number from drivers where license_number = '402143465091112'),
    (select name from spcaBranch where name = 'SPCA - Guelph'),
    (select name from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'),
    (select phone_number from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'));

insert into drives(animal_id, license_number, from_location, shelter_name, shelter_phone)
    values (
    (select animal_id from animals where animal_id = '012345678' and location = 'Kingston Shelter'),
    (select license_number from drivers where license_number = '066503744435231'),
    (select name from spcaBranch where name = 'SPCA - Kingston'),
    (select name from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'),
    (select phone_number from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'));
insert into drives(animal_id, license_number, from_location, shelter_name, shelter_phone)
    values (
    (select animal_id from animals where animal_id = '913785264' and location = 'Kingston Shelter'),
    (select license_number from drivers where license_number = '226144973412335'),
    (select name from spcaBranch where name = 'SPCA - Kingston'),
    (select name from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'),
    (select phone_number from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'));
insert into drives(animal_id, license_number, from_location, shelter_name, shelter_phone)
    values (
    (select animal_id from animals where animal_id = '731598462' and location = 'Kingston Shelter'),
    (select license_number from drivers where license_number = '597388788265741'),
    (select name from spcaBranch where name = 'SPCA - Kingston'),
    (select name from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'),
    (select phone_number from shelter where name = 'Kingston Shelter' and phone_number = '6131212121'));

/* populate associated */
insert into associated(license_number, shelter_name, shelter_phone)
    values (
    (select license_number from drivers where license_number = '817924949729572'),
    (select name from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'),
    (select phone_number from shelter where name = 'Guelph Shelter' and phone_number = '5198778778'));