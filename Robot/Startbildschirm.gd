extends Control

#safes audiobus for later use in Volume slider
var master_bus = AudioServer.get_bus_index("Master")

# when Volume slider is changed -> changes master_bus audio db value to given value
func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)

	#if slider is at lowest: mute the bus entirely
	if value ==-30:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus,false)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


