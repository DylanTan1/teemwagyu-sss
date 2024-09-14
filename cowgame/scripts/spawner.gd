extends Node2D

@onready var main = get_node("/root/main_game")

var enemyScene := preload("res://scenes/base_enemy.tscn")
var spawnPoints := []
var isNight = false
var spawn_cooldown = 0.1  # 0.5 seconds cooldown
var time_since_last_spawn = 0.0
var levelChange := false
var currentLevel := 1
var previousState = 0
var currentTotal = 0

func _ready():
	for i in get_children():
		if i is Marker2D:
			spawnPoints.append(i)
			
	

func nightTime(currentState):
	
	if currentState == 1:
		isNight = true
		
		if previousState != currentState:
			currentLevel += 1
			print_debug("Current Level: ", currentLevel)
			previousState = currentState
		
	elif currentState == 0:
		isNight = false
		previousState = 0
		



func _on_timer_timeout() -> void:
	pass

func _process(delta: float) -> void:
	time_since_last_spawn += delta
	var spawnTotal = currentLevel * 5
	if isNight and time_since_last_spawn >= spawn_cooldown and currentTotal < spawnTotal:
		time_since_last_spawn = 0.0
		spawnEnemies(delta, spawnTotal)
	
	if isNight == false:
		currentTotal = 0
	

func spawnEnemies(delta, spawnTotal):
		if currentTotal < spawnTotal:
			var spawn = spawnPoints[randi() % spawnPoints.size()]
			var enemy = enemyScene.instantiate()
			enemy.position = spawn.position
			currentTotal += 1
			print_debug("enemy spawn!", currentTotal)
			main.add_child(enemy)
		else:
			pass
		
	
