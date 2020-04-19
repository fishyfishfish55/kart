extends Control

export (PackedScene) var load_screen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Play_pressed():
	LoadScreen.load_scene("res://main.tscn")


func _on_Multi_pressed():
	pass # Replace with function body.


func _on_Join_pressed():
	pass # Replace with function body.
