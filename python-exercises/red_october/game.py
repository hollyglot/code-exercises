from sys import exit
from random import randint

class Scene(object):

    def enter(self):
        print "This scene is not yet configured. Subclass it and implement enter()."
        exit(1)


class Engine(object):

    def __init__(self, scene_map):
        self.scene_map = scene_map

    def play(self):
        current_scene = self.scene_map.opening_scene()
        last_scene = self.scene_map.next_scene('finished')

        while current_scene != last_scene:
            next_scene_name = current_scene.enter()
            current_scene = self.scene_map.next_scene(next_scene_name)

        # be sure to print out the last scene
        current_scene.enter()

class Death(Scene):

    quips = [
        "You died.  Now there will be World War III.",
        "You died. Oh, man...better luck next time maybe you'll be reincarnated as a mailman.",
        "You died. Tiny mice are playing tiny violins at your funeral.",
        "You died. My gerbil plays better than you."
    ]

    def enter(self):
        print Death.quips[randint(0, len(self.quips)-1)]
        exit(1)

class Helicoptor(Scene):

    def enter(self):
        print "You are Jack Ryan, famous CIA analyst"
        print "\n"
        print "Your mission is to board the Red October and discover Captain Ramius' intentions."
        print "\n"
        print "You are hovering above the USS Dallas submarine in a Seahawk helicoptor."
        print "\n"
        print "The sea is turbulent and the wind ferocious."
        print "The helicoptor cannot land in this weather."
        print "You only have 3 options. Do you dive, jump or curse?"

        action = raw_input("> ")

        if action == "jump!":
            print "You take a breath and then plunge into the sea."
            print "\n"
            print "A raft launches off of the USS Dallas."
            print "You climb aboard and the sailors safely navigate back to the submarine."
            print "\n"
            print "Once aboard you explain to Captain Manusco your theory about Captain Ramius requesting asylum."
            print "\n"
            print "He doesn't believe you right way, but finally you convince him."
            print "Captain Manusco, Petty Officer Jones and yourself navigate a rescue sub over to the Red October."
            print "You dock and climb into the Red October."
            return 'the_bridge'

        elif action == "dive!":
            print "You take a beautiful swan dive out of the helicoptor..."
            print "\n"
            print "What?? A great white appears out nowhere."
            print "You dive right into its mouth."
            print "\n"
            print "Too bad. Your mother didn't born you to be shark bait..."
            return 'death'

        elif action == "curse!":
            print "Today is not your lucky day."
            print "A freak gale force wind knocks into the helicoptor."
            print "It goes into a tail spin and crashes into the sea."
            print "Your life flashes before your eyes as you sink to the bottom."
            print "Why did you eat the kale salad last night instead of the steak??"
            return 'death'

        else:
            print "DOES NOT COMPUTE!"
            return 'helicoptor'

class Kitchen(Scene):

    def enter(self):
        print "You enter the kitchen."
        print "Food is still on plates. The men must have abandoned them when the alarm for the neuclear leak went off."
        print "The door at the other end of the kitchen slams shut."
        print "\n"
        print "You race across."
        print "The door is locked!"
        print "\n"
        print "You notice a 4-digit keypad on the wall."
        print "If you get the code wrong 10 times, then the lock closes forever and you can't get through.  The code is 3 digits."

        code = "%d%d%d" % (randint(1,4), randint(1,4), randint(1,4))
        guess = raw_input("[keypad]> ")
        guesses = 0
        print str(code)

        while guess != code and guesses < 10:
            print "BZZZZEDDD!"
            guesses += 1
            guess = raw_input("[keypad]> ")

        if guess == code:
            print "The doors buzzes and unlocks."
            print "You step through..."
            return 'missle_compartment'
        else:
            print "The lock buzzes one last time and then you hear a sickening"
            print "melting sound as the mechanism is fused together."
            print "\n"
            print "On the other side of the door in the missle compartment, the spy launches a missile...it jams and the whole submarine explodes."
            return 'death'

class TheBridge(Scene):

    def enter(self):
        print "You greet Captain Ramius. Suddenly, two shots are fired. Captain Ramius is wounded and Officer Vasily Borodin slowly bleeds to death. Do you panic, chase the culprit, or read the last rites to Officer Borodin?"

        action = raw_input("> ")

        if action == "panic":
            print "You have a panic attack. The room closes in on you. You can't breath. Why is the room so hot?"
            print "\n"
            print "The stress is too much for your heart. You have a heart attack."
            return 'death'

        elif action == "chase":
            print "You slowly creep down the hall. Checking every room for the suspect."
            print "\n"
            print "You hear a noise to your left; a shadow along the wall... You creep and enter the doorway to the left."
            return 'kitchen'
        elif action == "read the last rites":
            print "While you're busy playing priest, the spy launches a missile...it jams and the whole submarine explodes."
            return 'death'
        else:
            print "DOES NOT COMPUTE!"
            return "the_bridge"


class MissleCompartment(Scene):

    def enter(self):
        print "You are in the Missle Compartment."
        print "\n"
        print "You sneak behind some equipment and peek out...nothing moves..."
        print "\n"
        print "You creep to the stairwell and hide underneath...still no sounds or sights..."
        print "\n"
        print "Suddenly, shots are fired at you. You swiftly climb up the stairwell to the metal gangway."
        print "\n"
        print "You pace along the gangway."
        print "\n"
        print "You hear a noise to the left, but see a shadow on your right, do you investigate the shadow or the noise?"

        action = raw_input("> ")

        if action == "investigate shadow":
            print "You come upon the spy from behind."
            print "\n"
            print "He hears your footsteps and spins around."
            print "He shoots and misses."
            print "You fire off a shot. It pierces his coratid artery. He falls to the ground."
            return 'finished'

        elif action == "investigate noise":
            print "You step toward the noise."
            print "\n"
            print "You hear a sound behind and spin around. The spy has the drop on you. He laughs maniacally and caps one in your skull."
            return 'death'
        else:
            print "DOES NOT COMPUTE!"
            return "missle_compartment"


class Finished(Scene):

    def enter(self):
        print "You won! Jack Ryan has saved the day, once again! "
        return 'finished'

class Map(object):

    scenes = {
        'missle_compartment': MissleCompartment(),
        'kitchen': Kitchen(),
        'the_bridge': TheBridge(),
        'helicoptor': Helicoptor(),
        'death': Death(),
        'finished': Finished(),
    }

    def __init__(self, start_scene):
        self.start_scene = start_scene

    def next_scene(self, scene_name):
        val = Map.scenes.get(scene_name)
        return val

    def opening_scene(self):
        return self.next_scene(self.start_scene)

a_map = Map('helicoptor')
a_game = Engine(a_map)
a_game.play()
