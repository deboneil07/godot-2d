extends Node2D

func create_grass_effect():
	var GrassEffect = preload("res://World/grass_effect.tscn")
	var grassEffect = GrassEffect.instantiate()
	get_tree().current_scene.add_child(grassEffect)
	grassEffect.global_position = global_position

func _on_hurtbox_area_entered(area: Area2D) -> void:
	create_grass_effect()
	queue_free()
