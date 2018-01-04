$: << "plugins/RubyBukkit/lib/"
require "yaml"
require "pstore"
require "pp"
require "fileutils"

import 'org.bukkit.event.Event'
import 'com.nijiko.permissions.PermissionHandler'
import "org.bukkit.inventory.ItemStack"

Plugin.is {
    name "RQuest"
    version "0.1"
    author "Joshua Harding"
    commands :rquest => {
    	    :rquest => "/rquest - interface to rquest"
    }
}

class RQuestStore
	def initialize
		@store = PStore.new("plugins/RQuest/rquest.pstore")
		# @store.ultra_safe = true
	end
	
	# return true if the player is in a quest
	def in_quest?(player_name)
		@store.transaction(true) do
			return @store[player_name] && @store[player_name].current_quest_id	
		end
	end
	
	def quest_done(player_name)
		pd = lookup(player_name)
		pd.current_quest_id = nil
		update(pd)
	end
	
	# process a player starting a quest
	def start_quest(player_name, quest_id)
		pd = lookup(player_name)
		pd.current_quest_id = quest_id
		update(pd)
	end
	
	# returns the current quest_id of the player
	def current_quest(player_name)
		return lookup(player_name).current_quest_id	
	end
	
	private 
	
	# save the player data to the database
	def update(player_data)
		@store.transaction do
			@store[player_data.player_name] = player_data	
		end
	end
	
	# lookup a player and create a record if we don't exist...
	def lookup(player_name)
		@store.transaction do
			@store[player_name] = RQuestPlayerData.new unless @store[player_name]
			@store[player_name].player_name = player_name
			return @store[player_name]
		end
	end
end

class RQuestPlayerData
	attr_accessor :player_name, :current_quest_id, :num_completed_quests
end

class RQuestChecker
	class << self
		# check the player (this is an entity)
		# against the quest...
		def check(player, quest)
			inventory = player.getInventory
			# okay, quest is a hash with :required
			# iterate over required and see if the inventory contains 
			# what we need...
			quest[:required].each do |req_hash|
				puts "We require #{req_hash.inspect}"	
				# inventory has contains(material_id, amount)
				unless inventory.contains(req_hash[:id], req_hash[:quantity])
					return false
				end
			end
			return true	
		end
	end
end

class RQuest < RubyPlugin
    def onEnable
        puts "Enabling rQuest..."
        @quest_store = RQuestStore.new 
        # first step, load config file...
        unless File.exist?("plugins/RQuest")
        	FileUtils.mkdir("plugins/RQuest")
        	File.open("plugins/RQuest/config.yaml", "w") do |f|
        		f.puts("# CONFIG FOR RQUEST")
        	end
        end
        @quest_data = YAML.load(IO.read("plugins/RQuest/config.yaml"))
        # STDERR.puts @quest_data.inspect
        register_events
    end
    
    def onEvent(event)
    	    # puts "WE GOT AN EVENT: #{event.inspect}"
    end
    
    def register_events
    	    # puts "REGISTERING EVENTS!!"
    	    
    	    #registerEvent(Event::Type::PLAYER_PICKUP_ITEM, Event::Priority::Normal) do |pickup_event|
    	    #	    player = pickup_event.getPlayer    
    	    #	    item_stack = pickup_event.getItem.getItemStack
    	    #	    material = item_stack.getType
    	    #	    amount = item_stack.getAmount
    	    #	    inventory = player.getInventory
    	    #	    puts "#{player.getName} picked up #{amount} #{material}"
    	    #	    # check the inventory
    	    #	    inventory.getContents.each do |item_stack|
    	    #	    	   # puts "item_stack: #{item_stack.inspect}"    
    	    #	    end
    	    #end
    	    
    	    registerEvent(Event::Type::PLAYER_LOGIN, Event::Priority::Normal) do |loginEvent|
    	    	    player = loginEvent.getPlayer    
    	    	    puts "#{player.inspect} just logged in!!"
    	    end
    	    
    	    # register the plugin on enable and disable...
    	    registerEvent(Event::Type::PLUGIN_ENABLE, Event::Priority::Normal) do |enable_event|
    	    	    unless @iconomy
    	    	    	    plugin = getServer().getPluginManager().getPlugin("iConomy")
    	    	    	    if plugin
    	    	    	    	    if plugin.isEnabled && plugin.getClass().getName() == "com.iConomy.iConomy"
    	    	    	    	    	    puts "iConomy has been hooked!"
    	    	    	    	    	    puts "the class is: #{plugin.getClass.getName}"
    	    	    	    	    	    @iconomy = plugin
    	    	    	    	    end
    	    	    	    end
    	    	    end
    	    end
    	    
    	    registerEvent(Event::Type::PLUGIN_DISABLE, Event::Priority::Normal) do |disable_event|
    	    	    puts "Plugins are being disabled!"    	    	    
    	    end
    	    
    end
    
    def onCommand(sender, command, label, args)
       	    player_name = sender.getName
       	    # puts "working with #{player_name}"
    	    # see what command we are trying
    	    args = args.to_a
    	    # handle no arguments...
    	    if args.length == 0
    	    	    if sender.isPlayer then
    	    	    	    sender.sendMessage "RQuest: /rquest give, /rquest done, /rquest info, /rquest drop"
    	    	    	    return
       	    	    end
    	    end
    	    
    	    if args[0].casecmp("info") == 0
    	    	    show_quest(sender)
    	    	    return true
    	    end
    	    
    	    if args[0].casecmp("drop") == 0
    	    	    unless @quest_store.in_quest?(player_name)
    	    	    	    sender.sendMessage("You can't drop a quest... you don't have one!")
    	    	    	    return true
    	    	    end
    	    	    # now, grab our current quest...
    	    	    quest = quest(@quest_store.current_quest(player_name))
    	    	    # ok, figure out the reward and subtract double from our balance...
    	    	    balance = com::iConomy::iConomy.getAccount(player_name).getHoldings
    	    	    amount_to_subtract = quest[:reward] * 2
    	    	    	    
    	    	    	    
    	    	    balance.subtract(amount_to_subtract)
    	    	    sender.sendMessage("You dropped the quest but it cost $#{amount_to_subtract}")
    	    	    getServer.broadcastMessage("#{player_name} just dropped quest #{quest[:name]}! The shame!")
    	    	    @quest_store.quest_done(player_name)
    	    	    
    	    	    return true
    	    end
    	    
    	    if args[0].casecmp("give") == 0
    	    	    if @quest_store.in_quest?(player_name)
    	    	    	    sender.sendMessage("You are already in a quest!")
    	    	    	    show_quest(sender)
    	    	    	    return true
    	    	    else
    	    	    	    sender.sendMessage("OK! Quest Started!")
    	    	    	    
    	    	    	    start_quest(player_name)
    	    	    	    quest = quest(@quest_store.current_quest(player_name))
    	    	    	    getServer.broadcastMessage("#{player_name} just started quest #{quest[:name]}!")
    	    	    	    sender.sendMessage(quest[:on_start])
    	    	    	    show_quest(sender)
    	    	    	    return true
    	    	    end
    	    end
    	    
    	    if args[0].casecmp("done")
    	    	    unless @quest_store.in_quest?(player_name)
    	    	    	    sender.sendMessage("You're not currently in a quest...")
    	    	    	    return true
    	    	    end
    	    	    if RQuestChecker.check(sender, quest(@quest_store.current_quest(player_name)))
    	    	    	    sender.sendMessage("Your quest is complete!")
    	    	    	    
    	    	    	    # okay, now take the items away...
    	    	    	    current_quest = quest(@quest_store.current_quest(player_name))
    	    	    	    current_quest[:required].each do |req_hash|
    	    	    	    	    puts "Removing #{req_hash.inspect} from player..."
    	    	    	    	    id = req_hash[:id]
    	    	    	    	    quantity = req_hash[:quantity]
    	    	    	    	    remove_from_inventory(sender, id, quantity)
    	    	    	    end
    	    	    	    
    	    	    	    # now reward time!
    	    	    	    balance = com::iConomy::iConomy.getAccount(player_name).getHoldings
    	    	    	    amount_to_add = current_quest[:reward]
    	    	    	    
    	    	    	    
    	    	    	    balance.add(amount_to_add)
    	    	    	    sender.sendMessage(current_quest[:on_complete])
    	    	    	    sender.sendMessage("You have been rewarded with $#{amount_to_add}")
    	    	    	    @quest_store.quest_done(player_name)
    	    	    	    getServer.broadcastMessage("#{player_name} just completed quest #{current_quest[:name]}!")
    	    	    	    return true
    	    	    else
    	    	    	    sender.sendMessage("Your quest is not complete.")
    	    	    	    return true
    	    	    end
    	    end
       	    
    	    puts "Didn't match anything..."
    	    
       	    return true
    end
    
    # provided a quest id, returns the quest hash...
    def quest(quest_id)
    	    @quest_data[:quests].each do |qh|
    	    	    return qh if qh[:quest_id] == quest_id    
    	    end
    	    # we couldn't find it...
    	    return nil
    end
 
    def onDisable
        puts "Disabling rQuest..."
    end
    
    private
    def remove_from_inventory(player, id, quantity)
    	    total_removed = 0
    	    player.getInventory.getContents.each do |is|
    	    	    # puts "Evaluating #{is.inspect}" if is
    	    	    if is && is.getTypeId == id && total_removed <= quantity
    	    	    	    while is.getAmount > 0
    	    	    	          is.setAmount(is.getAmount - 1)
    	    	    	          # puts "Total left is now: #{is.getAmount}"
    	    	    	          if is.getAmount == 1
    	    	    	          	  # puts "1 left in the stack... removing..."
    	    	    	          	  player.getInventory.removeItem(is)
    	    	    	          end
    	    	    	          total_removed += 1
    	    	    	    end
    	    	    end
    	    end
    end
    
    def show_quest(player)
    	    player_name = player.getName
    	    # puts "Looking up quest for #{player_name}"
    	    quest_id = @quest_store.current_quest(player_name)
    	    # puts "The current quest id is: #{quest_id}"
    	    quest = quest(quest_id)
    	    # puts "The quest is: #{quest.inspect}"
    	    return false unless quest
    	    player.sendMessage("Quest: #{quest[:name]}")
    	    player.sendMessage("Reward: $#{quest[:reward]}")
    	    quest[:required].each do |req_hash|
    	    	    player.sendMessage("You must get #{req_hash[:quantity]} of #{req_hash[:description]}")
    	    end
    end
    
    # return a random quest ID
    def random_quest()
    	    @quest_data[:quests].random_element()[:quest_id]
    end
    
    def start_quest(player_name)
    	    quest_id = random_quest()
    	    @quest_store.start_quest(player_name, quest_id)
    end
end

class Array
  def random_element
    self[rand(length)]
  end
end