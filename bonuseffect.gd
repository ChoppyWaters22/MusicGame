extends Node


var id = -1
var damage = -1
var heal = -1
var critChance = -1
var element = ""
var status = ""
var target = ""
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func setID(ID):
	id = ID

func setDamage(DAMAGE):
	damage = DAMAGE

func setHeal(HEAL):
	heal = HEAL

func setCritChance(CRIT):
	critChance = CRIT
	
func setStatus(STATUS):
	status = STATUS

func setElement(ELEMENT):
	element = ELEMENT

func setTarget(TARGET):
	target = TARGET

func setBonusEffect(ID,DAMAGE,HEAL,CRIT,ELEMENT,STATUS,TARGET):
	id = ID
	damage= DAMAGE
	heal = HEAL
	critChance = CRIT
	element = ELEMENT
	status = STATUS
	target = TARGET

func getID():
	return id

func getDamage():
	return damage

func getHeal():
	return heal

func getCritChance():
	return critChance
	
func getStatus():
	return status

func getTarget():
	return target

func getElement():
	return element


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
