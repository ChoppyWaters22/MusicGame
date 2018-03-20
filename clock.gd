extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var sysStartTime = OS.get_time()
var sysCurrentTime = OS.get_time()
var inStartTime
var inCurrentTime
var sysSec = -1
var hours
var minutes
var seconds
var songPos = -1
	
func _ready():
	set_process(true)
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func get_songPos():
	return songPos
	pass
	
func _process(delta):
	songPos = get_node("streamPlayer").get_pos()
	
	sysCurrentTime = OS.get_time()
	hours = int(sysCurrentTime.hour) * 3600
	minutes = int(sysCurrentTime.minute) * 60
	seconds = int(sysCurrentTime.second)
	inCurrentTime = hours + minutes + seconds
	#if((int(sysCurrentTime.second)) -  (int(sysStartTime.second)) <= 0):
	#sysSec = inCurrentTime - inStartTime
	pass	
