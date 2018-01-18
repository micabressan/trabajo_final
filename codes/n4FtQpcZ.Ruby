  def drawPageTwo(pokemon)
    overlay=@sprites["overlay"].bitmap
    overlay.clear
    @sprites["background"].setBitmap("Graphics/Pictures/summary2")
    imagepos=[]
    if pbPokerus(pokemon)==1 || pokemon.hp==0 || @pokemon.status>0
      status=6 if pbPokerus(pokemon)==1
      status=@pokemon.status-1 if @pokemon.status>0
      status=5 if pokemon.hp==0
      imagepos.push(["Graphics/Pictures/statuses",124,100,0,16*status,44,16])
    end
    if pokemon.isShiny?
      imagepos.push([sprintf("Graphics/Pictures/shiny"),2,134,0,0,-1,-1])
    end
    if pokemon.isMetallic?
      imagepos.push([sprintf("Graphics/Pictures/metallic"),18,134,0,0,-1,-1])
    end
    if pbPokerus(pokemon)==2
      imagepos.push([sprintf("Graphics/Pictures/summaryPokerus"),176,100,0,0,-1,-1])
    end
    ballused=@pokemon.ballused ? @pokemon.ballused : 0
    ballimage=sprintf("Graphics/Pictures/summaryball%02d",@pokemon.ballused)
    imagepos.push([ballimage,14,60,0,0,-1,-1])
    pbDrawImagePositions(overlay,imagepos)
    base=Color.new(248,248,248)
    shadow=Color.new(104,104,104)
    pbSetSystemFont(overlay)
    naturename=PBNatures.getName(pokemon.nature)
    pokename=@pokemon.name
    textpos=[
       [_INTL("TRAINER MEMO"),26,16,0,base,shadow],
       [pokename,46,62,0,base,shadow],
       [pokemon.level.to_s,46,92,0,Color.new(64,64,64),Color.new(176,176,176)],
       [_INTL("Item"),16,320,0,base,shadow]
    ]
    if pokemon.hasItem?
      textpos.push([PBItems.getName(pokemon.item),16,352,0,Color.new(64,64,64),Color.new(176,176,176)])
    else
      textpos.push([_INTL("None"),16,352,0,Color.new(184,184,160),Color.new(208,208,200)])
    end
    if pokemon.isMale?
      textpos.push([_INTL("♂"),178,62,0,Color.new(24,112,216),Color.new(136,168,208)])
    elsif pokemon.isFemale?
      textpos.push([_INTL("♀"),178,62,0,Color.new(248,56,32),Color.new(224,152,144)])
    end
    pbDrawTextPositions(overlay,textpos)
    memo=""
    shownature=(!(pokemon.isShadow? rescue false)) || pokemon.heartStage<=3
    if shownature
      memo+=_INTL("<c3=F83820,E09890>{1}<c3=404040,B0B0B0> nature.\n",naturename)
    end
    if pokemon.timeReceived
      month=pbGetAbbrevMonthName(pokemon.timeReceived.mon)
      date=pokemon.timeReceived.day
      year=pokemon.timeReceived.year
      memo+=_INTL("<c3=404040,B0B0B0>{1} {2}, {3}\n",month,date,year)
    end
    mapname=pbGetMapNameFromId(pokemon.obtainMap)
    if (pokemon.obtainText rescue false) && pokemon.obtainText!=""
      mapname=pokemon.obtainText
    end
    if mapname && mapname!=""
      memo+=sprintf("<c3=F83820,E09890>%s\n",mapname)
    else
      memo+=_INTL("<c3=F83820,E09890>Faraway place\n")
    end
    if pokemon.obtainMode
      mettext=[_INTL("Met at Lv. {1}.",pokemon.obtainLevel),
               _INTL("Egg received."),
               _INTL("Traded at Lv. {1}.",pokemon.obtainLevel),
               "",
               _INTL("Had a fateful encounter at Lv. {1}.",pokemon.obtainLevel)
               ][pokemon.obtainMode]
      memo+=sprintf("<c3=404040,B0B0B0>%s\n",mettext)
      if pokemon.obtainMode==1 # hatched
        if pokemon.timeEggHatched
          month=pbGetAbbrevMonthName(pokemon.timeEggHatched.mon)
          date=pokemon.timeEggHatched.day
          year=pokemon.timeEggHatched.year
          memo+=_INTL("<c3=404040,B0B0B0>{1} {2}, {3}\n",month,date,year)
        end
        mapname=pbGetMapNameFromId(pokemon.hatchedMap)
        if mapname && mapname!=""
          memo+=sprintf("<c3=F83820,E09890>%s\n",mapname)
        else
          memo+=_INTL("<c3=F83820,E09890>Faraway place\n")
        end
        memo+=_INTL("<c3=404040,B0B0B0>Egg hatched.\n")
      else
        memo+="<c3=404040,B0B0B0>\n"
      end
    end
    if shownature
      bestiv=0
      tiebreaker=pokemon.personalID%6
      for i in 0...6
        if pokemon.iv[i]==pokemon.iv[bestiv]
          bestiv=i if i>=tiebreaker && bestiv<tiebreaker
        elsif pokemon.iv[i]>pokemon.iv[bestiv]
          bestiv=i
        end
      end
      characteristic=[_INTL("Loves to eat."),
                      _INTL("Often dozes off."),
                      _INTL("Often scatters things."),
                      _INTL("Scatters things often."),
                      _INTL("Likes to relax."),
                      _INTL("Proud of its power."),
                      _INTL("Likes to thrash about."),
                      _INTL("A little quick tempered."),
                      _INTL("Likes to fight."),
                      _INTL("Quick tempered."),
                      _INTL("Sturdy body."),
                      _INTL("Capable of taking hits."),
                      _INTL("Highly persistent."),
                      _INTL("Good endurance."),
                      _INTL("Good perseverance."),
                      _INTL("Likes to run."),
                      _INTL("Alert to sounds."),
                      _INTL("Impetuous and silly."),
                      _INTL("Somewhat of a clown."),
                      _INTL("Quick to flee."),
                      _INTL("Highly curious."),
                      _INTL("Mischievous."),
                      _INTL("Thoroughly cunning."),
                      _INTL("Often lost in thought."),
                      _INTL("Very finicky."),
                      _INTL("Strong willed."),
                      _INTL("Somewhat vain."),
                      _INTL("Strongly defiant."),
                      _INTL("Hates to lose."),
                      _INTL("Somewhat stubborn.")
                      ][bestiv*5+pokemon.iv[bestiv]%5]
      memo+=sprintf("<c3=404040,B0B0B0>%s\n",characteristic)
    end
    drawFormattedTextEx(overlay,232,78,276,memo)
    #=============================================================================
  # Egg Groups - Shows Pokemon's Egg Groups on Page 2 (Memo)
  #=============================================================================
  def pbDisplayEggGroups
      if !@pokemon.egg?
        dexdata=pbOpenDexData
        pbDexDataOffset(dexdata,@pokemon.species,31)
        compat10=dexdata.fgetb
        compat11=dexdata.fgetb
        noGender=(@pokemon.isGenderless? && !isConst?(@pokemon.species,PBSpecies,:DITTO))
        eggGroupbitmap=AnimatedBitmap.new(_INTL("Graphics/Pictures/typesEgg"))
        eggGroup0rect=Rect.new(0,420,64,28)
        eggGroup1rect=Rect.new(0,compat10*28,64,28)
        eggGroup2rect=Rect.new(0,compat11*28,64,28)
        overlay = @sprites["overlay"].bitmap
        if noGender && compat10!=0
          overlay.blt(364,336,eggGroupbitmap.bitmap,eggGroup0rect)
        elsif compat10==compat11
          overlay.blt(364,336,eggGroupbitmap.bitmap,eggGroup1rect)
        else
          overlay.blt(364,336,eggGroupbitmap.bitmap,eggGroup1rect)
          overlay.blt(432,336,eggGroupbitmap.bitmap,eggGroup2rect)
        end
        dexdata.close
      end
      textpos=[[_INTL("Egg Groups:"),234,334,0,Color.new(64,64,64),Color.new(176,176,176)]]
      pbDrawTextPositions(overlay,textpos)
    end
    drawMarkings(overlay,15,291,72,20,pokemon.markings)
  end