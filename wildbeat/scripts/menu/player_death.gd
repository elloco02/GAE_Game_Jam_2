extends Control

@onready var score_label: Label = $ScoreLabel

func _ready() -> void:
    score_label.text = "Your score: " + str(ScoreManager.score)