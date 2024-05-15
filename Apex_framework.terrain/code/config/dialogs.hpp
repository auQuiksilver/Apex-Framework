/*/
File: dialogs.hpp
Author:

	Quiksilver
	
Last Modified:

	24/11/2023 A3 2.14 by Quiksilver
	
Description:

    Dialogs
_____________________________________________________________/*/

#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102

#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C
#define ST_GROUP_BOX       96
#define ST_GROUP_BOX2      112
#define ST_ROUNDED_CORNER  ST_GROUP_BOX + ST_CENTER
#define ST_ROUNDED_CORNER2 ST_GROUP_BOX2 + ST_CENTER

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4

#define GUI_GRID_WAbs			((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs			(GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W			(GUI_GRID_WAbs / 40)
#define GUI_GRID_H			(GUI_GRID_HAbs / 25)
#define GUI_GRID_X			(safezoneX)
#define GUI_GRID_Y			(safezoneY + safezoneH - GUI_GRID_HAbs)

// Default text sizes
#define GUI_TEXT_SIZE_SMALL		(GUI_GRID_H * 0.8)
#define GUI_TEXT_SIZE_MEDIUM		(GUI_GRID_H * 1)
#define GUI_TEXT_SIZE_LARGE		(GUI_GRID_H * 1.2)

class QS_RD_dialog_RscCombo {
	idc = -1;
	type = 4;
	style = 1;
	x = 0;
	y = 0;
	w = 0.3;
	h = 0.035;
	colorSelect[] = {0.023529, 0, 0.0313725, 1};
	colorText[] = {0.023529, 0, 0.0313725, 1};
	colorBackground[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground[] = {0.543, 0.5742, 0.4102, 1.0};
	colorScrollbar[] = {0.023529, 0, 0.0313725, 1};
	arrowEmpty = "\ca\ui\data\ui_arrow_combo_ca.paa";
	arrowFull = "\ca\ui\data\ui_arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	color[] = {0, 0, 0, 0.6};
	colorActive[] = {0, 0, 0, 1};
	colorDisabled[] = {0, 0, 0, 0.3};
	font = "RobotoCondensed";
	sizeEx = 0.031;
	soundSelect[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundExpand[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundCollapse[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	maxHistoryDelay = 1.0;
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
	class ComboScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	class VScrollbar {
		color[] = {1, 1, 1, 0.6};
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
		shadow = 0;
	};
	
	class HScrollbar {
		color[] = {1, 1, 1, 0.6};
		height = 0.028;
		shadow = 0;
	};
};

class QS_RD_dialog_RscCombo_2
{
    deletable = 0;
    fade = 0;
    access = 0;
    type = CT_COMBO;
	style = ST_LEFT;
    colorSelect[] = {0, 0, 0, 1};
    colorText[] = {1, 1, 1, 1};
    colorBackground[] = {0, 0, 0, 0.5};
    colorScrollbar[] = {1, 0, 0, 1};
    colorDisabled[] = {1, 1, 1, 0.25};
    colorPicture[] = {1, 1, 1, 1};
    colorPictureSelected[] = {1, 1, 1, 1};
    colorPictureDisabled[] = {1, 1, 1, 0.25};
    colorPictureRight[] = {1, 1, 1, 1};
    colorPictureRightSelected[] = {1, 1, 1, 1};
    colorPictureRightDisabled[] = {1, 1, 1, 0.25};
    colorTextRight[] = {1, 1, 1, 1};
    colorSelectRight[] = {0, 0, 0, 1};
    colorSelect2Right[] = {0, 0, 0, 1};
    tooltipColorText[] = {1, 1, 1, 1};
    tooltipColorBox[] = {1, 1, 1, 1};
    tooltipColorShade[] = {0, 0, 0, 0.65};
    soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect", 0.1, 1};
    soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand", 0.1, 1};
    soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse", 0.1, 1};
    maxHistoryDelay = 1;
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
    class ComboScrollBar: ScrollBar {
        color[] = {1, 1, 1, 1};
    };
	class VScrollbar {
		color[] = {1, 1, 1, 0.6};
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
		shadow = 0;
	};
    colorSelectBackground[] = {1, 1, 1, 0.7};
    colorActive[] = {1, 0, 0, 1};
    font = "RobotoCondensed";
    sizeEx = 0.02;
    shadow = 0;
    x = 0;
    y = 0;
    w = 0;
    h = 0;
    arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
    arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
    wholeHeight = 0.05;
	rowHeight = 0.04;
};

class QS_RD_dialog_RscControlsGroup {
	type = 15;
	idc = -1;
	x = 0;
	y = 0;
	w = safeZoneW;
	h = safeZoneH;
	shadow = 0;
	style = 16;
	
	class VScrollbar {
		color[] = {1, 1, 1, 0.6};
		width = 0.021;
		autoScrollSpeed = -1;
		autoScrollDelay = 5;
		autoScrollRewind = 0;
		shadow = 0;
	};
	
	class HScrollbar {
		color[] = {1, 1, 1, 0.6};
		height = 0.028;
		shadow = 0;
	};
	
	class ScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	
	class ComboScrollBar {
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	};
	
	class Controls {};
};
class RscProgress
{
	deletable = 0;
	fade = 0;
	//access = 0;
	type = CT_PROGRESS;
	style = ST_HORIZONTAL;
	colorFrame[] = {0,0,0,0};
	colorBar[] =
	{
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"
	};
	x = 0.344;
	y = 0.619;
	w = 0.313726;
	h = 0.0261438;
	shadow = 2;
	texture = "#(argb,8,8,3)color(1,1,1,1)";
};
class QS_RD_dialog_RscText {
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	type = 0;
	style = 2;
	shadow = 0;
	colorShadow[] = {0, 0, 0, 0.5};
	colorDisabled[] = {1,1,1,0.25};
	font = "RobotoCondensed";
	SizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	colorText[] = {0,1,1,1};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
	linespacing = 1;
	class Attributes {
		align = "left";
	};
};
class QS_RD_dialog_RscEdit {
	type = 2;
	//access = 0;
	style = 16;
	font = "RobotoCondensed";
	shadow = 0;
	autocomplete = "scripting";
	canModify = 1;
	colorBackground[] = {0,0,0,0};
	colorDisabled[] = {1,1,1,0.25};
	colorSelection[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	colorText[] = {0.95,0.95,0.95,1};
	deletable = 0;
	fade = 0;
	sizeEx = 1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
	x = 0;
	y = 0;
	h = 0;
	w = 0;
};

class QS_RD_dialog_RscPicture {
    //access = 0;
    idc = -1;
    type = CT_STATIC;
    style = ST_PICTURE;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,0.8};
    font = "RobotoCondensed";
    sizeEx = 0;
    lineSpacing = 0;
    text = "";
    fixedWidth = 0;
    shadow = 0;
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.15;
};
class QS_RD_dialog_RscPictureKeepAspect: QS_RD_dialog_RscPicture {
	style = ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
};
class QS_RD_dialog_RscButton {
	//access = 0;
    type = CT_BUTTON;
    text = "";
   	style = 2;
	x = 0;
	y = 0;
	w = 0.095589;
	h = 0.039216;
	shadow = 0;
	font = "RobotoCondensed";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	//colorText[] = {1,1,1,1};
	colorText[] = {0,0,0,1};
	colorDisabled[] = {0.4,0.4,0.4,1};
	colorBackground[] = {0,0,0,0.7};
	colorBackgroundActive[] = {0.5,0.5,0.5,0.7};
	colorBackgroundDisabled[] = {0,0,0,0.7};
	offsetX = 0.003;
	offsetY = 0.003;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorFocused[] = {0,0,0,1};
	colorShadow[] = {0,0,0,1};
	colorBorder[] = {0,0,0,1};
	borderSize = 0.0;
	soundEnter[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundEnter", 0.09, 1};
	soundPush[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundPush", 0.0, 0};
	soundClick[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundClick", 0.07, 1};
	soundEscape[] = {"\A3\ui_f\data\Sound\RscButtonMenu\soundEscape", 0.09, 1};
};
class QS_RD_dialog_RscShortcutButton {
	//access = 0;
    type = CT_SHORTCUTBUTTON;
	idc = -1;
	style = 48;
	default = 0;
	shadow = 1;
	w = 0.183825;
	h = "(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20)";
	color[] = {1,1,1,1};
	color2[] = {0.95,0.95,0.95,1};
	colorDisabled[] = {1,1,1,0.25};
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",1};
	colorBackground2[] = {1,1,1,1};
	colorBackgroundFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	colorFocused[] = {1,1,1,1};
	animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
	animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
	animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
	animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
	periodFocus = 1.2;
	periodOver = 0.8;
	class HitZone {
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	class ShortcutPos{
		left = 0;
		top = "(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		w = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		h = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class TextPos{
		left = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1) * (3/4)";
		top = "(			(		(		((safezoneW / safezoneH) min 1.2) / 1.2) / 20) - 		(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.005;
		bottom = 0.0;
	};
	period = 0.4;
	font = "RobotoCondensed";
	size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	soundEnter[] = {"\A3\ui_f\data\sound\onover",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\new1",0.0,0};
	soundClick[] = {"\A3\ui_f\data\sound\onclick",0.07,1};
	soundEscape[] = {"\A3\ui_f\data\sound\onescape",0.09,1};
	action = "";
	class Attributes {
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
	class AttributesImage {
		font = "RobotoCondensed";
		color = "#E5E5E5";
		align = "left";
	};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
};
class QS_RD_dialog_RscButtonInvisible {
    //access = 0;
    type = 1;
    text = "";
    colorText[] = {0,0,0,0};
    colorDisabled[] = {0,0,0,0};
    colorBackground[] = {0,0,0,0};
    colorBackgroundDisabled[] = {0,0,0,0};
    colorBackgroundActive[] = {0,0,0,0};
    colorFocused[] = {0,0,0,0};
    colorShadow[] = {0,0,0,0};
    colorBorder[] = {0,0,0,0};
    soundEnter[] = {"",0.09,1};
    soundPush[] = {"",0.09,1};
    soundClick[] = {"",0.07,1};
    soundEscape[] = {"",0.09,1};
    style = 2;
    x = 0;
    y = 0;
    w = 0.095589;
    h = 0.039216;
    shadow = 2;
    font = "RobotoCondensed";
    sizeEx = 0.03921;
    offsetX = 0.003;
    offsetY = 0.003;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
};
class QS_RD_dialog_RscFrame {
    type = CT_STATIC;
    idc = -1;
    style = ST_FRAME;
    shadow = 2;
    colorBackground[] = {1,1,1,1};
	colorBorder[] = {1,1,1,1};
    colorText[] = {1,1,1,0.9};
    font = "RobotoCondensed";
    sizeEx = 0.03;
    text = "";
};
class QS_RD_dialog_Box {
    type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    shadow = 0;
    colorBackground[] = {0,0,0,0.5};
	colorBorder[] = {1,1,1,1};
    colorText[] = {1,1,1,0.5};
    font = "RobotoCondensed";
    sizeEx = 0.03;
    text = "";
};
class QS_RD_dialog_Box_2: QS_RD_dialog_Box {
    type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    shadow = 0;
    colorBackground[] = {0,0,0,0.5};
	colorBorder[] = {1,1,1,1};
    colorText[] = {1,1,1,0.5};
    font = "RobotoCondensed";
    sizeEx = 0.03;
    text = "";
	x = 0;
	y = 0;
	w = 0;
	h = 0;
};

class QS_RD_XSlider {
	style = 1024;
	type = 43;
	shadow = 1;
	x = 0;
	y = 0;
	h = 0.029412;
	w = 0.400000;
	color[] = {1, 1, 1, 0.7};
	colorActive[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.500000};
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
};
class QS_RD_Progress {
	type = 8;
	style = 0;
	colorFrame[] = {0,0,0,1};
	colorBar[] = {1,1,1,1};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
	w = 1;
	h = 0.03;
};
class QS_RD_RscStructuredText {
	type = 13;
	style = 2;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	shadow = 0;
	colorShadow[] = {0, 0, 0, 0.5};
	colorDisabled[] = {1,1,1,0.25};
	font = "RobotoCondensed";
	SizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	text = "";
	colorText[] = {0,1,1,1};
	colorBackground[] = { 0, 0, 0, 0 };	
	linespacing = 1;
};

class QS_RD_RscCheckbox {
	//access = 0;
	idc = -1;
	type = 77;
	style = ST_LEFT + ST_MULTI;
	default = 0;
	blinkingPeriod = 0;
	x = 0;
	y = 0;
	w = 1 * GUI_GRID_CENTER_W;
	h = 1 * GUI_GRID_CENTER_H;
	color[] = { 1, 1, 1, 0.7 };
	colorFocused[] = { 1, 1, 1, 1 };
	colorHover[] = { 1, 1, 1, 1 };
	colorPressed[] = { 1, 1, 1, 1 };
	colorDisabled[] = { 1, 1, 1, 0.2 };
	colorBackground[] = { 0, 0, 0, 0 };
	colorBackgroundFocused[] = { 0, 0, 0, 0 };
	colorBackgroundHover[] = { 0, 0, 0, 0 };
	colorBackgroundPressed[] = { 0, 0, 0, 0 };
	colorBackgroundDisabled[] = { 0, 0, 0, 0 };
	textureChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureFocusedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureFocusedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureHoverChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureHoverUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	texturePressedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	texturePressedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureDisabledChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureDisabledUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	tooltip = "";
	tooltipColorShade[] = { 0, 0, 0, 1 };
	tooltipColorText[] = { 1, 1, 1, 1 };
	tooltipColorBox[] = { 1, 1, 1, 1 };
	soundClick[] = { "\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1 };
	soundEnter[] = { "\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1 };
	soundPush[] = { "\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1 };
	soundEscape[] = { "\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1 };

};

class QS_RD_dialog_ScrollBar {
	color[] = {1,1,1,0.6};
	colorActive[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.3};
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	shadow = 0;
	scrollSpeed = 0.06;
	width = 0;
	height = 0;
	autoScrollEnabled = 0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
};

class QS_RD_dialog_RscListBox {
	style = 16;
	idc = -1;
	type = 5;
	w = 0.275;
	h = 0.04;
	font = "RobotoCondensed";
	color[] = {0.7, 0.7, 0.7, 1};
	colorActive[] = {0,0,0,1};
	colorDisabled[] = {0,0,0,0.3};
	colorSelect[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0.28,0.28,0.28,0.28};
	colorSelect2[] = {1, 1, 1, 1};
	colorSelectBackground[] = {0.95, 0.95, 0.95, 0.5};
	colorSelectBackground2[] = {1, 1, 1, 0.5};
	colorScrollbar[] = {0.2, 0.2, 0.2, 1};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,1};
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	wholeHeight = 0.45;
	rowHeight = 0.04;
	sizeEx = 0.023;
	soundSelect[] = {"",0.1,1};
	soundExpand[] = {"",0.1,1};
	soundCollapse[] = {"",0.1,1};
	maxHistoryDelay = 1;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	class ListScrollBar: QS_RD_dialog_ScrollBar {
		color[] = {1,1,1,1};
		autoScrollEnabled = 1;
	};
};
class QS_RD_dialog_RscListNBox {
	//access = 0;
	type = CT_LISTNBOX;			// 102; 
	style = ST_MULTI;
	w = 0.4;   
	h = 0.4; 
	font = "RobotoCondensed"; 
	sizeEx = 0.04; 

	autoScrollSpeed = -1; 
	autoScrollDelay = 5; 
	autoScrollRewind = 0; 
	arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
	arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
	columns[] = {0.3, 0.6, 0.7}; 

	color[] = {0.7, 0.7, 0.7, 1};
	colorSelect[] = {1, 1, 1, 1};
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0.28,0.28,0.28,0.28};
	colorSelect2[] = {1, 1, 1, 1};
	colorSelectBackground[] = {0.95, 0.95, 0.95, 0.5};
	colorSelectBackground2[] = {1, 1, 1, 0.5};
	colorScrollbar[] = {0.2, 0.2, 0.2, 1};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,1};
	colorActive[] = {0,0,0,1};
	colorDisabled[] = {0,0,0,0.3};
	drawSideArrows = 0; 
	idcLeft = -1; 
	idcRight = -1; 
	maxHistoryDelay = 1; 
	rowHeight = 0; 
	soundSelect[] = {"", 0.1, 1}; 
	period = 1; 
	shadow = 2; 
	class ScrollBar {
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
		border = "#(argb,8,8,3)color(1,1,1,1)";
		color[] = {1,1,1,1};
		colorActive[] = {1,1,1,1};
		colorDisabled[] = {1,1,1,0.3};
		thumb = "#(argb,8,8,3)color(1,1,1,1)";
	};
	class ListScrollBar: QS_RD_dialog_ScrollBar {
		color[] = {1,1,1,1};
		autoScrollEnabled = 1;
	};
};
/*
class dialog {
  class controls {
    class MyLbox:RscListNBox {
        x=y=wherever;
        canDrag=true;
        rows=10;
        lineSpacing = 1.3;
    };
  };
};
*/
/*
#define CT_MAP              100
#define CT_MAP_MAIN         101
*/
class QS_RD_dialog_RscMapControl {
	type = CT_MAP;
	style = ST_PICTURE;
	idc = 51;
	colorBackground[] = {0.969, 0.957, 0.949, 1};
	colorOutside[] = {0, 0, 0, 1};
	colorText[] = {0, 0, 0, 1};
	font = "TahomaB";
	sizeEx = 0.04;
	colorSea[] = {0.467, 0.631, 0.851, 0.5};
	colorForest[] = {0.624, 0.78, 0.388, 0.5};
	colorRocks[] = {0, 0, 0, 0.3};
	colorCountlines[] = {0.572, 0.354, 0.188, 0.25};
	colorMainCountlines[] = {0.572, 0.354, 0.188, 0.5};
	colorCountlinesWater[] = {0.491, 0.577, 0.702, 0.3};
	colorMainCountlinesWater[] = {0.491, 0.577, 0.702, 0.6};
	colorForestBorder[] = {0, 0, 0, 0};
	colorRocksBorder[] = {0, 0, 0, 0};
	colorPowerLines[] = {0.1, 0.1, 0.1, 1};
	colorRailWay[] = {0.8, 0.2, 0, 1};
	colorNames[] = {0.1, 0.1, 0.1, 0.9};
	colorInactive[] = {1, 1, 1, 0.5};
	colorLevels[] = {0.286, 0.177, 0.094, 0.5};
	colorTracks[] = {0.84, 0.76, 0.65, 0.15};
	colorRoads[] = {0.7, 0.7, 0.7, 1};
	colorMainRoads[] = {0.9, 0.5, 0.3, 1};
	colorTracksFill[] = {0.84, 0.76, 0.65, 1};
	colorRoadsFill[] = {1, 1, 1, 1};
	colorMainRoadsFill[] = {1, 0.6, 0.4, 1};
	colorGrid[] = {0.1, 0.1, 0.1, 0.6};
	colorGridMap[] = {0.1, 0.1, 0.1, 0.6};
	stickX[] = {0.2, {"Gamma", 1, 1.5}};
	stickY[] = {0.2, {"Gamma", 1, 1.5}};
	moveOnEdges = 1;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	shadow = 0;
	ptsPerSquareSea = 5;
	ptsPerSquareTxt = 20;
	ptsPerSquareCLn = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareFor = 9;
	ptsPerSquareForEdge = 9;
	ptsPerSquareRoad = 6;
	ptsPerSquareObj = 9;
	showCountourInterval = 0;
	scaleMin = 0.001;
	scaleMax = 1;
	scaleDefault = 0.16;
	maxSatelliteAlpha = 0.85;
	alphaFadeStartScale = 2;
	alphaFadeEndScale = 2;
	fontLabel = "RobotoCondensed";
	sizeExLabel = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontGrid = "TahomaB";
	sizeExGrid = 0.02;
	fontUnits = "TahomaB";
	sizeExUnits = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontNames = "EtelkaNarrowMediumPro";
	sizeExNames = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
	fontInfo = "RobotoCondensed";
	sizeExInfo = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontLevel = "TahomaB";
	sizeExLevel = 0.02;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	widthRailWay = 4;

	class Legend {
		colorBackground[] = {1, 1, 1, 0.5};
		color[] = {0, 0, 0, 1};
		x = "SafeZoneX + (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		font = "RobotoCondensed";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	};
	class ActiveMarker {
		color[] = {0.3, 0.1, 0.9, 1};
		size = 50;
	};
	class Command {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Task {
		colorCreated[] = {1, 1, 1, 1};
		colorCanceled[] = {0.7, 0.7, 0.7, 1};
		colorDone[] = {0.7, 1, 0.3, 1};
		colorFailed[] = {1, 0.3, 0.2, 1};
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class CustomMark {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Tree {
		color[] = {0.45, 0.64, 0.33, 0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class SmallTree {
		color[] = {0.45, 0.64, 0.33, 0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Bush {
		color[] = {0.45, 0.64, 0.33, 0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = "14/2";
		importance = "0.2 * 14 * 0.05 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Church {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Chapel {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Cross {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Rock {
		color[] = {0.1, 0.1, 0.1, 0.8};
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Bunker {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fortress {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fountain {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		size = 11;
		importance = "1 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class ViewTower {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.5;
		coefMax = 4;
	};
	class Lighthouse {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Quay {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Fuelstation {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Hospital {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class BusStop {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Transmitter {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Stack {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.9;
		coefMax = 4;
	};
	class Ruin {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 1;
		coefMax = 4;
	};
	class Tourism {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.7;
		coefMax = 4;
	};
	class Watertower {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Waypoint {
		color[] = {0, 0, 0, 1};
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
	};
	class WaypointCompleted {
		color[] = {0, 0, 0, 1};
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
	};
	class power {
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class powersolar {
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class powerwave {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class powerwind {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class Shipwreck {
		icon = "\A3\ui_f\data\map\mapcontrol\Shipwreck_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {0, 0, 0, 1};
	};
};
class QS_RD_dialog_RscMapControl2 {
	type = CT_MAP;
	style = ST_PICTURE;
	idc = 51;
	colorBackground[] = {0.969, 0.957, 0.949, 1};
	colorOutside[] = {0, 0, 0, 1};
	colorText[] = {0, 0, 0, 1};
	font = "TahomaB";
	sizeEx = 0.04;
	colorSea[] = {0.467, 0.631, 0.851, 0.5};
	colorForest[] = {0.624, 0.78, 0.388, 0.5};
	colorRocks[] = {0, 0, 0, 0.3};
	colorCountlines[] = {0.572, 0.354, 0.188, 0.25};
	colorMainCountlines[] = {0.572, 0.354, 0.188, 0.5};
	colorCountlinesWater[] = {0.491, 0.577, 0.702, 0.3};
	colorMainCountlinesWater[] = {0.491, 0.577, 0.702, 0.6};
	colorForestBorder[] = {0, 0, 0, 0};
	colorRocksBorder[] = {0, 0, 0, 0};
	colorPowerLines[] = {0.1, 0.1, 0.1, 1};
	colorRailWay[] = {0.8, 0.2, 0, 1};
	colorNames[] = {0.1, 0.1, 0.1, 0.9};
	colorInactive[] = {1, 1, 1, 0.5};
	colorLevels[] = {0.286, 0.177, 0.094, 0.5};
	colorTracks[] = {0.84, 0.76, 0.65, 0.15};
	colorRoads[] = {0.7, 0.7, 0.7, 1};
	colorMainRoads[] = {0.9, 0.5, 0.3, 1};
	colorTracksFill[] = {0.84, 0.76, 0.65, 1};
	colorRoadsFill[] = {1, 1, 1, 1};
	colorMainRoadsFill[] = {1, 0.6, 0.4, 1};
	colorGrid[] = {0.1, 0.1, 0.1, 0.6};
	colorGridMap[] = {0.1, 0.1, 0.1, 0.6};
	stickX[] = {0.2, {"Gamma", 1, 1.5}};
	stickY[] = {0.2, {"Gamma", 1, 1.5}};
	moveOnEdges = 1;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	shadow = 0;
	ptsPerSquareSea = 5;
	ptsPerSquareTxt = 20;
	ptsPerSquareCLn = 10;
	ptsPerSquareExp = 10;
	ptsPerSquareCost = 10;
	ptsPerSquareFor = 9;
	ptsPerSquareForEdge = 9;
	ptsPerSquareRoad = 6;
	ptsPerSquareObj = 9;
	showCountourInterval = 0;
	scaleMin = 0.001;
	scaleMax = 1;
	scaleDefault = 0.16;
	maxSatelliteAlpha = 0.85;
	alphaFadeStartScale = 2;
	alphaFadeEndScale = 2;
	fontLabel = "RobotoCondensed";
	sizeExLabel = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontGrid = "TahomaB";
	sizeExGrid = 0.02;
	fontUnits = "TahomaB";
	sizeExUnits = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontNames = "EtelkaNarrowMediumPro";
	sizeExNames = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
	fontInfo = "RobotoCondensed";
	sizeExInfo = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontLevel = "TahomaB";
	sizeExLevel = 0.02;
	text = "#(argb,8,8,3)color(1,1,1,1)";

	class Legend {
		colorBackground[] = {1, 1, 1, 0.5};
		color[] = {0, 0, 0, 1};
		x = "SafeZoneX + (((safezoneW / safezoneH) min 1.2) / 40)";
		y = "SafeZoneY + safezoneH - 4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w = "10 * (((safezoneW / safezoneH) min 1.2) / 40)";
		h = "3.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		font = "RobotoCondensed";
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	};
	class ActiveMarker {
		color[] = {0.3, 0.1, 0.9, 1};
		size = 50;
	};
	class Command {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size = 18;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Task {
		colorCreated[] = {1, 1, 1, 1};
		colorCanceled[] = {0.7, 0.7, 0.7, 1};
		colorDone[] = {0.7, 1, 0.3, 1};
		colorFailed[] = {1, 0.3, 0.2, 1};
		color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])", "(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
		icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		size = 27;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class CustomMark {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
	};
	class Tree {
		color[] = {0.45, 0.64, 0.33, 0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = 12;
		importance = "0.9 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class SmallTree {
		color[] = {0.45, 0.64, 0.33, 0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = 12;
		importance = "0.6 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Bush {
		color[] = {0.45, 0.64, 0.33, 0.4};
		icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		size = "14/2";
		importance = "0.2 * 14 * 0.05 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Church {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Chapel {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Cross {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Rock {
		color[] = {0.1, 0.1, 0.1, 0.8};
		icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		size = 12;
		importance = "0.5 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Bunker {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 14;
		importance = "1.5 * 14 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fortress {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size = 16;
		importance = "2 * 16 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class Fountain {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		size = 11;
		importance = "1 * 12 * 0.05";
		coefMin = 0.25;
		coefMax = 4;
	};
	class ViewTower {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		size = 16;
		importance = "2.5 * 16 * 0.05";
		coefMin = 0.5;
		coefMax = 4;
	};
	class Lighthouse {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Quay {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Fuelstation {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Hospital {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class BusStop {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Transmitter {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Stack {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size = 20;
		importance = "2 * 16 * 0.05";
		coefMin = 0.9;
		coefMax = 4;
	};
	class Ruin {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size = 16;
		importance = "1.2 * 16 * 0.05";
		coefMin = 1;
		coefMax = 4;
	};
	class Tourism {
		color[] = {0, 0, 0, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size = 16;
		importance = "1 * 16 * 0.05";
		coefMin = 0.7;
		coefMax = 4;
	};
	class Watertower {
		color[] = {1, 1, 1, 1};
		icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
	};
	class Waypoint {
		color[] = {0, 0, 0, 1};
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
	};
	class WaypointCompleted {
		color[] = {0, 0, 0, 1};
		size = 24;
		importance = 1;
		coefMin = 1;
		coefMax = 1;
		icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
	};
	class power {
		icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class powersolar {
		icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class powerwave {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class powerwind {
		icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {1, 1, 1, 1};
	};
	class Shipwreck {
		icon = "\A3\ui_f\data\map\mapcontrol\Shipwreck_CA.paa";
		size = 24;
		importance = 1;
		coefMin = 0.85;
		coefMax = 1;
		color[] = {0, 0, 0, 1};
	};
};
class QS_client_dialog_menu_roles {
	idd = 42000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "uiNamespace setVariable ['QS_client_dialog_menu_roles',_this # 0]; 0 spawn (missionNamespace getVariable 'QS_fnc_clientMenuRSS');";
	onUnload = "uiNamespace setVariable ['QS_client_dialog_menu_roles',displayNull];";
};
class QS_RD_client_dialog_menu_main {
	idd = 2000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuMain');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuMain');";
	class controls {
		class QS_RD_client_dialog_menu_main_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_main_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_main_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1000;
			text = "$STR_QS_Dialogs_019";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.0955624 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_main_picture_1: QS_RD_dialog_RscPictureKeepAspect {
			moving = 1;
			idc = 1200;
			text = "media\images\insignia\comm_patch.paa";
			x = 0.479294 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.030 * safezoneW;
			h = 0.050 * safezoneH;
			shadow = 0;
		};
		class QS_RD_client_dialog_menu_main_text_3: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1002;
			x = 0.375000 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.025 * safezoneH;
			sizeEx = 0.028;
			shadow = 0;
			colorText[] = {1,1,1,1};
			text = "";
			tooltip = "Score, Rating, Health, Equipment";
		};
		class QS_RD_client_dialog_menu_main_text_2: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1001;
			x = 0.375000 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.025 * safezoneH;
			sizeEx = 0.028;
			shadow = 0;
			colorText[] = {1,1,1,1};
			tooltip = "$STR_QS_Dialogs_020";
		};
		
		class QS_RD_client_dialog_menu_main_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1600;
			text = "";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.645 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B1',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuMain');";
		};
		class QS_RD_client_dialog_menu_main_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1601;
			text = "";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.69 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B2',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuMain');";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_main_button_3: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1602;
			text = "";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.735 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			tooltip = "";
			onButtonClick = "['B3',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuMain');";
		};
		class QS_RD_client_dialog_menu_main_button_4: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1603;
			text = "";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.78 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			onButtonClick = "['B4',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuMain');";
			tooltip = "";
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_main_button_5: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1605;
			text = "";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.825 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['B5',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuMain');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_main_button_6: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1604;
			text = "";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['B6',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuMain');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
	};
};
class QS_RD_client_dialog_menu_viewSettings {
	idd = 3000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',-1] spawn (missionNamespace getVariable 'QS_fnc_clientViewOptions');";
	onUnload = "['onUnload',-1,-1] spawn (missionNamespace getVariable 'QS_fnc_clientViewOptions');";
	class controls {
		class QS_RD_client_dialog_menu_view_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_view_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_view_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_021";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.0955624 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_view_picture_1: QS_RD_dialog_RscPictureKeepAspect {
			moving = 1;
			idc = 1803;
			text = "media\images\insignia\comm_patch.paa";
			x = 0.479294 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.030 * safezoneW;
			h = 0.050 * safezoneH;
			shadow = 0;
		};
		class QS_RD_client_dialog_menu_view_text_10: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1001;
			x = 0.375000 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.025 * safezoneH;
			sizeEx = 0.028;
			shadow = 0;
			colorText[] = {1,1,1,1};
			tooltip = "$STR_QS_Dialogs_022";
		};
		class QS_RD_client_dialog_menu_view_button_1: QS_RD_dialog_RscButtonInvisible {
			moving = 1;
			idc = 1804;
			text = "";
			x = 0.385 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0238906 * safezoneW;
			h = 0.0410023 * safezoneH;
			shadow = 0;
			onButtonClick = "['onButtonClick',0] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');";
			tooltip = "$STR_QS_Dialogs_023";
		};
		class QS_RD_client_dialog_menu_view_picture_2: QS_RD_dialog_RscPictureKeepAspect {
			moving = 1;
			idc = 1805;
			text = "A3\ui_f\data\igui\cfg\mptable\infantry_ca.paa";
			x = 0.385 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0238906 * safezoneW;
			h = 0.0410023 * safezoneH;
			shadow = 0;
		};
		class QS_RD_client_dialog_menu_view_text_2: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1806;
			text = "$STR_QS_Dialogs_024";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.655 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.0180039 * safezoneH;
			sizeEx = 0.0275;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_view_xslider_1 : QS_RD_XSlider {
			moving = 1;
			idc = 1807;
			text = "";
			onSliderPosChanged = "['onSliderPosChange',0,(_this # 1)] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');";
			tooltip = "";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.0180039 * safezoneH;
		};
		class QS_RD_client_dialog_menu_view_text_3 : QS_RD_dialog_RscText {
			moving = 1;
			idc = 1808;
			text = "12000";
			tooltip = "";
			x = 0.475 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0180039 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_view_button_2: QS_RD_dialog_RscButtonInvisible {
			moving = 1;
			idc = 1809;
			text = "";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0238906 * safezoneW;
			h = 0.0410023 * safezoneH;
			shadow = 0;
			onButtonClick = "['onButtonClick',1] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');";
			tooltip = "$STR_QS_Dialogs_025";
		};
		class QS_RD_client_dialog_menu_view_picture_3: QS_RD_dialog_RscPictureKeepAspect {
			moving = 1;
			idc = 1810;
			text = "A3\soft_f\MRAP_01\data\UI\map_mrap_01_ca.paa";
			x = 0.415 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0238906 * safezoneW;
			h = 0.0410023 * safezoneH;
			shadow = 0;
		};
		class QS_RD_client_dialog_menu_view_text_4: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1811;
			text = "$STR_QS_Dialogs_026";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.705 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.0180039 * safezoneH;
			sizeEx = 0.0275;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_view_xslider_2 : QS_RD_XSlider {
			moving = 1;
			idc = 1812;
			text = "";
			onSliderPosChanged = "['onSliderPosChange',1,(_this # 1)] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');";
			tooltip = "";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.73 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.0180039 * safezoneH;
		};
		class QS_RD_client_dialog_menu_view_text_5 : QS_RD_dialog_RscText {
			moving = 1;
			idc = 1813;
			text = "12000";
			tooltip = "";
			x = 0.475 * safezoneW + safezoneX;
			y = 0.73 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0180039 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_view_button_3: QS_RD_dialog_RscButtonInvisible {
			moving = 1;
			idc = 1814;
			text = "";
			x = 0.445 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0238906 * safezoneW;
			h = 0.0410023 * safezoneH;
			shadow = 0;
			onButtonClick = "['onButtonClick',2] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');";
			tooltip = "$STR_QS_Dialogs_027";
		};
		class QS_RD_client_dialog_menu_view_picture_4: QS_RD_dialog_RscPictureKeepAspect {
			moving = 1;
			idc = 1815;
			text = "A3\air_f_beta\heli_transport_01\data\UI\map_heli_transport_01_base_ca.paa";
			x = 0.445 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0238906 * safezoneW;
			h = 0.0410023 * safezoneH;
			shadow = 0;
		};
		class QS_RD_client_dialog_menu_view_text_6: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1816;
			text = "$STR_QS_Dialogs_028";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.755 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.0180039 * safezoneH;
			sizeEx = 0.0275;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_view_xslider_3 : QS_RD_XSlider {
			moving = 1;
			idc = 1817;
			text = "";
			onSliderPosChanged = "['onSliderPosChange',2,(_this # 1)] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');";
			tooltip = "";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.78 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.0180039 * safezoneH;
		};
		class QS_RD_client_dialog_menu_view_text_7 : QS_RD_dialog_RscText {
			moving = 1;
			idc = 1818;
			text = "12000";
			tooltip = "";
			x = 0.475 * safezoneW + safezoneX;
			y = 0.78 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0180039 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_view_button_4: QS_RD_dialog_RscButtonInvisible {
			moving = 1;
			idc = 1819;
			text = "";
			x = 0.475 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0238906 * safezoneW;
			h = 0.0410023 * safezoneH;
			shadow = 0;
			onButtonClick = "['onButtonClick',3] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');";
			tooltip = "$STR_QS_Dialogs_029";
		};
		class QS_RD_client_dialog_menu_view_picture_5: QS_RD_dialog_RscPictureKeepAspect {
			moving = 1;
			idc = 1820;
			text = "A3\Air_F_Jets\Plane_Fighter_01\Data\UI\Fighter01_icon_ca.paa";
			x = 0.475 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0238906 * safezoneW;
			h = 0.0410023 * safezoneH;
			shadow = 0;
		};
		class QS_RD_client_dialog_menu_view_text_8: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1821;
			text = "$STR_QS_Dialogs_030";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.805 * safezoneH + safezoneY;
			w = 0.05 * safezoneW;
			h = 0.0180039 * safezoneH;
			sizeEx = 0.0275;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			tooltip = "$STR_QS_Dialogs_031";
		};
		class QS_RD_client_dialog_menu_view_xslider_4 : QS_RD_XSlider {
			moving = 1;
			idc = 1822;
			text = "";
			onSliderPosChanged = "['onSliderPosChange',3,(_this # 1)] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');";
			tooltip = "";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.83 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.0180039 * safezoneH;
		};
		class QS_RD_client_dialog_menu_view_text_9 : QS_RD_dialog_RscText {
			moving = 1;
			idc = 1823;
			text = "12000";
			tooltip = "";
			x = 0.475 * safezoneW + safezoneX;
			y = 0.83 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0180039 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_view_button_5: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1824;
			text = "$STR_QS_Dialogs_032";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Unload'] call (missionNamespace getVariable 'QS_fnc_clientViewOptions');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
	};
};
class QS_RD_client_dialog_menu_options {
	idd = 4000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
	class controls {
		class QS_RD_client_dialog_menu_options_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.60 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_options_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.60 * safezoneH;
		};
		
		class QS_RD_client_dialog_menu_options_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "Options";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.0955624 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_options_picture_1: QS_RD_dialog_RscPictureKeepAspect {
			moving = 1;
			idc = 1803;
			text = "media\images\insignia\comm_patch.paa";
			x = 0.479294 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.030 * safezoneW;
			h = 0.050 * safezoneH;
			shadow = 0;
		};
		
		class QS_RD_client_dialog_menu_options_text_2: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1804;
			text = "$STR_QS_Dialogs_033";
			tooltip = "$STR_QS_Dialogs_033";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.59 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.02 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
		};
		
		class QS_RD_client_dialog_menu_options_checkbox_1 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1805;
			x = 0.475 * safezoneH + safezoneY; 
			y = 0.585 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "$STR_QS_Dialogs_034";
			onCheckedChanged = "['StaminaCheckbox',_this # 0,_this # 1] call (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
		};
		class QS_RD_client_dialog_menu_options_text_3: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1806;
			text = "$STR_QS_Dialogs_035";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.63 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.02 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			tooltip = "$STR_QS_Dialogs_036";
		};
		class QS_RD_client_dialog_menu_options_xslider_1 : QS_RD_XSlider {
			moving = 1;
			idc = 1807;
			text = "";
			onSliderPosChanged = "['AimCoefSlider',(_this # 0),(_this # 1)] call (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.655 * safezoneH + safezoneY;
			w = 0.09 * safezoneW;
			h = 0.0180039 * safezoneH;
			tooltip = "$STR_QS_Dialogs_037";
		};
		class QS_RD_client_dialog_menu_options_text_4 : QS_RD_dialog_RscText {
			moving = 1;
			idc = 1808;
			text = "";
			tooltip = "";
			x = 0.475 * safezoneW + safezoneX;
			y = 0.655 * safezoneH + safezoneY;
			w = 0.032 * safezoneW;
			h = 0.0180039 * safezoneH;
			//sizeEx = 0.02175;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_options_text_5: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1809;
			text = "$STR_QS_Dialogs_038";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.695 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.02 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			tooltip = "$STR_QS_Dialogs_039";
		};
		class QS_RD_client_dialog_menu_options_checkbox_2 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1810;
			x = 0.475 * safezoneH + safezoneY; 
			y = 0.69 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "$STR_QS_Dialogs_040";
			onCheckedChanged = "['1PVCheckbox',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
		};
		/*/ ===== BACKUP
		class QS_RD_client_dialog_menu_options_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1811;
			text = "$STR_QS_Dialogs_032";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Back',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		/*/
		class QS_RD_client_dialog_menu_options_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1811;
			text = "$STR_QS_Dialogs_032";
			x = 0.38 * safezoneW + safezoneX;
			y = 1.075 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Back',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_options_text_6: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1812;
			text = "$STR_QS_Dialogs_041";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.735 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.02 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_options_checkbox_3 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1813;
			x = 0.475 * safezoneH + safezoneY; 
			y = 0.73 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "$STR_QS_Dialogs_042";
			onCheckedChanged = "['QHUDCheckbox',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
		};
		class QS_RD_client_dialog_menu_options_text_7: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1814;
			text = "$STR_QS_Dialogs_043";
			tooltip = "$STR_QS_Dialogs_044";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.78 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.02 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_options_checkbox_4 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1815;
			x = 0.475 * safezoneH + safezoneY; 
			y = 0.775 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "$STR_QS_Dialogs_045";
			onCheckedChanged = "['AmbientCheckbox',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
		};
		class QS_RD_client_dialog_menu_options_text_8: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1816;
			text = "$STR_QS_Dialogs_046";
			tooltip = "$STR_QS_Dialogs_047";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.825 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.02 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_options_checkbox_5 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1817;
			x = 0.475 * safezoneH + safezoneY; 
			y = 0.82 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "$STR_QS_Dialogs_048";
			onCheckedChanged = "['DynSimCheckbox',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
		};
		
		
		class QS_RD_client_dialog_menu_options_text_9: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1820;
			text = "$STR_QS_Dialogs_049";
			tooltip = "$STR_QS_Dialogs_050";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.02 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_options_checkbox_6 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1818;
			x = 0.475 * safezoneH + safezoneY; 
			y = 0.865 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "$STR_QS_Dialogs_050";
			onCheckedChanged = "['Toggle3DGroupHex',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
		};

		class QS_RD_client_dialog_menu_options_text_10: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1821;
			text = "$STR_QS_Dialogs_051";
			tooltip = "$STR_QS_Dialogs_052";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.915 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.02 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};		
		class QS_RD_client_dialog_menu_options_checkbox_7 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1819;
			x = 0.475 * safezoneH + safezoneY; 
			y = 0.91 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "$STR_QS_Dialogs_053";
			onCheckedChanged = "['ToggleSystemChatSpam',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
		};

		class QS_RD_client_dialog_menu_options_text_11: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1822;
			text = "$STR_QS_Dialogs_054";
			tooltip = "$STR_QS_Dialogs_055";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.96 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.02 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};		
		class QS_RD_client_dialog_menu_options_checkbox_8 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1823;
			x = 0.475 * safezoneH + safezoneY; 
			y = 0.955 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "$STR_QS_Dialogs_055";
			onCheckedChanged = "['ToggleSuppression',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
		};
		
		class QS_RD_client_dialog_menu_options_text_12: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1824;
			text = "$STR_QS_Dialogs_056";
			tooltip = "$STR_QS_Dialogs_057";
			x = 0.38 * safezoneW + safezoneX;
			y = 1.005 * safezoneH + safezoneY;
			w = 0.08 * safezoneW;
			h = 0.02 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorDisabled[] = {0,0,0,0};
			colorBackground[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorFocused[] = {0,0,0,0};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};		
		class QS_RD_client_dialog_menu_options_checkbox_9 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1825;
			x = 0.475 * safezoneH + safezoneY; 
			y = 1 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "$STR_QS_Dialogs_057";
			onCheckedChanged = "['ToggleHitMarker',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuOptions');";
		};
	};
};
class QS_RD_client_dialog_menu_supporters {
	idd = 5000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuSupporters');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuSupporters');";
	class controls {
		class QS_RD_client_dialog_menu_supporters_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_supporters_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_supporters_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_058";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.0955624 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_supporters_picture_1: QS_RD_dialog_RscPictureKeepAspect {
			moving = 1;
			idc = 1803;
			text = "media\images\insignia\comm_patch.paa";
			x = 0.479294 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.030 * safezoneW;
			h = 0.050 * safezoneH;
			shadow = 0;
		};
		
		class QS_RD_client_dialog_menu_supporters_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1804;
			text = "$STR_QS_Dialogs_101";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B1',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuSupporters');";
			tooltip = "$STR_QS_Dialogs_101";
		};
		class QS_RD_client_dialog_menu_supporters_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1805;
			text = "$STR_QS_Dialogs_059";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.625 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B2',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuSupporters');";
			tooltip = "$STR_QS_Dialogs_060";
		};
		class QS_RD_client_dialog_menu_supporters_button_3: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1806;
			text = "$STR_QS_Dialogs_061";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.67 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B3',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuSupporters');";
			tooltip = "$STR_QS_Dialogs_061";
		};
		class QS_RD_client_dialog_menu_supporters_button_4: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1807;
			text = "$STR_QS_Dialogs_062";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.715 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B4',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuSupporters');";
			tooltip = "$STR_QS_Dialogs_062";
		};
		class QS_RD_client_dialog_menu_supporters_button_5: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1808;
			text = "$STR_QS_Dialogs_102";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B5',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuSupporters');";
			tooltip = "$STR_QS_Dialogs_102";
		};
		class QS_RD_client_dialog_menu_supporters_button_6: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1809;
			text = "$STR_QS_Dialogs_063";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.805 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B6',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuSupporters');";
			tooltip = "$STR_QS_Dialogs_064";
		};
		class QS_RD_client_dialog_menu_supporters_button_7: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "$STR_QS_Dialogs_032";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Back',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuSupporters');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
	};
};
class QS_RD_client_dialog_menu_vtexture {
	idd = 7000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuVTexture');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuVTexture');";
	class controls {
		class QS_RD_client_dialog_menu_vtexture_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_vtexture_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_vtexture_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_065";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.139 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_vtexture_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "$STR_QS_Dialogs_066";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.815 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Select',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuVTexture');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_vtexture_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1811;
			text = "$STR_QS_Dialogs_032";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Back',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuVTexture');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1804;
			x = 0.38 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.22 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
	};
};
class QS_RD_client_dialog_menu_insignia {
	idd = 9000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuInsignia');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuInsignia');";
	class controls {
		class QS_RD_client_dialog_menu_insignia_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_insignia_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_insignia_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_067";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.139 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_insignia_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "$STR_QS_Dialogs_066";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.815 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Select',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuInsignia');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_insignia_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1811;
			text = "$STR_QS_Dialogs_032";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Back',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuInsignia');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1804;
			x = 0.38 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.22 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
	};
};
class QS_RD_client_dialog_menu_utexture {
	idd = 10000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuUTexture');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuUTexture');";
	class controls {
		class QS_RD_client_dialog_menu_utexture_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_utexture_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_utexture_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_068";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.139 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_utexture_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "$STR_QS_Dialogs_066";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.815 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Select',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuUTexture');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_utexture_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1811;
			text = "$STR_QS_Dialogs_032";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Back',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuUTexture');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1804;
			x = 0.38 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.22 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
	};
};
class QS_RD_client_dialog_menu_lasers {
	idd = 24000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuLasers');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuLasers');";
	class controls {
		class QS_RD_client_dialog_menu_lasers_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_lasers_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_lasers_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_102";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.139 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_lasers_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "$STR_QS_Dialogs_066";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.815 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Select',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuLasers');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_lasers_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1811;
			text = "$STR_QS_Dialogs_032";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Back',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuLasers');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1804;
			x = 0.38 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.22 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
	};
};
class QS_RD_client_dialog_menu_face {
	idd = 25000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuFace');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuFace');";
	class controls {
		class QS_RD_client_dialog_menu_face_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_face_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_face_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_101";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.139 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_face_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "$STR_QS_Dialogs_066";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.815 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Select',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuFace');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_face_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1811;
			text = "$STR_QS_Dialogs_032";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Back',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuFace');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1804;
			x = 0.38 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.22 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
	};
};
/*/ 
The below dialog contains EULA License-relevant code, please be aware prior to editing. 
Essentially, dont tamper with lines related to developer patreon link (idc = 1811)
The license stipulates this dialog and link to developer patreon must be accessible to players ingame as normal (as it is in official build).
/*/

class QS_RD_client_dialog_menu_hub {
	idd = 11000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuHub');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuHub');";
	class controls {
		class QS_RD_client_dialog_menu_hub_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_hub_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_hub_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_069";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.0955624 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_hub_picture_1: QS_RD_dialog_RscPictureKeepAspect {
			moving = 1;
			idc = 1803;
			text = "media\images\insignia\comm_patch.paa";
			x = 0.479294 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.030 * safezoneW;
			h = 0.050 * safezoneH;
			shadow = 0;
		};
		class QS_RD_client_dialog_menu_hub_text_2: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1804;
			text = "";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			size = 0.03;
			colorText[] = {1,1,1,1};
			class Attributes {
				font = "RobotoCondensed";
				align = "center";
				valign = "middle";
			};
		};
		class QS_RD_client_dialog_menu_hub_text_3: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1805;
			text = "";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.60125 * safezoneH + safezoneY; //y = 0.605 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			size = 0.03;
			colorText[] = {1,1,1,1};
			class Attributes {
				font = "RobotoCondensed";
				align = "center";
				valign = "middle";
			};
		};
		class QS_RD_client_dialog_menu_hub_button_3: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1806;
			text = "- - -";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.67 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B3',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuHub');";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_hub_button_4: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1807;
			text = "- - -";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.715 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B4',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuHub');";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_hub_button_5: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1808;
			text = "- - -";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B5',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuHub');";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_hub_button_6: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1809;
			text = "$STR_QS_Dialogs_070";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.6225 * safezoneH + safezoneY; //y = 0.63 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			size = 0.03;
			colorText[] = {1,1,1,1};
			class Attributes {
				font = "RobotoCondensed";
				align = "center";
				valign = "middle";
			};
		};
		class QS_RD_client_dialog_menu_hub_button_7: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "$STR_QS_Dialogs_032";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Back',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuHub');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_hub_button_8: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1811;
			text = "Donate to Quiksilver";
			tooltip = "Donate to the Apex Framework designer (Patreon)";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.82 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			size = 0.03;
			colorText[] = {1,1,1,1};
			class Attributes {
				font = "RobotoCondensed";
				align = "center";
				valign = "middle";
			};
		};
		class QS_RD_client_dialog_menu_hub_button_9: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1812;
			text = "$STR_QS_Dialogs_071";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.64375 * safezoneH + safezoneY; //y = 0.63 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			size = 0.03;
			colorText[] = {1,1,1,1};
			class Attributes {
				font = "RobotoCondensed";
				align = "center";
				valign = "middle";
			};
		};
	};
};

/*/ The above dialog contains EULA License-relevant code, please be aware prior to editing. Essentially, dont tamper with lines (or visibility/interaction ingame) related to developer donation link (idc = 1811)/*/

class QS_RD_client_dialog_menu_context {
	idd = 12000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuContext');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuContext');";
	class controls {
		class QS_RD_client_dialog_menu_context_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_context_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_context_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_072";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.0955624 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_context_picture_1: QS_RD_dialog_RscPictureKeepAspect {
			moving = 1;
			idc = 1803;
			text = "media\images\insignia\comm_patch.paa";
			x = 0.479294 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.030 * safezoneW;
			h = 0.050 * safezoneH;
			shadow = 0;
		};
		
		class QS_RD_client_dialog_menu_context_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1804;
			text = "---";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B1',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuContext');";
		};
		class QS_RD_client_dialog_menu_context_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1805;
			text = "---";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.625 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B2',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuContext');";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_context_button_3: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1806;
			text = "---";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.67 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B3',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuContext');";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_context_button_4: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1807;
			text = "---";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.715 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B4',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuContext');";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_context_button_5: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1808;
			text = "---";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.76 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B5',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuContext');";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_context_button_6: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1809;
			text = "---";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.805 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B6',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuContext');";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_context_button_7: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "$STR_QS_Dialogs_073";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Close',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuContext');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
	};
};
class QS_RD_client_dialog_menu_entry {
	idd = 13000;
	movingEnabled = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuEntry');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuEntry');";
	class controls {
		class QS_RD_client_dialog_menu_entry_frame_1: QS_RD_dialog_RscFrame {
			idc = 1800;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.5 * safezoneW;
			h = 0.70 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.9};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_entry_box_1: QS_RD_dialog_Box {
			idc = 1801;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.5 * safezoneW;
			h = 0.70 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_entry_text_1: QS_RD_dialog_RscText {
			idc = 1802;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.16 * safezoneH + safezoneY;
			w = 0.43 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_entry_picture_1: QS_RD_dialog_RscPictureKeepAspect {
			idc = 1803;
			text = "a3\UI_F_Jets\Data\CfgUnitInsignia\jets_patch_01.paa";
			x = 0.6875 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.06 * safezoneW;
			h = 0.115 * safezoneH;
			shadow = 0;
		};
		class QS_RD_client_dialog_menu_entry_button_1: QS_RD_dialog_RscButton {
			idc = 1804;
			text = "$STR_QS_Dialogs_074";
			x = 0.65 * safezoneW + safezoneX;
			y = 0.855 * safezoneH + safezoneY;
			w = 0.10 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B1',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuEntry');";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_hub_text_2: QS_RD_RscStructuredText {
			idc = 1806;
			text = "";
			x = 0.26 * safezoneW + safezoneX;
			y = 0.23 * safezoneH + safezoneY;
			w = 0.425 * safezoneW;
			h = 0.60 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			size = 0.03;
			colorText[] = {1,1,1,1};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
	};
};
class QS_RD_client_dialog_menu_leaderboard {
	idd = 14000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuLeaderboard');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuLeaderboard');";
	class controls {
		class QS_RD_client_dialog_menu_leaderboard_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.20 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.7 * safezoneW;
			h = 0.70 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.9};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_leaderboard_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.20 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.7 * safezoneW;
			h = 0.70 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_leaderboard_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "";
			x = 0.202 * safezoneW + safezoneX;
			y = 0.155 * safezoneH + safezoneY;
			w = 0.63 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_entry_picture_1: QS_RD_dialog_RscPictureKeepAspect {
			moving = 1;
			idc = 1803;
			text = "media\images\insignia\comm_patch.paa";
			x = 0.8275 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.075 * safezoneW;
			h = 0.15 * safezoneH;
			shadow = 0;
		};
		class QS_RD_client_dialog_menu_leaderboard_text_2: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1804;
			text = "";
			x = 0.205 * safezoneW + safezoneX;
			y = 0.21 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.035;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
		};
		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1805;
			x = 0.205 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.525 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
		class QS_RD_client_dialog_menu_leaderboard_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1806;
			text = "";
			x = 0.205 * safezoneW + safezoneX;
			y = 0.79 * safezoneH + safezoneY;
			w = 0.10 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B1',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuLeaderboard');";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_leaderboard_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1807;
			text = "";
			x = 0.7985 * safezoneW + safezoneX;
			y = 0.855 * safezoneH + safezoneY;
			w = 0.10 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['B2',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuLeaderboard');";
			tooltip = "";
		};
		class listNboxA : QS_RD_dialog_RscListNBox {
			moving = 1;
			idc = 1808;
			x = 0.31 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.55 * safezoneW;
			h = 0.525 * safezoneH;
			sizeEx = 0.03;
			rowHeight = 1.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			colorBackground[] = {0,0,0,0.5};
		};
		class QS_RD_client_dialog_menu_leaderboard_text_3: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1809;
			text = "";
			x = 0.315 * safezoneW + safezoneX;
			y = 0.21 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.035;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_leaderboard_text_4: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1810;
			text = "";
			x = 0.43 * safezoneW + safezoneX;
			y = 0.21 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.035;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_leaderboard_text_5: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1811;
			text = "";
			x = 0.595 * safezoneW + safezoneX;
			y = 0.21 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.035;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_leaderboard_text_6: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1812;
			text = "";
			x = 0.725 * safezoneW + safezoneX;
			y = 0.21 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.035;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
		};
		class QS_RD_client_dialog_menu_leaderboard_text_7: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1813;
			text = "";
			x = 0.815 * safezoneW + safezoneX;
			y = 0.81 * safezoneH + safezoneY;
			w = 0.07 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.025;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
		};
	};
};
class QS_RD_client_dialog_menu_console {
	idd = 15000;
	movingEnabled = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuConsole');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuConsole');";
	class controls {
		class QS_RD_client_dialog_menu_console_text_1: QS_RD_dialog_RscText {
			idc = 1001;
			text = "";
			moving = 1;
			x = 0 * 			(			((safezoneW / safezoneH) min 1.2) / 40);
			y = 0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			w = 22 * 			(			((safezoneW / safezoneH) min 1.2) / 40);
			h = 1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			sizeEx = (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 0;
			linespacing = 1;
			deletable = 0;
			fade = 0;
			fixedWidth = 0;
			colorText[] = {0.95,0.95,0.95,1};
			colorShadow[] = {0,0,0,0.5};
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
			align = "left";
		};
		class QS_RD_client_dialog_menu_console_text_2: QS_RD_dialog_RscText {
			idc = 1002;
			text = "";
			moving = 1;
			x = 0 * 			(			((safezoneW / safezoneH) min 1.2) / 40);
			y = 1.1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			w = 22 * 			(			((safezoneW / safezoneH) min 1.2) / 40);
			h = 12 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25);			
			sizeEx = (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 1;
			linespacing = 1;
			deletable = 0;
			fade = 0;
			fixedWidth = 0;
			colorText[] = {1,1,1,1};
			colorShadow[] = {0,0,0,0.5};
			colorBackground[] = {0,0,0,0.7};
		};
		class QS_RD_client_dialog_menu_console_text_3: QS_RD_dialog_RscText {
			idc = 1003;
			text = "";
			moving = 1;
			x = 0.2 * 			(			((safezoneW / safezoneH) min 1.2) / 40);
			y = 1.1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			w = 22 * 			(			((safezoneW / safezoneH) min 1.2) / 40);
			h = 0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25);			
			sizeEx = 0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			shadow = 1;
			linespacing = 1;
			deletable = 0;
			fade = 0;
			fixedWidth = 0;
			colorText[] = {1,1,1,1};
			colorShadow[] = {0,0,0,0.5};
			colorBackground[] = {0,0,0,0};
			align = "left";
		};
		class QS_RD_client_dialog_menu_console_edit_1: QS_RD_dialog_RscEdit {
			idc = 1004;
			moving = 1;
			//access = 0;
			autocomplete = "scripting";
			text = "";
			canModify = 1;
			colorBackground[] = {0,0,0,0};
			colorDisabled[] = {1,1,1,0.25};
			colorSelection[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
			colorText[] = {0.95,0.95,0.95,1};
			deletable = 0;
			fade = 0;
			size = 0.3;
			sizeEx = "0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			style = 16;
			h = "11 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "21 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			x = "0.5 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "1.7 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class QS_RD_client_dialog_menu_console_button_1: QS_RD_dialog_RscButton {
			idc = 1005;
			moving = 1;
			text = "";
			x = "1.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "13.2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "6.9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			sizeExSecondary = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_console_button_2: QS_RD_dialog_RscButton {
			idc = 1006;
			moving = 1;
			text = "";
			x = "8.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "13.2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "6.9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			sizeExSecondary = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_console_button_3: QS_RD_dialog_RscButton {
			idc = 1007;
			moving = 1;
			text = "";
			x = "15.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "13.2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "6.9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			sizeExSecondary = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			shadow = 0;
			style = "0x02 + 0xC0";
			colorText[] = {1,1,1,1};
			onButtonClick = "";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_console_button_4: QS_RD_dialog_RscButton {
			idc = 1008;
			moving = 1;
			text = "";
			x = "1.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "14.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "6.9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			sizeExSecondary = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_console_button_5: QS_RD_dialog_RscButton {
			idc = 1009;
			moving = 1;
			text = "";
			x = "8.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "14.4 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "6.9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			sizeEx = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			sizeExSecondary = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "";
			tooltip = "";
		};
		class QS_RD_client_dialog_menu_console_text_4: QS_RD_dialog_RscText {
			idc = 1010;
			text = "";
			moving = 1;
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "13.2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";	
			sizeEx = (			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			shadow = 1;
			linespacing = 1;
			deletable = 0;
			fade = 0;
			fixedWidth = 0;
			colorText[] = {1,1,1,1};
			colorShadow[] = {0,0,0,0.5};
			colorBackground[] = {0,0,0,0.7};
		};
		class QS_RD_client_dialog_menu_console_checkbox_1 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1011;
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "13.2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			tooltip = "";
			onCheckedChanged = "['RxCheckbox',_this # 0,_this # 1] call (missionNamespace getVariable 'QS_fnc_clientMenuConsole');";
		};
	};
};
class QS_RD_client_dialog_menu_radio {
	idd = 17000;
	movingEnabled = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
	class controls {
		class QS_RD_client_dialog_menu_radio_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.5 * safezoneW;
			h = 0.70 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.9};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_radio_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.15 * safezoneH + safezoneY;
			w = 0.5 * safezoneW;
			h = 0.70 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_radio_text_1: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1802;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.16 * safezoneH + safezoneY;
			w = 0.43 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = 0.05;
			size = 0.04;
			shadow = 0;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			colorText[] = {1,1,1,1};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_picture_1: QS_RD_dialog_RscPictureKeepAspect {
			moving = 1;
			idc = 1803;
			text = "\A3\Weapons_F\Data\UI\gear_item_radio_ca.paa";
			x = 0.68 * safezoneW + safezoneX;
			y = 0.1475 * safezoneH + safezoneY;
			w = 0.075 * safezoneW;
			h = 0.15 * safezoneH;
			shadow = 0;
		};
		class QS_RD_client_dialog_menu_radio_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1804;
			text = "";
			x = 0.65 * safezoneW + safezoneX;
			y = 0.855 * safezoneH + safezoneY;
			w = 0.10 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			onButtonClick = "['Close',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
			tooltip = "";
		};

		
		
		/*/ CHANNELS HEADER ------------------------------------------------------------------------------ /*/
		class QS_RD_client_dialog_menu_radio_text_2: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1805;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = 0.035;
			size = 0.035;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		
		
		/*/ STATUS HEADER ------------------------------------------------------------------------------ /*/
		class QS_RD_client_dialog_menu_radio_text_3: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1806;
			text = "";
			x = 0.405 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = 0.035;
			size = 0.035;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		
		
		/*/ SUBSCRIBE HEADER ------------------------------------------------------------------------------ /*/
		class QS_RD_client_dialog_menu_radio_text_4: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1807;
			text = "";
			x = 0.555 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.05 * safezoneH;
			sizeEx = 0.035;
			size = 0.035;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		
		
		/*/ CHANNELS ------------------------------------------------------------------------------ /*/
		/*/ GENERAL /*/
		class QS_RD_client_dialog_menu_radio_text_5: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1808;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.275 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_text_13: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1816;
			text = "";
			x = 0.405 * safezoneW + safezoneX;
			y = 0.275 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_checkbox_1 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1827;
			x = 0.555 * safezoneW + safezoneX;
			y = 0.275 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "";
			onCheckedChanged = "['Check_1',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
		};
		/*/ AIRCRAFT /*/
		class QS_RD_client_dialog_menu_radio_text_6: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1809;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.325 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_text_14: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1817;
			text = "";
			x = 0.405 * safezoneW + safezoneX;
			y = 0.325 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_checkbox_2 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1828;
			x = 0.555 * safezoneW + safezoneX;
			y = 0.325 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "";
			onCheckedChanged = "['Check_2',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
		};
		/*/AO/*/
		class QS_RD_client_dialog_menu_radio_text_7: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1810;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.375 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_text_15: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1818;
			text = "";
			x = 0.405 * safezoneW + safezoneX;
			y = 0.375 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_checkbox_3 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1829;
			x = 0.555 * safezoneW + safezoneX;
			y = 0.375 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "";
			onCheckedChanged = "['Check_3',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
		};
		class QS_RD_client_dialog_menu_radio_checkbox_11 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1837;
			x = 0.605 * safezoneW + safezoneX;
			y = 0.375 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";
			onCheckedChanged = "['Check_11',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
		};
		/*/Side/*/
		class QS_RD_client_dialog_menu_radio_text_8: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1811;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.425 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_text_16: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1819;
			text = "";
			x = 0.405 * safezoneW + safezoneX;
			y = 0.425 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_checkbox_4 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1830;
			x = 0.555 * safezoneW + safezoneX;
			y = 0.425 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "";
			onCheckedChanged = "['Check_4',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
		};
		class QS_RD_client_dialog_menu_radio_checkbox_12 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1838;
			x = 0.605 * safezoneW + safezoneX;
			y = 0.425 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			text = "";
			onCheckedChanged = "['Check_12',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
		};
		/*/Platoon A/*/
		class QS_RD_client_dialog_menu_radio_text_9: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1812;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.475 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_text_17: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1820;
			text = "";
			x = 0.405 * safezoneW + safezoneX;
			y = 0.475 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_checkbox_5 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1831;
			x = 0.555 * safezoneW + safezoneX;
			y = 0.475 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "";
			onCheckedChanged = "['Check_5',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
		};
		/*/Platoon B/*/
		class QS_RD_client_dialog_menu_radio_text_10: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1813;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_text_18: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1821;
			text = "";
			x = 0.405 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_checkbox_6 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1832;
			x = 0.555 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "";
			onCheckedChanged = "['Check_6',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
		};
		/*/Platoon C/*/
		class QS_RD_client_dialog_menu_radio_text_11: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1814;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.575 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_text_19: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1841;
			text = "";
			x = 0.405 * safezoneW + safezoneX;
			y = 0.575 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_checkbox_7 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1833;
			x = 0.555 * safezoneW + safezoneX;
			y = 0.575 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "";
			onCheckedChanged = "['Check_7',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
		};
		/*/Off-Duty/*/
		class QS_RD_client_dialog_menu_radio_text_12: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1815;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.625 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_text_20: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1822;
			text = "";
			x = 0.405 * safezoneW + safezoneX;
			y = 0.625 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_checkbox_8 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1834;
			x = 0.555 * safezoneW + safezoneX;
			y = 0.625 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "";
			onCheckedChanged = "['Check_8',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
		};
		/*/--- 1 ---/*/
		class QS_RD_client_dialog_menu_radio_text_21: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1823;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.675 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_text_22: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1824;
			text = "";
			x = 0.405 * safezoneW + safezoneX;
			y = 0.675 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_checkbox_9 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1835;
			x = 0.555 * safezoneW + safezoneX;
			y = 0.675 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "";
			onCheckedChanged = "['Check_9',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
		};
		/*/--- 2 ---/*/
		class QS_RD_client_dialog_menu_radio_text_23: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1825;
			text = "";
			x = 0.255 * safezoneW + safezoneX;
			y = 0.725 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_text_24: QS_RD_RscStructuredText {
			moving = 1;
			idc = 1826;
			text = "";
			x = 0.405 * safezoneW + safezoneX;
			y = 0.725 * safezoneH + safezoneY;
			w = 0.15 * safezoneW;
			h = 0.04 * safezoneH;
			sizeEx = 0.03;
			size = 0.03;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
			class Attributes {
				font = "RobotoCondensed";
				align = "left";
			};
		};
		class QS_RD_client_dialog_menu_radio_checkbox_10 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1836;
			x = 0.555 * safezoneW + safezoneX;
			y = 0.725 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "";
			onCheckedChanged = "['Check_10',(_this # 0),(_this # 1)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuRadio');";
		};
	};
};

class QS_RD_client_dialog_menu_inventory1 {
	idd = 19000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuLoadout');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuLoadout');";
	class controls {
		class QS_RD_client_dialog_menu_inventory1_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			//x = 0.372583 * safezoneW + safezoneX;
			x = 0.672583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.47 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_inventory1_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			//x = 0.372583 * safezoneW + safezoneX;
			x = 0.672583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.47 * safezoneH;
		};
		class QS_RD_client_dialog_menu_inventory1_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_076";
			//x = 0.374500 * safezoneW + safezoneX;
			x = 0.674500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.139 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_inventory1_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1812;
			text = "Save";
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.78 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Save',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuLoadout');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_inventory1_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "$STR_QS_Dialogs_066";
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.825 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Load',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuLoadout');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_inventory1_button_3: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1811;
			text = "$STR_QS_Dialogs_032";
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Delete',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuLoadout');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_inventory1_button_4: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1815;
			text = "Edit";
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.915 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Edit',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuLoadout');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};

		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1804;
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.14 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
		class QS_RD_client_dialog_menu_inventory1_box_2: QS_RD_dialog_Box {
			moving = 1;
			idc = 1814;
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.735 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
		class QS_RD_client_dialog_menu_inventory1_edit_1: QS_RD_dialog_RscEdit {
			idc = 1813;
			moving = 1;
			//access = 0;
			autocomplete = "";
			text = "";
			canModify = 1;
			colorBackground[] = {0,0,0,0};
			colorDisabled[] = {1,1,1,0.25};
			colorSelection[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
			colorText[] = {0.95,0.95,0.95,1};
			deletable = 0;
			fade = 0;
			size = 0.3;
			sizeEx = "0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			style = 16;
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.735 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
		};

		class QS_RD_client_dialog_menu_inventory1_frame_2: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1817;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.965 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.015 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_inventory1_progress_1: RscProgress {
			moving = 1;
			idc = 1816;
			text = "My ammobox (800/1000)";
			x = 0.68 * safezoneW + safezoneX;
			y = 0.965 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.015 * safezoneH;
			sizeEx = 0.03;
			shadow = 2;
			texture = "#(argb,8,8,3)color(1,1,1,0.5)";
			colorText[] = {1,1,1,1};
			colorFrame[] = {0,0,0,0};
			//colorBar[] = {1,1,1,0.5};
		};
		class QS_RD_client_dialog_menu_inventory1_text_2: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1818;
			text = "";
			x = 0.68 * safezoneW + safezoneX;
			y = 0.967 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.011 * safezoneH;
			sizeEx = 0.025;
			size = 0.025;
			shadow = 0;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
		};
	};
};
class QS_RD_client_dialog_menu_hangar {
	idd = 20000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuHangar');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuHangar');";
	class controls {
		class QS_RD_client_dialog_menu_hangar_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			//x = 0.372583 * safezoneW + safezoneX;
			x = 0.672583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.47 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_hangar_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			//x = 0.372583 * safezoneW + safezoneX;
			x = 0.672583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.47 * safezoneH;
		};
		class QS_RD_client_dialog_menu_hangar_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_083";
			//x = 0.374500 * safezoneW + safezoneX;
			x = 0.674500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.139 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1812;
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.78 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.16 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
		class QS_RD_client_dialog_menu_hangar_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1815;
			text = "$STR_QS_Menu_032";
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.945 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Select',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuHangar');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxB : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1804;
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.14 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
		class QS_RD_client_dialog_menu_hangar_box_2: QS_RD_dialog_Box {
			moving = 1;
			idc = 1814;
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.735 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
		class QS_RD_client_dialog_menu_hangar_text_3: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1813;
			text = "$STR_QS_Dialogs_076";
			x = 0.68 * safezoneW + safezoneX;
			y = 0.735 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
	};
};
class QS_RD_client_dialog_menu_unloadCargo {
	idd = 21000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuUnloadCargo');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuUnloadCargo');";
	class objects {
		class objectmodel
		{
			idc = 100;
			type = CT_OBJECT_CONTAINER;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.16 * safezoneH + safezoneY;
			w = 0.5 * safezoneW;
			h = 0.68 * safezoneH;
			z = 0.2;
			xBack = 0.5;
			yBack = 0.5;
			zBack = 1.2;
			inBack = 9;
			scale = 2;
			direction[] = {0, -0.35, -0.65};
			up[] = {0, 0.65, -0.35};
			enableZoom = 1;
			zoomDuration = 0.001;
			model = "\A3\Weapons_F\empty.p3d";
		};
	};
	class controls {
		class QS_RD_client_dialog_menu_unloadCargo_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_unloadCargo_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_unloadCargo_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_084";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.139 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_unloadCargo_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "$STR_QS_Interact_002";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.815 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Unload_1',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuUnloadCargo');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_unloadCargo_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1811;
			text = "$STR_QS_Interact_005";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Unload_2',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuUnloadCargo');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1804;
			x = 0.38 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.22 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
	};
};
class QS_RD_client_dialog_menu_playerBuild {
	idd = 22000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuPlayerBuild');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuPlayerBuild');";
	class objects {
		class objectmodel
		{
			idc = 100;
			type = CT_OBJECT_CONTAINER;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.16 * safezoneH + safezoneY;
			w = 0.5 * safezoneW;
			h = 0.68 * safezoneH;
			z = 0.2;
			xBack = 0.5;
			yBack = 0.5;
			zBack = 1.2;
			inBack = 9;
			scale = 2;
			direction[] = {0, -0.35, -0.65};
			up[] = {0, 0.65, -0.35};
			enableZoom = 1;
			zoomDuration = 0.001;
			model = "\A3\Weapons_F\empty.p3d";
		};
	};
	class controls {
		class QS_RD_client_dialog_menu_playerBuild_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_playerBuild_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_playerBuild_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "Build";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.139 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_playerBuild_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "Build";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.815 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Button_1',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuPlayerBuild');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_playerBuild_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1811;
			text = "Exit";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Button_2',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuPlayerBuild');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1804;
			x = 0.38 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.22 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
		class Objects {
			class Model_Visual {
				idc = 1820;
				onLoad = "";
				type = 81;
				model = "";
				scale = "(1 * 0.675 * (SafeZoneW Min SafeZoneH))";
				direction[] = {0,-1,0};
				up[] = {0,0,-1}; 
				inBack = 1;
				x = 0.677 * safezoneW + safezoneX;
				y = 0.78 * safezoneH + safezoneY;
				z = 0.35;
				xBack = 0.677 * safezoneW + safezoneX;
				yBack = 0.78 * safezoneH + safezoneY;
				zBack = 0.35;
				enableZoom = 0;
				zoomDuration = 0.001;
			};
		};
	};
};
class QS_RD_client_dialog_menu_deployment {
	idd = 23000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuDeployment');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuDeployment');";
	class controls {
		class QS_RD_client_dialog_menu_deployment_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.455 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_deployment_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.455 * safezoneH;
		};
		class QS_RD_client_dialog_menu_deployment_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Menu_198";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.139 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_deployment_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "$STR_QS_Menu_199";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.815 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Button_1',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuDeployment');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_deployment_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1811;
			text = "Exit";
			x = 0.38 * safezoneW + safezoneX;
			//y = 0.87 * safezoneH + safezoneY;
			y = 0.925 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Button_2',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuDeployment');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1804;
			x = 0.38 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.165 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
		class QS_RD_client_dialog_menu_deployment_checkbox_1 : QS_RD_RscCheckbox {
			moving = 1;
			idc = 1805;
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.02 * safezoneW;
			h = 0.04 * safezoneH;
			tooltip = "$STR_QS_Menu_201";
			onCheckedChanged = "['HomeCheckbox',_this # 0,_this # 1] spawn (missionNamespace getVariable 'QS_fnc_clientMenuDeployment');";
		};
	};
};
class QS_RD_client_dialog_menu_fireSupport {
	idd = 26000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuFireSupport');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuFireSupport');";
	class controls {
		class QS_RD_client_dialog_menu_fireSupport_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			//x = 0.372583 * safezoneW + safezoneX;
			x = 0.672583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.47 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_fireSupport_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			//x = 0.372583 * safezoneW + safezoneX;
			x = 0.672583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.47 * safezoneH;
		};
		class QS_RD_client_dialog_menu_fireSupport_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "Fire Support";
			//x = 0.374500 * safezoneW + safezoneX;
			x = 0.674500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.139 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1812;
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.78 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.16 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
		class QS_RD_client_dialog_menu_fireSupport_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1815;
			text = "$STR_QS_Menu_032";
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.945 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Select',(_this # 0)] call (missionNamespace getVariable 'QS_fnc_clientMenuFireSupport');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxB : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1804;
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.14 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
		class QS_RD_client_dialog_menu_fireSupport_box_2: QS_RD_dialog_Box {
			moving = 1;
			idc = 1814;
			//x = 0.38 * safezoneW + safezoneX;
			x = 0.68 * safezoneW + safezoneX;
			y = 0.735 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
		class QS_RD_client_dialog_menu_fireSupport_text_3: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1813;
			text = "$STR_QS_Dialogs_076";
			x = 0.68 * safezoneW + safezoneX;
			y = 0.735 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
	};
};
class RscTitles {
	class QS_RD_dialog_crewIndicator {
		idd = 6000;
		duration = 9999999999;
		fadeIn = 0.2;
		fadeOut = 0.2;
		name = "QS_RD_client_dialog_crewIndicator";
		onLoad = "uiNamespace setVariable ['QS_RD_client_dialog_crewIndicator',_this # 0]";
		onUnload = "uiNamespace setVariable ['QS_RD_client_dialog_crewIndicator',nil]";
		class controlsBackground {
			class QS_RD_client_dialog_crewIndicator_1: QS_RD_RscStructuredText {		
				idc = 1001;
				size = 0.040;
				x = 0.005 * safezoneW + safezoneX;
				y = 0.25 * safezoneH + safezoneY;
				w = 0.3 * safezoneW;
				h = 0.75 * safezoneH;
				colorText[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R',0.3843])","(profileNamespace getVariable ['GUI_BCG_RGB_G',0.7019])","(profileNamespace getVariable ['GUI_BCG_RGB_B',0.8862])","(profileNamespace getVariable ['GUI_BCG_RGB_A',0.7])"};
				lineSpacing = 2;
				colorBackground[] = {0,0,0,0};
				text = "";
				font = "RobotoCondensed";
				shadow = 1;
				class Attributes {
					align = "left";
				};
			};

		};
	};
	class QS_RD_dialog_hud {
		idd = 16000;
		duration = 9999999999;
		fadeIn = 0.2;
		fadeOut = 0.2;
		name = "QS_RD_client_dialog_hud";
		onLoad = "uiNamespace setVariable ['QS_RD_client_dialog_hud',_this # 0]";
		onUnload = "uiNamespace setVariable ['QS_RD_client_dialog_hud',nil]";
		class controlsBackground {
			class QS_RD_client_dialog_hud_1: QS_RD_dialog_RscMapControl {
				idc = 1001;
				size = 0.040;
				x = 0.677 * safezoneW + safezoneX;
				y = 0.83 * safezoneH + safezoneY; //y = 0.78 * safezoneH + safezoneY;
				w = 0.09 * safezoneW;	//w = 0.12 * safezoneW;
				h = 0.165 * safezoneH;	//h = 0.22 * safezoneH;
				colorText[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R',0.3843])","(profileNamespace getVariable ['GUI_BCG_RGB_G',0.7019])","(profileNamespace getVariable ['GUI_BCG_RGB_B',0.8862])","(profileNamespace getVariable ['GUI_BCG_RGB_A',0.7])"};
				lineSpacing = 2;
				colorBackground[] = {0,0,0,0};
				text = "";
				font = "RobotoCondensed";
				shadow = 1;
				colorSea[] = {0,0,0,0};
				colorLevels[] = {0,0,0,0};
				colorGrid[] = {0,0,0,0};
				colorGridMap[] = {0,0,0,0};
				colorCountlines[] = {0,0,0,0};
				colorCountlinesWater[] = {0,0,0,0};
				colorMainCountlinesWater[] = {0,0,0,0};
				class Attributes {
					align = "left";
				};
			};
			class QS_RD_client_dialog_hud_2: QS_RD_dialog_RscPictureKeepAspect {
				idc = 1002;
				size = 0.040;
				x = 0.68 * safezoneW + safezoneX;
				y = 0.83 * safezoneH + safezoneY; //y = 0.78 * safezoneH + safezoneY;
				w = 0.09 * safezoneW;	//w = 0.12 * safezoneW;
				h = 0.165 * safezoneH;	//h = 0.22 * safezoneH;
				colorText[] = {0.5,0.5,0.5,1};
				colorBackground[] = {0,0,0,0};
				text = "media\images\icons\SquadBack.paa";
				font = "RobotoCondensed";
				shadow = 0;
				class Attributes {
					align = "left";
				};
			};			
			class QS_RD_client_dialog_hud_3: QS_RD_dialog_RscPictureKeepAspect {
				idc = 1003;
				size = 0.040;
				x = 0.68 * safezoneW + safezoneX;
				y = 0.83 * safezoneH + safezoneY; //y = 0.78 * safezoneH + safezoneY;
				w = 0.09 * safezoneW;	//w = 0.12 * safezoneW;
				h = 0.165 * safezoneH;	//h = 0.22 * safezoneH;
				colorText[] = {"(profileNamespace getVariable ['GUI_BCG_RGB_R',0.3843])","(profileNamespace getVariable ['GUI_BCG_RGB_G',0.7019])","(profileNamespace getVariable ['GUI_BCG_RGB_B',0.8862])","(profileNamespace getVariable ['GUI_BCG_RGB_A',0.7])"};
				colorBackground[] = {0,0,0,0};
				text = "media\images\icons\SquadRadarBackgroundTexture_ca.paa";
				font = "RobotoCondensed";
				shadow = 0;
				class Attributes {
					align = "left";
				};
			};
		};
	};
	class QS_radio {
		idd = 29000;
		onLoad = "uiNamespace setVariable ['QS_UI_radio_display',_this];";
		onUnload = "uiNamespace setVariable ['QS_UI_radio_display',nil];";
		duration = 9999999999;
		fadeIn = 0.01;
		fadeOut = 0.01;
		class Objects {
			class Radio {
				idc = 101;
				onLoad = "(_this # 0) ctrlSetModelScale 1.5; (_this # 0) ctrlSetPosition [0.25 * safezoneW + safezoneX,0.35,2 * safezoneH + safezoneY]; (_this # 0) ctrlSetModelDirAndUp [[0,-1,0],[0,0,-1]];(_this # 0) ctrlSetModelScale (1 * 0.675 * (SafeZoneW Min SafeZoneH)); (_this # 0) ctrlCommit 0; (_this # 0) ctrlSetPosition [0.25 * safezoneW + safezoneX,0.35,0.75 * safezoneH + safezoneY]; (_this # 0) ctrlCommit 1;";				
				type = 81;
				model = "\a3\Weapons_F\Ammo\mag_radio.p3d";
				scale = "(1 * 0.675 * (SafeZoneW Min SafeZoneH))";
				direction[] = {0,-1,0};
				up[] = {0,0,-1}; 
				inBack = 1;
				x = 0.677 * safezoneW + safezoneX;
				y = 0.78 * safezoneH + safezoneY;
				z = 0.35;
				xBack = 0.677 * safezoneW + safezoneX;
				yBack = 0.78 * safezoneH + safezoneY;
				zBack = 0.35;
				enableZoom = 0;
				zoomDuration = 0.001;
			};
		};
	};
	class QS_HComm_LiveFeed {
		idd = 30000;
		onLoad = "[_this,1] call (missionNamespace getVariable ['QS_fnc_HCommLFSetPosition',{}]);";
		onUnload = "[_this,0] call (missionNamespace getVariable ['QS_fnc_HCommLFSetPosition',{}]);";
		duration = 9999999999;
		fadeIn = 0.2;
		fadeOut = 0.2;
		name = "QS_HComm_LiveFeed";
		movingEnable = 1;
		class controls {
			class CameraPictureSingleView: QS_RD_dialog_RscPicture {
				idc = 102;
				moving = 1;
				h = "(profilenamespace getvariable [""IGUI_GRID_CUSTOMINFORIGHT_H"",		(10 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))]) - 1.25 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				w = "(profilenamespace getvariable [""IGUI_GRID_CUSTOMINFORIGHT_W"",		(10 * 			(			((safezoneW / safezoneH) min 1.2) / 40))]) - 0.25 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";			
				x = "0.125 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
				y = "1.125 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				text = "#(argb,512,512,1)r2t(QS_HComm_LiveFeed_r2t,1.25)";
				colorBackground[] = {0,0,0,0};
				colorText[] = {1,1,1,1};
				font = "RobotoCondensed";
			};
			class Title: QS_RD_dialog_RscText {
				idc = 103;
				moving = 1;
				h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				w = "(profilenamespace getvariable [""IGUI_GRID_CUSTOMINFORIGHT_W"",		(10 * 			(			((safezoneW / safezoneH) min 1.2) / 40))])";
				x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
				y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				sizeEx = "0.8 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				text = "";
				colorBackground[] = {0,0,0,0};
				colorText[] = {1,1,1,1};
				font = "RobotoCondensed";
				class Attributes {
					align = "left";
				};
			};
		};
	};
	class Default {
		idd = -1;
		fadein = 0;
		fadeout = 0;
		duration = 0;
	};
	class QS_hud_hint {
		idd = 33000;
		onLoad = "uiNamespace setVariable ['QS_hint_display_1',(_this # 0)];";
		onUnload = "";
		deletable = 0;
		fade = 0;
		fadein = 0.1;
		fadeout = 0.1;
		duration = 30;
		h = "5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		shadow = 0;
		style = 16;
		type = 15;
		w = "(12 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
		x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(profilenamespace getvariable [""IGUI_GRID_HINT_X"",		((safezoneX + safezoneW) - 		(12 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40))])";
		y = "0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(profilenamespace getvariable [""IGUI_GRID_HINT_Y"",		(safezoneY + 6 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])";
		class controls {
			class QS_hint_1: QS_RD_RscStructuredText {
				idc = 101;
				onLoad = "uiNamespace setVariable ['QS_hint_display_2',(_this # 0)];";
				onUnload = "";
				colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",0.7};
				colorText[] = {1,1,1,1};
				deletable = 0;
				linespacing = 1;
				fixedWidth = 0;
				fade = 0;
				h = "5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";//h = "4 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				shadow = 1;
				size = "(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
				style = 0;
				text = "";
				type = 13;
				w = "(12 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";//w = "(12 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
				x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(profilenamespace getvariable [""IGUI_GRID_HINT_X"",		((safezoneX + safezoneW) - 		(12 * 			(			((safezoneW / safezoneH) min 1.2) / 40)) - 1 * 			(			((safezoneW / safezoneH) min 1.2) / 40))])";//x = "0 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
				y = "0 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(profilenamespace getvariable [""IGUI_GRID_HINT_Y"",		(safezoneY + 6 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25))])";//y = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				class Attributes {
					align = "center";
					color = "#ffffff";
					colorLink = "#D09B43";
					font = "RobotoCondensed";
					shadow = 1;
				};
			};
		};
	};
};
class QS_RD_client_dialog_menu_assetSpawner {
	idd = 27000;
	movingEnable = 1;
	enableSimulation = 1;
	onLoad = "['onLoad',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuSpawnAsset');";
	onUnload = "['onUnload',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuSpawnAsset');";
	class objects {
		class objectmodel
		{
			idc = 100;
			type = CT_OBJECT_CONTAINER;
			x = 0.25 * safezoneW + safezoneX;
			y = 0.16 * safezoneH + safezoneY;
			w = 0.5 * safezoneW;
			h = 0.68 * safezoneH;
			z = 0.2;
			xBack = 0.5;
			yBack = 0.5;
			zBack = 1.2;
			inBack = 9;
			scale = 2;
			direction[] = {0, -0.35, -0.65};
			up[] = {0, 0.65, -0.35};
			enableZoom = 1;
			zoomDuration = 0.001;
			model = "\A3\Weapons_F\empty.p3d";
		};
	};
	class controls {
		class QS_RD_client_dialog_menu_assetSpawner_frame_1: QS_RD_dialog_RscFrame {
			moving = 1;
			idc = 1800;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
			shadow = 0;
			colorBackground[] = {0,0,0,0.7};
			colorDisabled[] = {1,1,1,0.25};
		};
		class QS_RD_client_dialog_menu_assetSpawner_box_1: QS_RD_dialog_Box {
			moving = 1;
			idc = 1801;
			x = 0.372583 * safezoneW + safezoneX;
			y = 0.52 * safezoneH + safezoneY;
			w = 0.145 * safezoneW;
			h = 0.40 * safezoneH;
		};
		class QS_RD_client_dialog_menu_assetSpawner_text_1: QS_RD_dialog_RscText {
			moving = 1;
			idc = 1802;
			text = "$STR_QS_Dialogs_112";
			x = 0.374500 * safezoneW + safezoneX;
			y = 0.525 * safezoneH + safezoneY;
			w = 0.139 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = 0.04;
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_assetSpawner_button_1: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1810;
			text = "- - -";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.815 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Button_1',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuSpawnAsset');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class QS_RD_client_dialog_menu_assetSpawner_button_2: QS_RD_dialog_RscButton {
			moving = 1;
			idc = 1811;
			text = "$STR_QS_Dialogs_113";
			x = 0.38 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.0340016 * safezoneH;
			sizeEx = 0.03;
			onButtonClick = "['Button_2',(_this # 0)] spawn (missionNamespace getVariable 'QS_fnc_clientMenuSpawnAsset');";
			shadow = 0;
			colorText[] = {1,1,1,1};
		};
		class listboxA : QS_RD_dialog_RscListBox {
			moving = 1;
			idc = 1804;
			x = 0.38 * safezoneW + safezoneX;
			y = 0.58 * safezoneH + safezoneY;
			w = 0.13 * safezoneW;
			h = 0.22 * safezoneH;
			sizeEx = 0.03;
			colorBackground[] = {0,0,0,0.5};
		};
	};
};