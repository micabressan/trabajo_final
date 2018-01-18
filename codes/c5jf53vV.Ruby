def pbShowCommands(commands)
    ret=-1
    cmdwindow=@sprites["cmdwindow"]
    cmdwindow.viewport=@viewport
    cmdwindow.index=$PokemonTemp.menuLastChoice
    cmdwindow.resizeToFit(commands)
    cmdwindow.commands=commands
    cmdwindow.x=Graphics.width-cmdwindow.width
    cmdwindow.y=0
    cmdwindow.visible=true
    
    #Tragic #ADD [01/07/2018]
    #A Hash object of help text for our pause menu.
    #Hash objects store values in a key/value pair. Where a value can only be
    #accessed with a specific key. Which simplifies finding the help text we want
    #by a great deal since commands[] returns the string literal of the menu object.
    commandHelp={
    "Pokédex" => "A device that records POKéMON secrets upon meeting or catching them.",
    "Pokémon" => "Check and organize POKéMON that are traveling with you in your party.",
    "Bag" => "Equipped with pockets for storing items you bought, received, or found.",
    "Pokégear" => "ANY BREASTS ARE GOOD AS LONG AS THEY'RE CUTE OR SHAPELY!",
    $Trainer.name => "Check your money and other game data.",
    "Clothes" => $Trainer.outfit!=2 ? "Show the world how much of a slut you are!" : "Put the slutting around to an end...",
    "Save" => "Save your game with a complete record of your progress to take a break.",
    "Options" => "Adjust various game settings such as text speed, game rules, etc.",
    "Debug" => "A menu for debug options.",
    "Quit" => "DFC IS PRETTY GUD THO.",
    "Quit Game" => "Exit the game.",
    "Quit Contest" => "FUCK LOLI PUSS!"
    }
    
    #Tragic #ADD [01/07/2018]
    #If the player wants to see help text, then show it.
    if $PokemonSystem.showHelpText==1
      #Set the help text of the item the menu is first starting on...
      curItem = commands[cmdwindow.index] #Sets the string returned by commands[x]
      pbShowHelp(commandHelp[curItem]) #Outputs the value from the Key that matches curItem
    else
      @sprites["helpwindow"].visible=false
    end
    
    loop do
      cmdwindow.update
      Graphics.update
      Input.update
      pbUpdateSceneMap
      
      if $PokemonSystem.showHelpText==1
        #Tragic #ADD [01/07/2018]
        #Set the help text of any item we're on in the menu.
        curItem = commands[cmdwindow.index] #Sets the string returned by commands[x]
        pbShowHelp(commandHelp[curItem]) #Outputs the value from the Key that matches curItem
      else
        @sprites["helpwindow"].visible=false
      end
      
      if Input.trigger?(Input::B)
        ret=-1
        break
      end
      if Input.trigger?(Input::C)
        ret=cmdwindow.index
        $PokemonTemp.menuLastChoice=ret
        break
      end
    end
    return ret
  end