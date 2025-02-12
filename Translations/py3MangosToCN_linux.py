# python3 py3MangosToCN_linux.py
import os

# select setting :
declaraction1 = """
did you already have MangosZero_Localised.git?
if haven't .
    please Ctrl+C then:
    git clone --recurse-submodules https://github.com/MangosExtras/MangosZero_Localised.git

test environment : debian10, mysql8.0, python3, chinese, 2018-10-06; other not test,good luck >_<
bug : QQ32686647; skype:fevefun@hotmail.com
test server : www.gamefunc.top

only support python3

Thanks Mangos and everyone.
my english not good.

***all ?? can't null;***

"""
print(declaraction1)


# select language
selectLanguageText = """[0]
select translation language number:[1] and (TODO) not support yet >_<
1.Chinese
2.French
3.German(TODO)
4.Italian(TODO)
5.Korean(TODO)
6.Russian
7.Spanish(TODO)
8.Spanish_South_American(TODO)
9.Taiwanese(TODO)
"""

languageSelect = input(selectLanguageText + " : (Must be number) : ")

if int(languageSelect) not in [1,2,6]:
    raise TypeError("language must be 1-9, and (TODO) not support yet")

langFolderName = selectLanguageText.split("\n")[int(languageSelect)+1][2:]
print(str(langFolderName))


# setting other
path = input("enter your MangosZero_Localised folder PATH(like: /root/MangosZero_Localised/ ) : ")
path = path.strip()
if path[-1] != "/":
    path = path + "/"

selectSqlType = input("select you sql type Number (1 or 2)(1=mysql, 2=mariaDB) : ")
sqlHost = input("database connect Address is(like: 192.168.1.1) : ")
sqlPort = input("database connect Port is(like: 3306) : ")
sqlUserName = input("database connect UserName is(like: mangos) : ")
zero_worldDBName = input("input worldDB in SQL's name(like: zero_world)  : ")



# get sql connect secert and set sqlExecCMD
if selectSqlType == "1":
    print("enter your sql connect PASSWORD ")
    secretCMD = "mysql_config_editor set --login-path=local --host={sqlHost} --port={sqlPort} --user={sqlUserName} --password --skip-warn".format(sqlHost=sqlHost, sqlPort=sqlPort, sqlUserName=sqlUserName)
    os.system(secretCMD)
    print(secretCMD)
    sqlExecCMD = "mysql --login-path=local -q -s " + zero_worldDBName + " <  "
elif selectSqlType == "2":
    mariaPassword = input ( "input your sql connect PASSWORD : ")
    sqlExecCMD = "mysql -h{sqlHost} -P{sqlPort} -u{sqlUserName} -p{mariaPassword}  {zero_worldDBName}  <  ".format(sqlHost=sqlHost, sqlPort=sqlPort, sqlUserName=sqlUserName, mariaPassword=mariaPassword, zero_worldDBName=zero_worldDBName)
else:
    raise TypeError("dbType Fail , when select sql Type must input 1 or 2 only")


# process start
for baseDB in ["1_LocaleTablePrepare.sql", "2_Add_NewLocalisationFields.sql", "3_InitialSaveEnglish.sql"]:
    os.system(sqlExecCMD + path + baseDB)
    print(sqlExecCMD + path + baseDB)


# install language
path2 = path + "Translations/" + langFolderName + "/" 
langFiles = os.listdir(path2)

for filename in langFiles:
    if os.path.isdir(path2 + filename) or not filename.endswith(".sql"):
        continue
    
    print(sqlExecCMD  + path2 + filename)
    os.system(sqlExecCMD  + path2 + filename)


# last,  over local : A_replace_BaseEnglish_with_xx
A_replace_BaseEnglish_with_xx = """
#1
UPDATE `creature_template`
INNER JOIN `locales_creature` ON `creature_template`.`entry` = `locales_creature`.`Entry`
SET creature_template.`Name`=`locales_creature`.`name_loc4`,creature_template.`subName`=`locales_creature`.`subname_loc4`;

#2
UPDATE `creature_ai_texts`
SET `content_default` = `content_loc4` where content_loc4 is not NULL ;


#3
UPDATE `db_script_string`
SET `content_default` = `content_loc4` where content_loc4 is not NULL;


#4
UPDATE `gameobject_template`
INNER JOIN `locales_gameobject` ON `gameobject_template`.`entry` = `locales_gameobject`.`Entry`
SET gameobject_template.`Name` = `locales_gameobject`.`name_loc4`;


#5
UPDATE `gossip_texts`
SET `content_default` = `content_loc4` where content_loc4 is not NULL ;

#6
UPDATE `gossip_menu_option`
INNER JOIN `locales_gossip_menu_option` ON gossip_menu_option.`menu_id`=`locales_gossip_menu_option`.`menu_id` AND gossip_menu_option.`id`=`locales_gossip_menu_option`.`id`
SET gossip_menu_option.`option_text`=`locales_gossip_menu_option`.`option_text_loc4`, gossip_menu_option.`box_text`=`locales_gossip_menu_option`.`box_text_loc4`;


#7
UPDATE `item_template`
INNER JOIN `locales_item` ON item_template.`Entry`=`locales_item`.`entry`
SET item_template.`Name`=`locales_item`.`name_loc4`,item_template.`description`=COALESCE(`locales_item`.`description_loc4`,'');


#8
UPDATE `mangos_string`
SET `content_default` = `content_loc4` where content_loc4 is not NULL; 

#9
UPDATE `page_text`
INNER JOIN `locales_page_text` ON page_text.`entry`=`locales_page_text`.`entry`
SET page_text.`Text`=COALESCE(`locales_page_text`.`Text_loc4`,'');


#10
UPDATE `points_of_interest`
INNER JOIN `locales_points_of_interest` ON points_of_interest.`entry`=`locales_points_of_interest`.`entry`
SET points_of_interest.`icon_name`=COALESCE(`locales_points_of_interest`.`icon_name_loc4`,`locales_points_of_interest`.`icon_name_loc0`);

#11
UPDATE `quest_template`
INNER JOIN `locales_quest` ON quest_template.`entry`=`locales_quest`.`entry` 
SET quest_template.`Title`=`locales_quest`.`Title_loc4`,
    quest_template.`Details`=`locales_quest`.`Details_loc4`,
    quest_template.`Objectives`=`locales_quest`.`Objectives_loc4`,
    quest_template.`OfferRewardText`=`locales_quest`.`OfferRewardText_loc4`,
    quest_template.`RequestItemsText`=`locales_quest`.`RequestItemsText_loc4`,
    quest_template.`EndText`=`locales_quest`.`EndText_loc4`,
    quest_template.`ObjectiveText1`=`locales_quest`.`ObjectiveText1_loc4`,
    quest_template.`ObjectiveText2`=`locales_quest`.`ObjectiveText2_loc4`,
    quest_template.`ObjectiveText3`=`locales_quest`.`ObjectiveText3_loc4`,
    quest_template.`ObjectiveText4`=`locales_quest`.`ObjectiveText4_loc4`;


#12
UPDATE `script_texts`
SET `content_default` = `content_loc4` where content_loc4 is not NULL;

#13
UPDATE `npc_text`
INNER JOIN `locales_npc_text` ON npc_text.`id`=`locales_npc_text`.`entry` 
SET npc_text.`Text0_0`=`locales_npc_text`.`Text0_0_loc4`,
    npc_text.`Text0_1`=`locales_npc_text`.`Text0_1_loc4`,
    npc_text.`Text1_0`=`locales_npc_text`.`Text1_0_loc4`,
    npc_text.`Text1_1`=`locales_npc_text`.`Text1_1_loc4`,
    npc_text.`Text2_0`=`locales_npc_text`.`Text2_0_loc4`,
    npc_text.`Text2_1`=`locales_npc_text`.`Text2_1_loc4`,
    npc_text.`Text3_0`=`locales_npc_text`.`Text3_0_loc4`,
    npc_text.`Text3_1`=`locales_npc_text`.`Text3_1_loc4`,
    npc_text.`Text4_0`=`locales_npc_text`.`Text4_0_loc4`,
    npc_text.`Text4_1`=`locales_npc_text`.`Text4_1_loc4`,
    npc_text.`Text5_0`=`locales_npc_text`.`Text5_0_loc4`,
    npc_text.`Text5_1`=`locales_npc_text`.`Text5_1_loc4`,
    npc_text.`Text6_0`=`locales_npc_text`.`Text6_0_loc4`,
    npc_text.`Text6_1`=`locales_npc_text`.`Text6_1_loc4`,
    npc_text.`Text7_0`=`locales_npc_text`.`Text7_0_loc4`,
    npc_text.`Text7_1`=`locales_npc_text`.`Text7_1_loc4`;
"""

# select1CN=4;  select2French=2, select3Russian=8
if int(languageSelect) == 1:
    a_replace_temp = A_replace_BaseEnglish_with_xx
elif int(languageSelect)  == 2:
    a_replace_temp = A_replace_BaseEnglish_with_xx.replace("_loc4", "_loc2")
elif int(languageSelect) == 6:
    a_replace_temp = A_replace_BaseEnglish_with_xx.replace("_loc4", "_loc8")
else:
    raise TypeError("TODO")

with open(path+"GameSQLtemp.sql", mode="w", encoding="utf-8") as tmpfile:
    tmpfile.write(a_replace_temp)

print(sqlExecCMD + path + "GameSQLtemp.sql")
os.system(sqlExecCMD + path + "GameSQLtemp.sql")
print("Final ok")

