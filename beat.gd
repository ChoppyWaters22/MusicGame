extends Sprite


#speed the beat moves
var tween 
var currentBeat
var beatNumber
var hit = false
var startTime = 1
var hitTime
var stringToReturn
var startPos = Vector2(-2.67336,2.04354)
var currentPos = startPos
var type = 2
# 0 = normal, 1 = hold, 2 = mash
var starPower = false
var character = 0
#0 = all, 1 = love, 2 = acceptance, 3 = redemption, 4 = joy
var screenSize = Vector2(Globals.get("display/width"),Globals.get("display/height"))
var speed = (screenSize.x / 8) 
var holdTime = speed
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func setStartTime(time):
	startTime = time# + 450
	setHitTime(time + 8)

func setHitTime(time):
	hitTime = time

func getStartTime():
	return startTime

func getHitTime():
	return hitTime

func setHit(HIT):
	hit = HIT

func setType(TYPE):
	type = TYPE

func getType():
	return type

func setHoldTime(time):
	holdTime = time

func getHoldTime():
	return holdTime


func tString():
	stringToReturn = "Hit Time: " + str(hitTime)
	return stringToReturn

func _ready():
	self.show()
	set_process(true)
	get_node("beatLabel").set_text(self.get_name())
	tween = Tween.new()
	add_child(tween)
	
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func _process(delta):

	#currentPos = Vector2(get_node("../../clock").get_songPos() * speed, currentPos.y)
	#self.set_pos(currentPos.x, currentPos.y)
	if(get_node("../../clock").get_songPos() >= startTime and hit == false):
		set_pos(Vector2(speed*(get_node("../../clock").get_songPos() -startTime), currentPos.y ))
		currentPos = Vector2(speed* (get_node("../../clock").get_songPos() -startTime), currentPos.y )
		var trash = get_node("../../beat").get_pos()
		speed = (screenSize.x / 8) + (trash.x / 8)
		get_node("../beatInfo/beatInfoLabel3").set_text(str(trash.x))
		#get_node("../beatInfo/beatInfoLabel3").set_text(str(currentPos.x))
		get_node("../beatInfo/beatInfoLabel4").set_text(str(get_node("../../clock").get_songPos() -startTime))
		get_node("../beatInfo/beatInfoLabel5").set_text(str(speed))
		#tween.interpolate_property(self, "transform/pos", 
		#	                      get_pos(), get_pos() + Vector2(speed + (get_node("../../clock").get_songPos() - getStartTime()),0),
        #                      1, Tween.TRANS_LINEAR, 
        #                 Tween.EASE_OUT)
	#tween.start()
	
	if(get_node("../../clock").get_songPos() == startTime ):
		self.show()
		self.set_pos(startPos)
		hit = false