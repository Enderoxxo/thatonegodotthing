extends RigidBody2D

@onready var bodies
@onready var currentball
signal damage

func try_collide():
	bodies = get_colliding_bodies()
	for body in bodies:
		if currentball != body:
			if body.is_in_group("Bullet"): #check colliding body is in the "players" group
				currentball = body
				damage.emit() #whatever u want to do (i.e, damage the player)
			

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	try_collide()
	pass
