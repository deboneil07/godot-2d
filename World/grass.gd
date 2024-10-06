extends Node2D

func create_grass_effect(): # always use preload 
	var GrassEffect = preload("res://World/grass_effect.tscn") # import grass effect
	var grassEffect = GrassEffect.instantiate() # instantiate the loaded effect
	get_tree().current_scene.add_child(grassEffect) # tree -> curr scene -> add -> grass effect
	grassEffect.global_position = global_position # pos of grass = pos of grass effect

func _on_hurtbox_area_entered(area: Area2D) -> void: # when hurtbox (area2d) enters
	create_grass_effect() # grass effect runs
	queue_free() # delete grass
