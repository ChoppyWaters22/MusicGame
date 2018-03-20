extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var enemyScr = load("enemy.gd")

var prepEnemy
var troops = []

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
	
func setTroops(troopIDs):
	var i = 0
	while(i <= troopIDs.size() - 1):
		var enemyToAdd = enemyScr.new()
		enemyToAdd.setEnemyViaEnemy(get_node("/root/enemylist").getEnemy(troopIDs[i]))
		troops.append(enemyToAdd)
		print(troops[i].getName())
		i = i + 1

func startBattle():
	get_tree().change_scene("res://battleTest.tscn")	
	pass