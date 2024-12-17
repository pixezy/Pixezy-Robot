extends CanvasLayer

@onready var okbtn: Button = %Okbtn

func _ready() -> void:
	okbtn.pressed.connect(okbtn_on_pressed)
func okbtn_on_pressed()->void:
	self.hide() 
