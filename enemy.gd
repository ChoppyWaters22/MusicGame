extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var id
var name
var hp
var mp
var image
var speed
var enemySkills = []
var physAtk
var magAtk
var magDef = .5
var physDef
var soundDef
var aiScr = load("enemyai.gd")
var skillScr = load("skill.gd")
var skill = skillScr.new()
var ai = aiScr.new()

func setHP(HP):
	hp = HP

func setMP(MP):
	mp = MP

func setSpeed(SPD):
	speed = SPD

func setEnemySkills(skills):
	var i = 0
	while(i <= skills.size()-1):
		enemySkills.append(skills[i])
		i = i + 1

func setImage(IMAGE):
	image = IMAGE

func setEnemy(ID,NAME,HP,MP,SPEED,IMAGE,PHYSATK,MAGATK,PHYSDEF,SOUNDDEF):
	id = ID
	name = NAME
	hp = HP
	mp = MP
	image = IMAGE
	speed = SPEED
	physAtk = PHYSATK
	magAtk = MAGATK
	physDef = PHYSDEF
	soundDef = SOUNDDEF



func setEnemyViaEnemy(enemyP):
	id = enemyP.getID()
	name = enemyP.getName()
	hp = enemyP.getHP()
	mp = enemyP.getMP()
	speed = enemyP.getSpeed()
	image = enemyP.getImage()
	setEnemySkills(enemyP.getEnemySkills())
	physAtk = enemyP.getPhysAtk()
	magAtk = enemyP.getMagAtk()
	physDef = enemyP.getPhysDef()
	soundDef = enemyP.getSoundDef()

func setPhysAtk(PHYSATK):
	physAtk = PHYSATK

func setMagAtk(MAGATK):
	magAtk = MAGATK

func setPhysDef(PHYSDEF):
	physDef = PHYSDEF

func setSoundDef(SOUNDDEF):
	soundDef = SOUNDDEF

func getID():
	return id

func getName():
	return name

func getMP():
	return mp

func getHP():
	return hp


func getSpeed():
	return speed

func getImage():
	return image

func getEnemySkills():
	return enemySkills

func getPhysAtk():
	return physAtk

func getMagAtk():
	return magAtk

func getPhysDef():
	return physDef

func getSoundDef():
	return soundDef

func randomAttack():
	var numOfSkills = enemySkills.size()
	randomize()
	var randomSkillNumber = int(enemySkills[int(rand_range(0,numOfSkills))])
	return randomSkillNumber

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
