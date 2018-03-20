extends Node

var song
var file
var timer = -1
var sysStartTime = OS.get_time()
var sysCurrentTime = OS.get_time()
var inStartTime
var inCurrentTime
var sysSec = -1
var tex = preload("res://sprites/beat.png")
var scr = preload("res://beat.gd")
var currentBeatNumber
var currentBeat
var newInput
var songOffSet = 800
var battle = true
var enemies = []
var enemyScr = load("enemy.gd")
var enemy = enemyScr.new()
var skillScr = load("skill.gd")
var currentSkill = skillScr.new()
var previousSkill = skillScr.new()
var prevPrevSkill = skillScr.new()
var prevPrevPrevSkill = skillScr.new()
var attackValue
var attackType
var attackElement
var damageCalc
var enemySkill = skillScr.new()
var target = 0
var hpLabel
var spriteNode
var maxBeats
var beatArray = []
var enemyAttackCheck
var buffer = 60
var actingCharacter
var targetCharacter
var holdBool = false
var hours
var minutes
var seconds


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	sysStartTime = OS.get_time()
	hours = int(sysStartTime.hour) * 3600
	minutes = int(sysStartTime.minute) * 60
	seconds = int(sysStartTime.second)
	inStartTime = hours + minutes + seconds
	newInput = true
	currentSkill = skilllist.getSkill(16)
	previousSkill = skilllist.getSkill(16)
	prevPrevSkill = skilllist.getSkill(16)
	prevPrevPrevSkill = skilllist.getSkill(16)

	#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getUp()).getName())
	get_node("targetLabel").set_text(str(target))
	generateBeatArray()
	# Called every time the node is added to the scene.
	# Initialization here
	enemySetUp()
	set_process(true)
	set_process_input(true)
	
	
	
func enemySetUp():
	var i = 0
	
	while(i <= enemyTroops.troops.size()-1):
		hpLabel = "enemyHP" + str(i)
		spriteNode = "enemySprite" + str(i)
		get_node(spriteNode).set_texture(load(enemyTroops.troops[0].getImage()))
		get_node(spriteNode).set_scale(Vector2(1,1))
		get_node(hpLabel).set_text(str(enemyTroops.troops[i].getHP()))
		i = i + 1
	#enemy.setEnemyViaEnemy(get_node("/root/enemylist").getEnemy(0))
	#get_node("enemySprite").set_texture(load("res://sprites/slime.png"))
	#get_node("enemySprite").set_scale(Vector2(1,1))
	#get_node("enemyHP").set_text(str(enemy.getHP()))
	#get_node("playerHP").set_text(str(playerinfo.getHP()))

func getBeatMap():
	file = File.new()
	file.open("beatmap.txt", file.READ)
	pass

func generateBeatArray():
	
	timer = 0
	currentBeatNumber = 1
	currentBeat = "beatSprite1"# + str(currentBeatNumber)
	getBeatMap()
	var i = 1
	var loop = true
	var stringToParse
	var beatParameters
	 
	
	while (loop == true):
		stringToParse = file.get_line()
		if (stringToParse != "END"):
			beatParameters = stringToParse.split(",")
			var currentNode = "beatSprite"+str(i)
			
			#print(beatParameters[0])
			
			var s = Sprite.new()
			var l = Label.new()
			l = get_node("beat/beatSprite/beatLabel").duplicate()
			s.set_name(currentNode)
			s.add_child(l)
			l.set_name("beatLabel")
			l.set_size(Vector2(200,200))
			l.set_scale(Vector2(1.3,1.3))
			s.set_texture(tex)
			s.set_script(scr)
			get_node("beat").add_child(s)
			get_node("beat").get_node(currentNode).setStartTime(int(beatParameters[0]))
			if (get_node("beat").get_node(currentNode).getType() == 1):
				var is = get_node("beat").get_node(currentNode).get_texture().get_size()
				var tw = get_node("beat").get_node(currentNode).getHoldTime()
				var scale = Vector2((is.x/(is.x/tw))/50,1)
				get_node("beat").get_node(currentNode).set_scale(scale)
			#print(get_node("beat").get_node(currentNode).get_node("beatLabel").get_name())
			#print(get_node("beat").get_node(currentNode).tString())
			i = i + 1
		else:
			maxBeats = i
			loop = false
			file.close()
	
func _process(delta):
	#timer = timer + 1
	sysCurrentTime = OS.get_time()
	hours = int(sysCurrentTime.hour) * 3600
	minutes = int(sysCurrentTime.minute) * 60
	seconds = int(sysCurrentTime.second)
	inCurrentTime = hours + minutes + seconds
	#if((int(sysCurrentTime.second)) -  (int(sysStartTime.second)) <= 0):
	sysSec = inCurrentTime - inStartTime
	#else:
#		sysSec = sysSec + (int(sysCurrentTime.second)) -  (int(sysStartTime.second))  
	#if (timer == 865):
	#	get_node("StreamPlayer").play()
	get_node("secondspassed").set_text(str(get_node("clock").get_songPos()))
	get_node("timerLabel").set_text(str(timer) + "  Seconds:" + str(timer/60) )
	checkBeatFail()

	#enemyTimedAttack()

	if (battle == false):
		set_process(false)
		set_process_input(false)
		get_tree().change_scene("res://Panel.tscn")

func bufferBeats():
	var bufferCheck = int(currentBeatNumber)
	var bufferCheckSprite = "beatSprite" + str(bufferCheck)
	var bufferLimit = currentBeatNumber + buffer
	while (bufferCheck <= bufferLimit):
		if (get_node("beat").get_node(bufferCheckSprite)!= null):
			get_node("beat").get_node(bufferCheckSprite).set_process(true)
			
		bufferCheck = bufferCheck + 1
		bufferCheckSprite = "beatSprite" + str(bufferCheck)
	pass

func checkBeatFail():
	if(get_node("beat").get_node(currentBeat)!= null):
		if(get_node("beat").get_node(currentBeat).getHitTime()+.25 < get_node("clock").get_songPos()):
			get_node("wrong").show()
			changeCurrentBeat()

func checkBeatMashPass():
	if(get_node("beat").get_node(currentBeat)!= null ):
		if(get_node("beat").get_node(currentBeat).getHitTime() ==  get_node("clock").get_songPos()):
			changeCurrentBeat()


func _input(event):
	hitBeat(event)



func hitBeat(event):
	if (event.is_action_pressed("ui_tabRight")):
		target = target + 1
		if (target > enemyTroops.troops.size()-1):
			target = 0
		get_node("targetLabel").set_text(str(target))
		hpLabel = "enemyHP" + str(target)
		spriteNode = "enemySprite" + str(target)

	if (event.is_action_pressed("ui_accept")):
		if(get_node("beat").get_node(currentBeat).getType() == 4):
			holdBool = true
		if (get_node("clock").get_songPos() <= get_node("beat").get_node(currentBeat).getHitTime()+.25 and get_node("clock").get_songPos() >= get_node("beat").get_node(currentBeat).getHitTime()-.25 ):
			get_node("check").show()
			if(Input.is_action_pressed("ui_up")):
				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getUp()).getName())
				get_node("neutralLabel").set_text(skilllist.getSkill(character0.getSkills().getUp()).getName())
				playerAttackUp(character0)
			elif(Input.is_action_pressed("ui_down")):
				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getDown()).getName())
				get_node("neutralLabel").set_text(skilllist.getSkill(character0.getSkills().getDown()).getName())
				playerAttackDown(character0)
			elif(Input.is_action_pressed("ui_left")):
				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getLeft()).getName())
				get_node("neutralLabel").set_text(skilllist.getSkill(character0.getSkills().getLeft()).getName())
				playerAttackLeft(character0)
			elif(Input.is_action_pressed("ui_right")):
				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getRight()).getName())
				get_node("neutralLabel").set_text(skilllist.getSkill(character0.getSkills().getRight()).getName())
				playerAttackRight(character0)
			else:
				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getNeutral()).getName())
				get_node("neutralLabel").set_text(skilllist.getSkill(character0.getSkills().getNeutral()).getName())
				playerAttackNeutral(character0)
			if (enemyTroops.troops[target].getHP() <= 0):
				changeTargetOnDeath()
			if (get_node("beat").get_node(currentBeat).getType() == 0):
				changeCurrentBeat()
			elif (get_node("beat").get_node(currentBeat).getType() == 1):
				holdBool = true
	elif (event.is_action_pressed("ui_other")):
		if(get_node("beat").get_node(currentBeat).getType() == 4):
			holdBool = true
		if (get_node("clock").get_songPos() <= get_node("beat").get_node(currentBeat).getHitTime()+.25 and get_node("clock").get_songPos() >= get_node("beat").get_node(currentBeat).getHitTime()-.25 ):
			get_node("check").show()
			if(Input.is_action_pressed("ui_up")):
				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getUp()).getName())
				get_node("neutralLabel").set_text(skilllist.getSkill(character1.getSkills().getUp()).getName())
				playerAttackUp(character1)
			elif(Input.is_action_pressed("ui_down")):
				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getDown()).getName())
				get_node("neutralLabel").set_text(skilllist.getSkill(character1.getSkills().getDown()).getName())
				playerAttackDown(character1)
			elif(Input.is_action_pressed("ui_left")):
				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getLeft()).getName())
				get_node("neutralLabel").set_text(skilllist.getSkill(character1.getSkills().getLeft()).getName())
				playerAttackLeft(character1)
			elif(Input.is_action_pressed("ui_right")):
				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getRight()).getName())
				get_node("neutralLabel").set_text(skilllist.getSkill(character1.getSkills().getRight()).getName())
				playerAttackRight(character1)
			else:
				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getNeutral()).getName())
				get_node("neutralLabel").set_text(skilllist.getSkill(character1.getSkills().getNeutral()).getName())
				playerAttackNeutral(character1)
			if (enemyTroops.troops[target].getHP() <= 0):
				changeTargetOnDeath()
			if (get_node("beat").get_node(currentBeat).getType() == 0):
				changeCurrentBeat()
			elif (get_node("beat").get_node(currentBeat).getType() == 1):
				holdBool = true
		else:
			get_node("wrong").show()
			enemyRandomAttack()
			changeCurrentBeat()
#	if (event.is_action_released("ui_accept") && holdBool == true):
#		holdBool = false
#		if (get_node("clock").get_songPos() <= get_node("beat").get_node(currentBeat).getHitTime()+.25 and get_node("clock").get_songPos() >= get_node("beat").get_node(currentBeat).getHitTime()-.25 ):
#			get_node("check").show()
#			if(Input.is_action_pressed("ui_up")):
#				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getUp()).getName())
#				get_node("neutralLabel").set_text(skilllist.getSkill(character0.getSkills().getUp()).getName())
#				playerAttackUp(character0)
#			elif(Input.is_action_pressed("ui_down")):
#				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getDown()).getName())
#				get_node("neutralLabel").set_text(skilllist.getSkill(character0.getSkills().getDown()).getName())
#				playerAttackDown(character0)
#			elif(Input.is_action_pressed("ui_left")):
#				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getLeft()).getName())
#				get_node("neutralLabel").set_text(skilllist.getSkill(character0.getSkills().getLeft()).getName())
#				playerAttackLeft(character0)
#			elif(Input.is_action_pressed("ui_right")):
#				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getRight()).getName())
#				get_node("neutralLabel").set_text(skilllist.getSkill(character0.getSkills().getRight()).getName())
#				playerAttackRight(character0)
#			else:
#				#get_node("neutralLabel").set_text(skilllist.getSkill(playerinfo.getSkills().getNeutral()).getName())
#				get_node("neutralLabel").set_text(skilllist.getSkill(character0.getSkills().getNeutral()).getName())
#				playerAttackNeutral(character0)
#			changeCurrentBeat()


func changeCurrentBeat():
	get_node("beat").get_node(currentBeat).setHit(true)
	get_node("beat").get_node(currentBeat).hide()
	get_node("beat").get_node(currentBeat).set_process(false)
	currentBeatNumber = currentBeatNumber + 1
	currentBeat = "beatSprite" + str(currentBeatNumber)
	lowerCooldown()
	#print(currentBeat)
	if (currentBeatNumber == maxBeats):
		timer = -10
		currentBeatNumber = 1
		currentBeat = "beatSprite" + str(currentBeatNumber)
	bufferBeats()

func changeTargetOnDeath():
		target = target + 1
		if (target > enemyTroops.troops.size()-1):
				target = 0
				get_node("targetLabel").set_text(str(target))
				hpLabel = "enemyHP" + str(target)
				spriteNode = "enemySprite" + str(target)

func lowerCooldown():
	playerinfo.getSkills().setNeutralCooldown(int(playerinfo.getSkills().getNeutralCooldown()) -1)
	playerinfo.getSkills().setUpCooldown(int(playerinfo.getSkills().getUpCooldown()) -1)
	playerinfo.getSkills().setDownCooldown(int(playerinfo.getSkills().getDownCooldown()) -1)
	playerinfo.getSkills().setLeftCooldown(int(playerinfo.getSkills().getLeftCooldown()) -1)
	playerinfo.getSkills().setRightCooldown(int(playerinfo.getSkills().getRightCooldown()) -1)
	character0.getSkills().setNeutralCooldown(int(character0.getSkills().getNeutralCooldown()) -1)
	character0.getSkills().setUpCooldown(int(character0.getSkills().getUpCooldown()) -1)
	character0.getSkills().setDownCooldown(int(character0.getSkills().getDownCooldown()) -1)
	character0.getSkills().setLeftCooldown(int(character0.getSkills().getLeftCooldown()) -1)
	character0.getSkills().setRightCooldown(int(character0.getSkills().getRightCooldown()) -1)
	character1.getSkills().setNeutralCooldown(int(character1.getSkills().getNeutralCooldown()) -1)
	character1.getSkills().setUpCooldown(int(character1.getSkills().getUpCooldown()) -1)
	character1.getSkills().setDownCooldown(int(character1.getSkills().getDownCooldown()) -1)
	character1.getSkills().setLeftCooldown(int(character1.getSkills().getLeftCooldown()) -1)
	character1.getSkills().setRightCooldown(int(character1.getSkills().getRightCooldown()) -1)


func getTimer():
	return timer

func enemyRandomAttack():
	enemySkill = enemyskilllist.getEnemySkill(enemyTroops.troops[target].randomAttack())
	#print(enemySkill.tString())
	var k = randi()%2
	if(k == 0):
		damageCalc = calculateEnemyDamage(character0,enemySkill)
		get_node("playerHP").set_text(str(character0.getHP()))
	elif(k== 1):
		damageCalc = calculateEnemyDamage(character1,enemySkill)
		get_node("playerHP").set_text(str(character1.getHP()))	
	#get_node("damageLabel").set_text(str(damageCalc))
	#playerinfo.setHP(playerinfo.getHP() - damageCalc)
	#character0.setHP(character0.getHP() - damageCalc)
	#get_node("playerHP").set_text(str(playerinfo.getHP()))
	#get_node("playerHP").set_text(str(character0.getHP()))


func calculateEnemyDamage(character,eSkill):
	var damage
	attackValue = eSkill.getDamage()
	attackType = eSkill.getType()
	attackElement = eSkill.getElement()
	randomize()
	if(attackType == "Physical" && attackElement == "NEUTRAL"):
		#damage = float(attackValue) * rand_range(0.75,1.25) * float(enemyTroops.troops[target].getPhysAtk()) * float(character.getPhysDef())
		damage = float(attackValue) * float(enemyTroops.troops[target].getPhysAtk()) * float(character.getPhysDef())
	elif(attackType == "Physical" && attackElement == "SOUND"):
		#damage = float(attackValue) * rand_range(0.75,1.25) * float(enemyTroops.troops[target].getPhysAtk()) * float(character.getSoundDef())
		damage = float(attackValue) * float(enemyTroops.troops[target].getPhysAtk()) * float(character.getSoundDef())
	elif(attackType == "Magic"):
		#damage = float(attackValue) * rand_range(0.75,1.25) * float(enemyTroops.troops[target].getMagAtk()) * float(character.getMagDef())
		damage = float(attackValue) * float(enemyTroops.troops[target].getMagAtk()) * float(character.getMagDef())
	return damage


func setCurrentSkill(skill):
	prevPrevPrevSkill = prevPrevSkill
	print("PrevPrevPrev Skill: " + prevPrevPrevSkill.getName())
	prevPrevSkill = previousSkill
	print("PrevPrev Skill: " + prevPrevSkill.getName())
	previousSkill = currentSkill
	print("Prev Skill: " + previousSkill.getName())
	currentSkill = skill
	print("Current Skill: " + currentSkill.getName())


func playerAttackNeutral(character):
	setCurrentSkill(skilllist.getSkill(character.getSkills().getNeutral()))
	if (character.getSkills().getNeutralCooldown() > 0):
		get_node("wrong").show()
		print("on Cooldown")
		enemyRandomAttack()
	else:
		damageCalc = calculateDamage(character0,currentSkill,previousSkill,prevPrevSkill,prevPrevPrevSkill)
		get_node("damageLabel").set_text(str(damageCalc))
		enemyTroops.troops[target].setHP(enemyTroops.troops[target].getHP() - damageCalc)
		get_node(hpLabel).set_text(str(enemyTroops.troops[target].getHP()))
		character.getSkills().setNeutralCooldown(skilllist.getSkill(character.getSkills().getNeutral()).getCooldown())

func playerAttackUp(character):
	setCurrentSkill(skilllist.getSkill(character.getSkills().getUp()))
	if (character.getSkills().getUpCooldown() > 0):
		get_node("wrong").show()
		print("on Cooldown")
		enemyRandomAttack()
	else:
		damageCalc = calculateDamage(character0,currentSkill,previousSkill,prevPrevSkill,prevPrevPrevSkill)
		get_node("damageLabel").set_text(str(damageCalc))
		enemyTroops.troops[target].setHP(enemyTroops.troops[target].getHP() - damageCalc)
		get_node(hpLabel).set_text(str(enemyTroops.troops[target].getHP()))
		character.getSkills().setUpCooldown(skilllist.getSkill(character.getSkills().getUp()).getCooldown())

func playerAttackDown(character):
	setCurrentSkill(skilllist.getSkill(character.getSkills().getDown()))
	if (character.getSkills().getDownCooldown() > 0):
		get_node("wrong").show()
		print("on Cooldown")
		enemyRandomAttack()
	else:
		damageCalc = calculateDamage(character0,currentSkill,previousSkill,prevPrevSkill,prevPrevPrevSkill)
		get_node("damageLabel").set_text(str(damageCalc))
		enemyTroops.troops[target].setHP(enemyTroops.troops[target].getHP() - damageCalc)
		get_node(hpLabel).set_text(str(enemyTroops.troops[target].getHP()))
		character.getSkills().setDownCooldown(character.getSkills().getDown().getCooldown())

func playerAttackLeft(character):
	
	setCurrentSkill(skilllist.getSkill(character.getSkills().getLeft()))
	if (character.getSkills().getLeftCooldown() > 0):
		get_node("wrong").show()
		print("on Cooldown")
		enemyRandomAttack()
	else:
		damageCalc = calculateDamage(character0,currentSkill,previousSkill,prevPrevSkill,prevPrevPrevSkill)
		get_node("damageLabel").set_text(str(damageCalc))
		enemyTroops.troops[target].setHP(enemyTroops.troops[target].getHP() - damageCalc)
		get_node(hpLabel).set_text(str(enemyTroops.troops[target].getHP()))
		character.getSkills().setLeftCooldown(character.getSkills().getLeft().getCooldown())

func playerAttackRight(character):
	setCurrentSkill(skilllist.getSkill(character.getSkills().getRight()))
	if (character.getSkills().getRightCooldown() > 0):
		get_node("wrong").show()
		print("on Cooldown")
		enemyRandomAttack()
	else:
		damageCalc = calculateDamage(character0,currentSkill,previousSkill,prevPrevSkill,prevPrevPrevSkill)
		get_node("damageLabel").set_text(str(damageCalc))
		enemyTroops.troops[target].setHP(enemyTroops.troops[target].getHP() - damageCalc)
		get_node(hpLabel).set_text(str(enemyTroops.troops[target].getHP()))
		character.getSkills().setRightCooldown(character.getSkills().getRight().getCooldown())

func enemyTimedAttack():
	enemyAttackCheck = int(enemyTroops.troops[target].getSpeed()) * 60
	if(get_node("clock").get_songPos() % enemyAttackCheck == 0 and get_node("clock").get_songPos()> 10):
		enemyRandomAttack()

func calculateDamage(character,curSkl,prevSkl,prevPrevSkl,prevPrevPrevSkl):
	var damage
	attackValue = curSkl.getDamage()
	attackType = curSkl.getType()
	attackElement = curSkl.getElement()
	randomize()
	
	if (character.getStyle() == "Repeat"):
		if (int(curSkl.getID()) == int(prevSkl.getID()) && int(curSkl.getID()) == int(prevPrevSkill.getID()) && int(curSkl.getID()) == int(prevPrevPrevSkl.getID())):
			attackValue = attackValue * 1.50
			print("Repeatx4! 1.5x Damage!")
			print(attackValue)
		elif (int(curSkl.getID()) == int(prevSkl.getID()) && int(curSkl.getID()) == int(prevPrevSkl.getID())):
			attackValue = attackValue * 1.25
			print("Repeatx3! 1.25x Damage!")
			print(attackValue)
		elif (int(curSkl.getID()) == int(prevSkl.getID())):
			attackValue = attackValue * 1.10
			print("Repeatx2! 1.1x Damage!")
			print(attackValue)
		else:
			attackValue = attackValue * 0.90
			print("Repeatx1! 0.9x Damage!")
			print(attackValue)
	elif(character.getStyle() == "Basic"):
		attackValue = attackValue * 1.25
		print("Basic! 1.25x Damage!")
	elif(character.getStyle() == "Combo"):
		attackValue = float(attackValue) +float(prevSkl.getBonusEffect().getDamage())
		#print(prevSkl.getBonusEffect().getDamage())
		#print("Combo! Damage UP!")
		#print(attackValue)
		print(prevSkl.getBonusEffect().getElement())
		if (prevSkl.getBonusEffect().getElement() != "NE"):
			attackElement = prevSkl.getBonusEffect().getElement()
			print(attackElement)
			#print("Combo! Element Change!")
	
	if(attackType == "Physical" && attackElement == "NEUTRAL"):
		damage = float(attackValue) *  float(character.getPhysAtk()) * float(enemyTroops.troops[target].getPhysDef())
		#print(damage)
	elif(attackType == "Physical" && attackElement == "SOUND"):
		damage = float(attackValue) *  float(character.getPhysAtk()) * float(enemyTroops.troops[target].getSoundDef())
	elif(attackType == "Magic"):
		damage = float(attackValue) * rand_range(0.75,1.25) * character.getMagAtk() * enemyTroops.troops[target].getMagDef()
	return damage
