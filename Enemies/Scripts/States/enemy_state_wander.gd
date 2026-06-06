class_name EnemyStateWander extends EnemyState 

@export var animation_name: String = "walk"
@export var wander_speed: int = 20
@export_category("AI")
@export var state_animation_duration: float = 0.7
@export var state_cycles_min: int = 1
@export var state_cycles_max: int = 3
@export var next_state: EnemyState

var _timer:  float = 0.0
var _direction: Vector2

func _ready() -> void:
	
	pass # Replace with function body.

func init() -> void:
	pass

func enter() -> void:
	_timer = randi_range(state_cycles_min, state_cycles_max)
	var rand = randi_range(0,3)
	_direction = enemy.DIR_4[rand]
	enemy.velocity = _direction * wander_speed
	enemy.set_direction(_direction)
	enemy.update_animation(animation_name)
	pass

func exit() -> void:
	pass

func process(delta: float) -> EnemyState:
	_timer -= delta
	if _timer <= 0:
		return next_state
	return null

func physics_process( _delta: float) -> EnemyState:
	return null
