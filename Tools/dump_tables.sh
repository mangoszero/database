#!/bin/bash

# if this does not run in Linux, then run the removeCR.sh file - edit its script with the name of this file

USERNAME=
PASSWORD=
DDUMPDIR=./mangos


###################################################################################

i=1
restore_warden_group() {

WARDEN_RESTORE_FAILED=0
for WARDEN_TABLE in warden warden_checks; do
WARDEN_OUTPUT="${DUMPDIR}/${WARDEN_TABLE}.sql"
WARDEN_ROLLBACK="${WARDEN_OUTPUT}.rollback.tmp"
WARDEN_NO_PRIOR="${WARDEN_OUTPUT}.no-prior.tmp"
if [ -e "${WARDEN_ROLLBACK}" ] && [ -e "${WARDEN_NO_PRIOR}" ]; then
WARDEN_RESTORE_FAILED=1
elif [ -e "${WARDEN_ROLLBACK}" ]; then
if ! mv -f "${WARDEN_ROLLBACK}" "${WARDEN_OUTPUT}" || [ -e "${WARDEN_ROLLBACK}" ] || [ ! -e "${WARDEN_OUTPUT}" ]; then
WARDEN_RESTORE_FAILED=1
fi
elif [ -e "${WARDEN_NO_PRIOR}" ]; then
if ! rm -f "${WARDEN_OUTPUT}" || [ -e "${WARDEN_OUTPUT}" ]; then
WARDEN_RESTORE_FAILED=1
elif ! rm -f "${WARDEN_NO_PRIOR}" || [ -e "${WARDEN_NO_PRIOR}" ]; then
WARDEN_RESTORE_FAILED=1
fi
fi
done
[ "${WARDEN_RESTORE_FAILED}" -eq 0 ]
}

dump_warden_tables() {

WARDEN_RECOVERY_ANY=0
WARDEN_RECOVERY_COMPLETE=1
for WARDEN_TABLE in warden warden_checks; do
WARDEN_RECOVERY_COUNT=0
[ -e "${DUMPDIR}/${WARDEN_TABLE}.sql.rollback.tmp" ] && WARDEN_RECOVERY_COUNT=$((WARDEN_RECOVERY_COUNT + 1))
[ -e "${DUMPDIR}/${WARDEN_TABLE}.sql.no-prior.tmp" ] && WARDEN_RECOVERY_COUNT=$((WARDEN_RECOVERY_COUNT + 1))
if [ "${WARDEN_RECOVERY_COUNT}" -gt 0 ]; then
WARDEN_RECOVERY_ANY=1
fi
if [ "${WARDEN_RECOVERY_COUNT}" -ne 1 ]; then
WARDEN_RECOVERY_COMPLETE=0
fi
done
if [ "${WARDEN_RECOVERY_ANY}" -eq 1 ]; then
if [ "${WARDEN_RECOVERY_COMPLETE}" -ne 1 ]; then
echo "Incomplete Warden recovery state in ${DUMPDIR}; preserving artifacts." >&2
return 1
fi
if ! restore_warden_group; then
echo "Could not restore stale Warden recovery state; preserving remaining artifacts." >&2
return 1
fi
fi

WARDEN_TABLES=
for WARDEN_TABLE in warden warden_checks; do
if ! WARDEN_FOUND=$(mysql --batch --skip-column-names -u"${USERNAME}" -p"${PASSWORD}" "${DB}" -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = '${WARDEN_TABLE}';" 2>/dev/null); then
echo "Could not inspect ${DB}.${WARDEN_TABLE}; retaining prior backups." >&2
return 1
fi
case "${WARDEN_FOUND}" in
0)
;;
1)
WARDEN_TABLES="${WARDEN_TABLES} ${WARDEN_TABLE}"
;;
*)
echo "Invalid table probe result for ${DB}.${WARDEN_TABLE}." >&2
return 1
;;
esac
done

if [ -z "${WARDEN_TABLES}" ]; then
echo "Neither warden nor warden_checks exists in ${DB}; retaining prior Warden dumps and continuing." >&2
return 0
fi

for WARDEN_TABLE in ${WARDEN_TABLES}; do
WARDEN_READY="${DUMPDIR}/${WARDEN_TABLE}.sql.new"
if ! rm -f "${WARDEN_READY}"; then
echo "Could not clear staged ${WARDEN_TABLE} dump." >&2
return 1
fi
if ! mysqldump -Q -c -e -q -u"${USERNAME}" -p"${PASSWORD}" "${DB}" "${WARDEN_TABLE}" > "${WARDEN_READY}"; then
rm -f "${DUMPDIR}/warden.sql.new" "${DUMPDIR}/warden_checks.sql.new"
echo "Could not dump ${DB}.${WARDEN_TABLE}; retaining prior backups." >&2
return 1
fi
done

for WARDEN_TABLE in warden warden_checks; do
WARDEN_OUTPUT="${DUMPDIR}/${WARDEN_TABLE}.sql"
WARDEN_ROLLBACK="${WARDEN_OUTPUT}.rollback.tmp"
WARDEN_NO_PRIOR="${WARDEN_OUTPUT}.no-prior.tmp"
if [ -e "${WARDEN_ROLLBACK}" ] || [ -e "${WARDEN_NO_PRIOR}" ]; then
echo "Unexpected recovery artifact for ${WARDEN_TABLE}; preserving it." >&2
restore_warden_group
rm -f "${DUMPDIR}/warden.sql.new" "${DUMPDIR}/warden_checks.sql.new"
return 1
fi
if [ -e "${WARDEN_OUTPUT}" ]; then
if ! mv -f "${WARDEN_OUTPUT}" "${WARDEN_ROLLBACK}" || [ -e "${WARDEN_OUTPUT}" ] || [ ! -e "${WARDEN_ROLLBACK}" ]; then
restore_warden_group
rm -f "${DUMPDIR}/warden.sql.new" "${DUMPDIR}/warden_checks.sql.new"
echo "Could not snapshot ${WARDEN_TABLE}; prior group was restored where possible." >&2
return 1
fi
elif ! : > "${WARDEN_NO_PRIOR}" || [ ! -e "${WARDEN_NO_PRIOR}" ]; then
restore_warden_group
rm -f "${DUMPDIR}/warden.sql.new" "${DUMPDIR}/warden_checks.sql.new"
echo "Could not record original absence for ${WARDEN_TABLE}." >&2
return 1
fi
done

for WARDEN_TABLE in ${WARDEN_TABLES}; do
WARDEN_READY="${DUMPDIR}/${WARDEN_TABLE}.sql.new"
if ! mv -f "${WARDEN_READY}" "${DUMPDIR}/${WARDEN_TABLE}.sql"; then
restore_warden_group
rm -f "${DUMPDIR}/warden.sql.new" "${DUMPDIR}/warden_checks.sql.new"
echo "Could not publish ${DB}.${WARDEN_TABLE}; prior group was restored where possible." >&2
return 1
fi
done

for WARDEN_TABLE in warden warden_checks; do
case " ${WARDEN_TABLES} " in
*" ${WARDEN_TABLE} "*)
;;
*)
if ! rm -f "${DUMPDIR}/${WARDEN_TABLE}.sql"; then
restore_warden_group
rm -f "${DUMPDIR}/warden.sql.new" "${DUMPDIR}/warden_checks.sql.new"
echo "Could not remove stale ${WARDEN_TABLE} dump." >&2
return 1
fi
;;
esac
done

WARDEN_RECOVERY_CLEANUP_FAILED=0
for WARDEN_TABLE in warden warden_checks; do
for WARDEN_RECOVERY in "${DUMPDIR}/${WARDEN_TABLE}.sql.rollback.tmp" "${DUMPDIR}/${WARDEN_TABLE}.sql.no-prior.tmp"; do
if ! rm -f "${WARDEN_RECOVERY}" || [ -e "${WARDEN_RECOVERY}" ]; then
WARDEN_RECOVERY_CLEANUP_FAILED=1
fi
done
done
if [ "${WARDEN_RECOVERY_CLEANUP_FAILED}" -ne 0 ]; then
echo "Published Warden group, but could not retire all recovery artifacts." >&2
return 1
fi
}

dump_table() {

TABLE=$1
TABLE_READY="${DUMPDIR}/${TABLE}.sql.new"
TABLE_OUTPUT="${DUMPDIR}/${TABLE}.sql"
if ! rm -f "${TABLE_READY}" || [ -e "${TABLE_READY}" ]; then
echo "Could not clear staged ${TABLE} dump." >&2
return 1
fi
if ! echo "--
-- Copyright (C) 2005-2024 MaNGOS <https://getmangos.eu/> <https://github.com/mangoszero>
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--
" > "${TABLE_READY}"; then
rm -f "${TABLE_READY}"
echo "Could not stage the header for ${TABLE}." >&2
return 1
fi
if ! (
set -o pipefail
mysqldump -Q -c -e -q -u"${USERNAME}" -p"${PASSWORD}" "${DB}" "${TABLE}" \
  | sed "s/VALUES /VALUES\n/g" \
  | sed "s/),(/),\n(/g" \
  | sed "/Dump completed/d" \
  | sed -e "1d;2d;3d;4d;5d;6d"
) >> "${TABLE_READY}"; then
rm -f "${TABLE_READY}"
echo "Could not dump ${DB}.${TABLE}; retaining prior backup." >&2
return 1
fi
if ! mv -f "${TABLE_READY}" "${TABLE_OUTPUT}"; then
rm -f "${TABLE_READY}"
echo "Could not publish ${DB}.${TABLE}; retaining prior backup." >&2
return 1
fi
return 0
}



do_dump_zero() {

mkdir -p ${DUMPDIR}

if ! dump_warden_tables; then
return 1
fi

for TABLE in \
areatrigger_involvedrelation \
areatrigger_tavern \
areatrigger_teleport \
battleground_events \
battleground_template \
battlemaster_entry \
command \
conditions \
creature \
creature_addon \
creature_ai_scripts \
creature_ai_summons \
creature_ai_texts \
creature_battleground \
creature_equip_template \
creature_equip_template_raw \
creature_involvedrelation \
creature_item_template \
creature_linking \
creature_linking_template \
creature_loot_template \
creature_model_info \
creature_movement \
creature_movement_template \
creature_onkill_reputation \
creature_questrelation \
creature_spells \
creature_template \
creature_template_addon \
creature_template_classlevelstats \
creature_template_spells \
custom_texts \
db_script_string \
db_scripts \
db_version \
disables \
disenchant_loot_template \
exploration_basexp \
fishing_loot_template \
game_event \
game_event_creature \
game_event_creature_data \
game_event_gameobject \
game_event_mail \
game_event_quest \
game_graveyard_zone \
game_tele \
game_weather \
gameobject \
gameobject_battleground \
gameobject_involvedrelation \
gameobject_loot_template \
gameobject_questrelation \
gameobject_template \
gossip_menu \
gossip_menu_option \
gossip_texts \
instance_template \
item_enchantment_template \
item_loot_template \
item_required_target \
item_template \
locales_command \
locales_creature \
locales_gameobject \
locales_gossip_menu_option \
locales_item \
locales_npc_text \
locales_page_text \
locales_points_of_interest \
locales_quest \
mail_loot_template \
mangos_string \
npc_text \
npc_trainer \
npc_trainer_template \
npc_vendor \
npc_vendor_template \
page_text \
pet_levelstats \
pet_name_generation \
petcreateinfo_spell \
pickpocketing_loot_template \
player_classlevelstats \
player_levelstats \
player_xp_for_level \
playercreateinfo \
playercreateinfo_action \
playercreateinfo_item \
playercreateinfo_spell \
points_of_interest \
pool_creature \
pool_creature_template \
pool_gameobject \
pool_gameobject_template \
pool_pool \
pool_template \
quest_template \
reference_loot_template \
reputation_reward_rate \
reputation_spillover_template \
reserved_name \
script_binding \
script_texts \
script_waypoint \
skill_fishing_base_level \
skinning_loot_template \
spell_affect \
spell_area \
spell_bonus_data \
spell_chain \
spell_elixir \
spell_facing \
spell_learn_spell \
spell_linked \
spell_pet_auras \
spell_proc_event \
spell_proc_item_enchant \
spell_script_target \
spell_target_position \
spell_threat \
transports \
; do

echo "Dumping ${i}/123 ${TABLE}..."

if ! dump_table "${TABLE}"; then
return 1
fi

let i=i+1

done

}

if [ -z $1 ] ; then
  echo "Usage: $0 [Database] {Dumpdir} "
  exit 1
fi

if [ -z $2 ] ; then
  DUMPDIR=$DDUMPDIR
else
  DUMPDIR=$2
fi

if [ -z $USERNAME ] ; then
  echo -n "User: "
  read USERNAME
fi

if [ -z $PASSWORD ] ; then

echo -n "Password: "

stty -echo
read PASSWORD
stty echo
echo ""
fi


DB=$1

do_dump_zero
