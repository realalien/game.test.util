
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

namespace BatchFileExec do
  
end





class Changelist
  
  attr_accessor :p4client  # setting and guide all ops, maybe deprecated, depend on p4 class instance
  attr_accessor :p4       # p4 connection and its API
  # SUG: introduce deferred objects, much like python twisted frameworks
  def test(&block)
    # TODO: call other method in the target client root directory 
  end
  
  # Q: call open-loop batch files or model after python deferred framework? TODO
  def try(&blk)
    
  end
  
  # trial and error
  def trial_changelist(chgnum, &blk)
    begin
      #p4a = P4Account.new("192.168.6.50:1666")
      #p4a.create_account("temp2","temp2@spicyhorse.com", "Temp2 for Test")
    rescue
      # If any errors occur, we'll jump in here. Just log them
      # and raise the exception up to the higher level
      
      p4.errors.each { |e| $stderr.puts( e ) }
      raise
    end
  end
  
  # add new description context for the changelist,e.g.the changelist failed 
  # TODO: it looks quite difficult to update change spec by api, now we just 
  #       keep the info locally, eg database
  def comment(username, msg)
    raise "unimplemented!"
  end
  
  # with logic of updating.
  def target(changenum)
    @p4.run_sync("@#{changenum}")
  end
  
  def initialize()
    @p4 = P4.new
    # load default p4 env. which is not suggested.
    @p4.connect unless @p4.connected?
    @p4client = p4.fetch_client()
    # TODO: other procedure
  end
  
  # assign p4 info
  def feed(cli_opt={})
    #TODO: test out feasibility
    @p4client._options = cli_opt[:options] || @p4client._options
    @p4client._owner = cli_opt[:owner] || @p4client._owner
    @p4client._root = cli_opt[:root] || @p4client._root
    @p4client._description = cli_opt[:description] || @p4client._description
    @p4.save_client(@p4client)
    
    puts @p4client
    puts @p4.cwd = @p4client._root
    puts "--------------"
    # access, update info
    # TODO: feedback and exception handling
    return self
  end
  
  
  
end

# Q: how to connect with P4 object
class Workspace
  
  
  
  
end

# wrapping the p4 user related task
class P4Account
  
  attr_accessor :p4agent # just a existing valid user 
  
  # to be useful, must have a working account, otherwise ops won't possible
  def initialize(p4port)
    @p4agent = P4.new
    @p4agent.port = p4port
  end
  
  
  def create_account(name, email, fullname=None)
    raise "Unimplemented"
    spec = @p4.run("user","-o")
    spec[0]["User"] = name
    spec[0]["Email"] = email
    spec[0]["FullName"] = fullname
    # @p4.run_user("-i", spec)
  end
  
  
end



# SUG: P4 cmd should be embedded into DSL! 
#    p4account = P4.new()
#    p4account.connect()
#    
#    workspace = Workspace.new(p4account) # use existing wksp or create new one
# 
#    
#    ------------------------------- client code -----------------------------
#    # to     
#        # test out one changelist
#    # NOTES: if the ruby obj is not reference by pointer, maybe we should embed the p4 account in Class Workspace 
#    workspace.prepare() do  # arg: clean, update, create new one? 
#      Changelist.target(11339) do # arg: accept specific task  
#        # update to specific changelist
#        # run_editor()
#        # Alice remote control
#      end  
#    end
#    
#    # figure out the one errored one from a set
#    Workspace "Alice2July2009" do
#      ChangelistDector.search() do
#        # update src to each changelist
#        # compile script
#        # run_editor()
#      end  
#    end
#    

#    p4.disconnect()




if __FILE__ == $0
  #     p4 = P4.new
  #      p4.user = "Admin"
  #      p4.client = "for.p4dti.test.env"
  #      p4.port = "192.168.6.50:1666"
  #      p4.connect
  #      puts(p4.client)
  #      puts("--------")
  #      p4.run_sync("@#{chgnum}")
  #      puts("--------sync done")
  #      client = p4.fetch_client()
  #      puts(client._Client)
  #      
  #      client._root = "D:/sandbox/zzz"
  #      client._description = "client for temp testing, workspace is volatile"
  #      p4.save_client(client)
  #      puts(client._Client)
  #      p4.run_sync("@1")
  #      
  #
  chg = Changelist.new
  
  temp_dir = "D:/sandbox/zzzz"
  chg.feed({:owner => "Admin", 
                :root => temp_dir, 
                :description => "temp client for testing, volatile workspace "})\
  .target(1) \
  .try do 
    # Alice manipulations. 
    
    # easy assertion clauses
  end
  
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
## And sync it
#p4.run_sync
#rescue P4Exception
## If any errors occur, we'll jump in here Just log them
## and raise the exception up to the higher level
#p4.errors.each { |e| $stderr.puts( e ) }
#raise
#end