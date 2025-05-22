extends AnimatedSprite2D
class_name AnimationPlayerTest

var is_dead: bool = false
var return_to_idle_after_anim: bool = false

func _ready():
	animation_finished.connect(_on_animation_finished)
	play_idle()

func play_idle():
	play("idle")

func play_dash_left():
	if not is_dead:
		return_to_idle_after_anim = true
		play("dash_left")

func play_dash_right():
	if not is_dead:
		return_to_idle_after_anim = true
		play("dash_right")

func play_take_damage():
	if not is_dead:
		return_to_idle_after_anim = true
		play("take_damage")

func play_dies():
	is_dead = true
	return_to_idle_after_anim = false
	play("dies")

func _on_animation_finished():
	if is_dead:
		return
	if return_to_idle_after_anim:
		return_to_idle_after_anim = false
		play_idle()
