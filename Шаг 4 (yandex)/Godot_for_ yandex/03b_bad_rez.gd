extends Control
var sec=3
func _ready():
	$AnimationPlayer.play("animate")

func _on_Button_button_up():
	$AudioStreamPlayer.play()
	Global.goto_scene("res://02_game.tscn")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	$Timer.start()


func _on_Timer_timeout():
	sec-=1
	$Show_ad_text.text="Реклама через: "+str(sec)
	if sec<=0:
		$Show_ad_text.visible=false
		Global.js_show_ad()
	else:
		$Timer.start()
	
	
