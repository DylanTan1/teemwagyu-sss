extends CanvasLayer


func show_shopkeeper_message(text):
	$"../Label".text = text
	$"../Label".show()

func hide_shopkeeper_message():
	$"../Label".hide()
