extends Control
onready var panel=$Panel
onready var emit=$CPUParticles2D
onready var player=$AnimationPlayer
onready var label_true=$Panel/MarginContainer/VBoxContainer/Label2
onready var label_lifes=$Panel/MarginContainer/VBoxContainer/Label3
onready var label_score=$Panel/MarginContainer/VBoxContainer/Label4
onready var button_video=$Panel/MarginContainer/VBoxContainer/Button
var lt:int=0
var ll:int=0
var ls:int=0
var true_vopr:int
var local_score:int
var yandex_score:int
var local_is_auth:bool
func _ready():
	$AudioWin.play()
	emit.emitting=true
	player.play("animate")
	true_vopr=Global.score/10
	local_score=true_vopr*10+Global.lifes*20
	button_video.disabled=true
	Global.connect('is_auth',self,'_is_auth')
	Global.js_is_auth()
	Global.connect('get_lider',self,'_get_lider')
	

func _is_auth(value):
	if value==false:
		$Panel/MarginContainer/VBoxContainer/Button2.visible=true
		get_lider_no_auth()
	else:
		$Panel/MarginContainer/VBoxContainer/Button2.visible=false
		Global.js_get_score_lider('lider')
	local_is_auth=value
	#$Panel/MarginContainer/VBoxContainer/Label.text=str(local_is_auth)

func _get_lider(value):
	yandex_score=value
	$rating.text="Ваш рейтинг: "+str(value)

func get_lider_no_auth():
	$rating.text="Ваш рейтинг: "+str(Global.no_auth_score)

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
	if ls<local_score:
		$Timer2.start()
	else:
		button_video.disabled=false
		
func _on_Button3_button_up():
	Global.js_is_auth()
	$Timer_button.start()
	
func _on_Timer_button_timeout():
	$AudioStreamPlayer.play()
	if local_is_auth:
		Global.no_auth_score+=local_score
		yandex_score+=Global.no_auth_score
		Global.no_auth_score=0
		Global.js_set_score_lider('lider',yandex_score)
	else:
		Global.no_auth_score+=local_score
	Global.goto_scene("res://02_game.tscn")

	
func _on_Button_button_down():
	button_video.visible=false
	$Panel/MarginContainer/VBoxContainer/Control4.visible=true
	local_score*=2
	$Timer2.start()
	Global.js_show_rewarded_ad()

func _on_Button2_button_down():
	Global.js_auth()


