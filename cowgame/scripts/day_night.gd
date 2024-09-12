extends DirectionalLight2D

@export var day_color: Color
@export var night_color: Color
@export var day_time: DateTime
@export var night_time: DateTime
@export var transition_time: int = 30
@export var time_system: TimeSystem

signal currentDayState

var in_transition: bool = false

enum DayState{DAY, NIGHT}
var current_state: DayState = DayState.DAY

@onready var time_map: Dictionary = {
	DayState.DAY: day_time,
	DayState.NIGHT: night_time,
}

@onready var transition_map: Dictionary = {
	DayState.DAY: DayState.NIGHT,
	DayState.NIGHT: DayState.DAY,
}

@onready var color_map: Dictionary = {
	DayState.DAY: day_color,
	DayState.NIGHT: night_color,
}

func _ready() -> void:
	var diff_day_start = time_system.date_time.diff_without_days(day_time)
	var diff_night_start = time_system.date_time.diff_without_days(night_time)
	if diff_day_start < 0 || diff_night_start > 0:
		current_state = DayState.NIGHT

func update(game_time: DateTime) -> void:
	var next_state = transition_map[current_state]
	var change_time = time_map[next_state]
	var time_diff = change_time.diff_without_days(game_time)
	var test_state = current_state
	currentDayState.emit(test_state) #test emit day/night states
	
	if in_transition:
		update_transition(time_diff, next_state)
	elif time_diff > 0 && time_diff < (transition_time * 60):
		in_transition = true
		update_transition(time_diff, next_state)
	else:
		color = color_map[current_state]
	
	if time_diff > 0 && time_diff < (transition_time * 60):
		in_transition = true
		

func update_transition(time_diff: int, next_state: DayState) -> void:
	var ratio = 1 - (time_diff as float / (transition_time * 60))
	if ratio > 1:
		current_state = next_state
		in_transition = false
	else:
		color = color_map[current_state].lerp(color_map[next_state], ratio)
