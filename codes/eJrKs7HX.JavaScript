//===============================
//LudoAltEnable.js
//===============================


/*:
 * @plugindesc Lets you change the base color of text, and the manipulate the color and transparancy of not enabled options.
 * @author Alessio De Santis
 *
 * @help Change the plugin parameters to the desired values, colors go from 0 - 23.
 * 
 * @param Default Color
 * @desc Default Text Color option
 * 
 * Default : 0
 * @default 0
 * 
 * @param Disabled Color
 * @desc Disabled option Color
 * Default : 0
 * @default 0
 * 
 * @param Disabled Text Transparent
 * @desc Boolean Value, true to have disabled text be transparent, false otherwise.
 * Default : true
 * @default true
 */


$normalColor = Number(PluginManager.parameters("LudoAltEnable")["Default Color"]) || 0;
$greyedColor = Number(PluginManager.parameters("LudoAltEnable")["Disabled Color"]) || 0;;
$greyedTransparency = PluginManager.parameters("LudoAltEnable")["Disabled Text Transparent"] || "true";

Window_Base.prototype.normalColor = function() {
    return this.textColor($normalColor);
};

Window_Base.prototype.translucentOpacity = function() {
    this.changeTextColor(this.textColor($greyedColor));
    var transparency = ($greyedTransparency == "true")?  160 : 255;
    return transparency;
};

Window_Base.prototype.resetFontSettings = function() {
    this.contents.fontFace = this.standardFontFace();
    this.contents.fontSize = this.standardFontSize();
    this.resetTextColor();
};

Window_Command.prototype.drawItem = function(index) {
    var rect = this.itemRectForText(index);
    var align = this.itemTextAlign();
    if(this.isCommandEnabled(index)) {this.resetTextColor();}
    this.changePaintOpacity(this.isCommandEnabled(index));
    this.drawText(this.commandName(index), rect.x, rect.y, rect.width, align);
    console.log(this.contents.textColor);
};