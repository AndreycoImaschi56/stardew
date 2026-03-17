extends CharacterBody2D

const speed = 200

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var screen_size: Vector2

func _ready():
	screen_size = get_viewport_rect().size
	position = screen_size/2

func get_input():
	
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	position = position.clamp(Vector2.ZERO, screen_size)
	
	var mouse = get_local_mouse_position()
	var angle = snappedf(mouse.angle(), PI / 4) / (PI / 4)
	angle = wrapi(int(angle), 0, 8)
	
	animated_sprite.animation = "walk" + str(angle)
	
	if velocity:
		animated_sprite.play()
	else:
		animated_sprite.stop()
		animated_sprite.frame = 1
