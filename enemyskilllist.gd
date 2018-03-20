extends Node
var enemySkillList = []
var file
var skil = load("skill.gd")


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	generateEnemySkillList()
	pass

func getEnemySkillListText():
	file = File.new()
	file.open("enemyskilllist.txt", file.READ)


func generateEnemySkillList():
	getEnemySkillListText()
	var i = 0
	var loop = true
	var stringToParse
	var skillParameters
	 
	while (loop == true):
		stringToParse = file.get_line()
		if (stringToParse != "END"):
			skillParameters = stringToParse.split(",")
			
			var newSkill = skil.new()
			
			newSkill.setSkill(skillParameters[0], skillParameters[1], skillParameters[2], skillParameters[3], skillParameters[4], skillParameters[5], skillParameters[6], skillParameters[7], skillParameters[8])
			
			enemySkillList.append(newSkill)
		else:
			loop = false

func getEnemySkillList():
	return enemySkillList
	
func getEnemySkill(enemySkillNumber):
	return enemySkillList[enemySkillNumber]