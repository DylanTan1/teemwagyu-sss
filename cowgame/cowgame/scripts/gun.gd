extends Area2D




# Called when the node enters the scene tree for the first time.
func _ready():
	$pivot/gun.play("banana")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	if Global.inventory["Gun"]["Name"] == "Pistol":
		$pivot/gun.play("pistol")
	elif Global.inventory["Gun"]["Name"] == "Machine Gun":
		$pivot/gun.play("machine_gun")

func shoot():
	var firerate = Global.inventory["Gun"]["Firerate"]
	#create instances of bullets
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	#position of the created bullet
	new_bullet.global_position = %shooting_point.global_position
	#rotation of the created bullet
	new_bullet.global_rotation = %shooting_point.global_rotation
	#creates a child node bullet into the starting point
	%shooting_point.add_child(new_bullet)
	#firerate cd starts
	$cooldown_timer.start(firerate)
