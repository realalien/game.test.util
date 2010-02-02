
# Purpose:
# * as a part of game testing framework, to cut the time and energy short
#   by automating the steps involved with less human intervention.




#locate the window block volume error:

#info: yesterday's and today's   => range(10562...10681)

# codify prereq.: tree search, ruby block, callback



# pseudo
# how to improve code efficiency by 
#  * auto put args into sorted seq. avoid checking and allow casual input
#  * wheter an arry or several args Q: can I use *args substitue array, then 

# Notes
# * no matter stategy used, all put the time saving in top priority.
# * class to find out the changelist which may have potential bugs that has been 
#   found in game play
# * for the moment, it is assumed that for a set of changelists, 
#   either all the changelists are not correct(thus no need to find the potential bugged change)
#   or changelist turned from right to wrong(thus to find the first wrong one).
# * it would be better to distribute the work like next range tests to other machines.

class ChangelistDetector

    attr_accessor :changelists  # the sequenced changelists need to trace
    
    attr_accessor :search_history  # record the search path, backend for reporting, maybe shared among methods.
    
    attr_accessor :neglect_boundaries  # usually the client of the program knows for sure that the beginning is right changelist and 
    
    FAKED_CHANGELISTS = { 0 => true, 1 => true, 2=> true , 3 => true, 4 =>true, 5=>false, 6=>false, 7=>false }
    
    def initialize()
        changelists = [] # assumably the list should be in ascending order
    end
    
    def ensure_rules()
        
    end
    
    
    # TODO: more logic here! e.g. quick guess, runtime input, maybe in block
    # NOTE:
    # * do the minimum work except the dependent ones.
    def search(head=nil, tail=nil )
        head = 0 unless head # maybe backwards 200 changelists (or of yesterday's qa approved changelist.)
        # tail = changelist.size() - 1
        tail = 4 unless tail
        mid = nil
        # TODO: ensure the head is ok and tail is not ok, thus search is meaningful!
        while !( (mid == head) or (mid == tail) ) 
            mid = ((head + tail ) / 2 ).round()
            puts "-----------------"
            puts "ready to search, head:#{head} mid:#{mid} tail:#{tail}  ..."
            # ok = try_this_changelist(changelists[mid])
            ok = try_this_changelist(mid)
            puts "deteck ok? .... #{ok}"
            # log it
            if ok
                head = mid
            else
                tail = mid
            end
            mid = ((head + tail ) / 2 ).round()
            puts "ranged changed to, head:#{head} mid:#{mid} tail:#{tail}  ..."
        end

        culprit = nil
        
        # TODO: just guess, not maths-proven
        if mid == head
            print "error found: index is #{tail}"  
            culprit = tail
        elsif mid == tail
            print "error found: index is #{head + 1}"   
            culprit = head + 1
        else
            raise "Interrupted, not go down enough"
        end
        
        return culprit
    end
    
    # * shall I delegate to the class Changelist? 
    # * to check the 'customized build steps' results, usually for one bug, 
    #   the steps involving detecting are the same.
    def try_this_changelist(changelist)
        # yield changelist
        return FAKED_CHANGELISTS[changelist]
    end
    
    # customized iterator, Q: how to unit test
    def each_mid(&block)
        
    end
    
    #alias each_mid dichotomy_search
    
end  # of class ChangelistDetector


def locate_error_with_block(range, &block)
    starter.status = OK
    Stopper.status = Ok

    middler = Object.new # all 

    # watch to count the time

    # preempt(elaminate or give warnings or impl. stategies) for any long-duration ops, 
    # like "common.usf" change(shader rebuilding)
    

    #while  (cont?)
        
     
       # binary tree search, how to test out efficiency? maths? turing test?
        # 10623 (delegate 10621,missing) ... error
#       10607 error
#           10603 erro 
#           10602 error 
#           10601  ok
#           10599  ok
#           10592     OK
    #esp. human intervention, check! 

        # DO A QUICK GUESS e.g. and repick old if wrong
        # RECEIVE new info to added more check constraints 
        
        # REQ: runtime state change if the executing last long.
    #end
end

def locate_error( starting ,ending, changes)
    # first init. & avoid seq. req.
    if starting > ending
        start = ending
        ends = starting
    else 
        start = starting
        ends = ending
    end
    # ensure "start is ok and end is error"
    #ensure_start_and_end()
    
        
    #while (start !=   )
end

class Changelist
    attr_accessor :id
    attr_accessor :is_valid
    
    def initialize(id, valid)
        @id = id
        @is_valid = valid
    end
end

# NOTE: such method is not easy for unit test! But it's quick!
if __FILE__ == $0
    
    # TODO: accept multiple convention of inputs, like 
    # * "cmd 101 142", 
    # * "cmd 101...142"
    # * no input, but to ask for
    
    # unit test case
    cls = []
    
    (1...6).each do | i |
        cls << Changelist.new(i, true)
    end
    (6...11).each do | i |
        cls << Changelist.new(i, false)
    end
    
    cls.each do | chg |
        puts "Change #{chg.id} ... is #{chg.is_valid} ;"
    end
    
    puts "---------------------------"
    #puts "Supposing that OK -> Error detection mode"
    # judgement depends on the selected range.
    #locate_error(1, 7, cls)
    
    
    # Q: how to embed the detector into a context 
    detector = ChangelistDetector.new()
   
    detector.search(1, 10)   # a list or a range?
       
    # program by intention now

    # attrs setting
    # detector.start_from_last_nightly_build()   # diagram to a time line
    # detector.ensure_boundaries()               # 
    
    # runtime modification
# ------------- client code e.g. 1 -----------------
#    #  sanity checking
#    detector.each_mid  do | mid |
#        mid.comment_check    # see if the changelist has already been detected for having potential bugs, which admin may have commented on.
#        mid.sanity_check     #  see if +/-10 changelists has someone to override the changelist, by whom may submit a missing file
#        mid.quick_and_dirty  # any short cut methods.
#    end
# --------------------------------------------------
    
    
# ------------- client code e.g. 2 -----------------
#   #SUG: maybe this code is for online 
#   detector.search() do
#       # receive env. change.
#   end

# --------------------------------------------------


# ------------- client code e.g. 3 -----------------
#   #SUG: the code is to demonstrate the abstraction of code/design 
#   detector.search(AI_level=5, ) do
        # API level means how intelligent the detector should be,
        # e.g. AI_5, incorporate logic like guess, context sensitive.

#       # receive env. change.
#   end

# --------------------------------------------------


#    detector.search() do
#        # Q: search is above or parallel to other methods? 
#            
#    end
    
#    if ARGV.size < 2
#        puts "at least two number for detecting range, start and end"
#    elsif ARGV.size > 2
#        puts " arguments after the 2nd one will be discarded.[#{ARGV[2, ARGV.size-2]}]"
#    elsif !( ARGV[0].is_a?(Integer) and  ARGV[0].is_a?(Integer) )
#        puts "Arguments must be an integer"
#    else
##        locate_error(ARGV[0], ARGV[1]) do
##            
##        end
#    end
    
    
end

# TODO: generate methodologies used from code parsing, like program by intention from Eclipse's IDE history,




# 2010.2.1
#  Make an analogy of action game, see http://aigamedev.com/open/articles/structure-action-game-ai/
#  quote
#  "In a nutshell, the structure is as follows: the game world is build of tiny fragments 
#   of locations called contexts, the AI can perform actions and reactions within these 
#    contexts; the actions are active things that AI can do and the reactions are actions 
#    which respond to player actions or events in the game world; the contexts can be 
#    grouped into settings where the AI are behaving according to a goal; the goal is 
#    basically the driving force for all AI actions, and these goals can be grouped into a 
#    scene which describes how the goals change according to events in the game world; and 
#    finally a scene defines a whole section of a game level.

# Context:
# This class should know about info from perforce server in the name of changelist collecting
# also, define the boundaries of action and reaction, e.g. upbound, lowbound
# maybe utilize/incorporate other info so that make the context of transparent. 
# AI Action:
# * search (dichotomy)
# * guess (blamer, programmers or LDs)
# * carried predefined steps (untested changelist) and keep recording
# * 
# Human Player action:
# * unscriptable scene play, to figure out if the game goes wrong
# * add more context info to the AI, the detector
# * 
# Goal:
# * find the changelist as fast as possible.

# Questions to solve:
# *  he contexts and actions should make both the designers and programmers aware of 
#    all the possible events you need to handle.


class Context
  

end



#  ===============    DEV LOG   =================

# 2010.2.1   
#  *  There is a tendency that chasing a changelist may be like chasing an enemy,
#     thus incorporating the AI algorithm is quite appealing, but the cost is high
#     for me.
#  *  The code structure is not very clear even though there listing 3 demo client
#     code for api use example, but is not clear how to utilize AI logic at runtime
#     and dynamic context sensing.
#      READ: http://aigamedev.com/open/articles/structure-action-game-ai/
#      TODO(delay): context implementation    
#   * ESP: since there is no good ruby replacement for python twisted async processing,
#      also because rewriting the buildbot step in ruby takes more time without verifying,
#      it maybe more realistic to get the code on existing code of buildbot, Twisted, Zope
#      with the example code of Buildbot
#      the benefits are
#        >> multiple slaves for testing out potential part of changelists in cut time short
#        >> reuse the existing steps 
#      on the wishlist:
#        >> dynamic status change
