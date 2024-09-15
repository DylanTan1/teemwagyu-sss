extends Node2D

@onready var main = get_node("/root/main_game")

@onready var player = get_node("/root/main_game/Player")

@onready var spawner = get_node("/root/main_game/Spawner")

@onready var daySong = get_node("/root/main_game/daySong")
@onready var nightSong = get_node("/root/main_game/nightSong")
@onready var windBlow = get_node("/root/main_game/windBlow")

var enemyScene := preload("res://scenes/base_enemy.tscn")
var tornadoScene := preload("res://scenes/tornado.tscn")
var spawnPoints := []
var isNight = false
var spawn_cooldown = 0.1  # 0.5 seconds cooldown
var time_since_last_spawn = 0.0
var levelChange := false
var currentLevel := 1
var previousState = 0
var currentTotal = 0
var tornadoGenerated = false
var globalTornadoes = []
var tornadoesDestroyed = false
var songPlaying = false

func _ready():
	daySong.play()
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
		var playerPos = player.position
		if tornadoGenerated == false:
			daySong.stop()
			nightSong.play()
			windBlow.play()
			spawn_tornadoes_around_player(playerPos)
			tornadoesDestroyed = false
		
		
		
	
	if isNight == false and tornadoGenerated == true and tornadoesDestroyed == false:
		nightSong.stop()
		windBlow.stop()
		daySong.play()
		destroyTornado(globalTornadoes)
		tornadoesDestroyed = true
		currentTotal = 0
		tornadoGenerated = false
	
	

func spawnEnemies(delta, spawnTotal):
		if currentTotal < spawnTotal:
			var spawn = spawnPoints[randi() % spawnPoints.size()]
			var enemy = enemyScene.instantiate()
			enemy.position = spawn.position
			currentTotal += 1
			#print_debug("number of cows: ", currentTotal)
			main.add_child(enemy)
		else:
			pass


func spawn_tornadoes_around_player(player_pos: Vector2):
	var currentSpawner = get_node("/root/main_game/Spawner")
	var tornadoes := []
	# List of 8 directions (unit vectors)
	
	
	var directions = [
		Vector2(0, -1),     # 0 degrees (Up)
		Vector2(0.38, -0.92),  # 22.5 degrees
		Vector2(0.71, -0.71),  # 45 degrees (Up-Right)
		Vector2(0.92, -0.38),  # 67.5 degrees
		Vector2(1, 0),       # 90 degrees (Right)
		Vector2(0.92, 0.38),   # 112.5 degrees
		Vector2(0.71, 0.71),   # 135 degrees (Down-Right)
		Vector2(0.38, 0.92),   # 157.5 degrees
		Vector2(0, 1),       # 180 degrees (Down)
		Vector2(-0.38, 0.92),  # 202.5 degrees
		Vector2(-0.71, 0.71),  # 225 degrees (Down-Left)
		Vector2(-0.92, 0.38),  # 247.5 degrees
		Vector2(-1, 0),      # 270 degrees (Left)
		Vector2(-0.92, -0.38), # 292.5 degrees
		Vector2(-0.71, -0.71), # 315 degrees (Up-Left)
		Vector2(-0.38, -0.92)  # 337.5 degrees
	]
	
	var distance = 180
	
	for dir in directions:
		var tornado_pos = player_pos + dir.normalized() * distance
		var tornado_instance = tornadoScene.instantiate()
		tornado_instance.position = tornado_pos
		currentSpawner.add_child(tornado_instance)
		tornadoes.append(tornado_instance)
	
	globalTornadoes = tornadoes
	tornadoGenerated = true
   
	
func destroyTornado(tornadoes):
	for tornado in tornadoes:
		if tornado:
			tornado.queue_free()
				
