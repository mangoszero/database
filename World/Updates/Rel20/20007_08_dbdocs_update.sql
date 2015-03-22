-- subtables
delete from `dbdocssubtables` where `subtableId`= 43 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (43,0,'POI icons','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Name</b></th>
<th><b>Value</b></th>
<th align=\'left\'><b>Meaning</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_GREY_AV_MINE</td><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Grey mine lorry</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_RED_AV_MINE</td><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Red mine lorry</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_BLUE_AV_MINE</td><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Blue mine lorry</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_BWTOMB</td><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Blue and White Tomb Stone</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_SMALL_HOUSE</td><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Small house</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_GREYTOWER</td><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Grey Tower</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_REDFLAG</td><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>Red Flag w/Yellow !</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_TOMBSTONE</td><td align=\'center\' valign=\'middle\'>7</td><td align=\'left\' valign=\'middle\'>Normal tomb stone (brown)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_BWTOWER</td><td align=\'center\' valign=\'middle\'>8</td><td align=\'left\' valign=\'middle\'>Blue and White Tower</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_REDTOWER</td><td align=\'center\' valign=\'middle\'>9</td><td align=\'left\' valign=\'middle\'>Red Tower</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_BLUETOWER</td><td align=\'center\' valign=\'middle\'>10</td><td align=\'left\' valign=\'middle\'>Blue Tower</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_RWTOWER</td><td align=\'center\' valign=\'middle\'>11</td><td align=\'left\' valign=\'middle\'>Red and White Tower</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_REDTOMB</td><td align=\'center\' valign=\'middle\'>12</td><td align=\'left\' valign=\'middle\'>Red Tomb Stone</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_RWTOMB</td><td align=\'center\' valign=\'middle\'>13</td><td align=\'left\' valign=\'middle\'>Red and White Tomb Stone</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_BLUETOMB</td><td align=\'center\' valign=\'middle\'>14</td><td align=\'left\' valign=\'middle\'>Blue Tomb Stone</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_BLANK</td><td align=\'center\' valign=\'middle\'>15</td><td align=\'left\' valign=\'middle\'>Blank (not visible)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_16</td><td align=\'center\' valign=\'middle\'>16</td><td align=\'left\' valign=\'middle\'>Grey ?</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_17</td><td align=\'center\' valign=\'middle\'>17</td><td align=\'left\' valign=\'middle\'>Blue/White ?</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_18</td><td align=\'center\' valign=\'middle\'>18</td><td align=\'left\' valign=\'middle\'>Blue ?</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_19</td><td align=\'center\' valign=\'middle\'>19</td><td align=\'left\' valign=\'middle\'>Red and White ?</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_20</td><td align=\'center\' valign=\'middle\'>20</td><td align=\'left\' valign=\'middle\'>Red ?</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_GREYLOGS</td><td align=\'center\' valign=\'middle\'>21</td><td align=\'left\' valign=\'middle\'>Grey Wood Logs</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_BWLOGS</td><td align=\'center\' valign=\'middle\'>22</td><td align=\'left\' valign=\'middle\'>Blue and White Wood Logs</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_BLUELOGS</td><td align=\'center\' valign=\'middle\'>23</td><td align=\'left\' valign=\'middle\'>Blue Wood Logs</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_RWLOGS</td><td align=\'center\' valign=\'middle\'>24</td><td align=\'left\' valign=\'middle\'>Red and White Wood Logs</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_REDLOGS</td><td align=\'center\' valign=\'middle\'>25</td><td align=\'left\' valign=\'middle\'>Red Wood Logs</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_26</td><td align=\'center\' valign=\'middle\'>26</td><td align=\'left\' valign=\'middle\'>Grey ?</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_27</td><td align=\'center\' valign=\'middle\'>27</td><td align=\'left\' valign=\'middle\'>Blue and White ?</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_28</td><td align=\'center\' valign=\'middle\'>28</td><td align=\'left\' valign=\'middle\'>Blue ?</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_29</td><td align=\'center\' valign=\'middle\'>29</td><td align=\'left\' valign=\'middle\'>Red and White ?</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_30</td><td align=\'center\' valign=\'middle\'>30</td><td align=\'left\' valign=\'middle\'>Red ?</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_GREYHOUSE</td><td align=\'center\' valign=\'middle\'>31</td><td align=\'left\' valign=\'middle\'>Grey House</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_BWHOUSE</td><td align=\'center\' valign=\'middle\'>32</td><td align=\'left\' valign=\'middle\'>Blue and White House</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_BLUEHOUSE</td><td align=\'center\' valign=\'middle\'>33</td><td align=\'left\' valign=\'middle\'>Blue House</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_RWHOUSE</td><td align=\'center\' valign=\'middle\'>34</td><td align=\'left\' valign=\'middle\'>Red and White House</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_REDHOUSE</td><td align=\'center\' valign=\'middle\'>35</td><td align=\'left\' valign=\'middle\'>Red House</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_GREYHORSE</td><td align=\'center\' valign=\'middle\'>36</td><td align=\'left\' valign=\'middle\'>Grey Horse</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_BWHORSE</td><td align=\'center\' valign=\'middle\'>37</td><td align=\'left\' valign=\'middle\'>Blue and White Horse</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_BLUEHORSE</td><td align=\'center\' valign=\'middle\'>38</td><td align=\'left\' valign=\'middle\'>Blue Horse</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>ICON_POI_RWHORSE</td><td align=\'center\' valign=\'middle\'>39</td><td align=\'left\' valign=\'middle\'>Red and White Horse</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>ICON_POI_REDHORSE</td><td align=\'center\' valign=\'middle\'>40</td><td align=\'left\' valign=\'middle\'>Red Horse</td></tr>
</table>
','<Name|Value|<Meaning
ICON_POI_GREY_AV_MINE|0|Grey mine lorry
ICON_POI_RED_AV_MINE|1|Red mine lorry
ICON_POI_BLUE_AV_MINE|2|Blue mine lorry
ICON_POI_BWTOMB|3|Blue and White Tomb Stone
ICON_POI_SMALL_HOUSE|4|Small house
ICON_POI_GREYTOWER|5|Grey Tower
ICON_POI_REDFLAG|6|Red Flag w/Yellow !
ICON_POI_TOMBSTONE|7|Normal tomb stone (brown)
ICON_POI_BWTOWER|8|Blue and White Tower
ICON_POI_REDTOWER|9|Red Tower
ICON_POI_BLUETOWER|10|Blue Tower
ICON_POI_RWTOWER|11|Red and White Tower
ICON_POI_REDTOMB|12|Red Tomb Stone
ICON_POI_RWTOMB|13|Red and White Tomb Stone
ICON_POI_BLUETOMB|14|Blue Tomb Stone
ICON_POI_BLANK|15|Blank (not visible)
ICON_POI_16|16|Grey ?
ICON_POI_17|17|Blue/White ?
ICON_POI_18|18|Blue ?
ICON_POI_19|19|Red and White ?
ICON_POI_20|20|Red ?
ICON_POI_GREYLOGS|21|Grey Wood Logs
ICON_POI_BWLOGS|22|Blue and White Wood Logs
ICON_POI_BLUELOGS|23|Blue Wood Logs
ICON_POI_RWLOGS|24|Red and White Wood Logs
ICON_POI_REDLOGS|25|Red Wood Logs
ICON_POI_26|26|Grey ?
ICON_POI_27|27|Blue and White ?
ICON_POI_28|28|Blue ?
ICON_POI_29|29|Red and White ?
ICON_POI_30|30|Red ?
ICON_POI_GREYHOUSE|31|Grey House
ICON_POI_BWHOUSE|32|Blue and White House
ICON_POI_BLUEHOUSE|33|Blue House
ICON_POI_RWHOUSE|34|Red and White House
ICON_POI_REDHOUSE|35|Red House
ICON_POI_GREYHORSE|36|Grey Horse
ICON_POI_BWHORSE|37|Blue and White Horse
ICON_POI_BLUEHORSE|38|Blue Horse
ICON_POI_RWHORSE|39|Red and White Horse
ICON_POI_REDHORSE|40|Red Horse');
delete from `dbdocssubtables` where `subtableId`= 44 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (44,0,'Quest Type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Type</b></th>
<th><b>Value</b></th>
<th align=\'left\'><b>Meaning</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>QUEST_TYPE_ELITE</td><td align=\'center\' valign=\'middle\'>1</td><td align=\'left\' valign=\'middle\'>Killing an elite mob.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>QUEST_TYPE_LIFE</td><td align=\'center\' valign=\'middle\'>21</td><td align=\'left\' valign=\'middle\'>Character should not die during the quest.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>QUEST_TYPE_PVP</td><td align=\'center\' valign=\'middle\'>41</td><td align=\'left\' valign=\'middle\'>Killing other characters or PvP flagged NPCs.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>QUEST_TYPE_RAID</td><td align=\'center\' valign=\'middle\'>62</td><td align=\'left\' valign=\'middle\'>Completable in raid only.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>QUEST_TYPE_DUNGEON</td><td align=\'center\' valign=\'middle\'>81</td><td align=\'left\' valign=\'middle\'>Dungeon-related.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>QUEST_TYPE_WORLD_EVENT</td><td align=\'center\' valign=\'middle\'>82</td><td align=\'left\' valign=\'middle\'>Calendar event related.</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>QUEST_TYPE_LEGENDARY</td><td align=\'center\' valign=\'middle\'>83</td><td align=\'left\' valign=\'middle\'>Unique and complex.</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>QUEST_TYPE_ESCORT</td><td align=\'center\' valign=\'middle\'>84</td><td align=\'left\' valign=\'middle\'>(Escort quest is not listed in QuestInfo.dbc.)</td></tr>
</table>
','<Type|Value|<Meaning
QUEST_TYPE_ELITE|1|Killing an elite mob.
QUEST_TYPE_LIFE|21|Character should not die during the quest.
QUEST_TYPE_PVP|41|Killing other characters or PvP flagged NPCs.
QUEST_TYPE_RAID|62|Completable in raid only.
QUEST_TYPE_DUNGEON|81|Dungeon-related.
QUEST_TYPE_WORLD_EVENT|82|Calendar event related.
QUEST_TYPE_LEGENDARY|83|Unique and complex.
QUEST_TYPE_ESCORT|84|(Escort quest is not listed in QuestInfo.dbc.)');
delete from `dbdocssubtables` where `subtableId`= 45 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (45,0,'Spell Linked Type','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Type name</b></th>
<th><b>Value</b></th>
<th align=\'left\'><b>Meaning</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_NONE</td><td align=\'center\' valign=\'middle\'>0</td><td align=\'left\' valign=\'middle\'>Ignored</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_BOOST</td><td align=\'center\' valign=\'middle\'>1</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_PRECAST</td><td align=\'center\' valign=\'middle\'>2</td><td align=\'left\' valign=\'middle\'>Triggered before spellcast</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_TRIGGERED</td><td align=\'center\' valign=\'middle\'>3</td><td align=\'left\' valign=\'middle\'>Cast on cast, i.e. triggering</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_PROC</td><td align=\'center\' valign=\'middle\'>4</td><td align=\'left\' valign=\'middle\'>Cast on aura proc</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_REMOVEONCAST</td><td align=\'center\' valign=\'middle\'>5</td><td align=\'left\' valign=\'middle\'>Remove aura on cast</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_REMOVEONREMOVE</td><td align=\'center\' valign=\'middle\'>6</td><td align=\'left\' valign=\'middle\'>Remove aura on remove another aura</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELL_LINKED_TYPE_CASTONREMOVE</td><td align=\'center\' valign=\'middle\'>7</td><td align=\'left\' valign=\'middle\'>Cast on remove another aura</td></tr>
</table>
','<Type name|Value|<Meaning
SPELL_LINKED_TYPE_NONE|0|Ignored
SPELL_LINKED_TYPE_BOOST|1|
SPELL_LINKED_TYPE_PRECAST|2|Triggered before spellcast
SPELL_LINKED_TYPE_TRIGGERED|3|Cast on cast, i.e. triggering
SPELL_LINKED_TYPE_PROC|4|Cast on aura proc
SPELL_LINKED_TYPE_REMOVEONCAST|5|Remove aura on cast
SPELL_LINKED_TYPE_REMOVEONREMOVE|6|Remove aura on remove another aura
SPELL_LINKED_TYPE_CASTONREMOVE|7|Cast on remove another aura');
delete from `dbdocssubtables` where `subtableId`= 46 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (46,0,'Spell School Mask','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Name</b></th>
<th><b>Value</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_SCHOOL_MASK_NORMAL</td><td align=\'center\' valign=\'middle\'>1</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELL_SCHOOL_MASK_HOLY</td><td align=\'center\' valign=\'middle\'>2</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_SCHOOL_MASK_FIRE</td><td align=\'center\' valign=\'middle\'>4</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELL_SCHOOL_MASK_NATURE</td><td align=\'center\' valign=\'middle\'>8</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_SCHOOL_MASK_FROST</td><td align=\'center\' valign=\'middle\'>16</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELL_SCHOOL_MASK_SHADOW</td><td align=\'center\' valign=\'middle\'>32</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_SCHOOL_MASK_ARCANE</td><td align=\'center\' valign=\'middle\'>64</td></tr>
</table>
','<Name|Value
SPELL_SCHOOL_MASK_NORMAL|1
SPELL_SCHOOL_MASK_HOLY|2
SPELL_SCHOOL_MASK_FIRE|4
SPELL_SCHOOL_MASK_NATURE|8
SPELL_SCHOOL_MASK_FROST|16
SPELL_SCHOOL_MASK_SHADOW|32
SPELL_SCHOOL_MASK_ARCANE|64');
delete from `dbdocssubtables` where `subtableId`= 47 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (47,0,'Spell Family Name','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Name</b></th>
<th><b>Value</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELLFAMILY_GENERIC</td><td align=\'center\' valign=\'middle\'>0</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELLFAMILY_ENVIRONMENT</td><td align=\'center\' valign=\'middle\'>1</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELLFAMILY_MAGE</td><td align=\'center\' valign=\'middle\'>3</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELLFAMILY_WARRIOR</td><td align=\'center\' valign=\'middle\'>4</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELLFAMILY_WARLOCK</td><td align=\'center\' valign=\'middle\'>5</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELLFAMILY_PRIEST</td><td align=\'center\' valign=\'middle\'>6</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELLFAMILY_DRUID</td><td align=\'center\' valign=\'middle\'>7</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELLFAMILY_ROGUE</td><td align=\'center\' valign=\'middle\'>8</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELLFAMILY_HUNTER</td><td align=\'center\' valign=\'middle\'>9</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELLFAMILY_PALADIN</td><td align=\'center\' valign=\'middle\'>10</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELLFAMILY_SHAMAN</td><td align=\'center\' valign=\'middle\'>11</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELLFAMILY_POTION</td><td align=\'center\' valign=\'middle\'>13</td></tr>
</table>
','<Name|Value
SPELLFAMILY_GENERIC|0
SPELLFAMILY_ENVIRONMENT|1
SPELLFAMILY_MAGE|3
SPELLFAMILY_WARRIOR|4
SPELLFAMILY_WARLOCK|5
SPELLFAMILY_PRIEST|6
SPELLFAMILY_DRUID|7
SPELLFAMILY_ROGUE|8
SPELLFAMILY_HUNTER|9
SPELLFAMILY_PALADIN|10
SPELLFAMILY_SHAMAN|11
SPELLFAMILY_POTION|13');
delete from `dbdocssubtables` where `subtableId`= 49 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (49,0,'ProcFlags extended','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Name</b></th>
<th><b>Value (hex)</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_EX_NONE</td><td align=\'center\' valign=\'middle\'>0x0000000</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_EX_NORMAL_HIT</td><td align=\'center\' valign=\'middle\'>0x0000001</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_EX_CRITICAL_HIT</td><td align=\'center\' valign=\'middle\'>0x0000002</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_EX_MISS</td><td align=\'center\' valign=\'middle\'>0x0000004</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_EX_RESIST</td><td align=\'center\' valign=\'middle\'>0x0000008</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_EX_DODGE</td><td align=\'center\' valign=\'middle\'>0x0000010</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_EX_PARRY</td><td align=\'center\' valign=\'middle\'>0x0000020</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_EX_BLOCK</td><td align=\'center\' valign=\'middle\'>0x0000040</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_EX_EVADE</td><td align=\'center\' valign=\'middle\'>0x0000080</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_EX_IMMUNE</td><td align=\'center\' valign=\'middle\'>0x0000100</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_EX_DEFLECT</td><td align=\'center\' valign=\'middle\'>0x0000200</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_EX_ABSORB</td><td align=\'center\' valign=\'middle\'>0x0000400</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_EX_REFLECT</td><td align=\'center\' valign=\'middle\'>0x0000800</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_EX_INTERRUPT</td><td align=\'center\' valign=\'middle\'>0x0001000</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_EX_EX_TRIGGER_ALWAYS</td><td align=\'center\' valign=\'middle\'>0x0010000</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_EX_EX_ONE_TIME_TRIGGER</td><td align=\'center\' valign=\'middle\'>0x0020000</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_EX_PERIODIC_POSITIVE</td><td align=\'center\' valign=\'middle\'>0x0040000</td></tr>
</table>
','<Name|Value (hex)
PROC_EX_NONE|0x0000000
PROC_EX_NORMAL_HIT|0x0000001
PROC_EX_CRITICAL_HIT|0x0000002
PROC_EX_MISS|0x0000004
PROC_EX_RESIST|0x0000008
PROC_EX_DODGE|0x0000010
PROC_EX_PARRY|0x0000020
PROC_EX_BLOCK|0x0000040
PROC_EX_EVADE|0x0000080
PROC_EX_IMMUNE|0x0000100
PROC_EX_DEFLECT|0x0000200
PROC_EX_ABSORB|0x0000400
PROC_EX_REFLECT|0x0000800
PROC_EX_INTERRUPT|0x0001000
PROC_EX_EX_TRIGGER_ALWAYS|0x0010000
PROC_EX_EX_ONE_TIME_TRIGGER|0x0020000
PROC_EX_PERIODIC_POSITIVE|0x0040000');
delete from `dbdocssubtables` where `subtableId`= 48 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (48,0,'ProcFlags','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Name</b></th>
<th><b>Value (hex)</b></th>
<th align=\'left\'><b>Meaning</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_KILLED</td><td align=\'center\' valign=\'middle\'>0x00000001</td><td align=\'left\' valign=\'middle\'>00 Killed by aggressor</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_KILL</td><td align=\'center\' valign=\'middle\'>0x00000002</td><td align=\'left\' valign=\'middle\'>01 Kill target (in most cases need XP/Honor reward, see Unit::IsTriggeredAtSpellProcEvent for additinoal check)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_SUCCESSFUL_MELEE_HIT</td><td align=\'center\' valign=\'middle\'>0x00000004</td><td align=\'left\' valign=\'middle\'>02 Successful melee auto attack</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_TAKEN_MELEE_HIT</td><td align=\'center\' valign=\'middle\'>0x00000008</td><td align=\'left\' valign=\'middle\'>03 Taken damage from melee auto attack hit</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_SUCCESSFUL_MELEE_SPELL_HIT</td><td align=\'center\' valign=\'middle\'>0x00000010</td><td align=\'left\' valign=\'middle\'>04 Successful attack by Spell that use melee weapon</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_TAKEN_MELEE_SPELL_HIT</td><td align=\'center\' valign=\'middle\'>0x00000020</td><td align=\'left\' valign=\'middle\'>05 Taken damage by Spell that use melee weapon</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_SUCCESSFUL_RANGED_HIT</td><td align=\'center\' valign=\'middle\'>0x00000040</td><td align=\'left\' valign=\'middle\'>06 Successful Ranged auto attack</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_TAKEN_RANGED_HIT</td><td align=\'center\' valign=\'middle\'>0x00000080</td><td align=\'left\' valign=\'middle\'>07 Taken damage from ranged auto attack</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_SUCCESSFUL_RANGED_SPELL_HIT</td><td align=\'center\' valign=\'middle\'>0x00000100</td><td align=\'left\' valign=\'middle\'>08 Successful Ranged attack by Spell that use ranged weapon</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_TAKEN_RANGED_SPELL_HIT</td><td align=\'center\' valign=\'middle\'>0x00000200</td><td align=\'left\' valign=\'middle\'>09 Taken damage by Spell that use ranged weapon</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_SUCCESSFUL_POSITIVE_AOE_HIT</td><td align=\'center\' valign=\'middle\'>0x00000400</td><td align=\'left\' valign=\'middle\'>10 Successful AoE (not 100% sure unused)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_TAKEN_POSITIVE_AOE</td><td align=\'center\' valign=\'middle\'>0x00000800</td><td align=\'left\' valign=\'middle\'>11 Taken AoE      (not 100% sure unused)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_SUCCESSFUL_AOE_SPELL_HIT</td><td align=\'center\' valign=\'middle\'>0x00001000</td><td align=\'left\' valign=\'middle\'>12 Successful AoE damage spell hit (not 100% sure unused)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_TAKEN_AOE_SPELL_HIT</td><td align=\'center\' valign=\'middle\'>0x00002000</td><td align=\'left\' valign=\'middle\'>13 Taken AoE damage spell hit      (not 100% sure unused)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_SUCCESSFUL_POSITIVE_SPELL</td><td align=\'center\' valign=\'middle\'>0x00004000</td><td align=\'left\' valign=\'middle\'>14 Successful cast positive spell (by default only on healing)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_TAKEN_POSITIVE_SPELL</td><td align=\'center\' valign=\'middle\'>0x00008000</td><td align=\'left\' valign=\'middle\'>15 Taken positive spell hit (by default only on healing)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_SUCCESSFUL_NEGATIVE_SPELL_HIT</td><td align=\'center\' valign=\'middle\'>0x00010000</td><td align=\'left\' valign=\'middle\'>16 Successful negative spell cast (by default only on damage)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_TAKEN_NEGATIVE_SPELL_HIT</td><td align=\'center\' valign=\'middle\'>0x00020000</td><td align=\'left\' valign=\'middle\'>17 Taken negative spell (by default only on damage)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_ON_DO_PERIODIC</td><td align=\'center\' valign=\'middle\'>0x00040000</td><td align=\'left\' valign=\'middle\'>18 Successful do periodic (damage / healing, determined by PROC_EX_PERIODIC_POSITIVE or negative if no procEx)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_ON_TAKE_PERIODIC</td><td align=\'center\' valign=\'middle\'>0x00080000</td><td align=\'left\' valign=\'middle\'>19 Taken spell periodic (damage / healing, determined by PROC_EX_PERIODIC_POSITIVE or negative if no procEx)</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_TAKEN_ANY_DAMAGE</td><td align=\'center\' valign=\'middle\'>0x00100000</td><td align=\'left\' valign=\'middle\'>20 Taken any damage</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_ON_TRAP_ACTIVATION</td><td align=\'center\' valign=\'middle\'>0x00200000</td><td align=\'left\' valign=\'middle\'>21 On trap activation</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_TAKEN_OFFHAND_HIT</td><td align=\'center\' valign=\'middle\'>0x00400000</td><td align=\'left\' valign=\'middle\'>22 Taken off-hand melee attacks (not used)</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>PROC_FLAG_SUCCESSFUL_OFFHAND_HIT</td><td align=\'center\' valign=\'middle\'>0x00800000</td><td align=\'left\' valign=\'middle\'>23 Successful off-hand melee attacks</td></tr>
</table>
','<Name|Value (hex)|<Meaning
PROC_FLAG_KILLED|0x00000001|00 Killed by aggressor
PROC_FLAG_KILL|0x00000002|01 Kill target (in most cases need XP/Honor reward, see Unit::IsTriggeredAtSpellProcEvent for additinoal check)
PROC_FLAG_SUCCESSFUL_MELEE_HIT|0x00000004|02 Successful melee auto attack
PROC_FLAG_TAKEN_MELEE_HIT|0x00000008|03 Taken damage from melee auto attack hit
PROC_FLAG_SUCCESSFUL_MELEE_SPELL_HIT|0x00000010|04 Successful attack by Spell that use melee weapon
PROC_FLAG_TAKEN_MELEE_SPELL_HIT|0x00000020|05 Taken damage by Spell that use melee weapon
PROC_FLAG_SUCCESSFUL_RANGED_HIT|0x00000040|06 Successful Ranged auto attack
PROC_FLAG_TAKEN_RANGED_HIT|0x00000080|07 Taken damage from ranged auto attack
PROC_FLAG_SUCCESSFUL_RANGED_SPELL_HIT|0x00000100|08 Successful Ranged attack by Spell that use ranged weapon
PROC_FLAG_TAKEN_RANGED_SPELL_HIT|0x00000200|09 Taken damage by Spell that use ranged weapon
PROC_FLAG_SUCCESSFUL_POSITIVE_AOE_HIT|0x00000400|10 Successful AoE (not 100% sure unused)
PROC_FLAG_TAKEN_POSITIVE_AOE|0x00000800|11 Taken AoE      (not 100% sure unused)
PROC_FLAG_SUCCESSFUL_AOE_SPELL_HIT|0x00001000|12 Successful AoE damage spell hit (not 100% sure unused)
PROC_FLAG_TAKEN_AOE_SPELL_HIT|0x00002000|13 Taken AoE damage spell hit      (not 100% sure unused)
PROC_FLAG_SUCCESSFUL_POSITIVE_SPELL|0x00004000|14 Successful cast positive spell (by default only on healing)
PROC_FLAG_TAKEN_POSITIVE_SPELL|0x00008000|15 Taken positive spell hit (by default only on healing)
PROC_FLAG_SUCCESSFUL_NEGATIVE_SPELL_HIT|0x00010000|16 Successful negative spell cast (by default only on damage)
PROC_FLAG_TAKEN_NEGATIVE_SPELL_HIT|0x00020000|17 Taken negative spell (by default only on damage)
PROC_FLAG_ON_DO_PERIODIC|0x00040000|18 Successful do periodic (damage / healing, determined by PROC_EX_PERIODIC_POSITIVE or negative if no procEx)
PROC_FLAG_ON_TAKE_PERIODIC|0x00080000|19 Taken spell periodic (damage / healing, determined by PROC_EX_PERIODIC_POSITIVE or negative if no procEx)
PROC_FLAG_TAKEN_ANY_DAMAGE|0x00100000|20 Taken any damage
PROC_FLAG_ON_TRAP_ACTIVATION|0x00200000|21 On trap activation
PROC_FLAG_TAKEN_OFFHAND_HIT|0x00400000|22 Taken off-hand melee attacks (not used)
PROC_FLAG_SUCCESSFUL_OFFHAND_HIT|0x00800000|23 Successful off-hand melee attacks');
delete from `dbdocssubtables` where `subtableId`= 50 and languageId=0;
insert  into `dbdocssubtables`(`subtableId`,`languageId`,`subtableName`,`subtablecontent`,`subtableTemplate`) values (50,0,'SpellTargetType','<table border=\'1\' cellspacing=\'1\' cellpadding=\'3\' bgcolor=\'#f0f0f0\'>
<tr bgcolor=\'#f0f0ff\'>
<th align=\'left\'><b>Name</b></th>
<th><b>Value</b></th>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_TARGET_TYPE_GAMEOBJECT</td><td align=\'center\' valign=\'middle\'>0</td></tr>
<tr bgcolor=\'#FEFEFF\'><td align=\'left\' valign=\'middle\'>SPELL_TARGET_TYPE_CREATURE</td><td align=\'center\' valign=\'middle\'>1</td></tr>
<tr bgcolor=\'#FFFFEE\'><td align=\'left\' valign=\'middle\'>SPELL_TARGET_TYPE_DEAD</td><td align=\'center\' valign=\'middle\'>2</td></tr>
</table>
','<Name|Value
SPELL_TARGET_TYPE_GAMEOBJECT|0
SPELL_TARGET_TYPE_CREATURE|1
SPELL_TARGET_TYPE_DEAD|2');

-- fields
update `dbdocsfields` set `FieldComment` = 'Random property type (See item_enchantment_template.entry).', `fieldNotes` = 'Type of the random property (see item_enchantment_template.entry). For items with either a random property or a random suffix.<br />Actual property of each item instance, taken from the item_enchantment_template list, is stored in item_instance table of the "characters" database.' where `fieldId`= '728' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Random property type (See item_template.RandomProperty).', `fieldNotes` = 'Random property type (See item_template.RandomProperty).' where `fieldId`= '661' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Enchantment type (See ItemRandomProperties.dbc).', `fieldNotes` = 'Enchantment type (See ItemRandomProperties.dbc).' where `fieldId`= '660' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chance to get the enchantment (%).', `fieldNotes` = 'Chance in % for item to get this enchantment.' where `fieldId`= '659' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='locales_creature', `tableNotes`='This table is used to provide to localized clients with localized names and subnames of creatures.' where tableId=73;
update `dbdocsfields` set `FieldComment` = 'Creature ID (See creature_template.entry).', `fieldNotes` = 'Creature ID (See creature_template.entry).' where `fieldId`= '800' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='locales_gameobject', `tableNotes`='This table is used to provide to localized clients with localized gameobject names.' where tableId=74;
update `dbdocsfields` set `FieldComment` = 'Gameobject ID (See gameobject_template.entry).', `fieldNotes` = 'Gameobject ID (See gameobject_template.entry).' where `fieldId`= '817' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reference to gossip_menu_option.menu_id.', `fieldNotes` = 'Reference to gossip_menu_option.menu_id.' where `fieldId`= '835' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reference to gossip_menu_option.id.', `fieldNotes` = 'Reference to gossip_menu_option.id.' where `fieldId`= '834' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='locales_item', `tableNotes`='This table is used to provide to localized clients with localized names and descriptions of items.' where tableId=76;
update `dbdocsfields` set `FieldComment` = 'Item ID (See item_template.entry).', `fieldNotes` = 'Item ID (See item_template.entry).' where `fieldId`= '852' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reference to npc_text.ID.', `fieldNotes` = 'Reference to npc_text.ID.' where `fieldId`= '861' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reference to page_text.entry.', `fieldNotes` = 'Reference to page_text.entry.' where `fieldId`= '990' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reference to points_of_interest.entry.', `fieldNotes` = 'Reference to points_of_interest.entry.' where `fieldId`= '999' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reference to quest_template.entry.', `fieldNotes` = 'Reference to quest_template.entry.' where `fieldId`= '1024' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (See creature_template.entry).', `fieldNotes` = 'ID of NPC which is a trainer, see creature_template.entry.' where `fieldId`= '1189' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Learning spell ID (See Spell.dbc).', `fieldNotes` = 'Spell ID (See Spell.dbc). The spell should have SPELL_EFFECT_LEARN_SPELL=36 as one of it effects. In other case it will be ignored.' where `fieldId`= '1193' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Learning cost (coppers).', `fieldNotes` = 'The sum in coppers required to pay for learning the spell.' where `fieldId`= '1194' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required skill type.', `fieldNotes` = 'Type of the skill required to learn the spell.<br />¬subtable:41¬' where `fieldId`= '1191' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required skill value.', `fieldNotes` = 'Value of the skill required to learn the spell.' where `fieldId`= '1192' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required level.', `fieldNotes` = 'Minimal level of character required to learn the spell.' where `fieldId`= '1190' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='npc_trainer_template', `tableNotes`='DEPRECATED. Use npc_trainer table instead.' where tableId=86;
update `dbdocsfields` set `FieldComment` = 'Item ID (See item_template.entry).', `fieldNotes` = 'ID of item, see item_template.entry.' where `fieldId`= '1204' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (See creature_template.entry).', `fieldNotes` = 'ID ofNPC which is a vendor, see item_template.entry.' where `fieldId`= '1202' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Items available.', `fieldNotes` = 'Maximum count of the available item instances. If equal to 0, ulimited supply.' where `fieldId`= '1205' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Restoration time, sec.', `fieldNotes` = 'Time interval (sec) at the end of which the limited items are fully restored, i.e. come back in stock.' where `fieldId`= '1203' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Condition ID (See conditions.condition_entry).', `fieldNotes` = 'ID of condition (see conditions.condition_entry) which player must fulfill to see this item in the stock. If equal to 0, unconditionally.' where `fieldId`= '1201' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='npc_vendor_template', `tableNotes`='DEPRECATED. Use npc_vendor table instead.' where tableId=88;
update `dbdocsfields` set `FieldComment` = 'Reference to item_template.PageText.', `fieldNotes` = 'Reference to item_template.PageText.' where `fieldId`= '1211' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Text of single page.', `fieldNotes` = 'Text of single page.' where `fieldId`= '1213' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reference to page_text.entry.', `fieldNotes` = 'ID of the next page, see page_text.entry. Equals to 0 for the last page.' where `fieldId`= '1212' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (See creature_template.entry).', `fieldNotes` = 'Creature ID (see creature_template.entry) of the pet.' where `fieldId`= '1216' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pet level.', `fieldNotes` = 'Pet level.' where `fieldId`= '1219' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pet HP at the level.', `fieldNotes` = 'Pet HP at the level.' where `fieldId`= '1217' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pet MP at the level.', `fieldNotes` = 'Pet mana points at the level.' where `fieldId`= '1220' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pet armor at the level.', `fieldNotes` = 'Pet armor at the level.' where `fieldId`= '1215' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pet strength at the level.', `fieldNotes` = 'Pet strength at the level.' where `fieldId`= '1223' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pet agility at the level.', `fieldNotes` = 'Pet agility at the level.' where `fieldId`= '1214' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pet stamina at the level.', `fieldNotes` = 'Pet stamina at the level.' where `fieldId`= '1222' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pet intellect at the level.', `fieldNotes` = 'Pet intellect at the level.' where `fieldId`= '1218' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pet spirit at the level.', `fieldNotes` = 'Pet spirit at the level.' where `fieldId`= '1221' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Table index.', `fieldNotes` = 'Table index, increases sequentially starting from 1.' where `fieldId`= '1226' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Part of the name.', `fieldNotes` = 'Part of the name.<br />The first namepart for half equal to 0, the second part otherwise.' where `fieldId`= '1227' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (See creature_template.entry).', `fieldNotes` = 'Creature ID (See creature_template.entry).' where `fieldId`= '1224' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Type of the word.', `fieldNotes` = 'Type of the word. If equal to 0, the word is first namepart, otherwise is the second one.' where `fieldId`= '1225' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'POI ID.', `fieldNotes` = 'POI ID.' where `fieldId`= '1276' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'X coordinate.', `fieldNotes` = 'X coordinate of the POI.' where `fieldId`= '1280' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Y coordinate.', `fieldNotes` = 'Y coordinate of the POI.' where `fieldId`= '1281' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'POI icon.', `fieldNotes` = 'Icon for the POI. An incomplete list of icons follows.<br />¬subtable:43¬' where `fieldId`= '1278' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='pool_creature', `tableNotes`='Contains all pool instances that participate, in particular, to any game event.' where tableId=102;
update `dbdocsfields` set `FieldComment` = 'Creature GUID (See creature.guid).', `fieldNotes` = 'GUID of the creature, see creature.guid.' where `fieldId`= '1284' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pool ID (See pool_template.entry).', `fieldNotes` = 'ID of the pool, see pool_template.entry.' where `fieldId`= '1285' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chance in %.', `fieldNotes` = 'Chance (%) for the creature to be spawned in the pool.<br />Either the sum of chances should be equal to 100, or all the chances for a pool should be 0. The latter is provided for description of even-chance pools.' where `fieldId`= '1282' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Description.', `fieldNotes` = 'Textual description ignored by the core.' where `fieldId`= '1283' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='pool_creature_template', `tableNotes`='Contains all pool instances that participate, in partuclar, to any game event.' where tableId=103;
update `dbdocsfields` set `FieldComment` = 'Creature ID (See creature_template.entry).', `fieldNotes` = 'ID of the creature, see creature_template.entry.' where `fieldId`= '1288' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pool ID (See pool_template.entry).', `fieldNotes` = 'Pool ID (See pool_template.entry).' where `fieldId`= '1289' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chance, %.', `fieldNotes` = 'Chance (%) of the creature to be spawned within the pool.<br />For a pool, either sum of chances should be equal to 100, or all chances should be 0. The latter describes an even-chanced pool.' where `fieldId`= '1286' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Description.', `fieldNotes` = 'Textual description, ignored by the core.' where `fieldId`= '1287' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='pool_gameobject', `tableNotes`='Contains all pool instances that participate, in particualr, to any game event.' where tableId=104;
update `dbdocsfields` set `FieldComment` = 'Gameobject GUID (See gameobject.guid).', `fieldNotes` = 'GUID of the gameobject, see gameobject.guid.' where `fieldId`= '1292' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pool ID (See pool_template.entry).', `fieldNotes` = 'ID of the pool, see pool_template.entry.' where `fieldId`= '1293' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chance, %.', `fieldNotes` = 'Chance (%) for the gameobject to be spawned within the pool.<br />For a pool, either the sum of chances should be equal to 100, or all chances should be 0. The latter describes an even-chanced pool.' where `fieldId`= '1290' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Description.', `fieldNotes` = 'Textual description, ignored by the core.' where `fieldId`= '1291' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='pool_gameobject_template', `tableNotes`='Contains all pool instances that participate, in particular, to any game event.' where tableId=105;
update `dbdocsfields` set `FieldComment` = 'Gameobject ID (See gameobject_template.entry).', `fieldNotes` = 'ID of the gameobject, see gameobject_template.entry.' where `fieldId`= '1296' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Pool ID (See pool_template.entry).', `fieldNotes` = 'ID of the pool, see pool_template.entry.' where `fieldId`= '1297' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chance, %.', `fieldNotes` = 'Chance (%) for the gameobject to be spawned within the pool.<br />For a pool, either the sum of chances should be equal to 100, or all chances should be 0. The latter describes an even-chanced pool.' where `fieldId`= '1294' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Description.', `fieldNotes` = 'Textual description, ignored by the core.' where `fieldId`= '1295' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='pool_pool', `tableNotes`='This is the pool of pools table. Like creatures and gameobjects, pools are the objects that may be gathered into other pools. You can create a pool with a chance of a range of pools in that pool being activated.' where tableId=106;
update `dbdocsfields` set `FieldComment` = 'Pool ID (See pool_template.entry).', `fieldNotes` = 'ID of the pool, see pool_template.entry.' where `fieldId`= '1301' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Mother pool ID.', `fieldNotes` = 'ID of the pool to which the pool belongs.' where `fieldId`= '1300' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chance, %.', `fieldNotes` = 'Chance (%) for the pool to be spawned within the mother pool.<br />For a pool, either the sum of chances should be equal to 100, or all chances should be 0. The latter describes an even-chanced pool.' where `fieldId`= '1298' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Description.', `fieldNotes` = 'Textual description, ignored by the core.' where `fieldId`= '1299' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='pool_template', `tableNotes`='Defines all pool instances that participate, in particular, to any game event.' where tableId=107;
update `dbdocsfields` set `FieldComment` = 'Pool ID.', `fieldNotes` = 'ID of the pool. It is mentioned in other pool_* tables like pool_creature.pool_entry.' where `fieldId`= '1303' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Maximum number of entities.', `fieldNotes` = 'Maximum number of entities spawned within the pool.' where `fieldId`= '1304' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Description.', `fieldNotes` = 'Textual description, ignored by the core.' where `fieldId`= '1302' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The unique identifier of the quest template entry.', `fieldNotes` = 'The unique identifier of the quest template entry.' where `fieldId`= '1317' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'This flag decides how a quest will be handled.', `fieldNotes` = 'This flag decides how a quest will be handled.<br />Allowed values: 0 autocompleted, 1 disabled, 2 usual handling.' where `fieldId`= '1321' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Defines the category under which a quest will be listed.', `fieldNotes` = 'Defines the category under which a quest will be listed in the in-game quest log. Depending on the sign of the value different category sources will be used. * If the value is > 0, the value references an entry from AreaTable.dbc. * If the value is < 0, the value references an entry from QuestSort.dbc. This is usually the case for class or skill related quests.' where `fieldId`= '1429' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The lowest level allowed to accept the quest.', `fieldNotes` = 'The lowest level allowed to accept the quest.' where `fieldId`= '1322' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The quest\'s level.', `fieldNotes` = 'The quest\'s level. Depending on the quest’s level, the experience rewarded for the quest will be awarded. *If a character’s level is <= QuestLevel+5, full experience will be given. *If QuestLevel is set to -1, the character’s level will be used as QuestLevel.' where `fieldId`= '1345' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Quest\'s difficulty.', `fieldNotes` = 'Classifies a quest\'s difficulty. This references an entry from QuestInfo.dbc (see QuestInfo.dbc). The following table lists allowed values:<br />¬subtable:44¬' where `fieldId`= '1428' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required classes mask.', `fieldNotes` = 'Bitmask of the classes which may obtain the quest (any if 0).<br />¬subtable:40¬' where `fieldId`= '1377' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required races mask.', `fieldNotes` = 'Mask of the races which may obtain the quest (any if 0).<br />¬subtable:30¬' where `fieldId`= '1382' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required skill type.', `fieldNotes` = 'Skill type required from character to obtain the quest.<br />¬subtable:41¬' where `fieldId`= '1383' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Required skill value.', `fieldNotes` = 'Required value of the skill allowing character to obtain the quest.' where `fieldId`= '1384' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Faction (See Faction.dbc).', `fieldNotes` = 'Faction (see Faction.dbc) to which the character should have a given reputation for completing the quest.' where `fieldId`= '1346' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reputation value.', `fieldNotes` = 'The value of the reputation the character should have to a given faction for completing the quest.' where `fieldId`= '1347' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Faction (See Faction.dbc).', `fieldNotes` = 'The faction (see Faction.dbc) to which the character should have a given reputation value (not below) for obtaining the quest.' where `fieldId`= '1380' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Reputation value.', `fieldNotes` = 'The reputation value that should not be above the character standing in order to obtain teh quest.' where `fieldId`= '1381' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Faction (See Faction.dbc).', `fieldNotes` = 'Faction (see Faction.dbc) reputation gain to which is modified.' where `fieldId`= '1438' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Rate for quest reputation.', `fieldNotes` = 'Rate for the reputation gained from quests.' where `fieldId`= '1439' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Rate for creature kill reputation.', `fieldNotes` = 'Rate for the reputation gained from creature killing.' where `fieldId`= '1437' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Rate for reputation spells.', `fieldNotes` = 'Rate for the reputation gained by spells with SPELL_EFFECT_REPUTATION=103.' where `fieldId`= '1440' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='reputation_reward_rate', `tableNotes`='Holds reputation multipliers for specific factions.<br />Setting a rate to 0 disables reputation gain to the faction by the defined way completely.<br />NOTE: For the low level kills/quests, the rate values are combined with the config file settings Rate.Reputation.LowLevel.Kill/Quest by multiplying.' where tableId=110;
update `dbdocsfields` set `FieldComment` = 'Base faction (See Faction.dbc).', `fieldNotes` = 'Base faction (see Faction.dbc). Modifying reputation to this faction triggers respective reputation changes for factions 1-4 defined below.' where `fieldId`= '1441' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Dependent faction (See Faction.dbc).', `fieldNotes` = 'Dependent faction one (See Faction.dbc).' where `fieldId`= '1442' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='reputation_spillover_template', `tableNotes`='This table holds information for additional factions which will be awarded reputation simultaneously with the original one. Note that the rates may be fractional and/or negative.' where tableId=111;
update `dbdocsfields` set `FieldComment` = 'Rate for faction one.', `fieldNotes` = 'The rate applied to the base reputation change, then the result is added to the faction one reputation.' where `fieldId`= '1450' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'The topmost rank allowed.', `fieldNotes` = 'The topmost reputation rank allowed. Since reaching it, the faction one reputation is not influenced by this table and should be gained directly.<br />¬subtable:42¬' where `fieldId`= '1446' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Areatrigger ID (See AreaTrigger.dbc).', `fieldNotes` = 'Areatrigger ID (See AreaTrigger.dbc).' where `fieldId`= '1477' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Eevnt ID.', `fieldNotes` = 'Event ID. This ID may be found in a spell with SPELL_EFFECT_SEND_EVENT=61, in the gameobject_template table for few GO types, or in the taxi node point data.' where `fieldId`= '1479' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='script_texts', `tableNotes`='This table contains the texts (and localized ones) for C++ SD2 script engine, used in the function DoScriptText().' where tableId=113;
update `dbdocsfields` set `FieldComment` = 'Script text ID.', `fieldNotes` = 'Script text ID, see SD2 sources. The value is negative and should be between -1000000 and -1999999.' where `fieldId`= '1466' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Sound ID (See SoundEntries.dbc).', `fieldNotes` = 'Sound ID. The SoundEntries.dbc maps these IDs to the filenames *.wav, the files are in the MPQ archives.' where `fieldId`= '1468' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chat type (see enum ChatType in Creature.h).', `fieldNotes` = 'Sound ID (See SoundEntries.dbc).<br />¬subtable:31¬' where `fieldId`= '1469' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'In-game language.', `fieldNotes` = 'In-game language restircts the understanding of the ingame text to ones having corresponding skill.<br />¬subtable:32¬' where `fieldId`= '1467' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, ignored by the core.' where `fieldId`= '1455' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (See creature_template.entry).', `fieldNotes` = 'Creature ID, see creature_template.entry.' where `fieldId`= '1470' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='script_waypoint', `tableNotes`='The table contains creature waypoints used in the C++ SD2 script library. The data is used by npc_escortAI::FillPointMovementListForCreature().' where tableId=114;
update `dbdocsfields` set `FieldComment` = 'Point ID.', `fieldNotes` = 'Point ID. The WPs are numerated sequentially starting from 0.' where `fieldId`= '1475' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'X position of WP.', `fieldNotes` = 'X position of the WP.' where `fieldId`= '1471' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Y position of WP.', `fieldNotes` = 'Y position of the WP.' where `fieldId`= '1472' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Z position of WP.', `fieldNotes` = 'Z position of the WP.' where `fieldId`= '1473' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Wait time (msec).', `fieldNotes` = 'Wait time in milliseconds. The creature will stay at the WP for this time.' where `fieldId`= '1476' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Textual comment.', `fieldNotes` = 'Textual comment, ignored by the core.' where `fieldId`= '1474' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Area ID (See AreaTable.dbc).', `fieldNotes` = 'Area ID (See AreaTable.dbc).' where `fieldId`= '1482' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Fishing skill value.', `fieldNotes` = 'Skill value of fishing. May be negative. It is used in the formula determining success of fish catching:<br />success = (player_skill > skill) AND (player_skill - skill + 5 > RANDOM(1...100))' where `fieldId`= '1483' and `languageId`= 0;

DELETE FROM `dbdocsfields` WHERE `fieldId` BETWEEN 1491 AND 1534;
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1491','0','spell_affect','effectId','Effect ID (See Spell.dbc).','ID of the effect of the spell, see Spell.dbc. Numbered from 0, so equals 0 to 2.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1492','0','spell_affect','entry','Spell ID (See Spell.dbc).','Spell ID (See Spell.dbc). The spell should apply an aura of any type from: SPELL_AURA_ADD_FLAT_MODIFIER, SPELL_AURA_ADD_PCT_MODIFIER, SPELL_AURA_ADD_TARGET_TRIGGER, SPELL_AURA_OVERRIDE_CLASS_SCRIPTS.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1493','0','spell_affect','SpellFamilyMask','SpellFamilyFlags (See Spell.dbc).','SpellFamilyFlags, see Spell.dbc and struct SpellEntry in DBCStructure.h. This is 64-bit value.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1494','0','spell_area','area','Area ID (See AreaTable.dbc).','Area ID, see AreaTable.dbc. If equals to 0, is not limited to any zone.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1495','0','spell_area','aura_spell','Spell ID (See Spell.dbc).','Spell ID (See Spell.dbc) of the aura spell which the character should already have applied (if positive) or do not have (if negative).');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1496','0','spell_area','autocast','Autocast flag.','If set, this flag requires the spell to be catsed on the character just entered the area. In other case, the spell is enabled for the character to be casted.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1497','0','spell_area','condition_id','Condition ID (See conditions.condition_entry).','Condition ID (See conditions.condition_entry) of teh condition which should be fulfilled.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1498','0','spell_area','gender','Gender.','Gender of the character (0 = male, 1 = female, 2 = not defined).');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1499','0','spell_area','quest_end','Quest ID (See quest_template.entry).','Quest ID (see quest_template.entry) of the quest that should not be rewarded.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1500','0','spell_area','quest_start','Quest ID (See quest_template.entry).','Quest ID (see quest_template.entry) that should be either active or rewarded.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1501','0','spell_area','quest_start_active','Flag for quest_start.','If set, this flag allows the quest mentioned in the quest_start field to be rewarded, not only be active.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1502','0','spell_area','racemask','Race mask value.','Race mask value. The entries may be combined by simple adding.<br />¬subtable:30¬');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1503','0','spell_area','spell','Spell ID (See Spell.dbc).','Spell ID, see Spell.dbc. The spell is either casted on the character or is allowed the character to cast.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1504','0','spell_bonus_data','ap_bonus','Any value here will modify the spells attack power with the factor given here.','Any value here will modify the spells attack power with the factor given here. Used for the spells with physical damage, like most warrior/rogue ones.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1505','0','spell_bonus_data','ap_dot_bonus','DoT bonus for physical damage.','DoT bonus coefficient for the spells with physical damage type.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1506','0','spell_bonus_data','comments','Textual comment.','Textual comment, ignored by the core.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1507','0','spell_bonus_data','direct_bonus','Direct damage bonus.','Direct damage spell bonus coefficient.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1508','0','spell_bonus_data','direct_bonus_done','Direct bonus for done part.','Direct damage bonus coefficient for done part.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1509','0','spell_bonus_data','direct_bonus_taken','Direct damage taken bonus.','Direct damage bonus coefficient for taken part.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1510','0','spell_bonus_data','dot_bonus','DoT tick bonus coefficient.','DoT tick bonus coefficient.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1511','0','spell_bonus_data','entry','Spell ID (See Spell.dbc).','Spell ID (See Spell.dbc) of the spells which bonus are to be modified.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1512','0','spell_bonus_data','one_hand_direct_bonus','Direct bonus for one-handed weapon.','Direct damage spell bonus coefficient while a one-handed weapon equipped.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1513','0','spell_bonus_data','one_hand_direct_bonus_done','Direct damage done bonus with one-handed weapon.','Direct damage bonus coefficient for done part while a one-handed weapon equipped.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1514','0','spell_bonus_data','one_hand_direct_bonus_taken','Direct damage taken bonus with one-handed weapon.','Direct damage bonus coefficient for taken part while a one-handed weapon equipped.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1515','0','spell_bonus_data','two_hand_direct_bonus','Direct damage bonus for two-handed weapon.','Direct damage spell bonus coefficient while a two-hand weapon equipped.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1516','0','spell_bonus_data','two_hand_direct_bonus_done','Direct damage done bonus with two-handed weapon.','Direct damage bonus coefficient for done part while a two-handed weapon equipped.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1517','0','spell_bonus_data','two_hand_direct_bonus_taken','Direct damage taken bonus with two-handed weapon.','Direct damage bonus coefficient for taken part while a two-handed weapon equipped.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1518','0','spell_chain','first_spell','Lowest rank spell.','Spell ID for the lowest rank spell of the chain.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1519','0','spell_chain','prev_spell','Previous rank of the spell.','Spell ID for the previous rank of the spell.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1520','0','spell_chain','rank','Rank.','Spell rank, numbered from 1.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1521','0','spell_chain','req_spell','Required spell ID.','ID of the side spell to be known to allow the whole spell chain. This is for talent-enabled spells.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1522','0','spell_chain','spell_id','Spell ID.','Spell ID.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1523','0','spell_elixir','entry','Spell ID (See Spell.dbc).','Spell ID (See Spell.dbc).');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1524','0','spell_elixir','mask','Type mask.','Type mask of the spell used by an elixir. Not defined yet, all records have 0 here (version 0.20).');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1525','0','spell_facing','entry','Spell ID (See Spell.dbc).','Spell ID (See Spell.dbc).');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1526','0','spell_facing','facingcasterflag','Facing caster flags.','Facing caster flags, see enum SpellFacingFlags in Unit.h.<br />Currenlty (0.20), in the core is defined the only flag SPELL_FACING_FLAG_INFRONT=1.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1527','0','spell_learn_spell','Active','Active flag.','The active flag. If set, the spell is enabled as active, i.e. allowed to be casted.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1528','0','spell_learn_spell','entry','Spell ID (See Spell.dbc).','Spell ID (See Spell.dbc) of the triggering spell.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1529','0','spell_learn_spell','SpellID','Spell ID (See Spell.dbc).','Spell ID (See Spell.dbc) of the additional spell to learn.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1530','0','spell_linked','comment','Textual comment.','Textual comment, ignored by the core.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1531','0','spell_linked','effect_mask','Effect mask.','The link may be limited to any or all spelleffects. The mask values are 1, 2, 4 for EFFECT_0, EFFECT_1, EFFECT_2 respectively. The values may be combined by adding.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1532','0','spell_linked','entry','Spell ID (See Spell.dbc).','Spell ID (See Spell.dbc) of the triggering spell.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1533','0','spell_linked','linked_entry','Spell ID (See Spell.dbc).','Spell ID (See Spell.dbc) of the triggered spell.');
insert into `dbdocsfields` (`fieldId`, `languageId`, `tableName`, `fieldName`, `fieldComment`, `fieldNotes`) values('1534','0','spell_linked','type','Link type.','Type of spell link, see enum SpellLinkedType in SpellMgr.h.<br />¬subtable:45¬');

update `dbdocsfields` set `FieldComment` = 'Spell ID (See Spell.dbc).', `fieldNotes` = 'Spell ID (see Spell.dbc) of the triggering spell. One of its spelleffects should be either EFFECT_DUMMY or applying the aura AURA_DUMMY.' where `fieldId`= '1537' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID (See creature_template.entry).', `fieldNotes` = 'Pet creature ID, see creature_template.enrty.' where `fieldId`= '1536' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell ID (See Spell.dbc).', `fieldNotes` = 'Spell ID (see Spell.dbc) of the aura spell to be applied on the pet.' where `fieldId`= '1535' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='spell_pet_auras', `tableNotes`='This table holds information for additional auras due to the pet. This mechanic implements character talents modifying the pet properties. If the character has aura/knows spell, then the pet get additional aura.' where tableId=128;
update `dbdocsfields` set `FieldComment` = 'Spell ID (See Spell.dbc).', `fieldNotes` = 'Spell ID (see Spell.dbc) of the aura that may proc during another spellcast or under other conditions defined in this table.' where `fieldId`= '1540' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell school mask.', `fieldNotes` = 'Spell school mask. Spell School is defined in in the second field of Spell.dbc entry. This value is the bitmask (see enum SpellSchoolMask in SharedDefines.h), where different schools may be combined.<br />¬subtable:46¬' where `fieldId`= '1544' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell family name.', `fieldNotes` = 'Spell family name classifies the spell as intended mostly for specific character class, see enum SpellFamily in DBCEnums.h. The field is defined for each spell in Spell.dbc, see SpellFamilyName field of struct SpellEntry in DBCStructure.h.<br />¬subtable:47¬' where `fieldId`= '1548' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Flags defining conditions for aura to proc.', `fieldNotes` = 'Bitmask defining conditions for aura to proc. Values may be combined by adding. If equals to 0, the value form Spell.dbc is used.<br />¬subtable:48¬' where `fieldId`= '1543' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell family mask for effect 0.', `fieldNotes` = 'Spell family mask for EFFECT_0.<br />The SpellFamilyMask is a 64-bit value defined for each spell in Spell.dbc (see SpellFamilyFlags field of struct SpellEntry in DBCStructure.h). It classifies the spell into a group within each SpellFamilyName, presenting a simple way to recognizing spells, for example, one spell of different ranks. The 64-bit values are defined in the sources as UI64LIT() type.' where `fieldId`= '1545' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell family mask for effect 1.', `fieldNotes` = 'Spell family mask for EFFECT_1.<br />The SpellFamilyMask is a 64-bit value defined for each spell in Spell.dbc (see SpellFamilyFlags field of struct SpellEntry in DBCStructure.h). It classifies the spell into a group within each SpellFamilyName, presenting a simple way to recognizing spells, for example, one spell of different ranks. The 64-bit values are defined in the sources as UI64LIT() type.' where `fieldId`= '1546' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell family mask for effect 2.', `fieldNotes` = 'Spell family mask for EFFECT_2.<br />The SpellFamilyMask is a 64-bit value defined for each spell in Spell.dbc (see SpellFamilyFlags field of struct SpellEntry in DBCStructure.h). It classifies the spell into a group within each SpellFamilyName, presenting a simple way to recognizing spells, for example, one spell of different ranks. The 64-bit values are defined in the sources as UI64LIT() type.' where `fieldId`= '1547' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Flags refining proc condition.', `fieldNotes` = 'Flags refining proc condition, optional.<br />¬subtable:49¬' where `fieldId`= '1542' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Proc frequency limit.', `fieldNotes` = 'The value limits the proc frequency. For melee (ranged?) damage spells it is the proc rate per minute. The actual proc may happen less frequently but not more frequently than defined here.<br />If zero, falls back to flat chance from Spell.dbc.' where `fieldId`= '1541' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Chance of proc.', `fieldNotes` = 'Chance of proc. If equals to 0, the standard value from Spell.dbc is used, else overrides it.<br />Mostly used for spell debugging when it is convenient to set the chance to 100%.' where `fieldId`= '1539' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Cooldown (in msec).', `fieldNotes` = 'A hidden cooldown used for some spell proc events, applied to _triggered_spell_.' where `fieldId`= '1538' and `languageId`= 0;
update `dbdocstable` set `languageId`=0, `tableName`='spell_proc_event', `tableNotes`='This table holds information on what events (or procs) certain spells are activated. All spells in this table must have apply a SPELL_AURA_PROC_TRIGGER_SPELL (42) aura. Any nonzero entries in this table will overwrite the existing proc settings in the spell’s DBC entry.' where tableId=129;
update `dbdocsfields` set `FieldComment` = 'Spell ID (See Spell.dbc).', `fieldNotes` = 'Spell ID (See Spell.dbc). Should be the first rank spell if in the rank chain.' where `fieldId`= '1549' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Proc frequency limit, per minute.', `fieldNotes` = 'The value (times per minute) limits the enchant proc frequency.' where `fieldId`= '1550' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell ID (See Spell.dbc).', `fieldNotes` = 'Spell ID (See Spell.dbc) of the spell requiring external implicit target definition.' where `fieldId`= '1551' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Spell ID (See Spell.dbc).', `fieldNotes` = 'Spell ID (See Spell.dbc) of the spell requiring external implicit target definition. The target type of a spelleffect has to be one of the following (look for the values at enum Targets in SharedDefines.h):<br />TARGET_SCRIPT, TARGET_SCRIPT_COORDINATES, TARGET_FOCUS_OR_SCRIPTED_GAMEOBJECT, TARGET_AREAEFFECT_INSTANT, TARGET_AREAEFFECT_CUSTOM, TARGET_AREAEFFECT_GO_AROUND_SOURCE, TARGET_AREAEFFECT_GO_AROUND_DEST, TARGET_NARROW_FRONTAL_CONE' where `fieldId`= '1551' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Type of the target entry.', `fieldNotes` = 'Type of the target entry.<br />¬subtable:50¬' where `fieldId`= '1554' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Creature ID or Gameobject ID.', `fieldNotes` = 'Creature ID (creature_template.entry) or Gameobject ID (gameobject_template.entry) dependently on the type.' where `fieldId`= '1553' and `languageId`= 0;
update `dbdocsfields` set `FieldComment` = 'Inverse effect mask.', `fieldNotes` = 'The bitmask (bits 0, 1, 2 corresponding to values 1, 2, 4) of the spell effect numbers that do not use this mechanic.' where `fieldId`= '1552' and `languageId`= 0;
