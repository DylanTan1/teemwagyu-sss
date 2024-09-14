extends CharacterBody2D

@export var speed: float = 500
@export var max_health: int = 100
@export var current_health: int = 5
var is_lose: bool

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

#shoot gun
	if Input.is_action_pressed("shoot") and $"gun/cooldown_timer".is_stopped():
		$gun.shoot()


#Call this when increasing speed
func gain_speed(speed: float) -> void:
	speed += speed

#Call thsi when losing speed
func lose_speed(speed: float) -> void:
	speed -= speed

#Call this when increasing max health
func gain_max_health(health: int) -> void:
	max_health += health

# Call this when gaining health from consumables
func gain_health(health: int) -> void:
	current_health = min(max_health, current_health + health)

# Call this when losing health
func lose_health(health: int) -> void:
	current_health = max(0, current_health - health)
	if current_health < 1:
		is_lose = true

#if player is near shopkeeper, can open shop
#TODO FIX THIS PLS
func _input(event):
	if event.is_action_pressed("interact") and is_near_shopkeeper == true:
		print("Opening shop...")
		get_tree().paused = true
		$"../shop/anim_shop".play("trans_in")
		$"../shopkeeper/shopkeeper_text".hide_shopkeeper_message()

#check if near shopkeeper
var is_near_shopkeeper = false
func _on_shopkeeper_open_shop():
	print("openshop")
	is_near_shopkeeper = true
func _on_shopkeeper_area_exited():
	print("closeshop")
	is_near_shopkeeper = false
