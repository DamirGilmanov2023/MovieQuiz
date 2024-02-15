extends Control
onready var lbl1=$MarginContainer/VBoxContainer/GridContainer/Variant_1/Label
onready var lbl2=$MarginContainer/VBoxContainer/GridContainer/Variant_2/Label
onready var lbl3=$MarginContainer/VBoxContainer/GridContainer/Variant_3/Label
onready var lbl4=$MarginContainer/VBoxContainer/GridContainer/Variant_4/Label
onready var but1=$MarginContainer/VBoxContainer/GridContainer/Variant_1
onready var but2=$MarginContainer/VBoxContainer/GridContainer/Variant_2
onready var but3=$MarginContainer/VBoxContainer/GridContainer/Variant_3
onready var but4=$MarginContainer/VBoxContainer/GridContainer/Variant_4
onready var kadr=$MarginContainer/VBoxContainer/Kadr
onready var player_fade=$fade
onready var player_life=$life
var mass_but=[]
var mass_lbl=[]
onready var numQ=$MarginContainer/VBoxContainer/Zagl/HBoxContainer/NumQ
onready var score=$MarginContainer/VBoxContainer/Zagl/HBoxContainer/Score
var i_numQ=10

func heaght_button():
	but1.rect_min_size.y=55*lbl1.get_line_count()
	but2.rect_min_size.y=55*lbl2.get_line_count()
	but3.rect_min_size.y=55*lbl3.get_line_count()
	but4.rect_min_size.y=55*lbl4.get_line_count()

func shuffleList(list):
	var shuffledList = [] 
	var indexList = range(list.size())
	for i in range(list.size()):
		var x = randi()%indexList.size()
		shuffledList.append(list[indexList[x]])
		indexList.remove(x)
	return shuffledList

func set_values():
	for i in range(len(mass_but)):
		mass_but[i]["custom_styles/disabled"].bg_color = Color("#fafbb4")
		mass_lbl[i]["custom_colors/font_color"] = Color("#000000")
		mass_but[i].disabled=false
	randomize()
	var flag=true
	if len(Global.mass_stack)>=len(Global.slovar_data)-1:
		Global.mass_stack.clear()
	#Нахождение нового кадра
	while flag:
		Global.rand_vopr=randi()%822+1
		if Global.rand_vopr in Global.mass_stack:
			continue
		else:
			Global.mass_stack.append(Global.rand_vopr)
			kadr.texture=ResourceLoader.load("res://img/"+str(Global.rand_vopr)+".jpg")
			flag=false
	#Создание вариантов
	flag=true
	var mass_variant=[]
	mass_variant.append(Global.slovar_data[Global.rand_vopr])
	var r
	while flag:
		r=randi()%822+1
		if Global.slovar_data[r] in mass_variant:
			continue
		else:
			mass_variant.append(Global.slovar_data[r])
		if len(mass_variant)==4:
			flag=false
	mass_variant=shuffleList(mass_variant)
	lbl1.text=mass_variant[0]
	lbl2.text=mass_variant[1]
	lbl3.text=mass_variant[2]
	lbl4.text=mass_variant[3]
	heaght_button()

func _ready():
	mass_but.append(but1)
	mass_but.append(but2)
	mass_but.append(but3)
	mass_but.append(but4)
	mass_lbl.append(lbl1)
	mass_lbl.append(lbl2)
	mass_lbl.append(lbl3)
	mass_lbl.append(lbl4)
	set_values()
	$MarginContainer/VBoxContainer/HBoxContainer/life3.modulate=Color(1,1,1,1)
	$MarginContainer/VBoxContainer/HBoxContainer/life2.modulate=Color(1,1,1,1)
	$MarginContainer/VBoxContainer/HBoxContainer/life1.modulate=Color(1,1,1,1)
	Global.lifes=3
	Global.score=0
	numQ.text="Осталось вопросов: "+str(i_numQ)
	score.text="Очки: "+str(Global.score)

func show_rezult(rez,but):
	i_numQ-=1
	if rez==true:
		Global.score+=10
		$l_score.text="+10"
		player_life.play("animate_score")
		for i in range(len(mass_but)):
			if i==but:
				mass_but[i]["custom_styles/disabled"].bg_color = Color("#03d376")
				mass_lbl[i]["custom_colors/font_color"] = Color("#ffffff")
			else:
				mass_but[i]["custom_styles/disabled"].bg_color = Color("#dbdbda")
				mass_lbl[i]["custom_colors/font_color"] = Color("#9a9996")
			mass_but[i].disabled=true
	else:
		Global.lifes-=1
		update_lifes(Global.lifes)
		for i in range(len(mass_but)):
			if i==but:
				mass_but[i]["custom_styles/disabled"].bg_color = Color("#f66151")
				mass_lbl[i]["custom_colors/font_color"] = Color("#ffffff")
			else:
				mass_but[i]["custom_styles/disabled"].bg_color = Color("#dbdbda")
				mass_lbl[i]["custom_colors/font_color"] = Color("#9a9996")
			mass_but[i].disabled=true
	$show_rezult_delay.start()

func update_lifes(l):
	if l==2:
		$l_life1.text='-1'
		player_life.play("animate_life_1")
	elif l==1:
		$l_life2.text='-1'
		player_life.play("animate_life_2")
	elif l==0:
		$l_life3.text='-1'
		player_life.play("animate_life_3")

func _on_Variant_1_button_up():
	if lbl1.text==Global.slovar_data[Global.rand_vopr]:
		show_rezult(true,0)
	else:
		show_rezult(false,0)

func _on_Variant_2_button_up():
	if lbl2.text==Global.slovar_data[Global.rand_vopr]:
		show_rezult(true,1)
	else:
		show_rezult(false,1)

func _on_Variant_3_button_up():
	if lbl3.text==Global.slovar_data[Global.rand_vopr]:
		show_rezult(true,2)
	else:
		show_rezult(false,2)

func _on_Variant_4_button_up():
	if lbl4.text==Global.slovar_data[Global.rand_vopr]:
		show_rezult(true,3)
	else:
		show_rezult(false,3)

func _on_show_rezult_delay_timeout():
	if i_numQ==0:
		Global.goto_scene("res://03a_good_rez.tscn")
	if Global.lifes>0:
		player_fade.play("animate")

func _on_fade_animation_finished(anim_name):
	numQ.text="Осталось вопросов: "+str(i_numQ)
	if anim_name=="animate":
		set_values()
		player_fade.play("animate2")

func _on_life_animation_finished(anim_name):
	if anim_name=="animate_life_3":
		Global.goto_scene("res://03b_bad_rez.tscn")
	elif anim_name=="animate_score":
		score.text="Очки: "+str(Global.score)
