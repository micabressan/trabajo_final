 - bukkit.command.version
    - bukkit.command.whitelist
    - bukkit.command.whitelist.add
    - bukkit.command.whitelist.disable
    - bukkit.command.whitelist.enable
    - bukkit.command.whitelist.list
    - bukkit.command.whitelist.reload
    - bukkit.command.whitelist.remove

# Permission nodes for Essentials
# by ementalo, snowleo, and KHobbits
# http://dev.bukkit.org/server-mods/essentials/

  g:essentials_default:
    permissions:
    - essentials.help
    - essentials.helpop
    - essentials.list
    - essentials.motd
    - essentials.rules
    - essentials.spawn
    - essentials.jail.allow.help
    - essentials.jail.allow.helpop
    - essentials.jail.allow.rules
    - essentials.help
  g:essentials_builder:
    permissions:
    - essentials.afk
    - essentials.afk.auto
    - essentials.back
    - essentials.back.ondeath
    - essentials.balance
    - essentials.balance.others
    - essentials.balancetop
    - essentials.book
    - essentials.chat.color
    - essentials.chat.format
    - essentials.chat.shout
    - essentials.chat.question
    - essentials.compass
    - essentials.delhome
    - essentials.depth
    - essentials.exp
    - essentials.getpos
    - essentials.hat
    - essentials.home
    - essentials.ignore
    - essentials.itemdb
    - essentials.kit
    - essentials.kits.tools
    - essentials.mail
    - essentials.mail.send
    - essentials.me
    - essentials.msg
    - essentials.msg.color
    - essentials.msg.format
    - essentials.nick
    - essentials.pay
    - essentials.ping
    - essentials.powertool
    - essentials.powertooltoggle
    - essentials.protect
    - essentials.recipe
    - essentials.seen
    - essentials.sethome
    - essentials.sethome.bed
    - essentials.sethome.multiple
    - essentials.signs.use.*
    - essentials.signs.create.disposal
    - essentials.signs.create.mail
    - essentials.signs.create.protection
    - essentials.signs.create.trade
    - essentials.signs.break.disposal
    - essentials.signs.break.mail
    - essentials.signs.break.protection
    - essentials.signs.break.trade
    - essentials.suicide
    - essentials.time
    - essentials.tpa
    - essentials.tpaccept
    - essentials.tpahere
    - essentials.tpdeny
    - essentials.warp
    - essentials.warp.list
    - essentials.worth
    - essentials.jail.allow.mail
    - essentials.jail.allow.ping
    - essentials.jail.allow.seen

  g:essentials_moderator:
    permissions:
    - default: true
permissions:
- essentials.kit
- essentials.sethome
- essentials.home
- essentials.balance
- essentials.balance.others
- essentials.baltop
- essentials.pay
- essentials.worth
- essentials.afk
- essentials.help.*
- essentials.helpop
- essentials.ignore
- essentials.info
- essentials.itemdb
- essentials.essentials.list
- essentials.mail
- essentials.mail.send
- essentials.me
- essentials.motd
- essentials.msg
- essentials.msg.colour
- essentials.msg.format
- essentials.msg.magic
- essentials.msg.colour
- essentials.msg.url
- essentials.realname
 essentials.rules
    - coloredTexts.colors.*
    -
    - 
    - 
    - 
    - 
    - 
    - 
    - 
    - 
    -
    - 
    - 

  g:essentials_admin:
    permissions:
    - -essentials.backup
    - -essentials.essentials
    - -essentials.setspawn
    - -essentials.reloadall
    - -essentials.plugin
    - essentials.*

# Permission nodes for Towny by ElgarL
# http://dev.bukkit.org/server-mods/towny-advanced/

  g:towny_default:
    permissions:
    - towny.chat.local

  g:towny_builder:
    permissions:
    - towny.wild.build.6
    - towny.wild.destroy.6
    - towny.wild.destroy.14
    - towny.wild.destroy.15
    - towny.wild.destroy.16
    - towny.wild.build.17
    - towny.wild.destroy.17
    - towny.wild.destroy.18
    - towny.wild.destroy.21
    - towny.wild.destroy.31
    - towny.wild.destroy.37
    - towny.wild.destroy.38
    - towny.wild.destroy.39
    - towny.wild.destroy.40
    - towny.wild.destroy.50
    - towny.wild.destroy.56
    - towny.wild.destroy.73
    - towny.wild.destroy.74
    - towny.wild.destroy.78
    - towny.wild.destroy.81
    - towny.wild.destroy.82
    - towny.wild.destroy.83
    - towny.wild.destroy.86
    - towny.wild.destroy.103
    - towny.wild.destroy.106
    - towny.wild.destroy.111
    - towny.wild.destroy.115

  g:towny_moderator:
    permissions:
    - towny.chat.mod
    - towny.wild.switch.64
    - towny.wild.build.83
    - towny.wild.build.86
    - towny.wild.build.103
    - towny.wild.build.111
    - towny.wild.build.115

  g:towny_admin:
    permissions:
    - towny.admin
    - -towny.wild.destroy.119
    - -towny.wild.destroy.120
    - towny.chat.admin

# Permission nodes for VanishNoPacket by mbaxter
# http://dev.bukkit.org/server-mods/vanish/

  g:vanish_moderator:
    permissions:
    - vanish.vanish
    - vanish.smokin
    - vanish.nofollow
    - vanish.nopickup
    - vanish.preventincomingdamage
    - vanish.hooks.dynmap.alwayshidden
    - vanish.hooks.essentials.hide

  g:vanish_admin:
    permissions:
    - vanish.silentjoin
    - vanish.silentquit
    - vanish.silentchests