class_name Fallable

extends Area2D

@export var fallable_type: Types

@export_subgroup("Fallable Settings")
@export var fall_speed: float = 100.0
@export var fall_step: float = 1.0
@export var spawn_weight: float = 1.0

@export_subgroup("Fallable Particles")
@export var collect_particles: CPUParticles2D

@export_subgroup("Fallable Sound Effects")
@export var player_hit_sound: SoundEffectSettings.SOUND_EFFECT_TYPE = SoundEffectSettings.SOUND_EFFECT_TYPE.NONE

@onready var sprite_2d: Sprite2D = $Sprite2D

enum Types {
	NONE,
	SHIELD,
	DAMAGE,
	HEAL,
	COIN,
	SLOW_MOTION,
}

func _ready():
	if fallable_type == Types.NONE:
		assert(false, "Invalid fallable type: " + str(fallable_type))

	self.body_entered.connect(handle_body_entered)


func _physics_process(delta: float) -> void:
	fall_down(delta)


func handle_body_entered(body: Node) -> void:
	if body is Player:
		play_player_hit_sound()
		play_particles(body)
		on_player_entered(body)
		sprite_2d.queue_free()
	elif body is Fallable:
		on_fallable_entered(body)
	remove_fallable()

# Should be implemented by the inheriting classes
func on_player_entered(_player: Player) -> void:
	pass


# Should be implemented by the inheriting classes
func on_fallable_entered(_fallable: Fallable) -> void:
	pass


func play_particles(_player: Player) -> void:
	if collect_particles:
		collect_particles.emitting = true


func play_player_hit_sound() -> void:
	AudioManager.create_2d_audio_at_location(global_position, player_hit_sound)


func fall_down(time: float) -> void:
	self.position.y = self.position.y + fall_speed * time * fall_step


# Not doing queue_free() immediately to allow for animation to play and the slow
# motion effects to finish
func remove_fallable() -> void:
	var childs = get_children()
	for child in childs:
		if child is CollisionShape2D or child is ColorRect:
			child.queue_free()
	fall_speed = 0
	if collect_particles:
		# 2 extra seconds to be sure the particles are done
		get_tree().create_timer(collect_particles.lifetime + 2.0).timeout.connect(_free)
	elif self is FallableSlowMotion:
		# 2 extra seconds to be sure that the slow motion effect is done
		get_tree().create_timer(self.slow_duration + 2.0).timeout.connect(_free)
	else:
		_free()


func _free() -> void:
	queue_free()
