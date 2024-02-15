extends Control

func _ready():
	Global.js_show_ad()

func _on_Button_button_down():
	$AudioStreamPlayer.play()
	Global.goto_scene("res://02_game.tscn")
