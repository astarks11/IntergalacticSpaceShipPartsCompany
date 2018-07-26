-- Customer (CustNum, Name, ContractNum):
insert into emanuelb.Customer values(1, 'Bob');
insert into emanuelb.Customer values(2, 'Tim');
insert into emanuelb.Customer values(3, 'Olivia');
insert into emanuelb.Customer values(4, 'Paul');
insert into  emanuelb.Customer values(5, 'Jose');
insert into emanuelb.Customer values(6, 'Jake');

-- Ship (ShipNum, ShipName, MarkUp)
insert into emanuelb.Ship values(1, 'Little Stinker', 2.1);
insert into emanuelb.Ship values(2, 'Voyager', 3.2);
insert into emanuelb.Ship values(3, 'Wobblin'' Goblin', 4.6);

-- Department (DeptName, ShipNum)
insert into emanuelb.Department values('Antitrust', 3);
insert into emanuelb.Department values('Transport', 1);
insert into emanuelb.Department values('Treasury', 2);
insert into emanuelb.Department values('Commerce', 3);
insert into emanuelb.Department values('Education', 1);

-- Part (PartNum, PartName, PartCost, IsLux)
-- Three essential parts for all ships
insert into emanuelb.Part values(0, 'Hull', 3949, 0);
insert into emanuelb.Part values(1, 'Chair', 4205, 0);
insert into emanuelb.Part values(2, 'Steering Wheel', 3384, 0);
-- Luxury parts for Little Stinker
insert into emanuelb.Part values(3, 'Windshield Wiper', 4702, 1);
insert into emanuelb.Part values(4, 'Tiki Doll', 3927, 1);
insert into emanuelb.Part values(5, 'Air Freshener', 4471, 1);
-- Luxury parts for Voyager
insert into emanuelb.Part values(6, 'Alarm System', 3128, 1);
insert into emanuelb.Part values(7, 'Steering Wheel Cover', 3650, 1);
insert into emanuelb.Part values(8, 'Flame Decal', 4481, 1);
insert into emanuelb.Part values(9, 'Butler', 3689, 1);
-- Luxury parts for Woblin' Goblin
insert into emanuelb.Part values(10, 'Spoiler', 2378, 1);
insert into emanuelb.Part values(11, 'Satellite Radio', 1254, 1);
insert into emanuelb.Part values(12, 'Personal Chef', 9351, 1);
insert into emanuelb.Part values(13, 'Leather Air Vents', 2319, 1);
insert into emanuelb.Part values(14, 'Sun Roof', 6712, 1);

-- ShipPart (ShipNum, PartNum)
-- Little Stinker essential parts
insert into emanuelb.ShipPart values(1, 0);
insert into emanuelb.ShipPart values(1, 1);
insert into emanuelb.ShipPart values(1, 2);
-- Little Stinker luxury parts
insert into emanuelb.ShipPart values(1, 3);
insert into emanuelb.ShipPart values(1, 4);
insert into emanuelb.ShipPart values(1, 5);
-- Voyager essential parts
insert into emanuelb.ShipPart values(2, 0);
insert into emanuelb.ShipPart values(2, 1);
insert into emanuelb.ShipPart values(2, 2);
-- Voyager luxury parts
insert into emanuelb.ShipPart values(2, 6);
insert into emanuelb.ShipPart values(2, 7);
insert into emanuelb.ShipPart values(2, 8);
insert into emanuelb.ShipPart values(2, 9);
-- Wobblin' Goblin essential parts
insert into emanuelb.ShipPart values(3, 0);
insert into emanuelb.ShipPart values(3, 1);
insert into emanuelb.ShipPart values(3, 2);
-- Wobblin' Goblin luxury parts
insert into emanuelb.ShipPart values(3, 10);
insert into emanuelb.ShipPart values(3, 11);
insert into emanuelb.ShipPart values(3, 12);
insert into emanuelb.ShipPart values(3, 13);
insert into emanuelb.ShipPart values(3, 14);

-- Contract(ContractNum, CustName, ShipNum, Cost)
-- Olivia's contracts
insert into emanuelb.Contract values(3, 3, 'Antitrust', 3, 7589);
-- Paul's contracts
insert into emanuelb.Contract values(6, 4, 'Treasury', 2, 11538);
insert into emanuelb.Contract values(4, 4, 'Transport', 1, 11538);
insert into emanuelb.Contract values(5, 4, 'Antitrust', 3, 0);
-- Jose's contracts
insert into emanuelb.Contract values(13, 5, 'Antitrust', 3, 11538);
insert into emanuelb.Contract values(14, 5, 'Commerce', 3, 11538);
insert into emanuelb.Contract values(12, 5, 'Transport', 1, 11538);
insert into emanuelb.Contract values(11, 5, 'Antitrust', 3, 11538);
-- Jake's contracts
insert into emanuelb.Contract values(9, 6, 'Education', 1, 8154);
insert into emanuelb.Contract values(7, 6, 'Treasury', 2, 11538);

-- MissingPart (ContractNum, PartNum)
-- Olivia's Wobblin' Goblin
insert into MissingPart values(3, 0);

-- Paul's Voyager
-- Alarm system
insert into MissingPart values(6, 6);
-- Flame decal
insert into MissingPart values(6, 8);

-- Paul's Little Stinker
-- Air freshener
insert into MissingPart values(4, 5);

-- Paul's Woblin' Goblin
insert into MissingPart values(5, 0);
insert into MissingPart values(5, 1);
insert into MissingPart values(5, 2);
-- Spoiler
insert into MissingPart values(5, 10);
-- Radio
insert into MissingPart values(5, 11);
-- Chef
insert into MissingPart values(5, 12);
-- Leather air vent
insert into MissingPart values(5, 13);

-- Jose's Wobblin' Goblin
-- Chef
insert into MissingPart values(13, 12);

-- Jose's Wobblin' Goblin
-- Spoiler
insert into MissingPart values(14, 10);
-- Sun roof
insert into MissingPart values(14, 14);

-- Jose's Little Stinker
-- Tiki doll
insert into MissingPart values(12, 4);

-- Jose's Wobblin' Goblin
-- Spoiler
insert into MissingPart values(11, 10);
-- Radio
insert into MissingPart values(11, 11);
-- Chef
insert into MissingPart values(11, 12);
-- Leather air vent
insert into MissingPart values(11, 13);
-- Sun roof
insert into MissingPart values(11, 14);

-- Jake's Little Stinker
insert into MissingPart values(9, 2);
insert into MissingPart values(9, 4);

-- Jake's Voyager
-- Steering wheel cover
insert into MissingPart values(7, 7);
