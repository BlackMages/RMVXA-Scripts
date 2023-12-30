#-------------------------------------------------------------------------------
# Fast Travel Script By Black Mage (Credit required to use)
# Version: 1.4
#
# https://burningwizard.wordpress.com/2017/05/03/fast-travel-script/
#-------------------------------------------------------------------------------
#
# * The script creates a map that hover through listed locations.
#
# * The background image is named "Map_Select", and placed inside 
#   Graphics/System folder.
#
#-------------------------------------------------------------------------------
#
# * How to use:
#
# * Enlist every available location into MAP_LIST.
#
# * Assign a switch for each location. Put them on SWITCH_LIST.
#
# * When you want a map is listed on the Map Select menu, simply turn their
#   respective switch value to "true".
#
# * Assign x and y variables for the screen to hover when a location is 
#   highlighted. Put them on LOCATION_COORDINATE
#
# * Assign where to teleport when a location is selected. Put them on 
#   TELEPORT_LIST.
#
# * Call the map using this script call:
#   fast_travel
#   use fast_travel(int) to highlight certain choice. The int value are taken 
#   from MAP_LIST order.
#
#       Note: Ensure that there's at least one location enabled by the switch. 
#       If there's no location enabled, the script will crash.
#
# * Enjoy your map select menu.
#
#-------------------------------------------------------------------------------
#
# * There's several additional option below. Feel free to edit them.
#
#-------------------------------------------------------------------------------
 
module BLACK_MAP_LIST
 
  #-----------------------------------------------------------------------------
  # Map name list. This is needed for metaprogramming.
  #-----------------------------------------------------------------------------
  MAP_LIST = ["Australia", 
              "Russia", 
              "America"]
 
  #-----------------------------------------------------------------------------
  # Switches that enable the map.
  #-----------------------------------------------------------------------------
  SWITCH_LIST = [1, # When switch 01 is on, you can transfer to Australia.
                 1, # When switch 03 is on, you can transfer to Russia.
                 2] # And so on.
 
  #-----------------------------------------------------------------------------
  # Assign each map name where to teleport. 
  #-----------------------------------------------------------------------------
  #                 Map ID, x,  y,  player direction
  TELEPORT_LIST = [[2,      8,  1,  2], # This is where "Australia" is going to be.
                   [3,      8, 11,  8], # "Russia".
                   [1,     15,  7,  4]] # and so on.
 
  #-----------------------------------------------------------------------------
  # Assign overworld location coordinate. 
  #-----------------------------------------------------------------------------
  LOCATION_COORDINATE = [[-470,-100], #The map will move here when "Australia" is highlighted
                         [-120,560],
                         [880,300]]
 
  #-----------------------------------------------------------------------------
  # Assign text color for location selection. The color depends on Window 
  # graphic that you use. 0 is the default color.
  #-----------------------------------------------------------------------------
  TEXT_LOCA_COLOR = [0, 
                     3,
                     2]
 
  #-----------------------------------------------------------------------------
  # Position of the background image.
  #-----------------------------------------------------------------------------
  MAP_POSITION = [0,0] #[x,y]  
  #-----------------------------------------------------------------------------
  # How far the background image is zoomed out.
  #-----------------------------------------------------------------------------
  MAP_ZOOM_OUT = [0.25, 0.25] #[zoom_x, zoom_y]
  #-----------------------------------------------------------------------------
  # How far the background image is zoomed in when a location is selected.
  #-----------------------------------------------------------------------------
  MAP_ZOOM_IN = [1, 1] #[x, y]
  #-----------------------------------------------------------------------------
  # Maximum magnify speed when the scene is started.
  #-----------------------------------------------------------------------------
  MAX_ZOOM_SPEED = 0.01
 
  #-----------------------------------------------------------------------------
  # Position of the available choices.
  #-----------------------------------------------------------------------------
  CHOICE_POSITION = [0,0] #[x,y]
  #-----------------------------------------------------------------------------
  # Position of window that hold list of the available choices.
  #-----------------------------------------------------------------------------
  WINDOW_POSITION = [0,10] #[x,y]
  #-----------------------------------------------------------------------------
  # The width for location selection choices.
  #-----------------------------------------------------------------------------
  MAP_WINDOW_WIDTH = 132
  #-----------------------------------------------------------------------------
  # The height for location selection choices. 
  #-----------------------------------------------------------------------------
  MAP_WINDOW_HEIGHT = 10 # Amount of visible choices in the window.
  #-----------------------------------------------------------------------------
  # Maximum scroll speed when scrolling through the map.
  #-----------------------------------------------------------------------------
  MAX_SCROLL_SPEED = 20
  #-----------------------------------------------------------------------------
  # The map won't scrolled until the zoom are above this number for x and y.
  #-----------------------------------------------------------------------------
  SCROLL_BOUNDARY = [0.5, 0.5] #[zoom_x, zoom_y]


  #-----------------------------------------------------------------------------
  # Use an image for location selection window background. The image is named 
  # "Window_Map" and placed inside Graphics/System folder.
  #-----------------------------------------------------------------------------
  WINDOW_PIC = false
  #-----------------------------------------------------------------------------
  # Position of location selection window picture.
  #-----------------------------------------------------------------------------
  WINDOW_PIC_POSITION = [0, 0] #[x, y]
  #-----------------------------------------------------------------------------
  # Opacity of location selection window picture.
  #-----------------------------------------------------------------------------
  WINDOW_PIC_OPACITY = 200
 
  #-----------------------------------------------------------------------------
  # Map Menu BGM.
  #-----------------------------------------------------------------------------
  MAP_MENU_BGM = ["Field3", 100, 100] #["BGM name", Volume, Pitch]
 
  #-----------------------------------------------------------------------------
  # SFX played when the selection is changed.
  #-----------------------------------------------------------------------------
  MAP_MENU_SFX = ["Wind1", 100, 100] #["SFX name", Volume, Pitch]
 
 
  #-----------------------------------------------------------------------------
  # 
  # * Below is the configuration of additional information window.
  #
  #-----------------------------------------------------------------------------
 
  #-----------------------------------------------------------------------------
  # Location name.
  #-----------------------------------------------------------------------------
  ADD_LOC_NAME = false # Set this to true to enable the location name info
  #-----------------------------------------------------------------------------
  # Location name info position.
  #-----------------------------------------------------------------------------
  ADD_LOC_NAME_POS = [347,0]
  #-----------------------------------------------------------------------------
  # Location name info width & height.
  #-----------------------------------------------------------------------------
  ADD_LOC_NAME_W_H = [200,100] # [width, height]
  #-----------------------------------------------------------------------------
  # Location name font size.
  #-----------------------------------------------------------------------------
  ADD_LOC_NAME_F_SIZE = 20
 
 
  #-----------------------------------------------------------------------------
  # Location description.
  #-----------------------------------------------------------------------------
  ADD_LOC_DESC = false # Set this to true to enable the location description info
  #-----------------------------------------------------------------------------
  # Location description position.
  #-----------------------------------------------------------------------------
  ADD_LOC_DESC_POS = [347,155] # [x, y]
  #-----------------------------------------------------------------------------
  # Location description width & height.
  #-----------------------------------------------------------------------------
  ADD_LOC_DESC_W_H = [300,100] # [width, height]
  #-----------------------------------------------------------------------------
  # Location description font size.
  #-----------------------------------------------------------------------------
  ADD_LOC_DESC_F_SIZE = 20
  #-----------------------------------------------------------------------------
  # Description for each location.
  #-----------------------------------------------------------------------------
  ADD_LOC_DESC_VALUE = ["Australia is, well," + "\n" + "Australia.",  # Desc. for Australia.
                        "Russia..." + "\n" + "Yeah, Russia.",         # Desc. for Russia.
                        "America is America."]                        # and so on.
 
  #-----------------------------------------------------------------------------
  # Location thumbnail.
  #-----------------------------------------------------------------------------
  # Set this to true to enable the location thumbnail. The thumbnail should be
  # placed inside Graphics/System folder, and will be named the same as the
  # location name from MAP_LIST, but with additional _THUMB in their name.
  #
  # So, for example if you have location named America, then the file should be
  # named America_THUMB.
  ADD_LOC_THUMB = false
  #-----------------------------------------------------------------------------
  # Location description position.
  #-----------------------------------------------------------------------------
  ADD_LOC_THUMB_POS = [376,47] # [x, y]
 
  #-----------------------------------------------------------------------------
  # Location quests.
  #-----------------------------------------------------------------------------
  ADD_LOC_QUEST = false
  #-----------------------------------------------------------------------------
  # Location quests switches.
  #-----------------------------------------------------------------------------
  ADD_LOC_QUEST_S = [[],
                     [6],
                     [4,5]]
  #-----------------------------------------------------------------------------
  # Location quests text.
  #-----------------------------------------------------------------------------
  #                 [switch number,   text to show when the value is true]
  ADD_LOC_Q_TEXT = [[4,               "* Find a way to" + "\n" + "Russia!"],
                    [5,               "* Get the package!"],
                    [6,               "* Deliver the package"]]
  #-----------------------------------------------------------------------------
  # Location quests position.
  #-----------------------------------------------------------------------------
  ADD_LOC_QUEST_POS = [347,200] # [x, y]
  #-----------------------------------------------------------------------------
  # Location quests width & height.
  #-----------------------------------------------------------------------------
  ADD_LOC_QUEST_W_H = [300,300] # [width, height]
  #-----------------------------------------------------------------------------
  # Location quests font size.
  #-----------------------------------------------------------------------------
  ADD_LOC_QUEST_F_SIZE = 20
 
  #-----------------------------------------------------------------------------
  # Information Window Picture.
  #-----------------------------------------------------------------------------
  # Set this to true to enable the information window picture. The picture 
  # should be named Window_Info and placed inside Graphics/System folder.
  ADD_WIN_PIC = false 
  #-----------------------------------------------------------------------------
  # Position of additional information window picture.
  #-----------------------------------------------------------------------------
  ADD_WIN_PIC_POS = [350, 3] #[x, y]
  #-----------------------------------------------------------------------------
  # Opacity of additional information window picture.
  #-----------------------------------------------------------------------------
  ADD_WIN_PIC_OPA = 200
 
  #-----------------------------------------------------------------------------
  # Current Party Window.
  #-----------------------------------------------------------------------------
  ADD_CUR_PARTY = false
  #-----------------------------------------------------------------------------
  # Location quests position.
  #-----------------------------------------------------------------------------
  ADD_CUR_PARTY_POS = [352,340] # [x, y]
  #-----------------------------------------------------------------------------
  # Location quests width & height.
  #-----------------------------------------------------------------------------
  ADD_CUR_PARTY_W_H = [180,80] # [width, height]
 
  #-----------------------------------------------------------------------------
  # This is an instruction if you want to use an icon for your location. This
  # icon also can serve as a cursor. Note that the icon use different files for
  # each location.
  # * First, the icon canvas mus be as big as the overworld canvas. This is
  #   the case to make sure the scrolling is as smooth as possible.
  # * Second, the icon must be named after the location found in MAP_LIST.
  # * Third, after the icon name, put the frame number of the icon. The number
  #   is start from 0.
  #-----------------------------------------------------------------------------
  #-----------------------------------------------------------------------------
  # * Location animated icon.
  #-----------------------------------------------------------------------------
  LOC_ANI_ICON = false
  #-----------------------------------------------------------------------------
  # * Set this to false to disable the icon fade. Note that the fade might
  #   conflict with the frame animation.
  #-----------------------------------------------------------------------------
  LOC_ANI_ICON_FADE = true
  #-----------------------------------------------------------------------------
  # * Location animated icon delay.
  #   You can call this animation speed. Decrease the value to make the 
  #   animation faster.
  #-----------------------------------------------------------------------------
  LOC_ANI_ICON_DELAY = 10
  #-----------------------------------------------------------------------------
  # Previously, we fix the maximum frame for each icon, that is 1000 frames.
  # However, this cause some problems with Krosk's "unable to find" script. 
  # To make sure that this script compatible with script similar with Krosk's, 
  # we add an additional configuration to specify how many frames will be used
  # in total for the icon animation.
  #-----------------------------------------------------------------------------
  LOC_ANI_ICON_TOTAL = [2, # Numbers of total frame used for 1st location icon.
                        2, 
                        2, 
                        ]  # Note that the file name start with zero, so you'll 
                           # end up with frame numbered n-1 if you put n as the 
                           # frame number.
 
  #-----------------------------------------------------------------------------
  # This section is for static location icon. Unlike the animated icon, this
  # icon will always appear on the map as long as it's unlocked. The files are
  # named the same as the location found in MAP_LIST, followed by "STAT".
  # ex. your location is "America", then the file should be named "AmericaSTAT".
  #-----------------------------------------------------------------------------
  #-----------------------------------------------------------------------------
  # * Set this to true to enable the static location icon.
  #-----------------------------------------------------------------------------
  LOC_STATIC_ICON = false
end
 
#-------------------------------------------------------------------------------
# * Beyond this is the sacred land of code. You need programming qualification 
#   to dwelve deeper, or it'll cause many unnecessary problems. Proceed on your 
#   own risk.
#-------------------------------------------------------------------------------
 
class Game_Interpreter
  def fast_travel(int = -1)
    $game_system.fast_travel_index = int
    SceneManager.call(Scene_Map_Select)
  end
end
class Game_System
  attr_accessor :fast_travel_index
  alias b_fst_trvl_initialize initialize
  def initialize; b_fst_trvl_initialize; @fast_travel_index = -1; end
end
 
class Scene_Map_Select < Scene_Base
 
  include BLACK_MAP_LIST
 
  def start
    super
    @last_map = "placeholder"
    @first_sfx = false
 
    @last_position = [MAP_POSITION[0], MAP_POSITION[1]]
    @distance_x = 0; @distance_y = 0    
    @last_zoom = [MAP_ZOOM_OUT[0], MAP_ZOOM_OUT[1]]
    @icon_max = 0; @icon_current = 0; @icon_delay_cur = 0
    create_maplist
    create_information_window
    create_command_window
    create_background
    create_map_icon
    create_stat_icon if LOC_STATIC_ICON
    create_map_window if WINDOW_PIC
    load_icon_pic if LOC_ANI_ICON
 
    # Method to set starting position of map index
    @starting_index_list = @command_window.get_map_list
    for i in 0..(@starting_index_list.size - 1)
      break if $game_system.fast_travel_index == -1
      if @starting_index_list[i].to_s == MAP_LIST[$game_system.fast_travel_index].to_s
        @command_window.index = i
      end
    end
 
    location_update_index
    RPG::BGM.new(MAP_MENU_BGM[0], MAP_MENU_BGM[1], MAP_MENU_BGM[2]).play
  end
 
  # Load all icon frame into the RAM so the next load shall be faster.
  def load_icon_pic
    for i in 0..(@map_list.size - 1)
      @map_name = @map_list[i].to_s
      for index in 0..0
        picture = Cache.system(@map_name + index.to_s).nil?
      end
    end
  end    
 
  def create_information_window
    if ADD_LOC_NAME
      @information_window_1 = Window_Information_1.new
      @information_window_1.opacity = 0
    end
    if ADD_LOC_DESC
      @information_window_2 = Window_Information_2.new
      @information_window_2.opacity = 0
    end
    if ADD_LOC_THUMB
      @information_window_3 = Sprite.new
      @information_window_3.bitmap = Bitmap.new(1,1)
      @information_window_3.ox = 0
      @information_window_3.oy = 0
      @information_window_3.x = ADD_LOC_THUMB_POS[0]
      @information_window_3.y = ADD_LOC_THUMB_POS[1]  
      @information_window_3.z = 2
    end
    if ADD_LOC_QUEST
      @information_window_4 = Window_Information_4.new
      @information_window_4.opacity = 0
    end
    if ADD_WIN_PIC
      @info_window = Sprite.new
      @info_window.bitmap = Cache.system("Window_Info")    
      @info_window.ox = 0
      @info_window.oy = 0
      @info_window.x = ADD_WIN_PIC_POS[0]
      @info_window.y = ADD_WIN_PIC_POS[1]  
      @info_window.z = 2
      @info_window.opacity = 0
    end
    if ADD_CUR_PARTY
      @current_party_window = Window_Current_Party.new
      @current_party_window.opacity = 0; @current_party_window.refresh
    end
  end
 
  def create_map_window
    @map_window = Sprite.new
    @map_window.bitmap = Cache.system("Window_Map")
    @map_window.ox = 0
    @map_window.oy = 0
    @map_window.x = WINDOW_PIC_POSITION[0]
    @map_window.y = WINDOW_PIC_POSITION[1]  
    @map_window.z = 2
    @map_window.opacity = 0
  end
 
  def create_maplist
    @map_list = []
    for i in 0..MAP_LIST.size - 1
      @map_list.push(MAP_LIST[i]) if $game_switches[SWITCH_LIST[i]] == true
    end
  end
 
  alias black_update update
  def update
    black_update
    if @map_list.size != 0
      icon_update if @command_window != nil
    end
  end
 
  def location_update_index
    if @command_window != nil
      @last_map = @map_list[@command_window.index].to_s
 
      if LOC_ANI_ICON
        @map_name = assigned_number(@map_list[@command_window.index].to_s)
        @map_name = @map_list[@command_window.index].to_s
        @map_icon.bitmap = Cache.system(@map_name + "0")
        @icon_max = pic_list_number
        @icon_current = 0
      else
        @map_icon.bitmap = Bitmap.new(1,1)
      end
 
    end
    if @first_sfx == true
      RPG::SE.new(MAP_MENU_SFX[0], MAP_MENU_SFX[1], MAP_MENU_SFX[2]).play
    end
  end
 
  def pic_list_number
    @pic_frames = []
    total_frame = LOC_ANI_ICON_TOTAL[assigned_number(@map_name)]
    for index in 0..(total_frame - 1)
      begin
        picture = Cache.system(@map_name + index.to_s).nil?
      rescue 
        nil
      else
        @pic_frames[index] = index
      end
      break if @pic_frames[index] == nil
    end
    return @pic_frames.size
  end
 
  def icon_update
    return if @background_sprite.nil?
    if @background_sprite.zoom_x > SCROLL_BOUNDARY[0] and @background_sprite.zoom_y > SCROLL_BOUNDARY[1]
      if LOC_ANI_ICON
        if @icon_delay_cur < LOC_ANI_ICON_DELAY
          @icon_delay_cur += 1
        else
          @icon_delay_cur = 0
          if @icon_current.to_i < (@icon_max - 1)
            @map_icon.bitmap = Cache.system(@map_name + (@icon_current.to_i + 1).to_s)
            @icon_current += 1
          else
            @map_icon.bitmap = Cache.system(@map_name + "0")
            @icon_current = 0
          end
        end
      end
    end
 
    if @map_icon != nil && @map_icon.bitmap != nil && LOC_ANI_ICON_FADE
      if @map_icon.opacity < 255 && @map_icon_opa == false
        @map_icon.opacity += 7
        @map_icon_opa = true if @map_icon.opacity > 254
      else
        @map_icon.opacity -= 7
        @map_icon_opa = false if @map_icon.opacity < 1
      end
    end
    @map_window.opacity = WINDOW_PIC_OPACITY if WINDOW_PIC
    @info_window.opacity = ADD_WIN_PIC_OPA if ADD_WIN_PIC
 
    @map_index = assigned_number(@map_list[@command_window.index].to_s)
    map_move(@last_position[0], @last_position[1],
             LOCATION_COORDINATE[@map_index][0], LOCATION_COORDINATE[@map_index][1],
             255)
 
    #---------------------------------------------------------------------------
    # Define the magnifying speed.
    #---------------------------------------------------------------------------
    @magnify_x = (MAP_ZOOM_IN[0] - @last_zoom[0])/10
 
    if @magnify_x > 0
      @magnify_x = [MAX_ZOOM_SPEED, @magnify_x].min
    end
    if @magnify_x < 0
      @magnify_x = [MAX_ZOOM_SPEED, @magnify_x].max
    end
 
    if @magnify_x < 0.005 and @magnify_x > 0
      @magnify_x = 0.005
    elsif @magnify_x > -0.005 and @magnify_x < 0
      @magnify_x = -0.005
    end
 
    @magnify_y = (MAP_ZOOM_IN[1] - @last_zoom[1])/10
 
    if @magnify_y > 0
      @magnify_y = [MAX_ZOOM_SPEED, @magnify_y].min
    end
    if @magnify_y < 0
      @magnify_y = [MAX_ZOOM_SPEED, @magnify_y].max
    end
 
    if @magnify_y < 0.005 and @magnify_y > 0
        @magnify_y = 0.005
    elsif @magnify_y > -0.005 and @magnify_y < 0
        @magnify_y = -0.005
    end
 
    #---------------------------------------------------------------------------
    # Scrolling.
    #---------------------------------------------------------------------------
    if @background_sprite.zoom_x > SCROLL_BOUNDARY[0] and @background_sprite.zoom_y > SCROLL_BOUNDARY[1]
      if @first_sfx == false
        RPG::SE.new(MAP_MENU_SFX[0], MAP_MENU_SFX[1], MAP_MENU_SFX[2]).play
        @first_sfx = true
      end
      @background_sprite.x = @background_sprite.x + @distance_x
      @background_sprite.y = @background_sprite.y + @distance_y
      @map_icon.x = @map_icon.x + @distance_x
      @map_icon.y = @map_icon.y + @distance_y
      if LOC_STATIC_ICON
        @stat_icon.each do |pic|
          pic.x = pic.x + @distance_x
          pic.y = pic.y + @distance_y
        end
      end
    end
 
    @background_sprite.zoom_x = @background_sprite.zoom_x + @magnify_x
    @map_icon.zoom_x = @map_icon.zoom_x + @magnify_x
    if LOC_STATIC_ICON
      @stat_icon.each do |pic|
        pic.zoom_x = pic.zoom_x + @magnify_x
      end
    end
 
    if @magnify_x == 0.005
      if @background_sprite.zoom_x > MAP_ZOOM_IN[0]
        @background_sprite.zoom_x = MAP_ZOOM_IN[0]
        @map_icon.zoom_x = MAP_ZOOM_IN[0]
        if LOC_STATIC_ICON
          @stat_icon.each do |pic|
            pic.zoom_x = MAP_ZOOM_IN[0]
          end
        end
      end
    elsif @magnify_x == -0.005
      if @background_sprite.zoom_x < MAP_ZOOM_IN[0]
        @background_sprite.zoom_x = MAP_ZOOM_IN[0]
        @map_icon.zoom_x = MAP_ZOOM_IN[0]
        if LOC_STATIC_ICON
          @stat_icon.each do |pic|
            pic.zoom_x = MAP_ZOOM_IN[0]
          end
        end
      end
    end
 
    @background_sprite.zoom_y = @background_sprite.zoom_y + @magnify_y
    @map_icon.zoom_y = @map_icon.zoom_y + @magnify_y
    if LOC_STATIC_ICON
      @stat_icon.each do |pic|
        pic.zoom_y = pic.zoom_y + @magnify_y
      end
    end
    if @magnify_y == 0.005
      if @background_sprite.zoom_y > MAP_ZOOM_IN[1]
        @background_sprite.zoom_y = MAP_ZOOM_IN[1]
        @map_icon.zoom_y = MAP_ZOOM_IN[1]
        if LOC_STATIC_ICON
          @stat_icon.each do |pic|
            pic.zoom_y = MAP_ZOOM_IN[1]
          end
        end
      end
    elsif @magnify_y == -0.005
      if @background_sprite.zoom_y < MAP_ZOOM_IN[1]
        @background_sprite.zoom_y = MAP_ZOOM_IN[1]
        @map_icon.zoom_y = MAP_ZOOM_IN[1]
        if LOC_STATIC_ICON
          @stat_icon.each do |pic|
            pic.zoom_y = MAP_ZOOM_IN[1]
          end
        end
      end
    end
 
    #---------------------------------------------------------------------------
    # Adjust the position.
    #---------------------------------------------------------------------------
    @last_position[0] = @background_sprite.x
    @last_position[1] = @background_sprite.y
    @last_zoom[0] = @background_sprite.zoom_x
    @last_zoom[1] = @background_sprite.zoom_y
  end
 
  def map_move(f_x, f_y, x, y, opacity)
 
    @distance_x = (x - f_x)/10
    if @distance_x > 0
      @distance_x = [MAX_SCROLL_SPEED, @distance_x].min
    end
    if @distance_x < 0
      @distance_x = [(MAX_SCROLL_SPEED*(-1)), @distance_x].max
    end
 
    if @distance_x == 0
      if @last_position[0] == LOCATION_COORDINATE[@map_index][0]
      elsif (x - f_x) < 0
        @distance_x = -1
      else
        @distance_x = 1        
      end
    end
 
    @distance_y = (y - f_y)/10
    if @distance_y > 0
      @distance_y = [MAX_SCROLL_SPEED, @distance_y].min
    end
    if @distance_y < 0
      @distance_y = [(MAX_SCROLL_SPEED*(-1)), @distance_y].max
    end
 
    if @distance_y == 0
      if @last_position[1] == LOCATION_COORDINATE[@map_index][1]
      elsif (y - f_y) < 0
        @distance_y = -1
      else
        @distance_y = 1        
      end
    end
 
  end
 
  def create_command_window
    @command_window = Window_MapSelect.new
    @command_window.opacity = 0 if WINDOW_PIC
    @command_window.x = WINDOW_POSITION[0]
    @command_window.y = WINDOW_POSITION[1]
    for i in 0..MAP_LIST.size - 1
      @command_window.set_handler(MAP_LIST[i].to_sym, method(MAP_LIST[i].to_sym))
    end
    @command_window.set_handler(:cancel,    method(:return_scene))
    @command_window.information_window_1 = @information_window_1
    @command_window.information_window_2 = @information_window_2
    @command_window.information_window_4 = @information_window_4
    @command_window.information_1_update if ADD_LOC_NAME
    @command_window.information_2_update if ADD_LOC_DESC
    information_3_update if ADD_LOC_THUMB
    @command_window.information_4_update if ADD_LOC_QUEST
  end
 
  def information_3_update
    if @information_window_3 != nil and @command_window !=nil
      bitmap_pic = @map_list[@command_window.index].to_s + "_Thumb"
      @information_window_3.bitmap = Cache.system(bitmap_pic)
    end
  end
 
  def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = Cache.system("Map_Select")    
    @background_sprite.ox = @background_sprite.bitmap.width / 2
    @background_sprite.oy = @background_sprite.bitmap.height / 2
    @background_sprite.x = Graphics.width / 2
    @background_sprite.y = Graphics.height / 2
    @background_sprite.zoom_x = MAP_ZOOM_OUT[0]
    @background_sprite.zoom_y = MAP_ZOOM_OUT[1]
  end
 
  def create_stat_icon
    @stat_icon = []
    @map_list.each do |loc|
      a = Sprite.new
      a.bitmap = Cache.system(loc + "STAT")
      a.ox = @background_sprite.bitmap.width / 2
      a.oy = @background_sprite.bitmap.height / 2
      a.zoom_x = MAP_ZOOM_OUT[0]
      a.zoom_y = MAP_ZOOM_OUT[1]
      a.x = Graphics.width / 2
      a.y = Graphics.height / 2
      a.z = 1
      @stat_icon.push(a)
    end
  end
 
  def create_map_icon
    @map_icon = Sprite.new
    @map_icon.bitmap = Bitmap.new(1,1)
    @map_icon.ox = @background_sprite.bitmap.width / 2
    @map_icon.oy = @background_sprite.bitmap.height / 2
    @map_icon.zoom_x = MAP_ZOOM_OUT[0]
    @map_icon.zoom_y = MAP_ZOOM_OUT[1]
    @map_icon.x = Graphics.width / 2
    @map_icon.y = Graphics.height / 2
    @map_icon.z = 2
  end
 
  MAP_LIST.each do |map_name|
    define_method(map_name) do
      list_number = assigned_number(map_name)
      transfer_map(list_number)
    end
  end
 
  def assigned_number(map_name)
    for i in 0..(MAP_LIST.size - 1)
      return i if MAP_LIST[i] == map_name
    end
  end
 
  def transfer_map(a)
    b = TELEPORT_LIST; $game_temp.fade_type = 2
    $game_player.reserve_transfer(b[a][0],b[a][1],b[a][2],b[a][3])
    return_scene
  end
 
  def close_command_window
    @command_window.close
	update until @command_window.close?
    fadeout_all
    @background_sprite.bitmap = nil
  end
 
  def black_dispose
    if WINDOW_PIC
      @map_window.bitmap.dispose
      @map_window.dispose
      @map_window = nil
    end
    
    @map_icon.bitmap.dispose ; @map_icon.dispose ; @map_icon = nil
 
    if ADD_WIN_PIC
      @info_window.bitmap.dispose
      @info_window.dispose
      @info_window = nil
    end
 
    if @background_sprite.bitmap != nil
      @background_sprite.bitmap.dispose
    end
    
    @background_sprite.dispose
    @background_sprite = nil
 
    @information_window_1.dispose if ADD_LOC_NAME
    @information_window_2.dispose if ADD_LOC_DESC
 
    if ADD_LOC_THUMB
      @information_window_3.bitmap.dispose
      @information_window_3.dispose
      @information_window_3 = nil
    end
 
    if LOC_STATIC_ICON
      @stat_icon.each do |pic|
        pic.bitmap.dispose; pic.dispose; pic = nil
      end
    end
 
    @information_window_4.dispose if ADD_LOC_QUEST
    @current_party_window.dispose if ADD_CUR_PARTY
  end
 
  def return_scene
    close_command_window; black_dispose
    super; RPG::BGM.fade(500)
    $game_map.autoplay; Cache.clear
  end
 
end
 
#-------------------------------------------------------------------------------
# * Map Command List Window
#-------------------------------------------------------------------------------
class Window_MapSelect < Window_Command
  include BLACK_MAP_LIST  
  #-----------------------------------------------------------------------------
  # * Object Initialization
  #-----------------------------------------------------------------------------
  def initialize
    create_maplist; super(0, 0); self.openness = 0; open
  end
  def window_height; fitting_height(MAP_WINDOW_HEIGHT); end
  def window_width; return MAP_WINDOW_WIDTH; end
 
  #-----------------------------------------------------------------------------
  # * Create Command List
  #-----------------------------------------------------------------------------
  def make_command_list
    for i in 0..@map_list.size - 1
      add_command(@map_list[i], @map_list[i].to_sym) if @map_list.size != 0
    end
  end
 
  #-----------------------------------------------------------------------------
  # * Get unlocked map list
  #-----------------------------------------------------------------------------
  def create_maplist
    @map_list = []
    for i in 0..MAP_LIST.size - 1
      @map_list.push(MAP_LIST[i]) if $game_switches[SWITCH_LIST[i]] == true
    end
  end
 
  def index=(index)
    super
    SceneManager.scene.location_update_index
    information_1_update if ADD_LOC_NAME
    information_2_update if ADD_LOC_DESC
    SceneManager.scene.information_3_update if ADD_LOC_THUMB
    information_4_update if ADD_LOC_QUEST
  end
 
  #-----------------------------------------------------------------------------
  # * Draw Item
  #-----------------------------------------------------------------------------
  def draw_item(index)
    font_color = assigned_number(command_name(index))
    change_color(text_color(TEXT_LOCA_COLOR[font_color]), command_enabled?(index))
    draw_text(item_rect_for_text(index), command_name(index), alignment)
  end    
 
  #-----------------------------------------------------------------------------
  # * Information Window stuff
  #-----------------------------------------------------------------------------
  def information_window_1=(information_window)
    @information_window_1 = information_window
  end
 
  def information_window_2=(information_window)
    @information_window_2 = information_window
  end
 
  def information_window_4=(information_window)
    @information_window_4 = information_window
  end
 
  def information_1_update
    if @information_window_1 != nil
      @information_window_1.clear
      text = @map_list[self.index].to_s
      @information_window_1.set_text(text)
    end
  end
 
  def information_2_update
    if @information_window_2 != nil
      @information_window_2.clear
      text = ADD_LOC_DESC_VALUE[assigned_number(@map_list[self.index].to_s)]
      @information_window_2.set_text(text)
    end
  end
 
  def information_4_update
    if @information_window_4 != nil
      @information_window_4.clear; text = ""
      map_num = assigned_number(@map_list[self.index].to_s)
      for i in 0..ADD_LOC_QUEST_S[map_num].size - 1
        if ADD_LOC_QUEST_S[map_num].size != -1
          if $game_switches[ADD_LOC_QUEST_S[map_num][i]]
            quest_desc = assigned_quest(ADD_LOC_QUEST_S[map_num][i])
            text = text + "\n" + ADD_LOC_Q_TEXT[quest_desc][1]
          end
        end
      end
      @information_window_4.set_text(text)
    end
  end
  #-----------------------------------------------------------------------------
 
  #-----------------------------------------------------------------------------
  # * Return location number from location name
  #-----------------------------------------------------------------------------
  def assigned_number(map_name)
    for i in 0..(MAP_LIST.size - 1)
      return i if MAP_LIST[i] == map_name
    end
  end
 
  #-----------------------------------------------------------------------------
  # * Return quest number from quest switch
  #-----------------------------------------------------------------------------
  def assigned_quest(quest_switch)
    for i in 0..ADD_LOC_Q_TEXT.size - 1
      return i if ADD_LOC_Q_TEXT[i][0] == quest_switch
    end
  end
 
  def get_map_list; return @map_list; end
end
#-------------------------------------------------------------------------------
 
 
#-------------------------------------------------------------------------------
# * Map Additional Location Name Window
#-------------------------------------------------------------------------------
class Window_Inf_Base < Window_Base
  include BLACK_MAP_LIST
  def set_text(text); (@text = text; refresh) if text != @text; end
  def clear; set_text(""); end
  def refresh; contents.clear; draw_text_ex(4, 0, @text); end
end
 
class Window_Information_1 < Window_Inf_Base
  include BLACK_MAP_LIST
  def initialize
    super(ADD_LOC_NAME_POS[0], ADD_LOC_NAME_POS[1], ADD_LOC_NAME_W_H[0], ADD_LOC_NAME_W_H[1])
  end
  def reset_font_settings
    super # run's Window_Base's reset_font_settings
    contents.font.size = ADD_LOC_NAME_F_SIZE
  end
end
 
class Window_Information_2 < Window_Inf_Base
  include BLACK_MAP_LIST
  def initialize
    super(ADD_LOC_DESC_POS[0], ADD_LOC_DESC_POS[1], ADD_LOC_DESC_W_H[0], ADD_LOC_DESC_W_H[1])
  end
  def reset_font_settings
    super # run's Window_Base's reset_font_settings
    contents.font.size = ADD_LOC_DESC_F_SIZE
  end
end
 
# Where is Window_Information_3, you ask? Good question, as I too wondering 
# why there isn't any here. Why the fuck do I skipped over it?
 
class Window_Information_4 < Window_Inf_Base
  include BLACK_MAP_LIST
  def initialize
    super(ADD_LOC_QUEST_POS[0], ADD_LOC_QUEST_POS[1], ADD_LOC_QUEST_W_H[0], ADD_LOC_QUEST_W_H[1])
  end
  def reset_font_settings
    super # run's Window_Base's reset_font_settings
    contents.font.size = ADD_LOC_QUEST_F_SIZE
  end  
end
#-------------------------------------------------------------------------------
 
 
#-------------------------------------------------------------------------------
# * Window Current Party
#-------------------------------------------------------------------------------
class Window_Current_Party < Window_Base  
  include BLACK_MAP_LIST
  def initialize
    super(ADD_CUR_PARTY_POS[0], ADD_CUR_PARTY_POS[1], ADD_CUR_PARTY_W_H[0], ADD_CUR_PARTY_W_H[1])
  end
  def item_max; return $game_party.members.size; end
  def draw_all_items; item_max.times {|i| draw_item(i) }; end  
  def draw_item(index)
    @actor = $game_party.members[index]
    (x_pos = 60; draw_actor_graphic(@actor, index*40 + 20, 45)) if @actor != nil
  end  
  def refresh; contents.clear; draw_all_items end  
end
#-------------------------------------------------------------------------------
