#pragma once

#define _IMPROVED_PACKET_ENCRYPTION_ 
//#define __AUCTION__
#define __PET_SYSTEM__
#define __UDP_BLOCK__

//////////////////////////////////////////////////////////////////////////
// ### General Features ###
#define ENABLE_D_NJGUILD
#define ENABLE_FULL_NOTICE
#define ENABLE_NEWSTUFF
#define ENABLE_PORT_SECURITY
#define ENABLE_BELT_INVENTORY_EX
#define ENABLE_CMD_WARP_IN_DUNGEON
// #define ENABLE_ITEM_ATTR_COSTUME
// #define ENABLE_SEQUENCE_SYSTEM
#define MAP_ALLOW_LIMIT 32
// ### General Features ###
//////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////
// ### Lycan ###
#define ENABLE_WOLFMAN_CHARACTER
	#ifdef ENABLE_WOLFMAN_CHARACTER
#define USE_MOB_BLEEDING_AS_POISON
#define USE_MOB_CLAW_AS_DAGGER
// #define USE_ITEM_BLEEDING_AS_POISON
// #define USE_ITEM_CLAW_AS_DAGGER
#define USE_WOLFMAN_STONES
#define USE_WOLFMAN_BOOKS
#endif
// ### Lycan ###
//////////////////////////////////////////////////////////////////////////

#define ENABLE_PLAYER_PER_ACCOUNT5
#define ENABLE_DICE_SYSTEM
#define ENABLE_EXTEND_INVEN_SYSTEM
#define ENABLE_MOUNT_COSTUME_SYSTEM
#define ENABLE_WEAPON_COSTUME_SYSTEM
#define ENABLE_MAGIC_REDUCTION_SYSTEM
#ifdef ENABLE_MAGIC_REDUCTION_SYSTEM
#define USE_MAGIC_REDUCTION_STONES
#endif


#define DISABLE_STOP_RIDING_WHEN_DIE //	if DISABLE_TOP_RIDING_WHEN_DIE is defined , the player does not lose the horse after his death
#define ENABLE_ACCE_SYSTEM //fixed version
#define ENABLE_HIGHLIGHT_NEW_ITEM //if you want to see highlighted a new item when dropped or when exchanged
#define __ENABLE_KILL_EVENT_FIX__ //if you want to fix the 0 exp problem about the when kill lua event (recommended)
#define ENABLE_SYSLOG_PACKET_SENT


// ### CommonDefines Systems ###
//////////////////////////////////////////////////////////////////////////
#define ENABLE_CHAT														// Flag on Chat System.
#define ENABLE_EXTENDED_ITEMNAME										// Extended Item Name System
#define ENABLE_TARGET_INFORMATION_SYSTEM										// Target Information System
#define ENABLE_HEALTH_BOARD_SYSTEM												// Health Board System
#define ENABLE_VIEW_TARGET_MONSTER_HP											// Target Hp Percent System
#define ENABLE_FALL_FIX
#define ENABLE_GOLD_REWARD_RENEWAL
#define ENABLE_DS_GRADE_MYTH
#define ENABLE_EMOJI_UPDATE														// Emoji update.
#define ENABLE_CHANNEL_SWITCH_SYSTEM											// Channel Switcher System
//#define ENABLE_ORE_DROP_FROM_MINING
//#define ENABLE_PTLOG
#define ENABLE_DEFAULT_PRIV
#define ENABLE_ITEMAWARD_REFRESH
#define ENABLE_PROTO_FROM_DB
#define ENABLE_AUTODETECT_VNUMRANGE
#define ENABLE_GOHOME_IF_MAP_NOT_ALLOWED
#define ENABLE_ANTI_CMD_FLOOD
#define ENABLE_OPEN_SHOP_WITH_ARMOR
#define ENABLE_EFFECT_PENETRATE
#define GetGoldMultipler() (1)
#define GetExpMultipler() (1)
#define ENABLE_NEWEXP_CALCULATION
#define ENABLE_EFFECT_EXTRAPOT
#define ENABLE_BOOKS_STACKFIX
#define ENABLE_ADDSTONE_FAILURE
//#define ENABLE_FIREWORK_STUN
//#define ENABLE_BLOCK_CMD_SHORTCUT
#define ENABLE_CMD_IPURGE_EX
#define ENABLE_SET_STATE_WITH_TARGET
#define ENABLE_STATPLUS_NOLIMIT

#define ENABLE_AUTODETECT_INTERNAL_IP
#define ENABLE_CMD_PLAYER
#define ENABLE_EXPTABLE_FROMDB

// #define ENABLE_GENERAL_CMD
// #define ENABLE_GENERAL_CONFIG
// #define ENABLE_IMMUNE_PERC
#define ENABLE_FORCE2MASTERSKILL
// #define ENABLE_MOUNTSKILL_CHECK
// #define ENABLE_NULLIFYAFFECT_LIMIT
// #define ENABLE_MASTER_SKILLBOOK_NO_STEPS
// #define ENABLE_SPAMDB_REFRESH
#define ENABLE_FISHINGROD_RENEWAL
// #define ENABLE_NEWGUILDMAKE
// #define ENABLE_INFINITE_HORSE_HEALTH_STAMINA
// #define ENABLE_ACCOUNT_W_SPECIALCHARS
#define ENABLE_GOHOME_IF_MAP_NOT_EXIST
//#define ENABLE_SHOP_BLACKLIST
#define ENABLE_PARTYKILL
// #define ENABLE_LOCALECHECK_CHANGENAME
// #define ENABLE_PC_OPENSHOP
#define ENABLE_TRANSLATE_LUA
#define ENABLE_QUEST_DIE_EVENT
#define ENABLE_PICKAXE_RENEWAL
//#define ENABLE_LIMIT_TIME
#define ENABLE_CHAT_LOGGING
#define ENABLE_CHAT_SPAMLIMIT
#define ENABLE_WHISPER_CHAT_SPAMLIMIT
#define ENABLE_CHECK_GHOSTMODE
#define ENABLE_IMMUNE_FIX
#define ENABLE_QUEST_RENEWAL
#define ENABLE_GENERAL_CONFIG


