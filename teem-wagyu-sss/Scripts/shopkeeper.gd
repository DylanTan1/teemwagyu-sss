extends CharacterBody2D


#spawns and move to designated place when day starts
#interactable by player
signal open_shop
signal area_exited

func _process(delta):
	pass
	#get_node("CanvasLayer/Label").position = self.position
#if player enters shopkeeper radius
func _on_area_2d_body_entered(body):
	if body.name == "player":
		print("Player is near the shopkeeper")
		$CanvasLayer.show_shopkeeper_message("Press E to Open Shop")
		# Emit a signal when the player enters the area
		emit_signal("open_shop")

#if player exits shopkeeper radius
func _on_area_2d_body_exited(body):
	if body.name == "player":
		print("Player exit the shopkeeper")
		$CanvasLayer.hide_shopkeeper_message()
		emit_signal("area_exited")
