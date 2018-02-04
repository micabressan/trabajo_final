Pegalo en services.conf ...


# BotNick [REQUIRED]
# Module: ircd_vhostserv
#	Define what nick the bot will have.
#
BotNick "vHostServ"

# BotIdent [REQUIRED]
#	Define the bot identd.
#
BotIdent "Bot"

# BotHost [REQUIRED]
#	Define the bot hostname or vhost.
#
BotHost "LocalHost-IRC.Host.Bot"

# BotReal [REQUIRED]
#	Define the bot realname.
#
BotReal "/msg vHostServ Help"

# vHostChannel [REQUIRED]
#	Define your network vhost channel.
#
vHostChannel "#vHost"

# BanClearTime [REQUIRED]
#	Sets the timeout period after which a particular ban set by
#	the bot will be removed.
#
BanClearTime 5h

# BotModes [OPTIONAL]
#	Define what modes the bot will have.
#
BotModes "+SqB"

# JoinLogChannel [OPTIONAL]
#	Define this if you want the bot to automatically
#	join services log channel.
#
JoinLogChannel

# RestrictHosts [RECOMMENDED]
#	Define unallowed vhosts which will be match using 
#	wildcards. This is not case-sensitive.
#
RestrictHosts "*ircop* *admin* *root* *staff* *some.wild.card*"

# KickBanRestrictHosts [OPTIONAL]
#	Define this to kick banned users who request
#	restricted hosts. If this option is enabled
#	RestrictHosts setting is required.
#
KickBanRestrictHosts

# End of config: ircd_vhostserv
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-