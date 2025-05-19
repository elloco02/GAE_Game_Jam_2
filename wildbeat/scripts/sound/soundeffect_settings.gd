extends Resource
class_name SoundEffectSettings

enum SOUND_EFFECT_TYPE {
	UI_BUTTON_PRESSED,
	PLAYER_DAMAGE,
	PLAYER_MOVE,
	PLAYER_DIES,
	SPAWB_ITEM,
	COLLECT_ITEM,
	BACKGROUND_MUSIC_IN_GAME,
	BACKGROUND_MUSIC_IN_MENU,
	PLAYER_SHIELDING,
	PLAYER_SLOWMOTION_LINE
}

@export var type : SOUND_EFFECT_TYPE
@export var sound_effect : AudioStream
@export_range(-50, 50) var volume = 0
@export var bus : String = "Master"
