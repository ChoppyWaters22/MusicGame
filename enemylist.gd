extends Node
var enemyList = []
var file
var enemy = load("enemy.gd")


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	generateEnemyList()
	pass

func getEnemyListText():
	file = File.new()
	file.open("enemylist.txt", file.READ)


func generateEnemyList():
	getEnemyListText()
	var i = 0
	var loop = true
	var stringToParse
	var skillsToParse
	var enemyParameters
	var skillList
	

	 
	while (loop == true):
		stringToParse = file.get_line()
		if (stringToParse != "END"):
			enemyParameters = stringToParse.split(",")
			
			var newEnemy = enemy.new()
			newEnemy.setEnemy(enemyParameters[0],enemyParameters[1],float(enemyParameters[2]),enemyParameters[3],enemyParameters[4],enemyParameters[5],enemyParameters[6],enemyParameters[7],enemyParameters[8],enemyParameters[9])
			skillsToParse = file.get_line()
			skillList = skillsToParse.split(",")
			newEnemy.setEnemySkills(skillList)
			enemyList.append(newEnemy)
			
		else:
			loop = false

func getEnemyList():
	return enemyList
	
func getEnemy(enemynumber):
	return enemyList[enemynumber]