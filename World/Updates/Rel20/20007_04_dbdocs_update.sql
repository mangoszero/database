-- Adding subtables
delete from `dbdocssubtables` where `subtableId`= 31 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (31,0,'ChatType','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>ChatType</b></th>
<th><b>Value</b></th>
<th align=\'left\'><b>Meaning</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>CHAT_TYPE_SAY</td><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Say in a limited radius</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>CHAT_TYPE_YELL</td><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Yell in a limited radius</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>CHAT_TYPE_TEXT_EMOTE</td><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>TextEmote, prepended by the creature name</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>CHAT_TYPE_BOSS_EMOTE</td><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Like previous, but zone-wide</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>CHAT_TYPE_WHISPER</td><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Whisper, requires a target to be defined</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>CHAT_TYPE_BOSS_WHISPER</td><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Like previous</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>CHAT_TYPE_ZONE_YELL</td><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>Yell to the zone</td></tr>
</table>
','<ChatType|Value|<Meaning
CHAT_TYPE_SAY|0|Say in a limited radius
CHAT_TYPE_YELL|1|Yell in a limited radius
CHAT_TYPE_TEXT_EMOTE|2|TextEmote, prepended by the creature name
CHAT_TYPE_BOSS_EMOTE|3|Like previous, but zone-wide
CHAT_TYPE_WHISPER|4|Whisper, requires a target to be defined
CHAT_TYPE_BOSS_WHISPER|5|Like previous
CHAT_TYPE_ZONE_YELL|6|Yell to the zone');
delete from `dbdocssubtables` where `subtableId`= 32 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (32,0,'Language','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Language</b></th>
<th><b>Value</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>LANG_UNIVERSAL</td><td align=\'center\' valign=\'middle\'>0</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>LANG_ORCISH</td><td align=\'center\' valign=\'middle\'>1</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>LANG_DARNASSIAN</td><td align=\'center\' valign=\'middle\'>2</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>LANG_TAURAHE</td><td align=\'center\' valign=\'middle\'>3</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>LANG_DWARVISH</td><td align=\'center\' valign=\'middle\'>6</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>LANG_COMMON</td><td align=\'center\' valign=\'middle\'>7</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>LANG_DEMONIC</td><td align=\'center\' valign=\'middle\'>8</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>LANG_TITAN</td><td align=\'center\' valign=\'middle\'>9</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>LANG_THALASSIAN</td><td align=\'center\' valign=\'middle\'>10</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>LANG_DRACONIC</td><td align=\'center\' valign=\'middle\'>11</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>LANG_KALIMAG</td><td align=\'center\' valign=\'middle\'>12</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>LANG_GNOMISH</td><td align=\'center\' valign=\'middle\'>13</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>LANG_TROLL</td><td align=\'center\' valign=\'middle\'>14</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>LANG_GUTTERSPEAK</td><td align=\'center\' valign=\'middle\'>33</td></tr>
</table>
','<Language|Value
LANG_UNIVERSAL|0
LANG_ORCISH|1
LANG_DARNASSIAN|2
LANG_TAURAHE|3
LANG_DWARVISH|6
LANG_COMMON|7
LANG_DEMONIC|8
LANG_TITAN|9
LANG_THALASSIAN|10
LANG_DRACONIC|11
LANG_KALIMAG|12
LANG_GNOMISH|13
LANG_TROLL|14
LANG_GUTTERSPEAK|33
');
delete from `dbdocssubtables` where `subtableId`= 33 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (33,0,'Gossip Option Icon','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Icon type</b></th>
<th><b>Value</b></th>
<th align=\'left\'><b>Outlook</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_ICON_CHAT</td><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>white chat bubble</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_ICON_VENDOR</td><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>brown bag</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_ICON_TAXI</td><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>flight</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_ICON_TRAINER</td><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>book</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_ICON_INTERACT_1</td><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>interaction wheel</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_ICON_INTERACT_2</td><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>interaction wheel</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_ICON_MONEY_BAG</td><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>brown bag with yellow dot</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_ICON_TALK</td><td align=\'center\' valign=\'middle\'>7</td><td align=\'left\' valign=\'middle\'>white chat bubble with black dots</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_ICON_TABARD</td><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>tabard</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_ICON_BATTLE</td><td align=\'center\' valign=\'middle\'>9</td><td align=\'left\' valign=\'middle\'>two crossed swords</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_ICON_DOT</td><td align=\'center\' valign=\'middle\'>10</td><td align=\'left\' valign=\'middle\'>yellow dot</td></tr>
</table>
','<Icon type|Value|<Outlook
GOSSIP_ICON_CHAT|0|white chat bubble
GOSSIP_ICON_VENDOR|1|brown bag

GOSSIP_ICON_TAXI|2| flight
GOSSIP_ICON_TRAINER|3|book
GOSSIP_ICON_INTERACT_1|4|interaction wheel

GOSSIP_ICON_INTERACT_2|5|interaction wheel
GOSSIP_ICON_MONEY_BAG|6|brown bag with yellow dot
GOSSIP_ICON_TALK|7|white chat bubble with black dots

GOSSIP_ICON_TABARD|8| tabard

GOSSIP_ICON_BATTLE|9| two crossed swords
GOSSIP_ICON_DOT|10|yellow dot');
delete from `dbdocssubtables` where `subtableId`= 34 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (34,0,'Gossip Option','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Gossip option</b></th>
<th><b>Value</b></th>
<th align=\'left\'><b>NPC flag required (value)</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_NONE</td><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_NONE (0)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_GOSSIP</td><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_GOSSIP (1)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_QUESTGIVER</td><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_QUESTGIVER (2)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_VENDOR</td><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_VENDOR (128)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_TAXIVENDOR</td><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_TAXIVENDOR (8192)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_TRAINER</td><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_TRAINER (16)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_SPIRITHEALER</td><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_SPIRITHEALER (16384)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_SPIRITGUIDE</td><td align=\'center\' valign=\'middle\'>7</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_SPIRITGUIDE  (32768)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_INNKEEPER</td><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_INNKEEPER (65536)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_BANKER</td><td align=\'center\' valign=\'middle\'>9</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_BANKER (131072)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_PETITIONER</td><td align=\'center\' valign=\'middle\'>10</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_PETITIONER (262144)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_TABARDDESIGNER</td><td align=\'center\' valign=\'middle\'>11</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_TABARDDESIGNER (524288)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_BATTLEFIELD</td><td align=\'center\' valign=\'middle\'>12</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_BATTLEFIELDPERSON (1048576)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_AUCTIONEER</td><td align=\'center\' valign=\'middle\'>13</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_AUCTIONEER (2097152)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_STABLEPET</td><td align=\'center\' valign=\'middle\'>14</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_STABLE (4194304)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_ARMORER</td><td align=\'center\' valign=\'middle\'>15</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_ARMORER (4096)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_UNLEARNTALENTS</td><td align=\'center\' valign=\'middle\'>16</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_TRAINER (16) (bonus option for GOSSIP_OPTION_TRAINER)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>GOSSIP_OPTION_UNLEARNPETSKILLS</td><td align=\'center\' valign=\'middle\'>17</td><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_TRAINER (16) (bonus option for GOSSIP_OPTION_TRAINER)</td></tr>
</table>
','<Gossip option|Value|<NPC flag required (value)
GOSSIP_OPTION_NONE|0|UNIT_NPC_FLAG_NONE (0)
GOSSIP_OPTION_GOSSIP|1|UNIT_NPC_FLAG_GOSSIP (1)
GOSSIP_OPTION_QUESTGIVER|2|UNIT_NPC_FLAG_QUESTGIVER (2)
GOSSIP_OPTION_VENDOR|3|UNIT_NPC_FLAG_VENDOR (128)
GOSSIP_OPTION_TAXIVENDOR|4|UNIT_NPC_FLAG_TAXIVENDOR (8192)
GOSSIP_OPTION_TRAINER|5|UNIT_NPC_FLAG_TRAINER (16)
GOSSIP_OPTION_SPIRITHEALER|6|UNIT_NPC_FLAG_SPIRITHEALER (16384)
GOSSIP_OPTION_SPIRITGUIDE|7|UNIT_NPC_FLAG_SPIRITGUIDE  (32768)
GOSSIP_OPTION_INNKEEPER|8|UNIT_NPC_FLAG_INNKEEPER (65536)
GOSSIP_OPTION_BANKER|9|UNIT_NPC_FLAG_BANKER (131072)
GOSSIP_OPTION_PETITIONER|10|UNIT_NPC_FLAG_PETITIONER (262144)
GOSSIP_OPTION_TABARDDESIGNER|11|UNIT_NPC_FLAG_TABARDDESIGNER (524288)
GOSSIP_OPTION_BATTLEFIELD|12|UNIT_NPC_FLAG_BATTLEFIELDPERSON (1048576)
GOSSIP_OPTION_AUCTIONEER|13|UNIT_NPC_FLAG_AUCTIONEER (2097152)
GOSSIP_OPTION_STABLEPET|14|UNIT_NPC_FLAG_STABLE (4194304)
GOSSIP_OPTION_ARMORER|15|UNIT_NPC_FLAG_ARMORER (4096)
GOSSIP_OPTION_UNLEARNTALENTS|16|UNIT_NPC_FLAG_TRAINER (16) (bonus option for GOSSIP_OPTION_TRAINER)
GOSSIP_OPTION_UNLEARNPETSKILLS|17|UNIT_NPC_FLAG_TRAINER (16) (bonus option for GOSSIP_OPTION_TRAINER)');
delete from `dbdocssubtables` where `subtableId`= 35 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (35,0,'NPCflags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>NPC flag</b></th>
<th><b>Value (hex)</b></th>
<th><b>Value (dec)</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_GOSSIP</td><td align=\'center\' valign=\'middle\'>0x00000001</td><td align=\'center\' valign=\'middle\'>1</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_QUESTGIVER</td><td align=\'center\' valign=\'middle\'>0x00000002</td><td align=\'center\' valign=\'middle\'>2</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_VENDOR</td><td align=\'center\' valign=\'middle\'>0x00000004</td><td align=\'center\' valign=\'middle\'>4</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_FLIGHTMASTER</td><td align=\'center\' valign=\'middle\'>0x00000008</td><td align=\'center\' valign=\'middle\'>8</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_TRAINER</td><td align=\'center\' valign=\'middle\'>0x00000010</td><td align=\'center\' valign=\'middle\'>16</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_SPIRITHEALER</td><td align=\'center\' valign=\'middle\'>0x00000020</td><td align=\'center\' valign=\'middle\'>32</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_SPIRITGUIDE</td><td align=\'center\' valign=\'middle\'>0x00000040</td><td align=\'center\' valign=\'middle\'>64</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_INNKEEPER</td><td align=\'center\' valign=\'middle\'>0x00000080</td><td align=\'center\' valign=\'middle\'>128</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_BANKER</td><td align=\'center\' valign=\'middle\'>0x00000100</td><td align=\'center\' valign=\'middle\'>256</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_PETITIONER</td><td align=\'center\' valign=\'middle\'>0x00000200</td><td align=\'center\' valign=\'middle\'>512</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_TABARDDESIGNER</td><td align=\'center\' valign=\'middle\'>0x00000400</td><td align=\'center\' valign=\'middle\'>1024</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_BATTLEMASTER</td><td align=\'center\' valign=\'middle\'>0x00000800</td><td align=\'center\' valign=\'middle\'>2048</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_AUCTIONEER</td><td align=\'center\' valign=\'middle\'>0x00001000</td><td align=\'center\' valign=\'middle\'>4096</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_STABLEMASTER</td><td align=\'center\' valign=\'middle\'>0x00002000</td><td align=\'center\' valign=\'middle\'>8192</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>UNIT_NPC_FLAG_REPAIR</td><td align=\'center\' valign=\'middle\'>0x00004000</td><td align=\'center\' valign=\'middle\'>16384</td></tr>
</table>
','<NPC flag|Value (hex)|Value (dec)
UNIT_NPC_FLAG_GOSSIP|0x00000001|1
UNIT_NPC_FLAG_QUESTGIVER|0x00000002|2
UNIT_NPC_FLAG_VENDOR|0x00000004|4
UNIT_NPC_FLAG_FLIGHTMASTER|0x00000008|8
UNIT_NPC_FLAG_TRAINER|0x00000010|16
UNIT_NPC_FLAG_SPIRITHEALER|0x00000020|32
UNIT_NPC_FLAG_SPIRITGUIDE|0x00000040|64
UNIT_NPC_FLAG_INNKEEPER|0x00000080|128
UNIT_NPC_FLAG_BANKER|0x00000100|256
UNIT_NPC_FLAG_PETITIONER|0x00000200|512
UNIT_NPC_FLAG_TABARDDESIGNER|0x00000400|1024
UNIT_NPC_FLAG_BATTLEMASTER|0x00000800|2048
UNIT_NPC_FLAG_AUCTIONEER|0x00001000|4096
UNIT_NPC_FLAG_STABLEMASTER|0x00002000|8192
UNIT_NPC_FLAG_REPAIR|0x00004000|16384');

-- Adding comments about fields
update `dbdocstable` set `languageId`=0, `tableName`='db_script_string', `tableNotes`='This table holds texts for the DB-based scripts.' where tableId=32;
update `dbdocsfields` set `FieldComment` = 'Text ID. See dataint parameter of the SCRIPT_COMMAND_TALK command.', `fieldNotes` = 'Text ID. The texts are numbered sequentially starting from 2000000000.<br />This ID is used in the SCRIPT_COMMAND_TALK command (see dataint field).' where `fieldId`= '322' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Sound ID. See SoundEntries.dbc.', `fieldNotes` = 'ID of the sound which will accompany the text appearance.<br />These IDs are tied to filenames in SoundEntries.dbc. The corresponding sound files are stored in the client MPQ archives.<br />Example: sound 8580 is tied to the file CThunDeathIsClose.wav, which is found under Sound\Creature\CThun section of an MPQ archive, this time it is patch.MPQ.' where `fieldId`= '324' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Sound and speech type.', `fieldNotes` = 'Chat type, affects chat radius and text colouring.<br /><br />¬subtable:31¬' where `fieldId`= '325' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'In-game language (See Languages.dbc).', `fieldNotes` = 'In-game language.<br />¬subtable:32¬' where `fieldId`= '323' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Emote ID that the creature should continually perform.', `fieldNotes` = 'Emote ID that the creature should continually perform.<br />
Note that for a given creature, some emotions may be not defined. It depends on corresponding animations accessibility.<br />
List of often used emote IDs and what they do ie. 65 Makes the creature look dead by lying on the ground.<br />
<br />¬subtable:22¬' where `fieldId`= '321' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, is not used by the core.<br />Usual form is like: CreatureName - Say1, CreatureName - YellAboutIntruders, so on.' where `fieldId`= '311' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Entry of the gameobject that starts the quest.', `fieldNotes` = 'Entry ID of the gameobject that starts the quest (See gameobject_template_entry).' where `fieldId`= '585' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Quest ID (See quest_template.entry).', `fieldNotes` = 'ID of the quest, see quest_template.entry.' where `fieldId`= '586' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='game_graveyard_zone', `tableNotes`='This table contains information about which zones are connected to the world’s graveyards.<br /><br />This table set if character die in zone ghost_zone and graveyard with id accept his team (HORDE or ALIANCE or both) and this is nearest graveyard then character’s ghost will be teleported to graveyard id.<br /><br />For a list of all existing graveyards and their respective IDs, check out WorldSafeLocs.dbc.' where tableId=56;
update `dbdocsfields` set `FieldComment` = 'Graveyard ID (See WorldSafeLocs.dbc).', `fieldNotes` = 'ID of the graveyard, see WorldSafeLocs.dbc. This DBC also defines coordinates where the ghost will pop up.' where `fieldId`= '538' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'AreaID of the zone the graveyard is tied to (See AreaTable.dbc).', `fieldNotes` = 'AreaID of the zone the graveyard is tied to, see AreaTable.dbc. The graveyard is considered to pop-up ghosts originated in this zone.' where `fieldId`= '537' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Player faction', `fieldNotes` = 'Faction: ALLIANCE = 469, HORDE = 67, both = 0.<br />Some graveyards accept ghosts of players only from one faction.' where `fieldId`= '536' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Gossip menu ID (See creature_template.GossipMenuId).', `fieldNotes` = 'Gossip menu ID (See creature_template.GossipMenuId). These values are predefined, but a lot of them is unknown.' where `fieldId`= '622' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Displayed text ID (See npc_text.ID).', `fieldNotes` = 'ID of the text (npc_text.ID), shown at the top of the gossip windows, above any variants of answer.' where `fieldId`= '624' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'DB script ID (See dbscritps_on_gossip.id).', `fieldNotes` = 'ID of the DB script (dbscripts_on_gossip.id), tied to the action of requesting the gossip request.' where `fieldId`= '623' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'DB script ID (See dbscritps_on_gossip.id).', `fieldNotes` = 'ID of the DB script (dbscripts_on_gossip.id), tied to the action of requesting the gossip.' where `fieldId`= '623' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Condition ID (See conditions.condition_entry).', `fieldNotes` = 'ID of the condition (conditions.condition_entry), allowing the gossip to appear. If the condition is not fulfilled by the player, he may not get the gossip.' where `fieldId`= '621' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Gossip menu ID (See gossip_menu.entry).', `fieldNotes` = 'ID of the gossip (gossip_menu.entry), to which this menu item is tied.' where `fieldId`= '633' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Menu item ID.', `fieldNotes` = 'ID of this menu item.<br />Some gossips may contain several variants of the player reply. The variants are numberred by this ID.<br />Menu items are numbered sequentially starting from 0.' where `fieldId`= '632' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Icon type for the menu item.', `fieldNotes` = 'Icon type displayed at the beginning of the menu optiion text.<br />' where `fieldId`= '635' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Icon type for the menu item.', `fieldNotes` = 'Icon type displayed at the beginning of the menu option text.See enum GossipOptionIcon in GossipDef.h.<br />¬subtable:33¬' where `fieldId`= '635' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Menu item text displayed.', `fieldNotes` = 'Text displayed for the menu item. Should be English only, find localizations in the locales_gossip_menu_option table.' where `fieldId`= '637' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Gossip option ID.', `fieldNotes` = 'ID of the option of the gossip menu item, see enum Gossip_Option in GossipDef.h.<br />¬subtable:34¬' where `fieldId`= '636' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'NPC flag required (see creature_template.NpcFlags).', `fieldNotes` = 'NPC flag (see creature_template.NpcFlags) which the NPC should have set to allow this menu item be displayed. The values are from enum NPCFlags in Unit.h.<br />¬subtable:35¬' where `fieldId`= '634' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Gossip ID for the action (see gossip_menu.entry).', `fieldNotes` = 'Gossip ID for the action (see gossip_menu.entry).<br />The scheme allows to create chains of gossips. Typical situation is a long story NPC tells to the player, requesting menu item as a confirmation after each brief part.' where `fieldId`= '625' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'POI ID (See points_of_interest.entry).', `fieldNotes` = 'ID of the POI (see points_of_interest.entry) which should be displayed as an action.' where `fieldId`= '626' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'DB script ID (See dbscripts_on_gossip.id).', `fieldNotes` = 'ID of DB script (see dbscripts_on_gossip.id) which should be executed as an action.' where `fieldId`= '627' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Sum of money requested by pop-up box.', `fieldNotes` = 'Money (in coppers) requested by pop-up box as an action.' where `fieldId`= '629' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Text for the pop-up box.', `fieldNotes` = 'The text names the pop-up box requesting a special input from player.' where `fieldId`= '630' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Flag for text entering into the pop-up box.', `fieldNotes` = 'Setting this flag (to 1) allows to player enter any text into the pop-up box.' where `fieldId`= '628' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Condition ID (See conditions.condition_entry).', `fieldNotes` = 'ID of the conditions (see conditions.condition_entry) which must be fulfilled by the player in order to get this  gossip menu option. If condition is not fulfilled, the option will be hidden (i.e. not present).' where `fieldId`= '631' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='gossip_texts', `tableNotes`='This table defines textes for gossip menu items, used by C++ native (SD2) scripts.' where tableId=67;
update `dbdocsfields` set `FieldComment` = 'Menu item ID text, referred by SD2 scripts.', `fieldNotes` = 'ID of the text of a menu item, generated by SD2 scripts.<br />Numbered starting from -3000000 in arithmetically decreasing order (i.e. to more negative values).' where `fieldId`= '648' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, ignored by the core. Usually should contain the named constant by which this text is referred within the C++ sources.' where `fieldId`= '638' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Map ID (See Map.dbc).', `fieldNotes` = 'ID of the instance map (see Map.dbc). This map should be instanceable.' where `fieldId`= '654' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Map ID of the parent instance See Map.dbc).', `fieldNotes` = 'Map ID (see Map.dbc) of the parent instance, from which player may enter to this one. Cases like Blackrock Depths/Molten Core.' where `fieldId`= '656' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Minimum allowed player level.', `fieldNotes` = 'Minimum allowed player level.' where `fieldId`= '653' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Maximum allowed player level.', `fieldNotes` = 'Maximum allowed player level.' where `fieldId`= '652' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Maximal number of players.', `fieldNotes` = 'Maximal number of players allowed into a single copy of the instance at once.' where `fieldId`= '655' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Instance reset delay (days).', `fieldNotes` = 'Instance reset delay in days. After time is up, instanced map is deleted and any state of the instance is reset.' where `fieldId`= '657' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Map ID (See Map.dbc) for ghost entrance.', `fieldNotes` = 'Map ID (See Map.dbc) for ghost entrance.' where `fieldId`= '649' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'X position of ghost entrance.', `fieldNotes` = 'X position of ghost entrance.' where `fieldId`= '650' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Y position of ghost entrance.', `fieldNotes` = 'Y position of ghost entrance.' where `fieldId`= '651' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Name of the script this instance uses.', `fieldNotes` = '"Instance script" is a native (SD2) script for the instance map. See Script::Name property. It is responsible, in particular, for instance states and their saving into DB.' where `fieldId`= '658' and `languageId`= 0;
