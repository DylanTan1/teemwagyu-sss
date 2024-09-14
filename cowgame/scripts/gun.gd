extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func shoot():
	#create instances of bullets
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	#position of the created bullet
	new_bullet.global_position = %shooting_point.global_position
	#rotation of the created bullet
	new_bullet.global_rotation = %shooting_point.global_rotation
	#creates a child node bullet into the starting point
	%shooting_point.add_child(new_bullet)
