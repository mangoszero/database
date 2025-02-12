# MangosZero Localisation Project

This is a culmination of over a years work to generate a full localisation process and files for Mangos.

### Features

Rather than an all or nothing system for localisation, the languages can be chosen individually

Current support will include the following:
* Korean
* French
* German
* Spanish
* Spanish (South American)
* Chinese
* Taiwanese
* Russian

Plus the following, even though the client does not natively support it (See "Using the Translated Locale on a different language client than the Locale" below):
* Italian

### How to use it

Eventually it will become part of the main install database scripts, but for now it's a case of manually applying the updates.

1) run the following SQL script:

    `1_LocaleTablePrepare.sql`

This will populate the localised tables with empty entries ready for the language pack.

2) Import the language pack you want from \Translations\<Language>

The language pack currently consists of 14 files:

    <Language>_CommandHelp.sql
    <Language>_Creature.sql
    <Language>_Creature_AI_Texts.sql
    <Language>_db_script_string.sql
    <Language>_Gameobject.sql
    <Language>_gossip_menu_option.sql
    <Language>_Gossip_texts.sql
    <Language>_Items.sql
    <Language>_Mangos_String.sql
    <Language>_NpcText.sql
    <Language>_Pagetext.sql
    <Language>_points_of_interest.sql
    <Language>_Quest.sql
    <Language>_Script_texts.sql


The 14 files ending in `_missing.sql` are entries that need to be translated.

### Using the Translated Locale on a different language client than the Locale

1) If you wish to run the localised text in a different language client i.e. Italian Locale using an English client, run these scripts in order:

    `1_LocaleTablePrepare.sql`
    `2_Add_NewLocalisationFields.sql`
    `3_InitialSaveEnglish.sql`

2) Then Import the language pack you want from \Translations\<Language>

The language pack currently consists of 14 files:

    <Language>_CommandHelp.sql
    <Language>_Creature.sql
    <Language>_Creature_AI_Texts.sql
    <Language>_db_script_string.sql
    <Language>_Gameobject.sql
    <Language>_gossip_menu_option.sql
    <Language>_Gossip_texts.sql
    <Language>_Items.sql
    <Language>_Mangos_String.sql
    <Language>_NpcText.sql
    <Language>_Pagetext.sql
    <Language>_points_of_interest.sql
    <Language>_Quest.sql
    <Language>_Script_texts.sql
    
3) Then run the remaining script
    `A_replace_BaseEnglish_with_<Language>.sql`

3a) Should you want to revent the changes, just run:
    `B_replace_BaseEnglish_with_English.sql`

**Official Websites**
----

* [**Official MaNGOS Site**](https://getmangos.eu/)  
* [**Official MaNGOS Community Forum**](https://www.getmangos.eu/home.php)  

**Main Wiki**
----
For browsing the Wiki, it is located at the following location:

* [**Wiki Home**](http://getmangos.eu/wiki)  

---
Proudly brought to you by:
<br>
[![getMaNGOS](https://www.getmangos.eu/!assets_mangos/logo.png)](http://getmangos.eu)

We would like to acknowledge the work of the following groups who have helped source some of the translations used:

* GMDB (German Mangos Database project)
* YTDB (non-mangos compatible Database)
* MA-WOWEE (Spanish database project)
* UDBFR (French Database Project)

Not to mention a number of people from the Mangos Community who have submitted corrections and updates:

* mpfans
* talendrys
* salja
* AzoG
* D3thw0lf
* bdebaere
