class_name State_Idle extends State

@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"

const STATE: String = "idle"

func Enter() -> void:
	player.UpdateAnimation(STATE)
	pass

func Exit() -> void:
	pass

func Process( _delta: float) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	
	player.velocity = Vector2.ZERO
	return null

func PhysicsProcess( _delta: float) -> State:
	return null

func HandleInput( _event: InputEvent) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	return null
