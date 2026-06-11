class_name EnemyStateDestroy extends EnemyState 

@export var animation_name: String = "destroy"
@export var knockback_speed: float = 200.0
@export var deceleration: float =  10.0

var _damage_position: Vector2
var _direction: Vector2

func _ready() -> void:
	
	pass # Replace with function body.

func init() -> void:
	enemy.enemy_destroyed.connect(_on_enemy_destroyed)
	pass

func enter() -> void:
	enemy.invulnerable = true
	
	_direction = enemy.global_position.direction_to(_damage_position)
	enemy.set_direction(_direction)
	enemy.velocity = _direction * -knockback_speed
	enemy.update_animation(animation_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	pass	

func exit() -> void:
	pass

func process(delta: float) -> EnemyState:
	enemy.velocity -= enemy.velocity * deceleration * delta
	return null

func physics_process( _delta: float) -> EnemyState:
	return null
	
func _on_enemy_destroyed(hurt_box: HurtBox) -> void:
	_damage_position = hurt_box.global_position
	state_machine.change_state(self)

func _on_animation_finished(_name: String) -> void:
	enemy.queue_free()
