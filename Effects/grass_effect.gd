extends Node2D

@onready var animatedSprite = $AnimatedSprite2D

func _ready() -> void:
	animatedSprite.frame = 0
	animatedSprite.play("Animate")

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
