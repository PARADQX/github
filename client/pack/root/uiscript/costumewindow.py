import uiScriptLocale
import item
import app

COSTUME_START_INDEX = item.COSTUME_SLOT_START


window = {
	"name" : "CostumeWindow",

	"x" : SCREEN_WIDTH - 175 - 140,
	"y" : SCREEN_HEIGHT - 37 - 565,

	"style" : ("movable", "float",),

	"width" : 140,
	"height" : (180 + 47), #±âÁ¸º¸´Ù 47 ±æ¾îÁü

	"children" :
	(
		{
			"name" : "board",
			"type" : "board",
			"style" : ("attach",),

			"x" : 0,
			"y" : 0,

			"width" : 140,
			"height" : (180 + 47),
			
			"children" :
			(
				## Title
				{
					"name" : "TitleBar",
					"type" : "titlebar",
					"style" : ("attach",),

					"x" : 6,
					"y" : 6,

					"width" : 130,
					"color" : "yellow",

					"children" :
					(
						{ "name":"TitleName", "type":"text", "x":60, "y":3, "text":uiScriptLocale.COSTUME_WINDOW_TITLE, "text_horizontal_align":"center" },
					),
				},

				## Equipment Slot
				{
					"name" : "Costume_Base",
					"type" : "image",

					"x" : 13,
					"y" : 38,
					
					"image" : "d:/ymir work/ui/new_costume_bg.jpg",					

					"children" :
					(

						{
							"name" : "CostumeSlot",
							"type" : "slot",

							"x" : 3,
							"y" : 3,

							"width" : 127,
							"height" : 145 + 47,

							"slot" : (
										{"index":COSTUME_START_INDEX+0, "x":62, "y":45, "width":32, "height":64},#¸ö
										{"index":COSTUME_START_INDEX+1, "x":62, "y": 9, "width":32, "height":32},#¸Ó¸®
										{"index":COSTUME_START_INDEX+2, "x":5, "y":126, "width":32, "height":32},#¸¶¿îÆ®
										{"index":COSTUME_START_INDEX+3, "x":70, "y":126, "width":32, "height":32},#¾Ç¼¼¼­¸®
										{"index":item.COSTUME_SLOT_WEAPON, "x":13, "y":13, "width":32, "height":96},#¹«±â
										#{"index":item.COSTUME_SLOT_AURA, "x":37, "y":126, "width":32, "height":32},#¿µ±â
									),
						},
					),
				},
			),
		},
	),
}
