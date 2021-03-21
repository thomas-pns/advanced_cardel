--##################################--
-- Create by THOMAS#9033
--##################################--

config = {}

config.title = "ADVANCED CARDEL" -- Title of menu
config.subtitle = "~b~main advanced_cardel" -- SubTitle of menu

config.glare_rui=false
config.TitleFont=2 -- 1 to 7
config.TitleScale=1.0 -- 0.1 to ...

config.boolean_color=false
config.color={r=255, g=0, b=0, a=255} -- RGBA color

config.boolean_texture=true
config.texture="graffiti" -- add texture on stream/common.ytd

config.boolean_key=true
config.key=51 -- (control index) E > https://docs.fivem.net/docs/game-references/controls/
config.key_type=0 -- (control type)

config.marker={
    type=2,
    z_add=2,
    size=1.0,
    color={r=255, g=0, b=0, a=255},
    rotate=true,
}

config.sphere_color={r=0, g=200, b=50, a=0.5} -- RGBA

config.notification_texture="CHAR_CARSITE" -- → https://wiki.gtanet.work/index.php?title=Notification_Pictures
config.notification_type=2 
-- ↓ -- 
--[[
    1 : Chat Box
    2 : Email
    3 : Add Friend Request
    4 : Nothing
    5 : Nothing
    6 : Nothing
    7 : Right Jumping Arrow
    8 : RP Icon
    9 : $ Icon
--]]

config.lang='en'

config.languages = {
    ['fr'] = {
        ['title_notif'] = 'advanced_cardel',
        ['subject_notif'] = '→ suppréssion de vehicules',
        ['msg_notif'] = ' vehicles suprimés !',
        ['delcar'] = 'suprimer vehicule ',
    },
    ['en'] = {
        ['title_notif'] = 'advanced_cardel',
        ['subject_notif'] = '→ removal of vehicles',
        ['msg_notif'] = ' vehicles removed !',   
        ['delcar'] = 'vehicle delete ',
    }
}