# Function for checking if an item is a battle item.
def pbIsBattleItem?(item)
  return $ItemData[item] && ($ItemData[item][ITEMBATTLEUSE]==0 && $ItemData[item][ITEMPOCKET]==1)
end
#===============================================================================
# * Bag screen
#===============================================================================
class Window_PokemonBag < Window_DrawableCommand
  attr_reader :pocket
  attr_reader :sortIndex

  def initialize(bag,pocket,x,y,width,height)
    @bag=bag
    @pocket=pocket
    @sortIndex=-1
    @adapter=PokemonMartAdapter.new
    super(x,y,width,height)
    @row_height=48
    @selarrow=AnimatedBitmap.new("Graphics/Pictures/Bag/panel_select")
    @panel=AnimatedBitmap.new("Graphics/Pictures/Bag/panel")
    @pokeball=AnimatedBitmap.new("Graphics/Pictures/Bag/icon_pokeball")
    @mail=AnimatedBitmap.new("Graphics/Pictures/Bag/icon_mail")
    @tm=AnimatedBitmap.new("Graphics/Pictures/Bag/icon_tm")
    @hm=AnimatedBitmap.new("Graphics/Pictures/Bag/icon_hm")
    @battle_item=AnimatedBitmap.new("Graphics/Pictures/Bag/icon_item")
    self.windowskin=nil
  end

  def pocket=(value)
    @pocket=value
    thispocket=@bag.pockets[@pocket]
    @item_max=thispocket.length+1
    self.index=@bag.getChoice(@pocket)
    refresh
  end

  def sortIndex=(value)
    @sortIndex=value
    refresh
  end

  def page_row_max; return PokemonBag_Scene::ITEMSVISIBLE; end
  def page_item_max; return PokemonBag_Scene::ITEMSVISIBLE; end

  def itemRect(item)
    if item<0 || item>=@item_max || item<self.top_item-1 ||
       item>self.top_item+self.page_item_max
      return Rect.new(0,0,0,0)
    else
      cursor_width = (self.width-self.borderX-(@column_max-1)*@column_spacing) / @column_max
      x = item % @column_max * (cursor_width + @column_spacing)
      y = item / @column_max * @row_height- @virtualOy #48 , virtualoy*1.5
      return Rect.new(x, y, cursor_width,48)
    end
  end

   def drawCursor(index,rect)
     # Creating panels
     if self.index==index
      # @selarrow=AnimatedBitmap.new("Graphics/Pictures/Bag/panel_select")
       pbCopyBitmap($bag_bitmap,@selarrow.bitmap,rect.x+6+48,rect.y+23) 
      else
       @panel=AnimatedBitmap.new("Graphics/Pictures/Bag/panel") if !@panel
       pbCopyBitmap($bag_bitmap,@panel.bitmap,rect.x+6+48,rect.y+23) #6
     end
     # Creating icons
     if @current_item
       if pbIsPokeBall?(@current_item)
        # @pokeball=AnimatedBitmap.new("Graphics/Pictures/Bag/icon_pokeball") if !@pokeball
         pbCopyBitmap($bag_bitmap,@pokeball.bitmap,rect.x-26+48,rect.y+23)
       elsif pbIsMail?(@current_item)
        # @mail=AnimatedBitmap.new("Graphics/Pictures/Bag/icon_mail")
         pbCopyBitmap($bag_bitmap,@mail.bitmap,rect.x-26+48,rect.y+23)
       elsif pbIsTechnicalMachine?(@current_item)
        # @tm=AnimatedBitmap.new("Graphics/Pictures/Bag/icon_tm") if !@tm
         pbCopyBitmap($bag_bitmap,@tm.bitmap,rect.x-34+48,rect.y+23)
       elsif pbIsHiddenMachine?(@current_item)
         pbCopyBitmap($bag_bitmap,@hm.bitmap,rect.x-34+48,rect.y+23)
       elsif pbIsBattleItem?(@current_item)
         @battle_item=AnimatedBitmap.new("Graphics/Pictures/Bag/icon_item") if !@battle_item
         pbCopyBitmap($bag_bitmap,@battle_item.bitmap,rect.x-26+48,rect.y+23)
      end
    end
    return Rect.new(rect.x+16,rect.y+24,rect.width-16,rect.height+24)
  end
  def item
    thispocket=@bag.pockets[self.pocket]
    item=thispocket[self.index]
    return item ? item[0] : 0
  end
  
  def itemCount
    return @bag.pockets[self.pocket].length+1
  end

  def drawItem(index,count,rect)
    textpos=[]
    rect=drawCursor(index,rect)
    ypos=rect.y+4
    if index==@bag.pockets[self.pocket].length
      textpos.push([_INTL("CLOSE BAG"),rect.x+48,ypos,false,
         self.baseColor,self.shadowColor])
    else
      item=@bag.pockets[self.pocket][index][0]
      @current_item=item
      itemname=@adapter.getDisplayName(item)
      qty=_ISPRINTF("x{1: 2d}",@bag.pockets[self.pocket][index][1])
      sizeQty=self.contents.text_size(qty).width
      xQty=rect.x+rect.width-sizeQty-16
      baseColor=(index==@sortIndex) ? Color.new(255,255,255) : self.baseColor
      shadowColor=(index==@sortIndex) ? Color.new(165,165,173) : self.shadowColor
      
      if pbIsHiddenMachine?(item) && self.index==index
        textpos.push([itemname,rect.x+48,ypos,false,Color.new(239,214,255),Color.new(189,148,206)])
      elsif pbIsHiddenMachine?(item)
        textpos.push([itemname,rect.x+48,ypos,false,Color.new(206,123,255),Color.new(123,82,148)])
      else
        textpos.push([itemname,rect.x+48,ypos,false,baseColor,shadowColor])
      end
      
      if !pbIsImportantItem?(item) # Not a Key item or HM (or infinite TM)
        textpos.push([qty,xQty+48,ypos,false,baseColor,shadowColor])
      end
    end
    pbDrawTextPositions($bag_bitmap,textpos)
    if index!=@bag.pockets[self.pocket].length
      if @bag.registeredItem==@bag.pockets[self.pocket][index][0]
        pbDrawImagePositions($bag_bitmap,[
           ["Graphics/Pictures/bagReg",rect.x+rect.width-58,ypos+4,0,0,-1,-1]
        ])
      end
    end
  end

  def refresh
    @item_max=itemCount()
    dwidth=self.width-self.borderX
    dheight=self.height-self.borderY
    self.contents=pbDoEnsureBitmap(self.contents,dwidth,dheight)
    self.contents.clear
    $bag_bitmap=self.contents
    for i in 0...@item_max
      if i<self.top_item-1  || i>self.top_item+self.page_item_max
        next
      end
      drawItem(i,@item_max,itemRect(i))
    end
  end
end

class PokemonBag_Scene
  #attr_accessor :sprites # creates a class function of sprites.
## Configuration
  ITEMLISTBASECOLOR     = Color.new(88,88,80)
  ITEMLISTSHADOWCOLOR   = Color.new(168,184,184)
  ITEMTEXTBASECOLOR     = Color.new(248,248,248)
  ITEMTEXTSHADOWCOLOR   = Color.new(0,0,0)
  POCKETNAMEBASECOLOR   = Color.new(88,88,80)
  POCKETNAMESHADOWCOLOR = Color.new(168,184,184)
  ITEMSVISIBLE          = 6#7

  def update
    pbUpdateSpriteHash(@sprites)
  end
  
  def sprites
    return @sprites
  end

  def pbStartScene(bag)
    @bag=bag
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=999999
    @sprites={}
    lastpocket=@bag.lastpocket 
    lastitem=@bag.getChoice(lastpocket) 
    @sprites["background"]=IconSprite.new(0,0,@viewport)
    @sprites["background"].setBitmap("Graphics/Pictures/Bag/bg")
    @sprites["background"].setBitmap("Graphics/Pictures/Bag/bg_f") if $Trainer.isFemale?
    @sprites["item_bg"]=IconSprite.new(0,0,@viewport)
    @sprites["item_bg"].setBitmap("Graphics/Pictures/Bag/item_bg")
    @sprites["item_bg"].setBitmap("Graphics/Pictures/Bag/item_bg_f") if $Trainer.isFemale?
    @sprites["item_bg"].visible=false
    @sprites["bag"]=IconSprite.new(0,0,@viewport)
    @sprites["bag"].y=46
    @sprites["itemwindow"]=Window_PokemonBag.new(@bag,lastpocket,281-32-48,-15,512,384) 
    @sprites["itemwindow"].viewport=@viewport
    @sprites["itemwindow"].pocket=lastpocket
    @sprites["itemwindow"].index=lastitem
    @sprites["itemwindow"].baseColor=Color.new(255,255,255)
    @sprites["itemwindow"].shadowColor=Color.new(156,156,156)
    @sprites["itemwindow"].refresh
    @sprites["slider"]=IconSprite.new(Graphics.width-40,60,@viewport)
    @sprites["slider"].setBitmap(sprintf("Graphics/Pictures/Bag/slider"))
    @sprites["slider"].x=486
    @sprites["itemtextwindow"]=Window_UnformattedTextPokemon.new("")
    @sprites["itemtextwindow"].x=20
    @sprites["itemtextwindow"].y=184
    @sprites["itemtextwindow"].visible=false
    @sprites["itemtextwindow"].width=Graphics.width-72
    @sprites["itemtextwindow"].height=128
    @sprites["itemtextwindow"].baseColor=Color.new(255,255,255)
    @sprites["itemtextwindow"].shadowColor=Color.new(123,148,173) 
    @sprites["itemtextwindow"].shadowColor=Color.new(231,123,148) if $Trainer.isFemale?
    @sprites["itemtextwindow"].viewport=@viewport
    @sprites["itemtextwindow"].windowskin=nil
    @sprites["helpwindow"]=Window_UnformattedTextPokemon.new("")
    @sprites["helpwindow"].visible=false
    @sprites["helpwindow"].viewport=@viewport
    @sprites["helpwindow"].z=999999
    @sprites["msgwindow"]=Window_AdvancedTextPokemon.new("")
    @sprites["msgwindow"].visible=false
    @sprites["msgwindow"].viewport=@viewport
    @sprites["down_bg"]=IconSprite.new(0,0,@viewport)
    @sprites["down_bg"].setBitmap("Graphics/Pictures/Universal/down_bg")
    @sprites["down_bg"].y= 384-48
    @sprites["down_bg"].z=999999
    @sprites["switch"]=IconSprite.new(0,0,@viewport)
    @sprites["switch"].setBitmap("Graphics/Pictures/Bag/switch")
    @sprites["switch"].x=6
    @sprites["switch"].y=346
    @sprites["switch"].z=999999
    @sprites["f1"]=IconSprite.new(0,0,@viewport)
    @sprites["f1"].setBitmap("Graphics/Pictures/Bag/f1")
    @sprites["f1"].x=294
    @sprites["f1"].y=340
    @sprites["f1"].z=999999
    @sprites["box"]=IconSprite.new(0,0,@viewport)
    @sprites["box"].setBitmap("Graphics/Pictures/Universal/box")
    @sprites["box"].x=346
    @sprites["box"].y=344
    @sprites["box"].z=999999
    @sprites["exit"]=IconSprite.new(0,0,@viewport)
    @sprites["exit"].setBitmap("Graphics/Pictures/Universal/exit")
    @sprites["exit"].x=385
    @sprites["exit"].y=346
    @sprites["exit"].z=999999
    @sprites["return"]=IconSprite.new(0,0,@viewport)
    @sprites["return"].setBitmap("Graphics/Pictures/Universal/return")
    @sprites["return"].x=459
    @sprites["return"].y=346
    @sprites["return"].z=999999
    @sprites["icon"]=IconSprite.new(230,127,@viewport)
    @sprites["icon"].visible=false
    @sprites["overlay"]=BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @sprites["overlay"].visible=false
    @sprites["pocketwindow"]=BitmapSprite.new(512,384,@viewport)# medicine,key items etc...
    @sprites["pocketwindow"].z=999999
    pbSetSystemFont(@sprites["pocketwindow"].bitmap)
    pbBottomLeftLines(@sprites["helpwindow"],1)
    pbDeactivateWindows(@sprites)
    pbRefresh
    pbFadeInAndShow(@sprites) 
  end

  def pbEndScene
    pbFadeOutAndHide(@sprites)
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end

  def pbChooseNumber(helptext,maximum)
    return UIHelper.pbChooseNumber(
       @sprites["helpwindow"],helptext,maximum) { update }
  end

  def pbDisplay(msg,brief=false)
    UIHelper.pbDisplay(@sprites["msgwindow"],msg,brief) { update }
  end

  def pbConfirm(msg)
    UIHelper.pbConfirm(@sprites["msgwindow"],msg) { update }
  end

  def pbShowCommands(helptext,commands)
    return UIHelper.pbShowCommands(
       @sprites["helpwindow"],helptext,commands) { update }
  end

  def pbRefresh
    bm=@sprites["pocketwindow"].bitmap
    bm.clear
    # Set the bag picture for the currently selected pocket
    fbagexists=pbResolveBitmap(sprintf("Graphics/Pictures/Bag/pocket_#{@bag.lastpocket}f"))
    if $Trainer.isFemale? && fbagexists
      @sprites["bag"].setBitmap("Graphics/Pictures/Bag/pocket_#{@bag.lastpocket}f")
    else
      @sprites["bag"].setBitmap("Graphics/Pictures/Bag/pocket_#{@bag.lastpocket}")
    end
    # Draw the pocket name
    name=PokemonBag.pocketNames()[@bag.lastpocket]
    base=Color.new(255,255,255)
    shadow=Color.new(165,165,173)
    pbDrawTextPositions(bm,[
       [name,117+28,344,2,base,shadow]
    ])
    itemwindow=@sprites["itemwindow"]
    # Draw the slider
    ycoord=36
    if itemwindow.itemCount>1
      ycoord+=228.0 * itemwindow.index/(itemwindow.itemCount-1)
    end
    @sprites["slider"].y=ycoord
    # Set the icon for the currently selected item
    filename=pbItemIconFile(itemwindow.item)
    @sprites["icon"].setBitmap(filename)
    # Display the item's description
    @sprites["itemtextwindow"].text=(itemwindow.item==0) ? _INTL("Close bag.") : 
       pbGetMessage(MessageTypes::ItemDescriptions,itemwindow.item)
    # Refresh the item window
    itemwindow.refresh
  end

# Called when the item screen wants an item to be chosen from the screen
  def pbChooseItem
    pbRefresh
    @sprites["helpwindow"].visible=false
    itemwindow=@sprites["itemwindow"]
    itemwindow.refresh
    sorting=false
    sortindex=-1
    pbActivateWindow(@sprites,"itemwindow"){
       loop do
         Graphics.update
         Input.update
         olditem=itemwindow.item
         oldindex=itemwindow.index
         self.update
         if itemwindow.item!=olditem
           # Update slider position
           ycoord=36
           if itemwindow.itemCount>1
             ycoord+=228.0 * itemwindow.index/(itemwindow.itemCount-1)
           end
           @sprites["slider"].y=ycoord
           # Update item icon and description
           filename=pbItemIconFile(itemwindow.item)
           @sprites["icon"].setBitmap(filename)
           @sprites["itemtextwindow"].text=(itemwindow.item==0) ? _INTL("Close bag.") :
              pbGetMessage(MessageTypes::ItemDescriptions,itemwindow.item)
         end
         if itemwindow.index!=oldindex
           # Update selected item for current pocket
           @bag.setChoice(itemwindow.pocket,itemwindow.index)
         end
         # Change pockets if Left/Right pressed
         numpockets=PokemonBag.numPockets
         if Input.trigger?(Input::LEFT)
           if !sorting
             itemwindow.pocket=(itemwindow.pocket==1) ? numpockets : itemwindow.pocket-1
             @bag.lastpocket=itemwindow.pocket
             pbRefresh
           end
         elsif Input.trigger?(Input::RIGHT)
           if !sorting
             itemwindow.pocket=(itemwindow.pocket==numpockets) ? 1 : itemwindow.pocket+1
             @bag.lastpocket=itemwindow.pocket
             pbRefresh
           end
         end
         # Select item for switching if A is pressed
         if Input.trigger?(Input::A)
           thispocket=@bag.pockets[itemwindow.pocket]
           if itemwindow.index<thispocket.length && thispocket.length>1 &&
              !POCKETAUTOSORT[itemwindow.pocket]
             sortindex=itemwindow.index
             sorting=true
             @sprites["itemwindow"].sortIndex=sortindex
           else
             next
           end
         end
         # Cancel switching or cancel the item screen
         if Input.trigger?(Input::B)
           if sorting
             sorting=false
             @sprites["itemwindow"].sortIndex=-1
           else
             @sprites["exit"].setBitmap("Graphics/Pictures/Universal/exit2")
             pbWait(10)
             @sprites["exit"].setBitmap("Graphics/Pictures/Universal/exit")
             pbWait(5)
             return 0
           end
         end
         if defined?($mouse)
           if $mouse.leftClick?(@sprites["exit"])
             @sprites["exit"].setBitmap("Graphics/Pictures/Universal/exit2")
             pbWait(10)
             @sprites["exit"].setBitmap("Graphics/Pictures/Universal/exit")
             pbWait(5)
             return 0
           elsif $mouse.leftClick?(@sprites["return"])
             @sprites["return"].setBitmap("Graphics/Pictures/Universal/return2")
             pbWait(10)
             @sprites["return"].setBitmap("Graphics/Pictures/Universal/return")
             pbWait(5)
             $MenuClose=true
             return 0
           elsif $mouse.inAreaLeft?(6,346,33,28) && !sorting
             @sprites["switch"].setBitmap("Graphics/Pictures/Bag/switch2")
             pbWait(10)
             @sprites["switch"].setBitmap("Graphics/Pictures/Bag/switch")
             pbWait(5)
             itemwindow.pocket=(itemwindow.pocket==1) ? numpockets : itemwindow.pocket-1
             @bag.lastpocket=itemwindow.pocket
             pbRefresh
          elsif $mouse.inAreaLeft?(247,346,33,28) && !sorting
             @sprites["switch"].setBitmap("Graphics/Pictures/Bag/switch3")
             pbWait(10)
             @sprites["switch"].setBitmap("Graphics/Pictures/Bag/switch")
             pbWait(5)
             itemwindow.pocket=(itemwindow.pocket==1) ? numpockets : itemwindow.pocket-1
             @bag.lastpocket=itemwindow.pocket
             pbRefresh
             
           end
         end
   if $mouse.inAreaLeft?(@sprites["slider"].x-8,430,@sprites["slider"].bitmap.width+16,272)
     newPos=$mouse.y
      if newPos<36
        newPos=36
      elsif newPos>36+234
        newPos=36+234
      end
      
      @sprites["slider"].y=newPos
      pocketitems=itemwindow.itemCount
      getPosition=(@sprites["slider"].y-36)/234.to_f
      getIndex=pocketitems*getPosition
         
      if getIndex.to_i>=pocketitems
        itemwindow.index=pocketitems-1
      elsif getIndex.to_i<0
        itemwindow.index=0
      else
        itemwindow.index=getIndex.to_i
      end
      pbRefresh(false)
    end

         # Confirm selection or item switch
         if Input.trigger?(Input::C)
           thispocket=@bag.pockets[itemwindow.pocket]
           if itemwindow.index<thispocket.length
             if sorting
               sorting=false
               tmp=thispocket[itemwindow.index]
               thispocket[itemwindow.index]=thispocket[sortindex]
               thispocket[sortindex]=tmp
               @sprites["itemwindow"].sortIndex=-1
               pbRefresh
               next
             else
               pbRefresh
               return thispocket[itemwindow.index][0]
             end
           else
             return 0
           end
         end
       end
    }
  end
end



class PokemonBagScreen
  
  def initialize(scene,bag)
    @bag=bag
    @scene=scene
  end

  def pbDisplay(text)
    @scene.pbDisplay(text)
  end

  def pbConfirm(text)
    return @scene.pbConfirm(text)
  end

# UI logic for the item screen when an item is to be held by a Pokémon.
  def pbGiveItemScreen
    @scene.pbStartScene(@bag)
    @otherclass=PokemonBag_Scene.new
    item=0
    loop do
      item=@scene.pbChooseItem
      if item==0
        pbFadeOutAndHide(@scene.sprites)
        break
      end
      
      itemname=PBItems.getName(item)
      # Key items and hidden machines can't be held
      if pbIsImportantItem?(item)
        @scene.pbDisplay(_INTL("The {1} can't be held.",itemname))
        next
      else
        break
      end
    end
    @scene.pbEndScene
    return item
  end

# UI logic for the item screen for choosing an item
  def pbChooseItemScreen
    oldlastpocket=@bag.lastpocket
    @scene.pbStartScene(@bag)
    @otherclass=PokemonBag_Scene.new
    item=@scene.pbChooseItem
    @scene.pbEndScene
    @bag.lastpocket=oldlastpocket
    return item
  end

# UI logic for the item screen for choosing a Berry
  def pbChooseBerryScreen
    oldlastpocket=@bag.lastpocket
    @bag.lastpocket=BERRYPOCKET
    @scene.pbStartScene(@bag)
    @otherclass=PokemonBag_Scene.new
    item=0
    loop do
      item=@scene.pbChooseItem
      break if item==0
      itemname=PBItems.getName(item)
      if !pbIsBerry?(item)
        @scene.pbDisplay(_INTL("That's not a Berry.",itemname))
        next
      else
        break
      end
    end
    @scene.pbEndScene
    @bag.lastpocket=oldlastpocket
    return item
  end

# UI logic for tossing an item in the item screen.
  def pbTossItemScreen
    if !$PokemonGlobal.pcItemStorage
      $PokemonGlobal.pcItemStorage=PCItemStorage.new
    end
    storage=$PokemonGlobal.pcItemStorage
    @scene.pbStartScene(storage)
    loop do
      item=@scene.pbChooseItem
      break if item==0
      if pbIsImportantItem?(item)
        @scene.pbDisplay(_INTL("That's too important to toss out!"))
        next
      end
      qty=storage.pbQuantity(item)
      itemname=PBItems.getName(item)
      if qty>1
        qty=@scene.pbChooseNumber(_INTL("Toss out how many {1}(s)?",itemname),qty)
      end
      if qty>0
        if pbConfirm(_INTL("Is it OK to throw away {1} {2}(s)?",qty,itemname))
          if !storage.pbDeleteItem(item,qty)
            raise "Can't delete items from storage"
          end
          pbDisplay(_INTL("Threw away {1} {2}(s).",qty,itemname))
        end
      end
    end
    @scene.pbEndScene
  end

# UI logic for withdrawing an item in the item screen.
  def pbWithdrawItemScreen
    if !$PokemonGlobal.pcItemStorage
      $PokemonGlobal.pcItemStorage=PCItemStorage.new
    end
    storage=$PokemonGlobal.pcItemStorage
    @scene.pbStartScene(storage)
    loop do
      item=@scene.pbChooseItem
      break if item==0
      commands=[_INTL("Withdraw"),_INTL("Give"),_INTL("Cancel")]
      itemname=PBItems.getName(item)
      command=@scene.pbShowCommands(_INTL("{1} is selected.",itemname),commands)
      if command==0
        qty=storage.pbQuantity(item)
        if qty>1
          qty=@scene.pbChooseNumber(_INTL("How many do you want to withdraw?"),qty)
        end
        if qty>0
          if !@bag.pbCanStore?(item,qty)
            pbDisplay(_INTL("There's no more room in the Bag."))
          else
            pbDisplay(_INTL("Withdrew {1} {2}(s).",qty,itemname))
            if !storage.pbDeleteItem(item,qty)
              raise "Can't delete items from storage"
            end
            if !@bag.pbStoreItem(item,qty)
              raise "Can't withdraw items from storage"
            end
          end
        end
      elsif command==1 # Give
        if $Trainer.pokemonCount==0
          @scene.pbDisplay(_INTL("There is no Pokémon."))
          return 0
        elsif pbIsImportantItem?(item)
          @scene.pbDisplay(_INTL("The {1} can't be held.",itemname))
        else
          pbFadeOutIn(99999){
             sscene=PokemonScreen_Scene.new
             sscreen=PokemonScreen.new(sscene,$Trainer.party)
             if sscreen.pbPokemonGiveScreen(item)
               # If the item was held, delete the item from storage
               if !storage.pbDeleteItem(item,1)
                 raise "Can't delete item from storage"
               end
             end
             @scene.pbRefresh
          }
        end
      end
    end
    @scene.pbEndScene
  end

# UI logic for depositing an item in the item screen.
  def pbDepositItemScreen
    @scene.pbStartScene(@bag)
    if !$PokemonGlobal.pcItemStorage
      $PokemonGlobal.pcItemStorage=PCItemStorage.new
    end
    storage=$PokemonGlobal.pcItemStorage
    item=0
    loop do
      item=@scene.pbChooseItem
      break if item==0
      qty=@bag.pbQuantity(item)
      if qty>1
        qty=@scene.pbChooseNumber(_INTL("How many do you want to deposit?"),qty)
      end
      if qty>0
        itemname=PBItems.getName(item)
        if !storage.pbCanStore?(item,qty)
          pbDisplay(_INTL("There's no room to store items."))
        else
          pbDisplay(_INTL("Deposited {1} {2}(s).",qty,itemname))
          if !@bag.pbDeleteItem(item,qty)
            raise "Can't delete items from bag"
          end
          if !storage.pbStoreItem(item,qty)
            raise "Can't deposit items to storage"
          end
        end
      end
    end
    @scene.pbEndScene
  end
  
  def pbUpdateItemWindow
    item=0
    loop do
      item=@scene.pbChooseItem
      break if item==0
      @scene.sprites["bag"].visible=false
      @scene.sprites["down_bg"].visible=false
      @scene.sprites["switch"].visible=false
      @scene.sprites["f1"].visible=false
      @scene.sprites["box"].visible=false
      @scene.sprites["exit"].visible=false
      @scene.sprites["return"].visible=false
      @scene.sprites["pocketwindow"].visible=false
      @scene.sprites["slider"].visible=false
      @scene.sprites["item_bg"].visible=true
      @scene.sprites["itemtextwindow"].visible=true
      #@scene.sprites["helpwindow"].visible=true
      @scene.sprites["msgwindow"].visible=true
      @scene.sprites["icon"].visible=true
      @scene.sprites["overlay"].visible=true
      $bag_bitmap.clear
      overlay= @scene.sprites["overlay"].bitmap
      overlay.clear
      base=Color.new(255,255,255)
      shadow=Color.new(123,148,173)
      shadow=Color.new(231,123,148) if $Trainer.isFemale?
      pbSetSystemFont(@scene.sprites["overlay"].bitmap)
      @adapter=PokemonMartAdapter.new
      itemname=@adapter.getDisplayName(item)
      # Changes String from Machines.
      # Example 1: TM02 Dragon Claw --> No. 02 Dragon Claw
      # Example 2: HM03 Surf ---> Hidden 03 Surf
      if pbIsMachine?(item)
        itemname=itemname[2..-1] # deleting first two characters of the string.
        if pbIsTechnicalMachine?(item)
          itemname.insert(0,"No. ") # adding characters to the string.
        elsif pbIsHiddenMachine?(item)
          itemname.insert(0,"Hidden ") # adding characters to the string.
        end
      end
      textos=[]
      textos.push([itemname,256,86,2,base,shadow])
      show_itemquantity=true
      show_itemquantity=false if pbIsKeyItem?(item)
      show_itemquantity=false if pbIsHiddenMachine?(item)
      show_itemquantity=false if (pbIsTechnicalMachine?(item) && INFINITETMS)
      if show_itemquantity
        textos.push([_INTL("x#{@bag.pbQuantity(item)}"),315,136,0,base,shadow])
      end
      pbDrawTextPositions(overlay,textos)
      if Input.press?(Input::C)
        @scene.sprites["helpwindow"].visible=true
        break
      end
      if Input.trigger?(Input::B)
        @scene.sprites["bag"].visible=true
        @scene.sprites["down_bg"].visible=true
        @scene.sprites["switch"].visible=true
        @scene.sprites["f1"].visible=true
        @scene.sprites["box"].visible=true
        @scene.sprites["exit"].visible=true
        @scene.sprites["return"].visible=true
        @scene.sprites["pocketwindow"].visible=true
        @scene.sprites["slider"].visible=true
        @scene.sprites["item_bg"].visible=false
        @scene.sprites["itemtextwindow"].visible=false
        @scene.sprites["helpwindow"].visible=false
        @scene.sprites["msgwindow"].visible=false
        break
      end
    end
  end

  def pbStartScreen
    #@otherclass=PokemonBag_Scene.new
    #@otherclass.sprites["background"].visible=false
    @scene.pbStartScene(@bag)
   #@scene.sprites["itemwindow"].visible=false
   loop do
     pbUpdateItemWindow
      item=@scene.pbChooseItem
      break if item==0
      cmdUse=-1
      cmdRegister=-1
      cmdGive=-1
      cmdToss=-1
      cmdRead=-1
      cmdMysteryGift=-1
      commands=[]
      # Generate command list
      commands[cmdRead=commands.length]=_INTL("Read") if pbIsMail?(item)
      commands[cmdUse=commands.length]=_INTL("Use") if ItemHandlers.hasOutHandler(item) || (pbIsMachine?(item) && $Trainer.party.length>0)
      commands[cmdGive=commands.length]=_INTL("Give") if $Trainer.party.length>0 && !pbIsImportantItem?(item)
      commands[cmdToss=commands.length]=_INTL("Toss") if !pbIsImportantItem?(item) || $DEBUG
      if @bag.registeredItem==item
        commands[cmdRegister=commands.length]=_INTL("Deselect")
      elsif pbIsKeyItem?(item) && ItemHandlers.hasKeyItemHandler(item)
        commands[cmdRegister=commands.length]=_INTL("Register")
      end
      commands[cmdMysteryGift=commands.length]=_INTL("Make Mystery Gift") if $DEBUG
      commands[commands.length]=_INTL("Cancel")
      # Show commands generated above
      itemname=PBItems.getName(item) # Get item name
      command=@scene.pbShowCommands(_INTL("{1} is selected.",itemname),commands)
      if cmdUse>=0 && command==cmdUse # Use item
        ret=pbUseItem(@bag,item,@scene)
        # 0=Item wasn't used; 1=Item used; 2=Close Bag to use in field
        break if ret==2 # End screen
        @scene.pbRefresh
        next
      elsif cmdRead>=0 && command==cmdRead # Read mail
        pbFadeOutIn(99999){
           pbDisplayMail(PokemonMail.new(item,"",""))
        }
      elsif cmdRegister>=0 && command==cmdRegister # Register key item
        @bag.pbRegisterKeyItem(item)
        @scene.pbRefresh
      elsif cmdGive>=0 && command==cmdGive # Give item to Pokémon
        if $Trainer.pokemonCount==0
          @scene.pbDisplay(_INTL("There is no Pokémon."))
        elsif pbIsImportantItem?(item)
          @scene.pbDisplay(_INTL("The {1} can't be held.",itemname))
        else
          # Give item to a Pokémon
          pbFadeOutIn(99999){
             sscene=PokemonScreen_Scene.new
             sscreen=PokemonScreen.new(sscene,$Trainer.party)
             sscreen.pbPokemonGiveScreen(item)
             @scene.pbRefresh
          }
        end
      elsif cmdToss>=0 && command==cmdToss # Toss item
        qty=@bag.pbQuantity(item)
        helptext=_INTL("Toss out how many {1}(s)?",itemname)
        qty=@scene.pbChooseNumber(helptext,qty)
        if qty>0
          if pbConfirm(_INTL("Is it OK to throw away {1} {2}(s)?",qty,itemname))
            pbDisplay(_INTL("Threw away {1} {2}(s).",qty,itemname))
            qty.times { @bag.pbDeleteItem(item) }      
          end
        end   
      elsif cmdMysteryGift>=0 && command==cmdMysteryGift   # Export to Mystery Gift
        pbCreateMysteryGift(1,item)
      end
    end
    @scene.pbEndScene
    return item
  end
end

#===============================================================================
# The Bag object, which actually contains all the items
#===============================================================================
class PokemonBag
  attr_reader :registeredItem
  attr_accessor :lastpocket
  attr_reader :pockets

  def self.pocketNames()
    return pbPocketNames
  end

  def self.numPockets()
    return self.pocketNames().length-1
  end

  def initialize
    @lastpocket=1
    @pockets=[]
    @choices=[]
    # Initialize each pocket of the array
    for i in 0..PokemonBag.numPockets
      @pockets[i]=[]
      @choices[i]=0
    end
    @registeredItem=0
  end

  def pockets
    rearrange
    return @pockets
  end

  def rearrange
    if (@pockets.length-1)!=PokemonBag.numPockets
      newpockets=[]
      for i in 0..PokemonBag.numPockets
        newpockets[i]=[]
        @choices[i]=0 if !@choices[i]
      end
      nump=PokemonBag.numPockets
      for i in 0...@pockets.length
        for item in @pockets[i]
          p=pbGetPocket(item[0])
          newpockets[p].push(item) if p<=nump
        end
      end
      @pockets=newpockets
    end
  end

# Gets the index of the current selected item in the pocket
  def getChoice(pocket)
    if pocket<=0 || pocket>PokemonBag.numPockets
      raise ArgumentError.new(_INTL("Invalid pocket: {1}",pocket.inspect))
    end
    rearrange
    return [@choices[pocket],@pockets[pocket].length].min || 0
  end

# Clears the entire bag
  def clear
    for pocket in @pockets
      pocket.clear
    end
  end

# Sets the index of the current selected item in the pocket
  def setChoice(pocket,value)
    if pocket<=0 || pocket>PokemonBag.numPockets
      raise ArgumentError.new(_INTL("Invalid pocket: {1}",pocket.inspect))
    end
    rearrange
    @choices[pocket]=value if value<=@pockets[pocket].length
  end

# Registers the item as a key item.  Can be retrieved with $PokemonBag.registeredItem
  def pbRegisterKeyItem(item)
    if item.is_a?(String) || item.is_a?(Symbol)
      item=getID(PBItems,item)
    end
    if !item || item<1
      raise ArgumentError.new(_INTL("The item number is invalid.",item))
      return
    end
    @registeredItem=(item!=@registeredItem) ? item : 0
  end

  def maxPocketSize(pocket)
    maxsize=MAXPOCKETSIZE[pocket]
    return -1 if !maxsize
    return maxsize
  end

  def pbQuantity(item)
    if item.is_a?(String) || item.is_a?(Symbol)
      item=getID(PBItems,item)
    end
    if !item || item<1
      raise ArgumentError.new(_INTL("The item number is invalid.",item))
      return 0
    end
    pocket=pbGetPocket(item)
    maxsize=maxPocketSize(pocket)
    maxsize=@pockets[pocket].length if maxsize<0
    return ItemStorageHelper.pbQuantity(@pockets[pocket],maxsize,item)
  end
    
  def pbDeleteItem(item,qty=1)
    if item.is_a?(String) || item.is_a?(Symbol)
      item=getID(PBItems,item)
    end
    if !item || item<1
      raise ArgumentError.new(_INTL("The item number is invalid.",item))
      return false
    end
    pocket=pbGetPocket(item)
    maxsize=maxPocketSize(pocket)
    maxsize=@pockets[pocket].length if maxsize<0
    ret=ItemStorageHelper.pbDeleteItem(@pockets[pocket],maxsize,item,qty)
    if ret
      @registeredItem=0 if @registeredItem==item && pbQuantity(item)<=0
    end
    return ret
  end

  def pbCanStore?(item,qty=1)
    if item.is_a?(String) || item.is_a?(Symbol)
      item=getID(PBItems,item)
    end
    if !item || item<1
      raise ArgumentError.new(_INTL("The item number is invalid.",item))
      return false
    end
    pocket=pbGetPocket(item)
    maxsize=maxPocketSize(pocket)
    maxsize=@pockets[pocket].length+1 if maxsize<0
    return ItemStorageHelper.pbCanStore?(
       @pockets[pocket],maxsize,BAGMAXPERSLOT,item,qty)
  end

  def pbStoreAllOrNone(item,qty=1)
    if item.is_a?(String) || item.is_a?(Symbol)
      item=getID(PBItems,item)
    end
    if !item || item<1
      raise ArgumentError.new(_INTL("The item number is invalid.",item))
      return false
    end
    pocket=pbGetPocket(item)
    maxsize=maxPocketSize(pocket)
    maxsize=@pockets[pocket].length+1 if maxsize<0
    return ItemStorageHelper.pbStoreAllOrNone(
       @pockets[pocket],maxsize,BAGMAXPERSLOT,item,qty)
  end

  def pbStoreItem(item,qty=1)
    if item.is_a?(String) || item.is_a?(Symbol)
      item=getID(PBItems,item)
    end
    if !item || item<1
      raise ArgumentError.new(_INTL("The item number is invalid.",item))
      return false
    end
    
    
    pocket=1
   # Adding Pockets together.
    if pbIsKeyItem?(item)
      pocket=5
    elsif pbIsBerry?(item)
      pocket=4
    elsif pbIsMachine?(item)
      pocket=3
    elsif $ItemData[item][ITEMTYPE]==2 # Medicine
      pocket=2
    end
    
    maxsize=maxPocketSize(pocket)
    maxsize=@pockets[pocket].length+1 if maxsize<0
    return ItemStorageHelper.pbStoreItem(
       @pockets[pocket],maxsize,BAGMAXPERSLOT,item,qty,true)
  end
end

#===============================================================================
# PC item storage screen
#===============================================================================
class Window_PokemonItemStorage < Window_DrawableCommand
  attr_reader :bag
  attr_reader :pocket
  attr_reader :sortIndex

  def sortIndex=(value)
    @sortIndex=value
    refresh
  end

  def initialize(bag,x,y,width,height)
    @bag=bag
    @sortIndex=-1
    @adapter=PokemonMartAdapter.new
    super(x,y,width,height)
    self.windowskin=nil
  end

  def item
    item=@bag[self.index]
    return item ? item[0] : 0
  end

  def itemCount
    return @bag.length+1
  end

  def drawItem(index,count,rect)
    textpos=[]
    rect=drawCursor(index,rect)
    ypos=rect.y
    if index==@bag.length
      textpos.push([_INTL("CANCEL"),rect.x,ypos,false,
         self.baseColor,self.shadowColor])
    else
      item=@bag[index][0]
      itemname=@adapter.getDisplayName(item)
      qty=_ISPRINTF("x{1: 2d}",@bag[index][1])
      sizeQty=self.contents.text_size(qty).width
      xQty=rect.x+rect.width-sizeQty-2
      baseColor=(index==@sortIndex) ? Color.new(248,24,24) : self.baseColor
      textpos.push([itemname,rect.x,ypos,false,self.baseColor,self.shadowColor])
      if !pbIsImportantItem?(item) # Not a Key item or HM (or infinite TM)
        textpos.push([qty,xQty,ypos,false,baseColor,self.shadowColor])
      end
    end
    pbDrawTextPositions(self.contents,textpos)
  end
end



class ItemStorageScene
## Configuration
  ITEMLISTBASECOLOR   = Color.new(88,88,80)
  ITEMLISTSHADOWCOLOR = Color.new(168,184,184)
  ITEMTEXTBASECOLOR   = Color.new(248,248,248)
  ITEMTEXTSHADOWCOLOR = Color.new(0,0,0)
  TITLEBASECOLOR      = Color.new(248,248,248)
  TITLESHADOWCOLOR    = Color.new(0,0,0)
  ITEMSVISIBLE        = 7

  def initialize(title)
    @title=title
  end

  def update
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartScene(bag)
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @bag=bag
    @sprites={}
    @sprites["background"]=IconSprite.new(0,0,@viewport)
    @sprites["background"].setBitmap("Graphics/Pictures/pcItembg")
    @sprites["icon"]=IconSprite.new(270,247,@viewport)
    # Item list
    @sprites["itemwindow"]=Window_PokemonItemStorage.new(@bag,98,14,334,32+ITEMSVISIBLE*32) #32
    @sprites["itemwindow"].viewport=@viewport
    @sprites["itemwindow"].index=0
    @sprites["itemwindow"].baseColor=ITEMLISTBASECOLOR
    @sprites["itemwindow"].shadowColor=ITEMLISTSHADOWCOLOR
    @sprites["itemwindow"].refresh
    # Title
    @sprites["pocketwindow"]=BitmapSprite.new(88,64,@viewport)
    @sprites["pocketwindow"].x=14
    @sprites["pocketwindow"].y=16
    pbSetNarrowFont(@sprites["pocketwindow"].bitmap)
    # Item description  
    @sprites["itemtextwindow"]=Window_UnformattedTextPokemon.newWithSize("",84,270,Graphics.width-84,128,@viewport)
    @sprites["itemtextwindow"].baseColor=ITEMTEXTBASECOLOR
    @sprites["itemtextwindow"].shadowColor=ITEMTEXTSHADOWCOLOR
    @sprites["itemtextwindow"].windowskin=nil
    @sprites["helpwindow"]=Window_UnformattedTextPokemon.new("")
    @sprites["helpwindow"].visible=false
    @sprites["helpwindow"].viewport=@viewport
    # Letter-by-letter message window
    @sprites["msgwindow"]=Window_AdvancedTextPokemon.new("")
    @sprites["msgwindow"].visible=false
    @sprites["msgwindow"].viewport=@viewport
    pbBottomLeftLines(@sprites["helpwindow"],1)
    pbDeactivateWindows(@sprites)
    pbRefresh
    pbFadeInAndShow(@sprites)
  end

  def pbEndScene
    pbFadeOutAndHide(@sprites)
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end

  def pbRefresh
    bm=@sprites["pocketwindow"].bitmap
    # Draw title at upper left corner ("Toss Item/Withdraw Item")
    drawTextEx(bm,0,0,bm.width,2,@title,TITLEBASECOLOR,TITLESHADOWCOLOR)
    itemwindow=@sprites["itemwindow"]
    # Draw item icon
    filename=pbItemIconFile(itemwindow.item)
    @sprites["icon"].setBitmap(filename)
    # Get item description
    @sprites["itemtextwindow"].text=(itemwindow.item==0) ? _INTL("Close storage.") : 
       pbGetMessage(MessageTypes::ItemDescriptions,itemwindow.item)
    itemwindow.refresh
  end

  def pbChooseItem
    pbRefresh
    @sprites["helpwindow"].visible=false
    itemwindow=@sprites["itemwindow"]
    itemwindow.refresh
    pbActivateWindow(@sprites,"itemwindow"){
       loop do
         Graphics.update
         Input.update
         olditem=itemwindow.item
         self.update
         if itemwindow.item!=olditem
           self.pbRefresh
         end
         if Input.trigger?(Input::B)
           return 0
         end
         if Input.trigger?(Input::C)
           if itemwindow.index<@bag.length
             pbRefresh
             return @bag[itemwindow.index][0]
           else
             return 0
           end
         end
       end
    }
  end

  def pbChooseNumber(helptext,maximum)
    return UIHelper.pbChooseNumber(
       @sprites["helpwindow"],helptext,maximum) { update }
  end

  def pbDisplay(msg,brief=false)
    UIHelper.pbDisplay(@sprites["msgwindow"],msg,brief) { update }
  end

  def pbConfirm(msg)
    UIHelper.pbConfirm(@sprites["msgwindow"],msg) { update }
  end

  def pbShowCommands(helptext,commands)
    return UIHelper.pbShowCommands(
       @sprites["helpwindow"],helptext,commands) { update }
  end
end



class WithdrawItemScene < ItemStorageScene
  def initialize
    super(_INTL("Withdraw\nItem"))
  end
end



class TossItemScene < ItemStorageScene
  def initialize
    super(_INTL("Toss\nItem"))
  end
end

#===============================================================================
# The PC item storage object, which actually contains all the items
#===============================================================================
class PCItemStorage
  MAXSIZE    = 50    # Number of different slots in storage
  MAXPERSLOT = 999   # Max. number of items per slot

  def initialize
    @items=[]
    # Start storage with a Potion
    if hasConst?(PBItems,:POTION)
      ItemStorageHelper.pbStoreItem(
         @items,MAXSIZE,MAXPERSLOT,getConst(PBItems,:POTION),1)
    end
  end

  def empty?
    return @items.length==0
  end

  def length
    @items.length
  end

  def [](i)
    @items[i]
  end

  def getItem(index)
    if index<0 || index>=@items.length
      return 0
    else
      return @items[index][0]
    end
  end

  def getCount(index)
    if index<0 || index>=@items.length
      return 0
    else
      return @items[index][1]
    end
  end

  def pbQuantity(item)
    return ItemStorageHelper.pbQuantity(@items,MAXSIZE,item)
  end

  def pbDeleteItem(item,qty=1)
    return ItemStorageHelper.pbDeleteItem(@items,MAXSIZE,item,qty)
  end

  def pbCanStore?(item,qty=1)
    return ItemStorageHelper.pbCanStore?(@items,MAXSIZE,MAXPERSLOT,item,qty)
  end

  def pbStoreItem(item,qty=1)
    return ItemStorageHelper.pbStoreItem(@items,MAXSIZE,MAXPERSLOT,item,qty)
  end
end



#===============================================================================
# Common UI functions used in both the Bag and item storage screens.
# Allows the user to choose a number.  The window _helpwindow_ will
# display the _helptext_.
#===============================================================================
module UIHelper
  def self.pbChooseNumber(helpwindow,helptext,maximum)
    oldvisible=helpwindow.visible
    helpwindow.visible=true
    helpwindow.text=helptext
    helpwindow.letterbyletter=false
    curnumber=1
    ret=0
    using(numwindow=Window_UnformattedTextPokemon.new("x000")){
       numwindow.viewport=helpwindow.viewport
       numwindow.letterbyletter=false
       numwindow.text=_ISPRINTF("x{1:03d}",curnumber)
       numwindow.resizeToFit(numwindow.text,480)
       pbBottomRight(numwindow) # Move number window to the bottom right
       helpwindow.resizeHeightToFit(helpwindow.text,480-numwindow.width)
       pbBottomLeft(helpwindow) # Move help window to the bottom left
       loop do
         Graphics.update
         Input.update
         numwindow.update
         block_given? ? yield : helpwindow.update
         if Input.repeat?(Input::LEFT)
           curnumber-=10
           curnumber=1 if curnumber<1
           numwindow.text=_ISPRINTF("x{1:03d}",curnumber)
           pbPlayCursorSE()
         elsif Input.repeat?(Input::RIGHT)
           curnumber+=10
           curnumber=maximum if curnumber>maximum
           numwindow.text=_ISPRINTF("x{1:03d}",curnumber)
           pbPlayCursorSE()
         elsif Input.repeat?(Input::UP)
           curnumber+=1
           curnumber=1 if curnumber>maximum
           numwindow.text=_ISPRINTF("x{1:03d}",curnumber)
           pbPlayCursorSE()
         elsif Input.repeat?(Input::DOWN)
           curnumber-=1
           curnumber=maximum if curnumber<1
           numwindow.text=_ISPRINTF("x{1:03d}",curnumber)
           pbPlayCursorSE()
         elsif Input.trigger?(Input::C)
           ret=curnumber
           pbPlayDecisionSE()
           break
         elsif Input.trigger?(Input::B)
           ret=0
           pbPlayCancelSE()
           break
         end
       end
    }
    helpwindow.visible=oldvisible
    return ret
  end

  def self.pbDisplayStatic(msgwindow,message)
    oldvisible=msgwindow.visible
    msgwindow.visible=true
    msgwindow.letterbyletter=false
    msgwindow.width=Graphics.width
    msgwindow.resizeHeightToFit(message,Graphics.width)
    msgwindow.text=message
    pbBottomRight(msgwindow)
    loop do
      Graphics.update
      Input.update
      if Input.trigger?(Input::B)
        break
      end
      if Input.trigger?(Input::C)
        break
      end
      block_given? ? yield : msgwindow.update
    end
    msgwindow.visible=oldvisible
    Input.update
  end

# Letter by letter display of the message _msg_ by the window _helpwindow_.
  def self.pbDisplay(helpwindow,msg,brief)
    cw=helpwindow
    cw.letterbyletter=true
    cw.text=msg+"\1"
    pbBottomLeftLines(cw,2)
    oldvisible=cw.visible
    cw.visible=true
    loop do
      Graphics.update
      Input.update
      block_given? ? yield : cw.update
      if brief && !cw.busy?
        cw.visible=oldvisible
        return
      end
      if Input.trigger?(Input::C) && cw.resume && !cw.busy?
        cw.visible=oldvisible
        return
      end
    end
  end

# Letter by letter display of the message _msg_ by the window _helpwindow_,
# used to ask questions.  Returns true if the user chose yes, false if no.
  def self.pbConfirm(helpwindow,msg)
    dw=helpwindow
    oldvisible=dw.visible
    dw.letterbyletter=true
    dw.text=msg
    dw.visible=true
    pbBottomLeftLines(dw,2)
    commands=[_INTL("Yes"),_INTL("No")]
    cw = Window_CommandPokemon.new(commands)
    cw.viewport=helpwindow.viewport
    pbBottomRight(cw)
    cw.y-=dw.height
    cw.index=0
    loop do
      cw.visible=!dw.busy?
      Graphics.update
      Input.update
      cw.update
      block_given? ? yield : dw.update
      if Input.trigger?(Input::B) && dw.resume && !dw.busy?
        cw.dispose
        dw.visible=oldvisible
        pbPlayCancelSE()
        return false
      end
      if Input.trigger?(Input::C) && dw.resume && !dw.busy?
        cwIndex=cw.index
        cw.dispose
        dw.visible=oldvisible
        pbPlayDecisionSE()
        return (cwIndex==0)?true:false
      end
    end
  end

  def self.pbShowCommands(helpwindow,helptext,commands)
    ret=-1
    oldvisible=helpwindow.visible
    helpwindow.visible=helptext ? true : false
    helpwindow.letterbyletter=false
    helpwindow.text=helptext ? helptext : ""
    cmdwindow=Window_CommandPokemon.new(commands)
    begin
      cmdwindow.viewport=helpwindow.viewport
      pbBottomRight(cmdwindow)
      helpwindow.resizeHeightToFit(helpwindow.text,480-cmdwindow.width)
      pbBottomLeft(helpwindow)
      loop do
        Graphics.update
        Input.update
        yield
        cmdwindow.update
        if Input.trigger?(Input::B)
          ret=-1
          pbPlayCancelSE()
          break
        end
        if Input.trigger?(Input::C)
          ret=cmdwindow.index
          pbPlayDecisionSE()
          break
        end
      end
    ensure
      cmdwindow.dispose if cmdwindow
    end
    helpwindow.visible=oldvisible
    return ret
  end
end