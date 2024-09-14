extends CanvasLayer

var current_item = 0

#display 1st item
func _ready():
	$Control/item_name_label.text = Global.items[current_item]["Name"]
	$Control/item_desc_label.text = Global.items[current_item]["Desc"] + "\n Cost: " + str(Global.items[current_item]["Cost"])

#display available items
func switch_items(select):
	if current_item != null:
		for i in range(Global.items.size()):
			if select == i:
	#			TODO refine this part by adding a var to Global.items[current_item]
				current_item = select
				print(select)
	#			TODO attach sprite to anim_shop_sprite
				$Control/anim_shop_sprite.play(Global.items[current_item]["Name"])
				$Control/item_name_label.text = Global.items[current_item]["Name"]
				$Control/item_desc_label.text = Global.items[current_item]["Desc"] + "\n Cost: " + str(Global.items[current_item]["Cost"])

#prev and next buttons
func _on_shop_prev_button_pressed():
	switch_items(current_item - 1)
func _on_shop_next_button_pressed():
	switch_items(current_item + 1)

#buy items
func _on_shop_buy_button_pressed():
	#check for gold coins if can buy
	if Global.gold >= Global.items[current_item]["Cost"]:
#deduct gold
		Global.gold -= Global.items[current_item]["Cost"]
#remove from shop
		print(Global.items, " ", Global.gold)
		#TODO remove bought item from shop: 1. make count 0 then if try to buy will say sold out
		#or remove from list (i tried this and it caused some wanky bugs so im not gonna bother for now)
#add to inventory
	if Global.items[current_item]["Name"] == "Potion":
		$"../Player".gain_health(1)
		print($"../Player".current_health)
	else:
		Global.inventory["Gun"] = Global.items[current_item]

#close shop
func _on_close_shop_pressed():
	$anim_shop.play("trans_out")
	get_tree().paused = false
	$"../shopkeeper/shopkeeper_text".show_shopkeeper_message("Press E to Open Shop")
