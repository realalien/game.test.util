

# 

#key: <Weapon>, value ( <Ammo>[], <Feature>[] )
ASSEMBLE_SPECIFICATION = {
         "Knife": ([], []),
         "Rifle": ([], [] ),
         # others 
         }                 


    

class Weapon():
    def __init__(self):
        self.range = 0 # in cm
        self.speed = 0
        self.sound = None
        self.direction = None
        self.category = None    # to diff cold / hot weapon
        self.inventory = []   # to keep several weapon
        self.can_use_ammo = False
        self.is_silencered = False
        
    def do_fire(self):
        self.fire()
        self.make_sound()
        self.calc_projectile()    
        
    def fire(self):
        raise "Abstract class, please use subclasses!"
    
    def make_sound(self):
        raise "Abstract class, please use subclasses!"

    def calc_projectile(self):
        raise "Abstract class, please use subclasses!"
    
class Knife(Weapon):

    def __init__(self):
        self.can_use_ammo = False 
        
    def fire(self):
        pass


class Rifle(Weapon):
    def __init__(self):
        self.can_use_ammo = False 
        
        
    def fire(self):
        # check ammo
        
        # 
        
    def make_sound(self):
        pass
    
    def calc_projectile(self):
        pass

class Crowbar(Weapon):
    pass
 
class Handgun(Weapon):
    pass


class Ammo:
    pass
 
class SoundDecorator:
    def __init__(self, decorated, weapon, ammo, can_use_silencer=False):   
        self.decorated = decorated 
        self.weapon = weapon
        self.ammo = ammo
        self.can_use_silencer = can_use_silencer  # e.g. silenser


    def get(self, weapon, ammo ): 
        
        
        