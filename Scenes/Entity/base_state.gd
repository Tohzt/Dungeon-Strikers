class_name base_state
extends Node

var Master: CharacterBody2D
var Current
var States

func init(master, states, current):
	Master = master
	Current = current
	States = states
	init_state()

func init_state():
	print_debug("init_state is not set")
func exit_state(): 
	print_debug("exit_state is not set")
func update_master():
	print_debug("update_state is not set")



