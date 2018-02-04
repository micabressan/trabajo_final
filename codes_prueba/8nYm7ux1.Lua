
Thu Dec 28 01:31:49 2017


Application has crashed: access violation

-------------------------------

Callstack:

         payday2_win32_release  (???)     ???                                                 
         payday2_win32_release  (???)     ???                                                 
         payday2_win32_release  (???)     ???                                                 
         payday2_win32_release  (???)     ???                                                 
         payday2_win32_release  (???)     ???                                                 
         payday2_win32_release  (???)     ???                                                 
         payday2_win32_release  (???)     ???                                                 


-------------------------------

Current thread: Main
Script stack:
           activate_callback()  core/lib/managers/coresequencemanager.lua:6036      
                    activate()  core/lib/managers/coresequencemanager.lua:1921      
           activate_callback()  core/lib/managers/coresequencemanager.lua:2718      
                    activate()  core/lib/managers/coresequencemanager.lua:1921      
                run_sequence()  core/lib/managers/coresequencemanager.lua:2382      
                run_sequence()  core/lib/units/coreunitdamage.lua:1209              
        run_sequence_simple3()  core/lib/units/coreunitdamage.lua:1205              
        run_sequence_simple2()  core/lib/units/coreunitdamage.lua:1201              
         run_sequence_simple()  core/lib/units/coreunitdamage.lua:1197              
         check_decapitations()  @mods/Melee                                         
                                Overhaul                                            
 REvamped/lua/copdamage.lua:28  func()                                              
                   @mods/Melee                                                      
                      Overhaul  REvamped/lua/copdamage.lua:145                      
                damage_melee()  @mods/base/req/core/Hooks.lua:267                   
   _do_melee_damage_original()  lib/units/beings/player/states/playerstandard.lua:2876  
                    original()  @mods/WolfHUD/lua/GameInfoManager.lua:3292          
            _do_melee_damage()  @mods/base/req/core/Hooks.lua:185                   
_update_melee_timers_original()  lib/units/beings/player/states/playerstandard.lua:2982  
                    original()  @mods/WolfHUD/lua/Interaction.lua:133               
        _update_melee_timers()  @mods/base/req/core/Hooks.lua:260                   
       _update_check_actions()  lib/units/beings/player/states/playerstandard.lua:825  
fs_original_playerstandard_update()  lib/units/beings/player/states/playerstandard.lua:424  
                    original()  @mods/Full                                          
                                Speed                                               
Swarm/lua/playerstandard.lua:6  update_original()                                   
@mods/base/req/core/Hooks.lua:260  update_original()                                   
  @mods/Sliding/sliding.lua:51  update_original()                                   
@mods/WolfHUD/lua/BurstFire.lua:196  _hts_PlayerStandard_update()                        
@mods/pjal3urb-burstfire-72e3030d4fbd/BurstFire.lua:195  _hts_PlayerStandard_update()                        
@assets/mod_overrides/Gunshield/Hooks/playerstandard.lua:29  _hts_PlayerStandard_update()                        
@assets/mod_overrides/predator_shield_reborn/Hooks/playerstandard.lua:38  update()                                            
@assets/mod_overrides/predator_shield_reborn/Hooks/playerstandard.lua:38  original()                                          
lib/units/beings/player/playermovement.lua:324                                                      
@mods/base/req/core/Hooks.lua:260