extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var hp = 100
var mp = 50
var physAtk = 1.25
var magAtk = 1
var physDef = 1
var soundDef = 1
var skillScr = load("characterskill.gd")
var charSkills = skillScr.new()
var style = "Combo"
func _ready():
	charSkills.setNeutral(0)
	charSkills.setUp(1)
	charSkills.setDown(2)
	charSkills.setLeft(3)
	charSkills.setRight(4)
	
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func getHP():
	return hp
	
func getMP():
	return mp
	
func getSkills():
	return charSkills

func getPhysAtk():
	return physAtk

func getMagAtk():
	return magAtk
	
func getPhysDef():
	return physDef

func getSoundDef():
	return soundDef
	
	
func setHP(HP):
	hp = HP
	
func getStyle():
	return style