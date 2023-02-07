extends Node

# this script functions as the "main function" of the game and will be able to show all major
# game elements like the ui and the game itsself

func _ready():
	$UI/HomeScreen.show()
	

# create event handler with events such as
# open settings
# open world
# open menus over the world
# close menus

# events handled with signals

# each scene has to have a signal that
# closes itsself
# opens every other scene that it can open

# eg  home can close itsself and open wolrd+preGame and settings
# world will be integratet

func _on_openHome():
	$UI/HomeScreen.show()

func _on_closeHome():
	$UI/HomeScreen.hide()


func _on_openSets():
	$UI/SettingsScreen.show()
	
func _on_closeSets():
	$UI/SettingsScreen.hide()


func _on_openWorld():
	$World.show()
	
func _on_closeWorld():
	$World.hide()


func _on_openPre():
	$UI/PreGameScreen.show()

func _on_closePre():
	$UI/PreGameScreen.hide()


func _on_openPause():
	$UI/PauseScreen.show()
	
func _on_closePause():
	$UI/PauseScreen.hide()


func _on_openPost():
	$UI/AfterGameScreen.show()

func _on_closePost():
	$UI/AfterGameScreen.hide()
