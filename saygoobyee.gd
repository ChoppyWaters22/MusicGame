extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _on_button_pressed():
	get_node("Label").set_text("H*CK OFF NERDO")
	get_tree().change_scene("res://battleTest.tscn")
	var enemyIDArray = []
	enemyIDArray.append(0)
	enemyIDArray.append(0)
	enemyTroops.setTroops(enemyIDArray)

func _ready():
	get_node("Button").connect("pressed",self,"_on_button_pressed")