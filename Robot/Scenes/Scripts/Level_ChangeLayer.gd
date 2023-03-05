extends Area

var translationPossible = false

func _on_area_entered(area):
	translationPossible = true


func _on_area_exited(area):
	translationPossible = false
