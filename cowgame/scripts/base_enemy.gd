extends CharacterBody2D

var health = 3
var damage = 1

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to($"../Player".global_position)
	velocity = direction * 20.0
	move_and_slide()

func deal_damage():
	return damage

func take_damage():
	health -= 1
	if health == 0:
		queue_free()
