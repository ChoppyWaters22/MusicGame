extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.show()
	var currentPos = get_pos()
	set_pos(Vector2(1024,currentPos.y))
	# Called every time the node is added to the scene.
	# Initialization here
	pass

