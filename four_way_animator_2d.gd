extends AnimatedSprite2D

@export_group("Animation Settings")
@export var fps : float = 5.0

@export_group("Walk Animation Names")
@export var walk_left	: String = "walk_left"
@export var walk_right	: String = "walk_right"
@export var walk_up		: String = "walk_up"
@export var walk_down	: String = "walk_down"

@export_group("Idle Animation Names")
@export var idle_left	: String = "idle_left"
@export var idle_right	: String = "idle_right"
@export var idle_up		: String = "idle_up"
@export var idle_down	: String = "idle_down"

var current_anim : String = ""


func _ready() -> void:
	_check_frames()


func accept_direction(dir: Vector2):
	prints(self, "accepted directional input:", dir)
	if dir == Vector2.ZERO:
		prints(self, "processing direction vector of zero.")
		prints(self, "matching current animation:", current_anim)
		match current_anim:
			walk_left:
				_play_if_new(idle_left)
			walk_right:
				_play_if_new(idle_right)
			walk_up:
				_play_if_new(idle_up)
			walk_down:
				_play_if_new(idle_down)
	
	elif abs(dir.x) > abs(dir.y):
		if dir.x > 0.0:
			_play_if_new(walk_right)
		else:
			_play_if_new(walk_left)
	else:
		if dir.y > 0.0:
			_play_if_new(walk_down)
		else:
			_play_if_new(walk_up)


func has_animation(anim: String) -> bool:
	var frames = self.sprite_frames
	return frames != null and frames.has_animation(anim)


func _check_frames():
	if not has_animation(walk_left):
		push_error("FourWayAnimator2d does not have animation frames for walk_left: " + walk_left)
	if not has_animation(walk_right):
		push_error("FourWayAnimator2d does not have animation frames for walk_right: " + walk_right)
	if not has_animation(walk_up):
		push_error("FourWayAnimator2d does not have animation frames for walk_up: " + walk_up)
	if not has_animation(walk_down):
		push_error("FourWayAnimator2d does not have animation frames for walk_down: " + walk_down)
	
	if not has_animation(idle_left):
		push_error("FourWayAnimator2d does not have animation frames for idle_left: " + idle_left)
	if not has_animation(idle_right):
		push_error("FourWayAnimator2d does not have animation frames for idle_right: " + idle_right)
	if not has_animation(idle_up):
		push_error("FourWayAnimator2d does not have animation frames for idle_up: " + idle_up)
	if not has_animation(idle_down):
		push_error("FourWayAnimator2d does not have animation frames for idle_down: " + idle_down)


func _play_if_new(anim: String):
	if current_anim == anim:
		return
	prints(self, "setting new animation to:", anim)
	current_anim = anim
	prints(self, "confirming new current_anim:", current_anim)
	if self.sprite_frames.has_animation(anim):
		self.play(anim)
