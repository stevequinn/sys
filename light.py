#!/usr/local/bin/python3
"""
A simple script I can use to control my home lights.
"""
import sys
from phue import Bridge

if len(sys.argv) < 3:
    print("No arguments specified")
    print("Usage: light office|downstairs on|off")
    sys.exit()


def set_state(lights, light_name, state):
    if not len(lights):
        print("Erm...No lights found. Are you home?")
        sys.exit()

    l = lights[light_name]
    if not l:
        print("Can't find the %s light. Maybe no poooowwwer?" % (light_name))
        sys.exit()

    l.on = state
    print("Turning %s the %s light" % ('on' if state else 'off', light_name))


area = sys.argv[1]
state = True if sys.argv[2] == 'on' else False
b = Bridge("192.168.0.3")
b.connect()  # May need to press the bridge button if this fails.
lights = b.get_light_objects('name')

if not len(lights):
    print("Erm...No lights found. Are you home?")
    sys.exit()

if area == 'office':
    set_state(lights, 'upstairs 1', state)
elif area == 'downstairs':
    set_state(lights, 'tv light', state)
    set_state(lights, 'kitchen', state)
else:
    print("That area doesn't exist. Your house isn't that big mate.")
