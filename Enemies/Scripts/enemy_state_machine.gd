class_name EnemyStateMachine extends Node

var states : Array[EnemyState]
var prev_state : EnemyState
var current_state : EnemyState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_state(current_state.process(delta))
	pass
	
func _physics_process(delta: float) -> void:
	change_state(current_state.physics_process(delta))
	pass
	
func initialize(_enemy: Enemy) -> void:
	states = []
	
	for c in get_children():
		if c is EnemyState:
			c.enemy = _enemy
			c.state_machine = self
			c.init()
			states.append(c)
			
	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state: EnemyState) -> void:
	if new_state == current_state || new_state == null:
		return
	
	if current_state:
		current_state.exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.enter() 
