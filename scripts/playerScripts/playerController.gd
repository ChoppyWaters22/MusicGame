extends KinematicBody2D

var speed = 100
var xMovement = 0;
var yMovement = 0;
var vel = Vector2();
#player state is an indentifier to determine valid button inputs?
#0 means the player is moving on the map regularly
#1 means the game is paused and the player is in the menu
var playerState = 0;

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass


func _movement(delta):
	print(self.get_collider( ) )
	
	if Input.is_action_pressed("ui_right"):
		xMovement = speed
		vel = Vector2(speed,yMovement)
		get_node("player").set_frame(4)
	elif Input.is_action_pressed("ui_left"):
		xMovement = -speed
		vel = Vector2(-speed,yMovement)
		get_node("player").set_frame(3)
	else:
		xMovement = 0
		vel = Vector2(0,yMovement)
	
	if Input.is_action_pressed("ui_up"):
		yMovement = -speed
		vel = Vector2(xMovement,-speed)
		get_node("player").set_frame(1)
	elif Input.is_action_pressed("ui_down"):
		yMovement = speed
		vel = Vector2(xMovement,speed)
		get_node("player").set_frame(0)
	else:
		yMovement = 0
		vel = Vector2(xMovement,0)
		
		
	self.move(vel * delta)

func _pause():
	if Input.is_action_pressed("ui_start"):
		playerState = 1;
		get_tree().set_pause(true);
		get_parent().get_node("pause_popup").show();
		pass
	elif Input.is_action_pressed("ui_start") && playerState == 1:
		playerState = 0;
		get_tree().set_pause(false);
		get_parent().get_node("pause_popup").hide();
		pass

func _process(delta):
	_movement(delta);
	_pause();	
	