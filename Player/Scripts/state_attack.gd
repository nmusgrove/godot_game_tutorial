class_name State_Attack extends State

var is_attacking: bool = false

@export var attack_sound: AudioStream
@export_range(1,20,0.5) var deceleration: float = 5.0

@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"
@onready var animation_player:  AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animation_player: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurt_box: HurtBox = %AttackHurtBox

const STATE: String = "attack"


func Enter() -> void:
	player.UpdateAnimation(STATE)
	attack_animation_player.play("attack_" + player.AnimDirection())
	animation_player.animation_finished.connect(end_attack)
	audio_stream_player_2d.stream = attack_sound
	audio_stream_player_2d.pitch_scale = randf_range(0.9, 1.1)
	audio_stream_player_2d.play()
	is_attacking = true
	await  get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true
	pass
	
func Exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	is_attacking = false
	hurt_box.monitoring = false
	pass

func Process( _delta: float) -> State:
	player.velocity -= player.velocity * deceleration * _delta
	if not is_attacking:
		if player.velocity == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

func PhysicsProcess( _delta: float) -> State:
	return null

func HandleInput( _event: InputEvent) -> State:
	return null
	
func end_attack(_anim_name: StringName) ->   void:
	is_attacking = false
	hurt_box.monitoring = false
	
