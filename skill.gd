extends Node

var id = -1
var name = ""
var damage = -1
var heal = -1
var critChance = -1
var cooldown = -1
var currentCooldown = 0
var type = "Physical"
var element = ""
var status = ""
var target = ""
var onCooldownFor = 0
var bonusScr = load("bonuseffect.gd")
var bonusEffect = bonusScr.new()
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func setID(ID):
	id = ID

func setName(nam):
	name = name

func setDamage(dmg):
	damage = dmg

func setHeal(hel):
	heal = hel

func setCritChance(crit):
	critChance = crit

func setCooldown(cdwn):
	cooldown = cdwn

func setElement(ele):
	element = ele

func setStatus(sta):
	status = sta

func setTarget(tar):
	target = tar

func setType(TYPE):
	type = TYPE

func setBonusViaBonus(BONUS):
	bonusEffect.setID(BONUS.getID())
	bonusEffect.setDamage(BONUS.getDamage())
	bonusEffect.setHeal(BONUS.getHeal())
	bonusEffect.setCritChance(BONUS.getCritChance())
	bonusEffect.setElement(BONUS.getElement())
	bonusEffect.setStatus(BONUS.getStatus())
	bonusEffect.setTarget(BONUS.getTarget())
	
	

func getID():
	return id

func getName():
	return name

func getDamage():
	return damage
	
func getHeal():
	return heal

func getCritChance():
	return critChance

func getCooldown():
	return cooldown

func getElement():
	return element

func getStatus():
	return status

func getTarget():
	return target

func getType():
	return type

func getBonusEffect():
	return bonusEffect

func setSkill(ID,NAME,DAMAGE,HEAL,CRIT,COOLDOWN,ELEMENT,STATUS,TARGET):
	id = ID
	name = NAME
	damage = DAMAGE
	heal = HEAL
	critChance = CRIT
	cooldown = COOLDOWN
	element = ELEMENT
	status = STATUS
	target = TARGET

func setOnCooldownFor(OnCD):
	onCooldownFor = OnCD

func getOnCooldownFor():
	return onCooldownFor

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func tString():
	var returnString = "ID: " + str(id) + "  Name: " + str(name) + "   Damage: " + str(damage) + "  Heal: " + str(heal) + "   Critical Chance: " + str(critChance) + "  Cooldown: " + str(cooldown) + "   Element: " + str(element) + "  Status: " + str(status) + "   Target: " + str(target)
	return returnString