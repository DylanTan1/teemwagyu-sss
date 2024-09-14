extends CharacterBody2D


#spawns and move to designated place when day starts
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
	position = Vector2(1222, 711)

func _process(delta):
	pass
	#if is_shopkeeper_out == 0:
		#print(is_shopkeeper_out)
		#var direction = Vector2(0,1)
		#position += direction * speed * delta
		#travelled_distance += speed * delta
		#if position > Vector2(539,290):
			#speed = 0
	#else:
		#var direction = Vector2(0,-1)
		#speed = 20
		#print(is_shopkeeper_out, travelled_distance)
		#position += direction * speed * delta
		#travelled_distance += speed * delta
		#if position < Vector2(539,280):
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
