extends Control
onready var panel=$Panel
onready var emit=$CPUParticles2D
onready var player=$AnimationPlayer
onready var label_true=$Panel/MarginContainer/VBoxContainer/Label2
onready var label_lifes=$Panel/MarginContainer/VBoxContainer/Label3
onready var label_score=$Panel/MarginContainer/VBoxContainer/Label4
var lt:int=0
var ll:int=0
var ls:int=0
var true_vopr:int
func _ready():
	emit.emitting=true
	player.play("animate")
	true_vopr=Global.score/10
func _on_AnimationPlayer_animation_finished(anim_name):
	$Timer.start()
	$Timer2.start()
func _on_Timer_timeout():
	if lt<true_vopr:
		lt+=1
		label_true.text="Правильные ответы: "+str(lt)
		$Timer.start()
	else:
		if ll<Global.lifes:
			ll+=1
			label_lifes.text="Сохранено жизней: "+str(ll)
			$Timer.start()
func _on_Timer2_timeout():
	ls+=1
	label_score.text="Очки: "+str(ls)
	if ls<true_vopr*10+Global.lifes*20:
		$Timer2.start()
func _on_Button3_button_up():
	Global.goto_scene("res://02_game.tscn")
