extends CharacterBody2D

var speed = 200



#func _ready():
	#Global.set_player_reference(self)

func get_input():
	var input_direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = input_direction * speed
	
func _physics_process(delta):
	get_input()
	move_and_slide()

#if player is near shopkeeper, can open shop
func _input(event):
	if event.is_action_pressed("ui_interact") and is_near_shopkeeper == true:
		print("Opening shop...")
		get_tree().paused = true
		$"../shop/Anim".play("trans_in")
		$"../shopkeeper/CanvasLayer".hide_shopkeeper_message()


#check if near shopkeeper
var is_near_shopkeeper = false
func _on_shopkeeper_open_shop():
	print("openshop")
	is_near_shopkeeper = true
func _on_shopkeeper_area_exited():
	print("closeshop")
	is_near_shopkeeper = false
	
