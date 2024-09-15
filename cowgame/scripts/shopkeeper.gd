extends CharacterBody2D

#interactable by player
signal open_shop
signal area_exited
var travelled_distance = 0
var speed = 20
var range = 10
var is_shopkeeper_out = 0
var is_shopkeeper_exist = 1

#spawns and move to designated place when day starts
func _ready():
	#pass
	position = Vector2(1318,695)

func _process(delta):
	pass
	if is_shopkeeper_out == 0:
		print(is_shopkeeper_out)
		var direction = Vector2(0,1)
		position += direction * speed * delta
		travelled_distance += speed * delta
		if position > Vector2(1318,723):
			speed = 0
	else:
		var direction = Vector2(0,-1)
		speed = 20
		print(is_shopkeeper_out, travelled_distance)
		position += direction * speed * delta
		travelled_distance += speed * delta
		#if position < Vector2(1318,695):
			#queue_free()


#if player enters shopkeeper radius
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		print("Player is near the shopkeeper")
		$shopkeeper_text.show_shopkeeper_message("Press E to Open Shop")
		# Emit a signal when the player enters the area
		emit_signal("open_shop")

#if player exits shopkeeper radius
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		print("Player exit the shopkeeper")
		$shopkeeper_text.hide_shopkeeper_message()
		emit_signal("area_exited")


func _on_day_night_current_day_state(currentState):
	if currentState == 0:
		is_shopkeeper_out = 0

		#
		##var new_shopkeeper = load("res://scenes/shopkeeper.tscn")
		##add_child(new_shopkeeper)
		##new_shopkeeper.position = Vector2(539,279)
		#const BULLET = preload("res://scenes/bullet.tscn")
		#var new_bullet = BULLET.instantiate()
		##position of the created bullet
		#new_bullet.global_position = %shooting_point.global_position
		##rotation of the created bullet
		#new_bullet.global_rotation = %shooting_point.global_rotation
		#print("It's day time!")
		#visible = true
		#$AnimationPlayer.play("ShopkeeperAnimOpen")
	else:
		is_shopkeeper_out = 1
		#print("It's night time!")
		#$AnimationPlayer.play("ShopkeeperAnimClose")
		#if position == Vector2(539,279):
			#visible = true
