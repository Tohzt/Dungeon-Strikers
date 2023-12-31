extends AnimationClass

func _update_anim(verb: String = ""):
	if verb == "":
		verb = Master.Anim.animation.rsplit("_")[0]
	
	var dir := "down"
	Master.animate_to(verb, dir)
