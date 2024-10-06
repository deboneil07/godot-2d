extends Node2D

@onready var animatedSprite = $AnimatedSprite2D

func _ready() -> void: # on start of game
	animatedSprite.frame = 0 # setting fram to 0 forcefully
	animatedSprite.play("Animate") # play animate when effect starts

func _on_animated_sprite_2d_animation_finished() -> void: # this is a signal
	queue_free() # delete after anim over
