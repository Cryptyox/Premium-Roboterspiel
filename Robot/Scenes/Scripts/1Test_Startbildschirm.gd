extends Control

#safes audiobus for later use in Volume slider
var master_bus = AudioServer.get_bus_index("Master")

# when Volume slider is changed -> changes master_bus audio db value to given value
func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)

	#if slider is at lowest: mute the bus entirely
	if value ==-30:
		AudioServer.set_bus_mute(master_bus,true)
	else:
		AudioServer.set_bus_mute(master_bus,false)

func _on_EffectSlider_value_changed(value):
	pass
	#AudioServer.set_bus_volume_db(master_bus, value)

	#if slider is at lowest: mute the bus entirely
	#if value ==-30:
		#AudioServer.set_bus_mute(master_bus,true)
	#else:
		#AudioServer.set_bus_mute(master_bus,false)
