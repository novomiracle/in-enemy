extends Node2D

onready var lose_screen = load("res://scenes/lose_scene.tscn")
onready var theMap = load("res://scenes/mainScene.tscn")
onready var mainMenu = load("res://scenes/MainMenu.tscn")
onready var settingsScene =  load("res://scenes/Settings.tscn")
func switch_scene(scene):
	get_child(0).queue_free()
	add_child(scene)
	move_child(scene, 0)
func switch_to_lose_screen():
	switch_scene(lose_screen.instance())
func retry():
	switch_scene(theMap.instance())
func _ready():
	GameState.connect("switch",self,"switch")
func settings():
	switch_scene(settingsScene.instance())
func switch():
	GameState.theMonster.connect("died",self,"switch_to_lose_screen")
	GameState.reset()
func main_menu():
	switch_scene(mainMenu.instance())
