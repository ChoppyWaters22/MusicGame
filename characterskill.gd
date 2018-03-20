extends Node

var skills = load("skill.gd")
var neutralSkill
var upSkill
var downSkill
var leftSkill
var rightSkill

var neutralCooldown = 0
var upCooldown = 0
var downCooldown = 0
var leftCooldown = 0
var rightCooldown = 0

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func setNeutral(newSkill):
	neutralSkill = newSkill

func setUp(newSkill):
	upSkill = newSkill

func setDown(newSkill):
	downSkill = newSkill

func setLeft(newSkill):
	leftSkill = newSkill

func setRight(newSkill):
	rightSkill = newSkill

func setNeutralCooldown(cd):
	neutralCooldown = cd

func setUpCooldown(cd):
	upCooldown = cd

func setDownCooldown(cd):
	downCooldown = cd

func setLeftCooldown(cd):
	leftCooldown = cd

func setRightCooldown(cd):
	rightCooldown = cd

func getNeutral():
	return neutralSkill

func getUp():
	return upSkill

func getDown():
	return downSkill

func getLeft():
	return leftSkill

func getRight():
	return rightSkill

func getNeutralCooldown():
	return neutralCooldown

func getUpCooldown():
	return upCooldown

func getDownCooldown():
	return downCooldown

func getLeftCooldown():
	return leftCooldown

func getRightCooldown():
	return rightCooldown


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
