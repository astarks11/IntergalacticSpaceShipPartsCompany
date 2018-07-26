import random

if __name__ == "__main__":
	# Generate data for the customer
	customerNumbers = [i for i in range(10)]
	customerNames = ["John", "Bob", "Tim", "Joan", "Paul", "Jose", "Jake", "Al", "Mary", "Shelly"]
	contractNumbers = [12 + i for i in customerNumbers]
	customerTuples = [(custNum, customerNames[custNum], contractNumbers[custNum]) for custNum in customerNumbers]
	print("CUSTOMER")
	for row in customerTuples:
		print(row)

	# Generate data for part
	partNumbers = [i for i in range(10)]
	partNames = ["Hull", "Chair", "Steering Wheel", "Windshield Wiper", "Tiki Doll", "Air Freshener", "Alarm System", "Steering Wheel Cover", "Flame Decal", "Butler"]
	partCosts = [3000 + random.randint(0,2000) for num in partNumbers]
	partTuples = [(partNum, partNames[partNum], partCosts[partNum], partNum < 3) for partNum in partNumbers]
	print("PART")
	for row in partTuples:
		print(row)

	# Generate data for ship
	shipNumbers = [i for i in range(3)]
	shipName = ["Little Stinker", "Voyager", "Wobblin' Goblin"]
	shipMarkUp = [random.randint(1, 8) + random.randint(1, 9) / 10.0 for i in range(5)]
	shipTuples = [(shipNum, shipName[shipNum], shipMarkUp[shipNum]) for shipNum in shipNumbers]
	print("SHIP")
	for row in shipTuples:
		print(row)

	# Generate data for department
	deptNames = ["Antitrust", "Transport", "Treasury", "Homeland Security", "Education"]
	ships = [x for x in shipNumbers]
	deptTuples = [(deptNames[ship], ship) for ship in ships]
	print("DEPARTMENT")
	for row in deptTuples:
		print(row)

	# Generate data for contract
	print("CONTRACT")

	# Generate data for necessary parts
	print("NECESSARY_PART")

	# Generate data for missing parts
	print("MISSING_PART")
