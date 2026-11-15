
extends CharacterBody2D

var lemons: int = 0

@export var speed: float = 250.0
@export var jump_velocity: float = -450.0
@export var score_label: Label

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	update_score()

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Movement
	var direction = Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = direction * speed
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = 0

	move_and_slide()
	update_animation()

func update_animation():
	if not is_on_floor():
		animated_sprite.play("jump")
	elif velocity.x != 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")

# Fungsi ketika player mengambil semut
func collect_ant(points: int = 1):
	lemons += points
	update_score()
	print("Score player: ", lemons)

# Memperbarui tampilan score
func update_score():
	if score_label:
		score_label.text = "Score: " + str(lemons)
