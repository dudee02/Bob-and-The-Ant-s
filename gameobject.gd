
extends Node2D

@onready var player = $player

@onready var ant1 = $ant1
@onready var ant2 = $ant2
@onready var ant3 = $ant3

@onready var score_label = $CanvasLayer/Label
@onready var win_label = $CanvasLayer/Label2

func _process(_delta):

	score_label.text = (
		"Player: " + str(player.lemons) + "\n" +
		"Ant1: " + str(ant1.lemons_collected) + "\n" +
		"Ant2: " + str(ant2.lemons_collected) + "\n" +
		"Ant3: " + str(ant3.lemons_collected)
	)

	win_label.visible = player.lemons >= 10


func _on_timer_timeout():

	var ants = [ant1, ant2, ant3]

	var random_ant = ants[randi() % ants.size()]

	if random_ant.visible:

		if random_ant.lemons_collected < random_ant.MAX_LEMONS:

			random_ant.lemons_collected += 1

			print("Semut mengumpulkan lemon: ",
				random_ant.lemons_collected)


func _on_area_2d_area_entered(area):

	if area.is_in_group("enemy1"):
		area.visible = false
		area.set_deferred("monitoring", false)
