class_name FallableSlowMotion

extends Fallable

@export var slow_factor: float = 0.5
@export var slow_duration: float = 10.0

# only slows down the objects that are spawned by the same spawner as this object
func on_player_entered(_player: Player) -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_SLOWMOTION_LINE)
	var spawner: Spawner = self.get_parent()
	self.activate_slow(spawner)
	#self.camouflage()
	# keep slow for slow_duration
	await get_tree().create_timer(self.slow_duration).timeout
	self.deactivate_slow(spawner)

# activate the slow effect for already spawned Fallables in the same column
# as this object and all newly spawned Fallables in the same column during the
# effect duration
func activate_slow(spawner: Spawner) -> void:
	print("slow motion collected")
	# if spawner already slowed, don't stack the effect
	if not spawner.slowed:
		# set slowed variable for spawner true, that way all newly spawned
		# fallables are also slowed
		spawner.slowed = true
		# add slow down effect for already spawned objects in the same column
		for child in spawner.get_children():
			if child is Fallable:
				child.fall_step = self.slow_factor
		print("slow motion activated, objects slowed by a factor of ", self.slow_factor)
	else:
		print("spawner in this column already slowed")

# deactivate the slow effect for already spawned Fallables in the same column
# as this object and all newly spawned Fallables in the same column during the
# effect duration
func deactivate_slow(spawner: Spawner) -> void:
	# set slowed variable for spawner false, that way all newly spawned
	# fallables are not slowed
	spawner.slowed = false
	# remove slow down effect for already spawned objects in the same column
	for child in spawner.get_children():
		if child is Fallable:
			child.fall_step = 1.0
	print("slow motion deactivated")

# delete collision shape and sprite to create an illusion of object destruction
func camouflage() -> void:
	for child in self.get_children():
		child.free()
