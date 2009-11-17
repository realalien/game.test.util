
# To try out the P4Ruby API
# * wrapping/opening existing class

      ####################### 
      # architecture of api #
      #######################

    #------------------------------
    #  DSL for Alice2 project     #
    #------------------------------
    #  P4Ruby API  # async fmwk   #
    #------------------------------

require 'P4'



class Changelist

   
  
  # SUG: introduce deferred objects, much like python twisted frameworks
  def test(&block)
      
  end
  
  
  # add new description context for the changelist,e.g. the changelist failed 
  # TODO: it looks quite difficult to update change spec by api, now we just 
  #       keep the info locally, e.g. database.
  def comment(username, msg)
    raise "unimplemented!"
  end

  def target(changenum, &blk)
    
  end

end

# Q: how to connect with P4 object.
class Workspace
  
  def 
  
  
end



if __FILE__ == $0
  
    # SUG: P4 cmd should be embedded into DSL! 
    p4account = P4.new()
    p4account.connect()
    
    workspace = Workspace.new(p4account) # use existing wksp or create new one
    
        # test out one changelist
    # NOTES: if the ruby obj is not reference by pointer, maybe we should embed the p4 account in Class Workspace 
    workspace.prepare() do  # arg: clean, update, create new one? 
      Changelist.target(11339) do # arg: accept specific task.  
        # update to specific changelist
        # run_editor()
        # Alice remote control
      end  
    end
    
    # figure out the one errored one from a set
    Workspace "Alice2July2009" do
      ChangelistDector.search() do
        # update src to each changelist
        # compile script
        # run_editor()
      end  
    end
    
    
    p4.disconnect()
    
end





# ==========================   demo code   ==========================
# template = "my-client-template"
#client_root = 'd:\Alice2Workspace2009July'
#p4 = P4.new
#p4.connect
#begin
## Run a "p4 client -t template -o" and convert it into a Ruby hash
#spec = p4.fetch_client( "-t", template )
## Now edit the fields in the form
#spec[ "Root" ] = client_root
#spec[ "Options" ] = spec[ "Options" ].sub( "normdir", "rmdir" )
## Now save the updated spec
#p4.save_client( spec )
## And sync it.
#p4.run_sync
#rescue P4Exception
## If any errors occur, we'll jump in here. Just log them
## and raise the exception up to the higher level
#p4.errors.each { |e| $stderr.puts( e ) }
#raise
#end
