
extends Area2D

var lemons_collected: int = 0
const MAX_LEMONS: int = 3

var spawn_position: Vector2

@export var speed: float = 100.0

var direction: int = -1
var collected: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	spawn_position = global_position
	sprite.play("walk")


func _physics_process(delta):

	position.x += direction * speed * delta
	sprite.flip_h = direction > 0


func turn_around():
	direction *= -1


func _on_area_2d_body_entered(body):

	print("Menyentuh: ", body.name)

	if collected:
		return

	if body is CharacterBody2D:

		if lemons_collected <= 0:
			return

		collected = true

		# Memberikan lemon kepada player
		body.lemons += lemons_collected

		print("Player mendapat ",
			lemons_collected, " lemon")

		print("Total lemon player: ",
			body.lemons)

		# Mengosongkan lemon semut
		lemons_collected = 0

		# Menghilangkan semut
		visible = false
		set_deferred("monitoring", false)
		set_physics_process(false)

		# Menunggu 5 detik
		await get_tree().create_timer(5.0).timeout

		# Mengembalikan semut
		global_position = spawn_position

		visible = true
		set_deferred("monitoring", true)
		set_physics_process(true)

		collected = false

		sprite.play("walk")
