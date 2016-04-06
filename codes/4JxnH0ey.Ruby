require 'java'
require 'digest'

class SpellBook
  attr_accessor :code, :name, :author, :hash_code

  def initialize(name, author)
    @name = name
    @author = author
  end

  def hash
    @hash ||= [self.class, name, author, code].hash
  end

  def run(context)
    eval(@code, context)
  end

  def ==(y)
    # The following line doesn't do anything because of the line that
    # proceeded it.
    # @hash_code.to_s == y[y.length-1] if y.class == Array
    hash == y.hash
  end
end

class SpellLocks
  attr_accessor :init, :interact, :pickup, :despawn, :move
end

$vars = Globals.new

def spell_init &block
  yield if $vars.init
end

def spell_run &block
  yield unless $vars.init
end

def spell_interact &block
  yield if $vars.interact
end

def spell_pickup &block
  yield if $vars.pickup
end

def spell_despawn &block
  yield if $vars.despawn
end

def spell_move &block
  yield if $vars.move
end

def set_player_variable(player) #Set Global Player Variable
  $player = player
end

# Is this ever accessed elsewhere? Doesn't seem to be used.
def set_event_variable(event)
  $event = event
end

def is_bound_item?(item)
  item.getItemMeta.hasLore && item.getItemMeta.getLore[0] == "Ruby Spell Bound"
end

def is_bound_block?(block)
  block.hasMetadata("reich") == true && block.getMetadata("reich")[0].value
end

class RubySpellBooks < RubyPlugin

  attr_accessor :spell_books, :selected_block

  def create_spell_book(new_book, player) #Add Ruby Spell Book to internal list
    if new_book.getPages[0] == "Ruby Spell Book" && @spell_books[new_book.getTitle].nil?
      new_spell = SpellBook.new(new_book.getTitle, new_book.getAuthor)
      new_spell.code = new_book.getPages[1..new_book.getPages.length-1].join
      @spell_books[new_book.getTitle] = new_spell
      $vars = Globals.new
      $vars.init = true
      set_player_variable(player)
      new_spell.run(binding)
      true
    end
  end

  def spawn_spell_item(world, loc, material, spell)
    spell_item = ItemStack.new(material)
    new_meta = spell_item.getItemMeta
    new_meta.setLore(["Ruby Spell Bound",spell])
    spell_item.setItemMeta new_meta
    world.dropItemNaturally(loc, spell_item)
  end

  def valid_spell?(s)
    spell_books[s]
  end

  def onEnable #Enabled Plugin
    @spell_books = {}
    server.broadcastMessage "[" + description.name + "] " + description.fullName + " enabled."
    register_events
  end

  def register_events
    registerEvent(PlayerEditBookEvent, :Normal) do |event| #Ruby Spell Book Create Event
      new_book = event.getNewBookMeta
      set_event_variable(event)
      if event.isSigning && !create_spell_book(new_book, event.getPlayer)
        event.getPlayer.sendMessage("Could not create Ruby Spell Book.")
        event.setCancelled(true)
      end
    end

    registerEvent(PlayerInteractEvent, :Normal) do |event| #Use Bound Wand Event
      item = event.getPlayer.getInventory.getItemInHand
      if is_bound_item? item
        set_event_variable(event)
        set_player_variable(event.getPlayer)
        $vars = Globals.new
        $vars.interact = true
        @spell_books[item.getItemMeta.getLore[1]].run(binding) if valid_spell? item.getItemMeta.getLore[1]
      end
      if item.getType == Material::STICK  #Select Block
        new_loc = event.getClickedBlock.getLocation
        new_loc.setY(new_loc.getY + 1)
        @selected_block = event.getClickedBlock.getWorld.getBlockAt(new_loc)
        event.getPlayer.sendMessage "Selected block at (#{@selected_block.getLocation.getX}, #{@selected_block.getLocation.getY}, #{@selected_block.getLocation.getZ})"
      end
    end

    registerEvent(PlayerPickupItemEvent, :Normal) do |event| #Pick up Bound Wand Event
      if is_bound_item? event.getItem.getItemStack
        set_event_variable(event)
        set_player_variable(event.getPlayer)
        $vars = Globals.new
        $vars.pickup = true
        @spell_books[event.getItem.getItemStack.getItemMeta.getLore[1]].run(binding)
      end
    end

    registerEvent(ItemDespawnEvent, :Normal) do |event| #Bound Wand Item despawn event
      if is_bound_item? event.getEntity.getItemStack
        set_event_variable(event)
        set_player_variable(nil)
        $vars = Globals.new
        $vars.despawn = true
        @spell_books[event.getEntity.getItemStack.getItemMeta.getLore[1]].run(binding) if valid_spell? event.getEntity.getItemStack.getItemMeta.getLore[1]
      end
    end

    registerEvent(PlayerMoveEvent, :Normal) do |event| #Player Move over Bound Block Event
      cur_block = event.getPlayer.getWorld.getBlockAt(event.getTo)
      if is_bound_block?(cur_block) && valid_spell?(cur_block.getMetadata("reich")[0].value)
        set_event_variable(event)
        set_player_variable(event.getPlayer)
        $vars = Globals.new
        $vars.move = true
        $block = cur_block
        @spell_books[cur_block.getMetadata("reich")[0].value].run(binding)
      end
    end
  end

  def onCommand(sender, command, label, args)
    method_name = "command_#{command}".to_sym
    if respond_to?(method_name)
      send method_name, [sender, label, args]
    end
  end

  def onDisable #Disable Plugin
    server.broadcastMessage "[" + description.name + "] " + description.fullName + " disabled."
  end

  private
  def command_listbooks sender, label, args
    spell_books.length > 0 ? sender.sendMessage("Ruby Spell Books (#{@spell_books.length}):") : sender.sendMessage("No Ruby Spell Books exist.")
    spell_books.each_value { |book| sender.sendMessage "#{book.name} by #{book.author}" }
    true
  end

  def command_binditem sender, label, args
    if spell_books.has_key? args[0].to_s
      new_meta = sender.getInventory.getItemInHand.getItemMeta
      new_meta.setLore(["Ruby Spell Bound", args[0].to_s])
      sender.getInventory.getItemInHand.setItemMeta new_meta
    else
      sender.sendMessage "#{args[0]} is not a valid Ruby Spell Book."
    end
    true
  end

  def command_reloadbook sender, label, args
    item = sender.getInventory.getItemInHand
    if item.getType == Material::WRITTEN_BOOK && !create_spell_book(item.getItemMeta, sender)
      sender.sendMessage("Could not create Ruby Spell Book.")
    end
    true
  end

  def command_editbook sender, label, args
    item = sender.getInventory.getItemInHand
    if item.getType == Material::WRITTEN_BOOK && item.getItemMeta.getAuthor == sender.getPlayerListName
      item.setType(Material::BOOK_AND_QUILL)
      @spell_books.delete(item.getItemMeta.getTitle)
      true
    end
    false
  end

  def command_bindblock sender, label, args
    cur_block = @selected_block
    cur_block.setMetadata("reich", FixedMetadataValue.new(RubySpellBooks, args[0]))
    true
  end
end