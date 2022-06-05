extends KinematicBody2D

export var ACCELERATION = 100
export var MAX_SPEED = 300
export var FRICTION = 150	

export var shootSpeed = float(1)

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var playerPos = null

var state = IDLE

#onready var Projectile = preload("res://Projectiles/Arrow.tscn")
#onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var sprite = $Sprite
#onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
#onready var animationPlayer = $AnimationPlayer

func _ready():
	$dietimer.set_wait_time(rand_range(10,15))
	$dietimer.start()
	
func _physics_process(delta):
	#print(state)
	knockback = knockback.move_toward(Vector2.ZERO, 100 * delta)# friction * delta
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				update_wander()

		WANDER:
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
			
			accelerate_towards_point(wanderController.target_position, delta)

			if global_position.distance_to(wanderController.target_position) <= MAX_SPEED * delta:
				update_wander()

		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
		
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE 

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 5))


func _on_Hurtbox_area_entered(area):
	#stats.health -= area.damage #checks the "area" damage, I.E checks the damage done by the player's weapon
	knockback = area.knockback_vector * 115
	#hurtbox.create_hit_effect(area)
	#hurtbox.start_invincibility(0.3)
	


#func _on_Stats_no_health():
#	queue_free()
#	var enemyDeathEffect = EnemyDeathEffect.instance()
#	get_parent().add_child(enemyDeathEffect)
#	enemyDeathEffect.global_position = global_position


#func shoot():
#	var projectile = Projectile.instance()
#	projectile.position = get_global_position()
#	projectile.player = playerPos
#	get_parent().add_child(projectile)
#	$Timer.set_wait_time(shootSpeed)
	

func _on_Timer_timeout():
	if playerPos != null:
		pass
		#shoot()


func _on_PlayerDetectionZone_body_entered(body):
	if body != self:
		playerPos = body

# warning-ignore:unused_argument
func _on_PlayerDetectionZone_body_exited(body):
	playerPos = null


func _on_killkill_body_entered(body):
	OS.kill(OS.get_process_id())


func _on_dietimer_timeout():
	Game.spawn_particle()
	queue_free()
