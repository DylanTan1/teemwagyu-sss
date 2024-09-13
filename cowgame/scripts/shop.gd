extends CanvasLayer

var current_item = 0
var select = 0

func _on_close_shop_pressed():
	$anim_shop.play("trans_out")
	get_tree().paused = false
	$"../shopkeeper/shopkeeper_text".show_shopkeeper_message("Press E to Open Shop")
	

func switch_items(select):
	print(select)

func _on_prev_pressed():
	switch_items(current_item - 1)


func _on_next_pressed():
	switch_items(current_item + 1)


func _on_buy_pressed():
	pass # Replace with function body.
	

#display available items
#buy items
#check for gold coins if can buy
#remove from shop
#add to inventory
