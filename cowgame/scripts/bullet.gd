extends Area2D
var travelled_distance = 0
var bullet_speed = 1000
var bullet_range = 500


func _physics_process(delta):
	#get direction of the rotated bullet
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * bullet_speed * delta
	#get distance travelled by the bullet
	travelled_distance += bullet_speed * delta
	#destroy bullet if more than range
	if travelled_distance > bullet_range:
		queue_free()


func _on_body_entered(body):
	queue_free()
	#checks if body 2D has a function called "take_damage", if true, calls that function
	if body.has_method("take_damage"):
		body.take_damage()
