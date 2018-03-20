extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var numOfSkills
var enemyAttack
var skillScr = load("skill.gd")
var skill = skillScr.new()

func randAttack(enemySkills):
	numOfSkills = enemySkills.size() - 1
	randomize()
	enemySkills[randi()%numOfSkills].tString()
	skill = enemySkills[randi()%numOfSkills]
	return skill

func bestAttack(enemySkills):
	
	pass

func targetHate(enemySkills):
	pass

func targetMember(enemySkills):
	pass


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
