extends Node2D

@export var button:PackedScene

@export var game_clear_text:Label

@onready var score_label:Label = $Score
var score = 0

var last_clicked_number = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# ゲームクリアテキストを非表示にする
	game_clear_text.hide()

	# ボタンを10個生成する
	for i in range(10):
		create_number_button(i)

# ボタンの生成
func create_number_button(button_index:int):
	var buttonNode = button.instantiate() as Button
	buttonNode.text = str(button_index + 1)
	add_child(buttonNode)
	
	var viewport_rect = get_viewport_rect()
	
		# ボタンのサイズをランダムに決める
	var random_size = randf_range(0.5,2)
	buttonNode.scale = Vector2(random_size,random_size)
	
	# ボタンの位置をランダムに決める
	var random_x = randf_range(viewport_rect.position.x,viewport_rect.size.x - buttonNode.size.x)
	var random_y = randf_range(viewport_rect.position.y,viewport_rect.size.y - buttonNode.size.y)
	buttonNode.position = Vector2(random_x,random_y)	

	# ボタンの色をランダムに決める
	var random_color = Color(randf(),randf(),randf(),1)
	buttonNode.modulate = random_color
	
	# ボタンを押したときのイベントを登録する
	buttonNode.pressed.connect(on_some_button_pressed.bind(buttonNode))


# ボタンをクリックしたときにイベント
func on_some_button_pressed(target_button:Button):
	print(target_button.text)
	
	score_label.text = "Score:" + str(score)
	
	var clicked_button_number = int(target_button.text)
	
	if last_clicked_number + 1 == clicked_button_number:
		score += 1
		last_clicked_number = clicked_button_number
		target_button.queue_free()
	else:
		score = 0
		
	score_label.text ="Score:" + str(score)
	
	if last_clicked_number == 10:
		game_clear_text.show()
