#-------------------------------------------------------------------------------
# * [ACE] Khas Core Library
#-------------------------------------------------------------------------------
# * By Nilo K. (Khas)
# * Version: 1.03
# * Released on: 12.07.2016
#
# * Social Media
# Blog: arcthunder.blogspot.com
# Facebook: facebook.com/khasarc
# Twitter: twitter.com/arcthunder
# Youtube: youtube.com/c/khasarc
#
# * Khas Scripts @ RPG Maker Web forums (official support!)
# forums.rpgmakerweb.com/index.php?/forum/132-khas-scripts
#
#-------------------------------------------------------------------------------
# * Terms of Use
#-------------------------------------------------------------------------------
# When using KHAS CORE LIBRARY (the script), you agree with the following terms:
# 1. If you purchased a license to one of my scripts, credit is not required. 
#    Otherwise, you must give credit to Khas (if you want, a link to my blog is 
#    always appreciated);
# 2. You can use the script for free in both non-commercial and commercial 
#    projects;
# 4. You can edit the script for using in your own project. However, you are 
#    not allowed to share/distribute any modified version;
# 5. If you want to share a Khas script, don’t post the direct download link,
#    redirect the user to my blog instead;
# 6. The script can not be ported to any RPG Maker version than VX Ace.
#
#-------------------------------------------------------------------------------
# * Log
#-------------------------------------------------------------------------------
# KCL 1.03 (12.07.2016)
# Improved Khas notetag system (support for negative numbers)
# Included scene map spriteset access
#
# KCL 1.02 (09.27.2015)
# Fixed some issues with regions that are not used by this script.
#
# KCL 1.01 (08.23.2015)
# Added Min_Region_Height constant. This makes possible to choose a custom 
# range of Regions to use as height marks.
#
# KCL 1.00 (03.14.2015)
# First release!
#
#-------------------------------------------------------------------------------
# * Updates
#-------------------------------------------------------------------------------
# Please check my blog for KCL updates!
#
#-------------------------------------------------------------------------------
# * Requirements
#-------------------------------------------------------------------------------
# Place this script before any Khas script.
#
#-------------------------------------------------------------------------------
# * Khas Core (configuration)
#-------------------------------------------------------------------------------

module Khas_Core
  
  # MIN REGION HEIGHT
  # Minimum region to consider a height mark.
  # Marking a tile with this value will give it a height of 1.
  # Unmarked tiles or tiles marked with values smaller than this will 
  # considered to be of zero height.
  Min_Region_Height = 1
  
  # MAX REGION HEIGHT
  # Maximum region to consider a height mark.
  # Unmarked tiles or tiles marked with values greater than this will 
  # considered to be of zero height.
  Max_Region_Height = 16
  
  # LOAD MAP DATA
  # You can add map IDs here if you want their data to be loaded before the 
  # game starts. This will prevent any delay when switching to a big map.
  Load_Map_Data = []
  
  # ENABLE BUILDING HEIGHT DATA
  # If you are using scripts and features that need building and height data,
  # please set this to true. 
  Enable_BH_Data = true
  
end

#-------------------------------------------------------------------------------
# * Khas Variables
#-------------------------------------------------------------------------------

$khas = {:core => 1.03}
$khas_graphics = {}
$khas_physics = {}

#-------------------------------------------------------------------------------
# * String
#-------------------------------------------------------------------------------

class String

  def khas_id?
    (self =~ /\A[\w_0-9]+\Z/) == 0
  end
  
  def khas_tag?
    (self =~ /\A\[[\w_0-9]+\]/) == 0
  end
  
  def khas_command?
    (self =~ /\A\[[\w_0-9]+\s-?[\w_0-9]+\]/) == 0
  end
  
  def khas_tag
    self[/\[[\w_0-9]+\]/].sub("\[","").sub("\]","")
  end
  
  def khas_command
    self[/\[[\w_0-9]+\s/].sub("\[","").sub("\s","")
  end
  
  def khas_value
    self[/\s-?[\w_0-9]+\]/].sub("\s","").sub("\]","")
  end
  
  def is_int?
    (self =~ /\A\d+\Z/) == 0
  end
  
  def is_float?
    (self =~ /\A\d+\.\d+\Z/) == 0
  end

end

#-------------------------------------------------------------------------------
# * Table
#-------------------------------------------------------------------------------

class Table
  
  def clear
    for x in 0...xsize
      for y in 0...ysize
        for z in 0...zsize
          self[x,y,z] = 0
        end
      end
    end
  end
  
end

#-------------------------------------------------------------------------------
# * RPG Map
#-------------------------------------------------------------------------------

class RPG::Map
  
  def valid?(x, y)
    x >= 0 && x < @width && y >= 0 && y < @height
  end

end

#-------------------------------------------------------------------------------
# * RPG Event Command
#-------------------------------------------------------------------------------

class RPG::EventCommand
  
  def comment?
    @code == 108 || @code == 408
  end
  
  def khas_tag?
    @parameters[0].khas_tag?
  end
  
  def khas_command?
    @parameters[0].khas_command?
  end
  
  def khas_tag
    @parameters[0].khas_tag
  end
  
  def khas_command
    @parameters[0].khas_command
  end
  
  def khas_value
    @parameters[0].khas_value
  end
  
end

#-------------------------------------------------------------------------------
# * RPG Base Item
#-------------------------------------------------------------------------------

class RPG::BaseItem
  
  def khas_note
    tags_commands = []
    @note.each_line do |line|
      tags_commands << line if line.khas_command? || line.khas_tag?
    end
    tags_commands
  end
  
end

#-------------------------------------------------------------------------------
# * SceneManager
#-------------------------------------------------------------------------------

module SceneManager
  
  def self.spriteset
    @scene.spriteset
  end
  
end

#-------------------------------------------------------------------------------
# * Game Map
#-------------------------------------------------------------------------------

class Game_Map
  
  include Khas_Core
  
  attr_reader :height_map
  attr_reader :building_map
  
  alias khas_setup setup
  alias khas_setup_events setup_events
  
  def setup(map_id)
    khas_setup(map_id)
    khas_extend_setup
    khas_scan_note
  end
  
  def setup_events
    khas_setup_map
    khas_setup_events
  end
  
  def khas_scan_note
    @map.note.each_line do |line|
      call_khas_tag(line.khas_tag) if line.khas_tag?
      call_khas_command(line.khas_command, line.khas_value) if line.khas_command?
    end
  end
  
  def khas_setup_map
    setup_height_building
  end
  
  def khas_extend_setup
  end
  
  def call_khas_tag(t)
  end
  
  def call_khas_command(c,v)
  end
  
  def setup_height_building
    if Enable_BH_Data
      @height_map = Khas_Core.height_table(@map_id, @map)
      @building_map = Khas_Core.building_table(@map_id, @map)
    end
  end
  
  def local_height(x,y)
    @height_map.lxy(x,y)
  end
 
  def wall?(x,y)
    (@height_map.lxy(x,y) & 0x1) > 0
  end
  
  def floor?(x,y)
    (@height_map.lxy(x,y) & 0x1) == 0
  end
  
  def building?(x,y)
    @building_map.lxy(x,y) > 0
  end
  
end

#-------------------------------------------------------------------------------
# * Game Event
#-------------------------------------------------------------------------------

class Game_Event < Game_Character
  
  alias khas_setup_page setup_page
  
  def setup_page(new_page)
    khas_setup_page(new_page)
    khas_extend_setup
    khas_scan_comments
  end
  
  def khas_scan_comments
    return if @page.nil? || @list.nil?
    for command in @list
      if command.comment?
        call_khas_tag(command.khas_tag) if command.khas_tag?
        call_khas_command(command.khas_command, command.khas_value) if command.khas_command?
      end
    end
  end
  
  def khas_extend_setup
  end
  
  def call_khas_tag(t)
  end
  
  def call_khas_command(c,v)
  end
  
end

#-------------------------------------------------------------------------------
# * Game Interpreter
#-------------------------------------------------------------------------------

class Game_Interpreter
  
  def this_event
    $game_map.events[@event_id]
  end
  
end

#-------------------------------------------------------------------------------
# * Spriteset Map
#-------------------------------------------------------------------------------

class Spriteset_Map
  
  attr_accessor :viewport1
  attr_accessor :viewport2
  attr_accessor :viewport3
  
end

#-------------------------------------------------------------------------------
# * Scene Base
#-------------------------------------------------------------------------------

class Scene_Base
  
  attr_accessor :spriteset
  
end

#-------------------------------------------------------------------------------
# * Table Map
#-------------------------------------------------------------------------------

class Table_Map < Table
  
  def initialize(width, height, loop_x, loop_y)
    super(width, height)
    @loop_x = loop_x
    @loop_y = loop_y
  end
  
  def lxy(x,y)
    if @loop_x
      x += xsize if x < 0
      x -= xsize if x >= xsize
    else
      return 0 if x < 0 || x >= xsize
    end
    if @loop_y
      y += ysize if y < 0
      y -= ysize if y >= ysize
    else
      return 0 if y < 0 || y >= ysize
    end
    self[x,y]
  end
  
  def wall?(x,y)
    (lxy(x,y) & 0x1) > 0
  end
  
  def floor?(x,y)
    (lxy(x,y) & 0x1) == 0
  end
  
end

#-------------------------------------------------------------------------------
# * Smooth Int
#-------------------------------------------------------------------------------

class Smooth_Int
  
  attr_reader :i
  
  def initialize(ii)
    @i = ii
  end
  
  def update
    @timer > 0 ? refresh : set(@target)
  end
  
  def update?
    @timer != nil
  end
  
  def refresh
    @phase -= @dp
    @i = (@base + @delta*(Math.cos(@phase)+1)).to_i
    @timer -= 1
  end
  
  def set(target, time = nil)
    if time.nil?
      @i = target
      @timer = nil
    else
      @phase = Math::PI
      @dp = @phase/time
      @target = target
      @base = @i
      @delta = (@target - @base)/2
      @timer = time - 1
    end
  end
  
end

#-------------------------------------------------------------------------------
# * Smooth Float
#-------------------------------------------------------------------------------

class Smooth_Float
  
  attr_reader :f
  
  def initialize(ff)
    @f = ff
  end
  
  def update
    @timer > 0 ? refresh : set(@target)
  end
  
  def update?
    @timer != nil
  end
  
  def refresh
    @phase -= @dp
    @f = @base + @delta*(Math.cos(@phase)+1)
    @timer -= 1
  end
  
  def set(target, time = nil)
    if time.nil?
      @f = target
      @timer = nil
    else
      @phase = Math::PI
      @dp = @phase/time
      @target = target
      @base = @f
      @delta = (@target - @base)/2
      @timer = time - 1
    end
  end
  
end

#-------------------------------------------------------------------------------
# * Khas Core
#-------------------------------------------------------------------------------

module Khas_Core
  
  @@height_cache = {}
  @@building_cache = {}
  
  def self.ntag?(tag)
    tag < Min_Region_Height || tag > Max_Region_Height
  end
  
  def self.gen_height_table(map)
    htable = Table_Map.new(map.width, map.height, map.scroll_type == 2 || map.scroll_type == 3, map.scroll_type == 1 || map.scroll_type == 3)
    for x in 0...map.width
      for y in 0...map.height
        tag = (map.data[x, y, 3] >> 8) 
        next if ntag?(tag)
        tag -= (Min_Region_Height - 1)
        htable[x,y] = tag*2
        if map.valid?(x,y+1) && ntag?(map.data[x, y+1, 3] >> 8)
          ty = y + 1
          while map.valid?(x,ty) && ntag?(map.data[x, ty, 3] >> 8) && tag > 0 do
            htable[x,ty] = tag*2 - 1
            ty += 1
            tag -= 1
          end
        end
      end
    end
    htable
  end
  
  def self.gen_building_table(map)
    btable = Table_Map.new(map.width, map.height, map.scroll_type == 2 || map.scroll_type == 3, map.scroll_type == 1 || map.scroll_type == 3)
    for x in 0...map.width
      for y in 0...map.height
        tag = (map.data[x, y, 3] >> 8) 
        next if ntag?(tag)
        tag -= (Min_Region_Height - 1)
        btable[x,y+tag] = tag if map.valid?(x,y+tag)
      end
    end
    btable
  end
  
  def self.height_table(map_id, map)
    @@height_cache.include?(map) ? @@height_cache[map_id] : gen_height_table(map)
  end
  
  def self.building_table(map_id, map)
    @@building_cache.include?(map_id) ? @@building_cache[map_id] : gen_building_table(map)
  end
  
  def self.load_bh_data
    for id in Load_Map_Data
      map = load_data(sprintf("Data/Map%03d.rvdata2", id))
      @@height_cache[id] = gen_height_table(map)
      @@building_cache[id] = gen_building_table(map)
    end
  end
  
end

Khas_Core.load_bh_data if Khas_Core::Enable_BH_Data

#-------------------------------------------------------------------------------
# * End
#-------------------------------------------------------------------------------