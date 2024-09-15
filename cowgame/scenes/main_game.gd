extends Node

@onready var heartsContainer = $CanvasLayer/heartsContainer
@onready var player = $Player
@onready var shop = $shop

# Called when the node enters the scene tree for the first time.
func _ready():
	heartsContainer.setMaxHearts(player.max_health)
	heartsContainer.updateHearts(player.current_health)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player.healthChanged.connect(heartsContainer.updateHearts)
	shop.playerHealthChanged.connect(heartsContainer.updateHearts)
