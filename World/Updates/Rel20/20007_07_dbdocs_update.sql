-- subtables added
delete from `dbdocssubtables` where `subtableId`= 38 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (38,0,'Item Quality','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th><b>ID</b></th>
<th align=\'left\'><b>Color</b></th>
<th align=\'left\'><b>Quality</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Grey</td><td align=\'left\' valign=\'middle\'>Poor</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>White</td><td align=\'left\' valign=\'middle\'>Common</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Green</td><td align=\'left\' valign=\'middle\'>Uncommon</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Blue</td><td align=\'left\' valign=\'middle\'>Rare</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Purple</td><td align=\'left\' valign=\'middle\'>Epic</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Orange</td><td align=\'left\' valign=\'middle\'>Legendary</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>Red</td><td align=\'left\' valign=\'middle\'>Artifact</td></tr>
</table>
','ID|<Color|<Quality
0|Grey|Poor
1|White|Common
2|Green|Uncommon
3|Blue|Rare
4|Purple|Epic
5|Orange|Legendary
6|Red|Artifact');
delete from `dbdocssubtables` where `subtableId`= 39 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (39,0,'Item Prototype Flags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Name</b></th>
<th><b>Value (hex)</b></th>
<th align=\'left\'><b>Meaning</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_RESERVED_0</td><td align=\'center\' valign=\'middle\'>0x00000001</td><td align=\'left\' valign=\'middle\'>Reserved for later usage</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_CONJURED</td><td align=\'center\' valign=\'middle\'>0x00000002</td><td align=\'left\' valign=\'middle\'>items created by spells with SPELL_EFFECT_CREATE_ITEM</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_LOOTABLE</td><td align=\'center\' valign=\'middle\'>0x00000004</td><td align=\'left\' valign=\'middle\'>affect only non container items that can be "open" for loot. It or lockid set enable for client show "Right click to open". See also ITEM_DYNFLAG_UNLOCKED</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_WRAPPED</td><td align=\'center\' valign=\'middle\'>0x00000008</td><td align=\'left\' valign=\'middle\'>not used in pre-3.x</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_DEPRECATED</td><td align=\'center\' valign=\'middle\'>0x00000010</td><td align=\'left\' valign=\'middle\'>items is deprecated and no longer equipable</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_INDESTRUCTIBLE</td><td align=\'center\' valign=\'middle\'>0x00000020</td><td align=\'left\' valign=\'middle\'>used for totem. Item can not be destroyed, except by using spell (item can be reagent for spell and then allowed)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_USABLE</td><td align=\'center\' valign=\'middle\'>0x00000040</td><td align=\'left\' valign=\'middle\'>items that can be used via right-click</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_NO_EQUIP_COOLDOWN</td><td align=\'center\' valign=\'middle\'>0x00000080</td><td align=\'left\' valign=\'middle\'>items without an equip cooldown (and usually a _USABLE flag)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_RESERVED_1</td><td align=\'center\' valign=\'middle\'>0x00000100</td><td align=\'left\' valign=\'middle\'>reserved for later usage</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_WRAPPER</td><td align=\'center\' valign=\'middle\'>0x00000200</td><td align=\'left\' valign=\'middle\'>used or not used wrapper</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_STACKABLE</td><td align=\'center\' valign=\'middle\'>0x00000400</td><td align=\'left\' valign=\'middle\'>items which can be stacked</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_PARTY_LOOT</td><td align=\'center\' valign=\'middle\'>0x00000800</td><td align=\'left\' valign=\'middle\'>items which can be looted by all party members</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_RESEVERD_2</td><td align=\'center\' valign=\'middle\'>0x00001000</td><td align=\'left\' valign=\'middle\'>reserved for later usage</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_CHARTER</td><td align=\'center\' valign=\'middle\'>0x00002000</td><td align=\'left\' valign=\'middle\'>guild charter</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_LETTER</td><td align=\'center\' valign=\'middle\'>0x00004000</td><td align=\'left\' valign=\'middle\'>readable letter items</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_PVP_REWARD</td><td align=\'center\' valign=\'middle\'>0x00008000</td><td align=\'left\' valign=\'middle\'>items rewarded for PvP ranks and/or honor standing</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_UNK16</td><td align=\'center\' valign=\'middle\'>0x00010000</td><td align=\'left\' valign=\'middle\'>a lot of items have this</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ITEM_FLAG_UNK17</td><td align=\'center\' valign=\'middle\'>0x00020000</td><td align=\'left\' valign=\'middle\'>last used flag in 1.12.1</td></tr>
</table>
','<Name|Value (hex)|<Meaning
ITEM_FLAG_RESERVED_0|0x00000001|Reserved for later usage
ITEM_FLAG_CONJURED|0x00000002|items created by spells with SPELL_EFFECT_CREATE_ITEM

ITEM_FLAG_LOOTABLE|0x00000004|affect only non container items that can be "open" for loot. It or lockid set enable for client show "Right click to open". See also ITEM_DYNFLAG_UNLOCKED
ITEM_FLAG_WRAPPED|0x00000008|not used in pre-3.x
ITEM_FLAG_DEPRECATED|0x00000010|items is deprecated and no longer equipable
ITEM_FLAG_INDESTRUCTIBLE|0x00000020|used for totem. Item can not be destroyed, except by using spell (item can be reagent for spell and then allowed)
ITEM_FLAG_USABLE|0x00000040|items that can be used via right-click
ITEM_FLAG_NO_EQUIP_COOLDOWN|0x00000080|items without an equip cooldown (and usually a _USABLE flag)
ITEM_FLAG_RESERVED_1|0x00000100|reserved for later usage
ITEM_FLAG_WRAPPER|0x00000200|used or not used wrapper
ITEM_FLAG_STACKABLE|0x00000400|items which can be stacked
ITEM_FLAG_PARTY_LOOT|0x00000800|items which can be looted by all party members
ITEM_FLAG_RESEVERD_2|0x00001000|reserved for later usage
ITEM_FLAG_CHARTER|0x00002000|guild charter
ITEM_FLAG_LETTER|0x00004000|readable letter items
ITEM_FLAG_PVP_REWARD|0x00008000|items rewarded for PvP ranks and/or honor standing
ITEM_FLAG_UNK16|0x00010000|a lot of items have this
ITEM_FLAG_UNK17|0x00020000|last used flag in 1.12.1');
delete from `dbdocssubtables` where `subtableId`= 40 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (40,0,'Character ClassMask','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Class</b></th>
<th><b>Value (hex)</b></th>
<th><b>Value (dec)</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>CLASS_WARRIOR</td><td align=\'center\' valign=\'middle\'>0x1</td><td align=\'center\' valign=\'middle\'>1</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>CLASS_PALADIN</td><td align=\'center\' valign=\'middle\'>0x2</td><td align=\'center\' valign=\'middle\'>2</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>CLASS_HUNTER</td><td align=\'center\' valign=\'middle\'>0x4</td><td align=\'center\' valign=\'middle\'>4</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>CLASS_ROGUE</td><td align=\'center\' valign=\'middle\'>0x8</td><td align=\'center\' valign=\'middle\'>8</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>CLASS_PRIEST</td><td align=\'center\' valign=\'middle\'>0x10</td><td align=\'center\' valign=\'middle\'>16</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>CLASS_SHAMAN</td><td align=\'center\' valign=\'middle\'>0x40</td><td align=\'center\' valign=\'middle\'>64</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>CLASS_MAGE</td><td align=\'center\' valign=\'middle\'>0x80</td><td align=\'center\' valign=\'middle\'>128</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>CLASS_WARLOCK</td><td align=\'center\' valign=\'middle\'>0x100</td><td align=\'center\' valign=\'middle\'>256</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>CLASS_DRUID</td><td align=\'center\' valign=\'middle\'>0x400</td><td align=\'center\' valign=\'middle\'>1024</td></tr>
</table>
','<Class|Value (hex)|Value (dec)
CLASS_WARRIOR|0x1|1
CLASS_PALADIN|0x2|2
CLASS_HUNTER|0x4|4
CLASS_ROGUE|0x8|8
CLASS_PRIEST|0x10|16

CLASS_SHAMAN|0x40|64
CLASS_MAGE|0x80|128
CLASS_WARLOCK|0x100|256
CLASS_DRUID|0x400|1024');
delete from `dbdocssubtables` where `subtableId`= 41 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (41,0,'Skill Type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Skill name</b></th>
<th><b>Value</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_FROST</td><td align=\'center\' valign=\'middle\'>6</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_FIRE</td><td align=\'center\' valign=\'middle\'>8</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_ARMS</td><td align=\'center\' valign=\'middle\'>26</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_COMBAT</td><td align=\'center\' valign=\'middle\'>38</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_SUBTLETY</td><td align=\'center\' valign=\'middle\'>39</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_POISONS</td><td align=\'center\' valign=\'middle\'>40</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_SWORDS</td><td align=\'center\' valign=\'middle\'>43</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_AXES</td><td align=\'center\' valign=\'middle\'>44</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_BOWS</td><td align=\'center\' valign=\'middle\'>45</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_GUNS</td><td align=\'center\' valign=\'middle\'>46</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_BEAST_MASTERY</td><td align=\'center\' valign=\'middle\'>50</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_SURVIVAL</td><td align=\'center\' valign=\'middle\'>51</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_MACES</td><td align=\'center\' valign=\'middle\'>54</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_2H_SWORDS</td><td align=\'center\' valign=\'middle\'>55</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_HOLY</td><td align=\'center\' valign=\'middle\'>56</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_SHADOW</td><td align=\'center\' valign=\'middle\'>78</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_DEFENSE</td><td align=\'center\' valign=\'middle\'>95</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_COMMON</td><td align=\'center\' valign=\'middle\'>98</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_RACIAL_DWARVEN</td><td align=\'center\' valign=\'middle\'>101</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_ORCISH</td><td align=\'center\' valign=\'middle\'>109</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_DWARVEN</td><td align=\'center\' valign=\'middle\'>111</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_DARNASSIAN</td><td align=\'center\' valign=\'middle\'>113</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_TAURAHE</td><td align=\'center\' valign=\'middle\'>115</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_DUAL_WIELD</td><td align=\'center\' valign=\'middle\'>118</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_RACIAL_TAUREN</td><td align=\'center\' valign=\'middle\'>124</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_ORC_RACIAL</td><td align=\'center\' valign=\'middle\'>125</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_RACIAL_NIGHT_ELF</td><td align=\'center\' valign=\'middle\'>126</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_FIRST_AID</td><td align=\'center\' valign=\'middle\'>129</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_FERAL_COMBAT</td><td align=\'center\' valign=\'middle\'>134</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_STAVES</td><td align=\'center\' valign=\'middle\'>136</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_THALASSIAN</td><td align=\'center\' valign=\'middle\'>137</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_DRACONIC</td><td align=\'center\' valign=\'middle\'>138</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_DEMON_TONGUE</td><td align=\'center\' valign=\'middle\'>139</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_TITAN</td><td align=\'center\' valign=\'middle\'>140</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_OLD_TONGUE</td><td align=\'center\' valign=\'middle\'>141</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_SURVIVAL2</td><td align=\'center\' valign=\'middle\'>142</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_RIDING_HORSE</td><td align=\'center\' valign=\'middle\'>148</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_RIDING_WOLF</td><td align=\'center\' valign=\'middle\'>149</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_RIDING_TIGER</td><td align=\'center\' valign=\'middle\'>150</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_RIDING_RAM</td><td align=\'center\' valign=\'middle\'>152</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_SWIMING</td><td align=\'center\' valign=\'middle\'>155</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_2H_MACES</td><td align=\'center\' valign=\'middle\'>160</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_UNARMED</td><td align=\'center\' valign=\'middle\'>162</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_MARKSMANSHIP</td><td align=\'center\' valign=\'middle\'>163</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_BLACKSMITHING</td><td align=\'center\' valign=\'middle\'>164</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_LEATHERWORKING</td><td align=\'center\' valign=\'middle\'>165</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_ALCHEMY</td><td align=\'center\' valign=\'middle\'>171</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_2H_AXES</td><td align=\'center\' valign=\'middle\'>172</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_DAGGERS</td><td align=\'center\' valign=\'middle\'>173</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_THROWN</td><td align=\'center\' valign=\'middle\'>176</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_HERBALISM</td><td align=\'center\' valign=\'middle\'>182</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_GENERIC_DND</td><td align=\'center\' valign=\'middle\'>183</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_RETRIBUTION</td><td align=\'center\' valign=\'middle\'>184</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_COOKING</td><td align=\'center\' valign=\'middle\'>185</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_MINING</td><td align=\'center\' valign=\'middle\'>186</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PET_IMP</td><td align=\'center\' valign=\'middle\'>188</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_FELHUNTER</td><td align=\'center\' valign=\'middle\'>189</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_TAILORING</td><td align=\'center\' valign=\'middle\'>197</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_ENGINEERING</td><td align=\'center\' valign=\'middle\'>202</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PET_SPIDER</td><td align=\'center\' valign=\'middle\'>203</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_VOIDWALKER</td><td align=\'center\' valign=\'middle\'>204</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PET_SUCCUBUS</td><td align=\'center\' valign=\'middle\'>205</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_INFERNAL</td><td align=\'center\' valign=\'middle\'>206</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PET_DOOMGUARD</td><td align=\'center\' valign=\'middle\'>207</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_WOLF</td><td align=\'center\' valign=\'middle\'>208</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PET_CAT</td><td align=\'center\' valign=\'middle\'>209</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_BEAR</td><td align=\'center\' valign=\'middle\'>210</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PET_BOAR</td><td align=\'center\' valign=\'middle\'>211</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_CROCILISK</td><td align=\'center\' valign=\'middle\'>212</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PET_CARRION_BIRD</td><td align=\'center\' valign=\'middle\'>213</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_CRAB</td><td align=\'center\' valign=\'middle\'>214</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PET_GORILLA</td><td align=\'center\' valign=\'middle\'>215</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_RAPTOR</td><td align=\'center\' valign=\'middle\'>217</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PET_TALLSTRIDER</td><td align=\'center\' valign=\'middle\'>218</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_RACIAL_UNDED</td><td align=\'center\' valign=\'middle\'>220</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_CROSSBOWS</td><td align=\'center\' valign=\'middle\'>226</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_WANDS</td><td align=\'center\' valign=\'middle\'>228</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_POLEARMS</td><td align=\'center\' valign=\'middle\'>229</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_SCORPID</td><td align=\'center\' valign=\'middle\'>236</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_ARCANE</td><td align=\'center\' valign=\'middle\'>237</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_TURTLE</td><td align=\'center\' valign=\'middle\'>251</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_ASSASSINATION</td><td align=\'center\' valign=\'middle\'>253</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_FURY</td><td align=\'center\' valign=\'middle\'>256</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PROTECTION</td><td align=\'center\' valign=\'middle\'>257</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_BEAST_TRAINING</td><td align=\'center\' valign=\'middle\'>261</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PROTECTION2</td><td align=\'center\' valign=\'middle\'>267</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_TALENTS</td><td align=\'center\' valign=\'middle\'>270</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PLATE_MAIL</td><td align=\'center\' valign=\'middle\'>293</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_GNOMISH</td><td align=\'center\' valign=\'middle\'>313</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_TROLL</td><td align=\'center\' valign=\'middle\'>315</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_ENCHANTING</td><td align=\'center\' valign=\'middle\'>333</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_DEMONOLOGY</td><td align=\'center\' valign=\'middle\'>354</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_AFFLICTION</td><td align=\'center\' valign=\'middle\'>355</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_FISHING</td><td align=\'center\' valign=\'middle\'>356</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_ENHANCEMENT</td><td align=\'center\' valign=\'middle\'>373</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_RESTORATION</td><td align=\'center\' valign=\'middle\'>374</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_ELEMENTAL_COMBAT</td><td align=\'center\' valign=\'middle\'>375</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_SKINNING</td><td align=\'center\' valign=\'middle\'>393</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_MAIL</td><td align=\'center\' valign=\'middle\'>413</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_LEATHER</td><td align=\'center\' valign=\'middle\'>414</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_CLOTH</td><td align=\'center\' valign=\'middle\'>415</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_SHIELD</td><td align=\'center\' valign=\'middle\'>433</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_FIST_WEAPONS</td><td align=\'center\' valign=\'middle\'>473</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_RIDING_RAPTOR</td><td align=\'center\' valign=\'middle\'>533</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_RIDING_MECHANOSTRIDER</td><td align=\'center\' valign=\'middle\'>553</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_RIDING_UNDEAD_HORSE</td><td align=\'center\' valign=\'middle\'>554</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_RESTORATION2</td><td align=\'center\' valign=\'middle\'>573</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_BALANCE</td><td align=\'center\' valign=\'middle\'>574</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_DESTRUCTION</td><td align=\'center\' valign=\'middle\'>593</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_HOLY2</td><td align=\'center\' valign=\'middle\'>594</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_DISCIPLINE</td><td align=\'center\' valign=\'middle\'>613</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_LOCKPICKING</td><td align=\'center\' valign=\'middle\'>633</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_BAT</td><td align=\'center\' valign=\'middle\'>653</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PET_HYENA</td><td align=\'center\' valign=\'middle\'>654</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_PET_OWL</td><td align=\'center\' valign=\'middle\'>655</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PET_WIND_SERPENT</td><td align=\'center\' valign=\'middle\'>656</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_LANG_GUTTERSPEAK</td><td align=\'center\' valign=\'middle\'>673</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_RIDING_KODO</td><td align=\'center\' valign=\'middle\'>713</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_RACIAL_TROLL</td><td align=\'center\' valign=\'middle\'>733</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_RACIAL_GNOME</td><td align=\'center\' valign=\'middle\'>753</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_RACIAL_HUMAN</td><td align=\'center\' valign=\'middle\'>754</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SKILL_PET_EVENT_RC</td><td align=\'center\' valign=\'middle\'>758</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SKILL_RIDING</td><td align=\'center\' valign=\'middle\'>762</td></tr>
</table>
','<Skill name|Value
SKILL_FROST|6
SKILL_FIRE|8
SKILL_ARMS|26
SKILL_COMBAT|38
SKILL_SUBTLETY|39
SKILL_POISONS|40
SKILL_SWORDS|43
SKILL_AXES|44
SKILL_BOWS|45
SKILL_GUNS|46
SKILL_BEAST_MASTERY|50
SKILL_SURVIVAL|51
SKILL_MACES|54
SKILL_2H_SWORDS|55
SKILL_HOLY|56
SKILL_SHADOW|78
SKILL_DEFENSE|95
SKILL_LANG_COMMON|98
SKILL_RACIAL_DWARVEN|101
SKILL_LANG_ORCISH|109
SKILL_LANG_DWARVEN|111
SKILL_LANG_DARNASSIAN|113
SKILL_LANG_TAURAHE|115
SKILL_DUAL_WIELD|118
SKILL_RACIAL_TAUREN|124
SKILL_ORC_RACIAL|125
SKILL_RACIAL_NIGHT_ELF|126
SKILL_FIRST_AID|129
SKILL_FERAL_COMBAT|134
SKILL_STAVES|136
SKILL_LANG_THALASSIAN|137
SKILL_LANG_DRACONIC|138
SKILL_LANG_DEMON_TONGUE|139
SKILL_LANG_TITAN|140
SKILL_LANG_OLD_TONGUE|141
SKILL_SURVIVAL2|142
SKILL_RIDING_HORSE|148
SKILL_RIDING_WOLF|149
SKILL_RIDING_TIGER|150
SKILL_RIDING_RAM|152
SKILL_SWIMING|155
SKILL_2H_MACES|160
SKILL_UNARMED|162
SKILL_MARKSMANSHIP|163
SKILL_BLACKSMITHING|164
SKILL_LEATHERWORKING|165
SKILL_ALCHEMY|171
SKILL_2H_AXES|172
SKILL_DAGGERS|173
SKILL_THROWN|176
SKILL_HERBALISM|182
SKILL_GENERIC_DND|183
SKILL_RETRIBUTION|184
SKILL_COOKING|185
SKILL_MINING|186
SKILL_PET_IMP|188
SKILL_PET_FELHUNTER|189
SKILL_TAILORING|197
SKILL_ENGINEERING|202
SKILL_PET_SPIDER|203
SKILL_PET_VOIDWALKER|204
SKILL_PET_SUCCUBUS|205
SKILL_PET_INFERNAL|206
SKILL_PET_DOOMGUARD|207
SKILL_PET_WOLF|208
SKILL_PET_CAT|209
SKILL_PET_BEAR|210
SKILL_PET_BOAR|211
SKILL_PET_CROCILISK|212
SKILL_PET_CARRION_BIRD|213
SKILL_PET_CRAB|214
SKILL_PET_GORILLA|215
SKILL_PET_RAPTOR|217
SKILL_PET_TALLSTRIDER|218
SKILL_RACIAL_UNDED|220
SKILL_CROSSBOWS|226
SKILL_WANDS|228
SKILL_POLEARMS|229
SKILL_PET_SCORPID|236
SKILL_ARCANE|237
SKILL_PET_TURTLE|251
SKILL_ASSASSINATION|253
SKILL_FURY|256
SKILL_PROTECTION|257
SKILL_BEAST_TRAINING|261
SKILL_PROTECTION2|267
SKILL_PET_TALENTS|270
SKILL_PLATE_MAIL|293
SKILL_LANG_GNOMISH|313
SKILL_LANG_TROLL|315
SKILL_ENCHANTING|333
SKILL_DEMONOLOGY|354
SKILL_AFFLICTION|355
SKILL_FISHING|356
SKILL_ENHANCEMENT|373
SKILL_RESTORATION|374
SKILL_ELEMENTAL_COMBAT|375
SKILL_SKINNING|393
SKILL_MAIL|413
SKILL_LEATHER|414
SKILL_CLOTH|415
SKILL_SHIELD|433
SKILL_FIST_WEAPONS|473
SKILL_RIDING_RAPTOR|533
SKILL_RIDING_MECHANOSTRIDER|553
SKILL_RIDING_UNDEAD_HORSE|554
SKILL_RESTORATION2|573
SKILL_BALANCE|574
SKILL_DESTRUCTION|593
SKILL_HOLY2|594
SKILL_DISCIPLINE|613
SKILL_LOCKPICKING|633
SKILL_PET_BAT|653
SKILL_PET_HYENA|654
SKILL_PET_OWL|655
SKILL_PET_WIND_SERPENT|656
SKILL_LANG_GUTTERSPEAK|673
SKILL_RIDING_KODO|713
SKILL_RACIAL_TROLL|733
SKILL_RACIAL_GNOME|753
SKILL_RACIAL_HUMAN|754
SKILL_PET_EVENT_RC|758
SKILL_RIDING|762');
delete from `dbdocssubtables` where `subtableId`= 42 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (42,0,'Reputation Rank','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Name</b></th>
<th><b>Value</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>REP_HATED</td><td align=\'center\' valign=\'middle\'>0</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>REP_HOSTILE</td><td align=\'center\' valign=\'middle\'>1</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>REP_UNFRIENDLY</td><td align=\'center\' valign=\'middle\'>2</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>REP_NEUTRAL</td><td align=\'center\' valign=\'middle\'>3</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>REP_FRIENDLY</td><td align=\'center\' valign=\'middle\'>4</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>REP_HONORED</td><td align=\'center\' valign=\'middle\'>5</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>REP_REVERED</td><td align=\'center\' valign=\'middle\'>6</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>REP_EXALTED</td><td align=\'center\' valign=\'middle\'>7</td></tr>
</table>
','<Name|Value
REP_HATED|0
REP_HOSTILE|1
REP_UNFRIENDLY|2
REP_NEUTRAL|3
REP_FRIENDLY|4
REP_HONORED|5
REP_REVERED|6
REP_EXALTED|7');

-- field description added
update `dbdocstable` set `languageId`=0, `tableName`='exploration_basexp', `tableNotes`='This table controls the XP gained by characters when they explore new zones.<br />Many areas have an "area level" defined in AreaTable.dbc. It is the suggested level of the character exploring the area. This table defines exploration XP reward and in conjunction with a core mechanic limits the reward for the characters of substantial different level. The basic formula for the XP reward is:<br />basexp[area_level] * Rate.XP.Explore<br />where the last parameter is defined in the config file. If the area level exceeds the player level by 5 or more, the formula turns into:<br />basexp[player_level+5] * Rate.XP.Explore' where tableId=48;
update `dbdocsfields` set `FieldComment` = 'Area level (See AreaTable.dbc).', `fieldNotes` = 'Area level (See ExplorationLevel in AreaTable.dbc).' where `fieldId`= '503' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Base XP reward.', `fieldNotes` = 'Base XP reward for exploring the area.' where `fieldId`= '502' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The unique identifier of the game object spawn.', `fieldNotes` = 'The global unique identifier (GUID, low 32-bit) of the GameObject spawn.' where `fieldId`= '560' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'GameObject ID (See gameobject_template.entry).', `fieldNotes` = 'This defines what GameObject will be spawned (see gameobject_template.entry).' where `fieldId`= '561' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'GameObject ID (See gameobject_template.entry).', `fieldNotes` = 'ID of the GameObject (See gameobject_template.entry) which starts the quest.' where `fieldId`= '576' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Quest ID (See quest_template.entry).', `fieldNotes` = 'Quest ID (See quest_template.entry).' where `fieldId`= '577' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'GameObject ID (See gameobject_template.entry).', `fieldNotes` = 'ID of the GameObject (See gameobject_template.entry) which takes the quest.' where `fieldId`= '576' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'GameObject ID (See gameobject_template.entry).', `fieldNotes` = 'ID of the GameObject (See gameobject_template_entry) that starts the quest.' where `fieldId`= '585' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Item ID.', `fieldNotes` = 'Item ID. Note: do not mix it with the item GUID, which numbers concrete item instances.' where `fieldId`= '705' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Item prototype ID.', `fieldNotes` = 'Item prototype ID. Note: do not mix it with the item GUID, which numbers concrete item instances.' where `fieldId`= '705' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Class of the item.', `fieldNotes` = 'Class of the item is it very general description.<br />¬subtable:16¬' where `fieldId`= '683' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Item name.', `fieldNotes` = 'Name of item displayed to the players. See locales_item table for localized versions of this.' where `fieldId`= '723' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Quality of item.', `fieldNotes` = 'The quality of the item.<br />¬subtable:38¬' where `fieldId`= '727' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Item prototype flags.', `fieldNotes` = 'Item prototype flags, see enum ItemPrototypeFlags in ItemPrototype.h.<br />¬subtable:39¬' where `fieldId`= '708' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Stack size by vendors.', `fieldNotes` = 'Stack size by vendors.' where `fieldId`= '681' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Item price (coppers).', `fieldNotes` = 'Price in coppers for players to sell the item.' where `fieldId`= '682' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Item buying price (coppers).', `fieldNotes` = 'Price in coppers for players to buy the item.' where `fieldId`= '682' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Item selling price (coppers).', `fieldNotes` = 'Price in coppers for players to sell the item.' where `fieldId`= '739' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Inventory type.', `fieldNotes` = 'Type of inventory defining the way of wearing the item.<br />¬subtable:18¬' where `fieldId`= '712' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Mask of allowed classes.', `fieldNotes` = 'Mask of the classes which may use the item. Numbers from the table may be added.<br />¬subtable:40¬' where `fieldId`= '672' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Mask of allowed races.', `fieldNotes` = 'Mask of races which may use the item. Values from the table may be added.<br />' where `fieldId`= '673' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Mask of allowed races.', `fieldNotes` = 'Mask of races which may use the item. Values from the table may be added.<br />¬subtable:30¬' where `fieldId`= '673' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Level of item.', `fieldNotes` = 'Level of item. Used by addons in calculating Gear Level.' where `fieldId`= '713' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required level.', `fieldNotes` = 'Minimum level required to use the item.' where `fieldId`= '732' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required skill type.', `fieldNotes` = 'Skill type required to use the item, see SpellLine.dbc and enum SkillType in SharedDefines.h.<br />¬subtable:41¬' where `fieldId`= '735' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required skill value.', `fieldNotes` = 'Value of the skill required to use the item.' where `fieldId`= '736' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required spell (See Spell.dbc).', `fieldNotes` = 'The spell ID the character is required to know before using the item.' where `fieldId`= '737' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required honor rank.', `fieldNotes` = 'Required honor rank.' where `fieldId`= '731' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required faction for reputation check (See Faction.dbc).', `fieldNotes` = 'The faction (see Faction,dbc), reputation to which will be checked before using the item.' where `fieldId`= '733' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required minimal reputation rank.', `fieldNotes` = 'The minimal reputation rank required to use the item.<br />¬subtable:42¬' where `fieldId`= '734' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Quest ID (See quest_template.entry).', `fieldNotes` = 'ID of the quest (see quest_template.entry) the item can start.' where `fieldId`= '778' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Lock ID (See Lock.dbc).', `fieldNotes` = 'ID of the lock (see Lock.dbc) for locked items.' where `fieldId`= '716' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Material type.', `fieldNotes` = 'Material type. Used for sound selection when moving item.<br />¬subtable:19¬' where `fieldId`= '718' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Disenchant template (See disenchant_loot_template.entry).', `fieldNotes` = 'Disenchant template (see disenchant_loot_template.entry) if any.' where `fieldId`= '687' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Maximum stack size.', `fieldNotes` = 'Maximum number of items in the single stack.' where `fieldId`= '777' and `languageId`= 0;
