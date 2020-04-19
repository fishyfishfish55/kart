extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_Timer_timeout():
	$Particles.emitting = false
	$RigidBody/CSGCylinder.show()
	$RigidBody/CollisionShape.show()

func _on_RigidBody_body_entered(body):
	if body.name == "Spatial":
		print("Emmitting!")
		$Timer.start()
		$Particles.emitting = true
		$RigidBody/CSGCylinder.hide()
		$RigidBody/CollisionShape.hide()
