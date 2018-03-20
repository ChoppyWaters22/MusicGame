extends Node
var skillList = []
var bonusList = []
var file
var skil = load("skill.gd")
var bonus = load("bonuseffect.gd")


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	generateBonusEffectList()
	generateSkillList()
	pass

func getSkillListText():
	file = File.new()
	file.open("skilllist.txt", file.READ)

func getBonusEffectText():
	file = File.new()
	file.open("bonusskilleffects.txt", file.READ)


func generateBonusEffectList():
	getBonusEffectText()
	var i = 0
	var loop = true
	var stringToParse
	var bonusParameters
	
	

	 
	while (loop == true):
		stringToParse = file.get_line()
		if (stringToParse != "END"):
			bonusParameters = stringToParse.split(",")
			
			var newBonus = bonus.new()
			
			newBonus.setBonusEffect(bonusParameters[0], float(bonusParameters[1]), bonusParameters[2], bonusParameters[3], bonusParameters[4], bonusParameters[5],bonusParameters[6])
			bonusList.append(newBonus)
			
		else:
			loop = false

func generateSkillList():
	getSkillListText()
	var i = 0
	var loop = true
	var stringToParse
	var skillParameters
	
	

	 
	while (loop == true):
		stringToParse = file.get_line()
		if (stringToParse != "END"):
			skillParameters = stringToParse.split(",")
			
			var newSkill = skil.new()
			
			newSkill.setSkill(skillParameters[0], skillParameters[1], float(skillParameters[2]), skillParameters[3], skillParameters[4], skillParameters[5], skillParameters[6], skillParameters[7], skillParameters[8])
			newSkill.setBonusViaBonus(bonusList[int(newSkill.getID())])
			print(newSkill.getBonusEffect().getElement())
			skillList.append(newSkill)
			
		else:
			loop = false

func getSkillList():
	return skillList
	
func getSkill(skillnumber):
	return skillList[skillnumber]