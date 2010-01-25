## Dice game from Game programming test 1-2

#maintainer:    realalien@gmail.com

# INFO: the number of objects are intentionally designed to be large. 
# TODO: game logic not in class
# TODO: weak game interface.

import random
import sys
import time
import unittest
# ATTENTION: double means two dices have equal value, not mean 'even'!


MAX_FACETS = 6
FACET_MAX_VALUE = 6
WINNING_AVERAGE = 70  # percentage value (0~100)

class Die:
    """assume dice with 6 facets!"""
    def __init__(self, cheat=False):
        self.value = None
        self.cheat = False

    def roll(self, num=FACET_MAX_VALUE):
        value = 0
        if self.cheat == True:
            self.value = num
        else:
            self.value = random.randint(1,MAX_FACETS)  #TODO: ensure winning average here?  #See example: http://docs.python.org/library/random.html 
        return self
    
    def cheat_roll(self, val):
        self.value = val  #TODO: ensure winning average here?  #See example: http://docs.python.org/library/random.html 
        return self
        
    def __cmp__(self, other):
        if self.value > other.value:
            return 1
        elif self.value == other.value:
            return 0
        else:
            return -1
    
    def __repr__(self):
        return str(self.value)
    
class TwoDicesInBundle:
    
    def __init__(self):
        self.num_of_dice = 2
        self.dice = []
        self.has_double_value = False
        
    def roll(self):
        for i in range(1, self.num_of_dice + 1): # Python range exclusiveness
            self.dice.append(Die().roll())
        self.pre_calc()
        return self
    
    # used for unit test
    def mocking_roll(self, d1v, d2v):
        d1 = Die(cheat=True).cheat_roll(d1v)
        d2 = Die(cheat=True).cheat_roll(d2v)
        self.dice.append(d1)
        self.dice.append(d2)
        self.pre_calc()
        return self 
    
    def pre_calc(self):
        if self.dice[0] == self.dice[1]:
            self.has_double_value = True 
    
    def num_of_double(self):
        cnt = 0
        for d in self.dice:
            if d.value % 2 == 0:
                cnt = cnt + 1
        return cnt    
        
    def has_double(self):
        return self.has_double_value   # ATTENTION:why in Eclipse 'method rename' refactor causes instance variable change?
            
    def has_not_double(self):    
        return not self.has_double()
    
    def total(self):
        return self.dice[0] + self.dice[1]
    
    def _has_double_of_bigger_value(self, other):
        #TODO: safe here? shall not be expose
        return cmp(self.dice[0] , other.dice[0])
        
    def __cmp__(self,other):
        """logic here! TODO: unit test to verify!"""  
        
        
        # wins(return value:1) the round that gets a double (or higher double if both get doubles)
        if self.has_double()  and other.has_not_double():
            return 1
        elif self.has_not_double() and  other.has_double():
            return -1
        elif self.has_double()  and other.has_double(): # both has double
            return self._has_double_of_bigger_value(other)
        else:   # neither has double, with the highest number on a die wins
            return cmp( max(self.dice[0], self.dice[1]),  max(other.dice[0], other.dice[1]))
              
    def __repr__(self):
        out = "Dice 1 ... [ %s ], Dice 2 ... [ %s ]." % ( str(self.dice[0]) , str(self.dice[1])  )
        return out
        
def dice_rolling():
    for i in range(1, 7):  # TODO: write same output buffer, 3s rolling looks like no cheating!
        time.sleep(0.5) # I shall have learnt embedded system well at school.
        print(".")
        
def user_input():
    var = raw_input("Press any key to start a new game(type 'q' to quit the game): ")
    if var.strip() != None and var.strip() == "q":
        return False
    else:
        return True

# TODO: test not fully implemented
class TwoDiceInBundleTest(unittest.TestCase):

    def setUp(self):
        pass
        
    def test_equality(self):
        
        p1 = TwoDicesInBundle().mocking_roll( 1, 0)
        p2 = TwoDicesInBundle().mocking_roll( 1, 1)
        self.assertTrue(p1 < p2 , "Player has double number shall win out" )
        
        p1 = TwoDicesInBundle().mocking_roll( 3, 3)
        p2 = TwoDicesInBundle().mocking_roll( 4, 4)
        self.assertTrue(p1 < p2 , "Player has double number shall win" )
        
        # both have double
        p1 = TwoDicesInBundle().mocking_roll( 1, 1)
        p2 = TwoDicesInBundle().mocking_roll( 1, 1)
        self.assertTrue(p1 == p2 , "Players should equal with same number" )
        
        # either has double
        p1 = TwoDicesInBundle().mocking_roll( 1, 3)
        p2 = TwoDicesInBundle().mocking_roll( 4, 1)
        self.assertTrue(p1 < p2 , "If either has double, Players win with the highest number on a die " )

    def test_winning_coverage(self):
        
        pass
        # assertTrue()
        
        
        
if __name__ == '__main__':
    # Must pass the test to ensure happiness of human player
    unittest.main()
    
    # ===============  game logic   ================
    
    # audit, can be used as 
    total_match = 0
    pc_win = 0
    
    
    # flip between 1 and -1
    pc_turn = 1   
    human_turn =  pc_turn * (-1) 
    who_first = pc_turn  #be friendly, at least superficially TODO: allow user to change who rolls dice first!
    
    while(user_input()):
        winner = None
        total_match = total_match + 1
        # roll dice twice, use random[] to assign the bigger one to the computer, 
        # TODO: I do not know if it's ok! 
        a = TwoDicesInBundle().roll()
        b = TwoDicesInBundle().roll()        
        pc_player = None
        human = None
        win = None
        lose = None
        
        # assign the value of two dice
        if cmp(a,b) > 0:
            win = a; lose = b
        elif cmp(a,b) < 0:
            win = b; lose = a
        else:
            win = None; lose = None

        # decide who win
        god = random.random()
        if ( god*100 ) < WINNING_AVERAGE:   # TODO: "<" looks confusing, wrapping with a method
            pc_player = win ; human = lose 
            winner = pc_player
        else:
            pc_player = lose ; human = win
            winner = human
       
        # Interaction
        if who_first == pc_turn : 
            dice_rolling()
            print("PC player: ")
            print(pc_player)
            time.sleep(2)
            print("Human player: ")
            raw_input("Press any key to roll the two dice: ")
            dice_rolling()
            print(human)
        else: #human_turn
            print("Human player: ")
            raw_input("Press any key to roll the two dice: ")
            dice_rolling()
            print(human)
            time.sleep(2)
            print("PC player: ")
            dice_rolling()            
            print(pc_player)
        
        # print result and  change turn
        result = None
        if winnner == None: result = "No winner! "
        elif winner == pc_player: result="PC player won, you lose!" ; 
        else: result= "You won!" ;
        print(result)
        who_first = who_first * (-1)
        
                
    # TODO: test winning average
    # record to test the winning average
    if total_match != 0:
        print("Total_matches:   %s"  %   str(total_match) )      
        print("PC_win:   %s"  %   str(pc_win) )  
        print("PC_win ratio:   %s"  %   str(pc_win/total_match) )
    else:
        print("No match!")

