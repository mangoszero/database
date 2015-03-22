--
-- Copyright (C) 2005-2013 MaNGOS <http://getmangos.com/>
-- Copyright (C) 2009-2013 MaNGOSZero <https://github.com/mangoszero>
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

-- plagued bat & frenzied bat down to scale
-- Source: http://www.youtube.com/watch?v=JIPkO0DphWk
-- Source: http://www.youtube.com/watch?v=7VcozSUZc9Y
-- Source: http://www.youtube.com/watch?v=agWfYn0piY8
-- Source: http://www.youtube.com/watch?v=KxITOD-fQ5g
-- Source: http://www.youtube.com/watch?v=PQ88MOZ-gGk
UPDATE `creature_template` SET `scale` = 0.6 WHERE `entry` = 16037;
UPDATE `creature_template` SET `scale` = 0.6 WHERE `entry` = 16036;

-- plague beast waypoints
DELETE FROM `creature_movement` WHERE `id` = 88188;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 1,  2900.62,  -3683.83, 284.001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 17, 2884.27,  -3662.16, 277.412, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 16, 2867.52,  -3655.97, 274.442, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 15, 2884.27,  -3662.16, 277.412, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 14, 2897.48,  -3671.88, 280.394, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 13, 2900.62,  -3683.83, 284.001, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 12, 2894.65,  -3698.18, 285.475, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 11, 2882,     -3708.83, 285.733, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 10, 2865.73,  -3705.73, 284.167, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 9,  2858.94,  -3691.24, 281.145, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 8,  2846.58,  -3686.15, 278.529, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 7,  2827.88,  -3686.89, 275.89,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 6,  2846.58,  -3686.15, 278.529, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 5,  2858.94,  -3691.24, 281.145, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 4,  2865.73,  -3705.73, 284.167, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 3,  2882,     -3708.83, 285.733, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 2,  2894.85,  -3698.01, 285.474, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88188, 18, 2897.48,  -3671.88, 280.394, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `creature_movement` WHERE `id` = 88192;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88192, 1, 2790.74, -3564.99, 251.512,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88192, 11, 2767.95, -3589.93, 256.704, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88192, 10, 2777.6, -3575.9, 253.75,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88192, 9, 2790.98, -3565.05, 251.559,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88192, 8, 2806.23, -3568.65, 252.559,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88192, 7, 2817.8, -3583.1, 254.576,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88192, 6, 2822.72, -3595.13, 257.765,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88192, 5, 2829.62, -3612.2, 259.915,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88192, 4, 2822.72, -3595.13, 257.765,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88192, 3, 2817.8, -3583.1, 254.576,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88192, 2, 2806.23, -3568.65, 252.559,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88192, 12, 2777.6, -3575.9, 253.75,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `creature_movement` WHERE `id` = 88193;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 1,  2857,    -3599.33, 263.679, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 15, 2857,    -3599.33, 263.679, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 14, 2873.12, -3590.24, 267.126, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 13, 2887.85, -3592.76, 270.652, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 12, 2897.19, -3605.39, 273.306, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 11, 2899.38, -3619.34, 275.036, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 10, 2891.76, -3631.64, 274.199, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 9,  2879.47, -3638.18, 273.289, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 8,  2866.48, -3640.01, 271.325, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 7,  2879.47, -3638.18, 273.289, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 6,  2891.76, -3631.64, 274.199, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 5,  2899.38, -3619.34, 275.036, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 4,  2897.19, -3605.39, 273.306, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 3,  2887.85, -3592.76, 270.652, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 2,  2873.12, -3590.24, 267.126, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88193, 16, 2847.41, -3611.5,  261.861, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `creature_movement` WHERE `id` = 88194;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 1,  2723.64, -3604.72, 259.696,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 13, 2736.52, -3591.67, 257.918,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 12, 2743.84, -3597.85, 257.671,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 11, 2752.58, -3595.4,  257.06,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 10, 2755.27, -3585.13, 256.305,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 9,  2757.01, -3575.48, 255.636,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 8,  2755.27, -3585.13, 256.305,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 7,  2752.58, -3595.4,  257.06,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 6,  2743.84, -3597.85, 257.671,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 5,  2736.52, -3591.67, 257.918,    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 4,  2727.22, -3594.06, 258.886,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 3,  2723.64, -3604.72, 259.696,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 2,  2720.89, -3620.15, 260.07,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88194, 14, 2727.22, -3594.06, 258.886,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Added Waypoints for Bony Construct x2
DELETE FROM `creature_movement` WHERE `id` = 88422;
UPDATE `creature` SET `position_x` = 2845.06, `position_y` = -3296.36, `position_z` = 298.124, `orientation` = 5.63452, `movementtype` = 2 WHERE `guid` = 88422;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88422, 1, 2847.82, -3308.78, 298.147, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88422, 2, 2838.8, -3321.94,  298.152, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88422, 3, 2847.82, -3308.78, 298.147, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88422, 4, 2845.06, -3296.36, 298.124, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88422, 5, 2832.53, -3295.22, 298.15,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88422, 6, 2845.06, -3296.36, 298.124, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `creature_movement` WHERE `id` = 88418;
UPDATE `creature` SET `position_x` = 2835.76, `position_y` = -3331.32, `position_z` = 299.364, `orientation` = 4.84961, `movementtype` = 2 WHERE `guid` = 88418;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88418, 1, 2830.41, -3329.09, 304.837, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88418, 2, 2835.76, -3331.32, 299.364, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88418, 3, 2842.91, -3323.56, 298.155, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88418, 4, 2852.52, -3333.61, 298.146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88418, 5, 2854.87, -3350.62, 298.146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88418, 6, 2852.52, -3333.61, 298.146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88418, 7, 2842.91, -3323.56, 298.155, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88418, 8, 2835.76, -3331.32, 299.364, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Noth the plaguebringer path
DELETE FROM `creature_movement` WHERE `id` = 88100;
UPDATE `creature` SET `position_x` = 2671.65, `position_y` = -3489.11, `position_z` = 261.375, `orientation` = 3.89492, `movementtype` = 2 WHERE `guid` = 88100;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88100, 1, 2666.34, -3502.6, 261.29,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88100, 2, 2670.34, -3514.17, 261.278, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88100, 3, 2676.19, -3520.29, 261.262, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88100, 4, 2670.34, -3514.17, 261.278, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88100, 5, 2666.34, -3502.6, 261.29,   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88100, 6, 2671.65, -3489.11, 261.375, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88100, 7, 2676.57, -3484.5, 261.4,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88100, 8, 2671.65, -3489.11, 261.375, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Added death lord into area before razuvious
-- Source: http://www.youtube.com/watch?v=JIPkO0DphWk
-- Source: http://www.youtube.com/watch?v=7VcozSUZc9Y
-- Source: http://www.youtube.com/watch?v=agWfYn0piY8
-- Source: http://www.youtube.com/watch?v=KxITOD-fQ5g
-- Source: http://www.youtube.com/watch?v=PQ88MOZ-gGk
DELETE FROM `creature` WHERE `guid` = 154229;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154229, 16861, 533, 0, 1268, 2931.33, -3190.24, 273.371, 3.1229, 25, 0, 0, 113175, 12430, 0, 0);

-- Frenzied bat add
-- Plagued bat relocate and add mutated grub move/del
-- Source: http://www.wowcr.net/videos/vid08-naxxramas/
-- Source: http://www.youtube.com/watch?v=JIPkO0DphWk
-- Source: http://www.youtube.com/watch?v=7VcozSUZc9Y
-- Source: http://www.youtube.com/watch?v=agWfYn0piY8
-- Source: http://www.youtube.com/watch?v=KxITOD-fQ5g
-- Source: http://www.youtube.com/watch?v=PQ88MOZ-gGk
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2846.37, `position_y` = -3629.32, `position_z` = 263.927, `orientation` = 0.663225, `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88187;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2868.29, `position_y` = -3643.7,  `position_z` = 272.456, `orientation` = 6.0912,   `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88186;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2895.22, `position_y` = -3581.66, `position_z` = 272.621, `orientation` = 2.93215,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88185;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2908.21, `position_y` = -3598.82, `position_z` = 275.449, `orientation` = 0.20944,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88184;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2910.16, `position_y` = -3581.52, `position_z` = 274.212, `orientation` = 2.82743,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88183;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2749.98, `position_y` = -3572.63, `position_z` = 255.623, `orientation` = 0.942478, `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88182;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2764.99, `position_y` = -3540.81, `position_z` = 253.575, `orientation` = 5.0091,   `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88181;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2799.55, `position_y` = -3610.14, `position_z` = 256.026, `orientation` = 1.0821,   `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88180;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2799.82, `position_y` = -3622.71, `position_z` = 256.142, `orientation` = 5.51524,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88179;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2826.9,  `position_y` = -3625.57, `position_z` = 260.106, `orientation` = 5.7321,   `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88178;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2750.46, `position_y` = -3613.72, `position_z` = 256.717, `orientation` = 3.26377,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88177;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2721.05, `position_y` = -3615.26, `position_z` = 260.121, `orientation` = 4.24115,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88176;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2766.36, `position_y` = -3610.83, `position_z` = 255.69,  `orientation` = 1.95477,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88175;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2672.38, `position_y` = -3626.03, `position_z` = 266.216, `orientation` = 0.645772, `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88174;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2690.14, `position_y` = -3610.98, `position_z` = 262.288, `orientation` = 4.81711,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88173;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2659.54, `position_y` = -3605.86, `position_z` = 262.47,  `orientation` = 0.663225, `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88172;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2677.9,  `position_y` = -3596.35, `position_z` = 261.582, `orientation` = 2.80998,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88171;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2816.25, `position_y` = -3582.72, `position_z` = 254.552, `orientation` = 5.30591,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88170;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2816.62, `position_y` = -3573.75, `position_z` = 253.326, `orientation` = 5.99961,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88169;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2833.93, `position_y` = -3555.91, `position_z` = 253.269, `orientation` = 4.08407,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88168;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2705.66, `position_y` = -3572.01, `position_z` = 261.494, `orientation` = 5.67232,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88167;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2698.5,  `position_y` = -3585.11, `position_z` = 260.696, `orientation` = 2.62,     `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88166;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2719.04, `position_y` = -3576.17, `position_z` = 260.124, `orientation` = 3.97935,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88165;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2696.64, `position_y` = -3599.3,  `position_z` = 261.22,  `orientation` = 5.35413,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88164;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2893.91, `position_y` = -3706.73, `position_z` = 286.163, `orientation` = 4.76475,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88163;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2914.51, `position_y` = -3690.77, `position_z` = 286.372, `orientation` = 2.77507,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88162;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2899.61, `position_y` = -3693.08, `position_z` = 285.491, `orientation` = 2.54818,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88161;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2893.05, `position_y` = -3652.01, `position_z` = 276.695, `orientation` = 1.94322,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88160;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2887.21, `position_y` = -3633.74, `position_z` = 273.876, `orientation` = 0.750492, `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88159;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2838.08, `position_y` = -3585.05, `position_z` = 256.51,  `orientation` = 1.6057,   `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88158;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2849.72, `position_y` = -3598.39, `position_z` = 262.169, `orientation` = 5.81195,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88157;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2860.91, `position_y` = -3585.21, `position_z` = 262.448, `orientation` = 1.18682,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88142;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2851.45, `position_y` = -3717.97, `position_z` = 286.667, `orientation` = 2.80998,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88141;
UPDATE `creature` SET `id` = 16036, `modelid` = 7896, `position_x` = 2851.08, `position_y` = -3693.53, `position_z` = 281.254, `orientation` = 4.01426,  `spawndist` = 8, `curhealth` = 10283, `curmana` = 12000, `MovementType` = 1 WHERE `guid` = 88140;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2855.76, `position_y` = -3654.55, `position_z` = 272.829, `orientation` = 3.05433,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88139;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2857.25, `position_y` = -3628.22, `position_z` = 266.402, `orientation` = 4.7865,   `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88138;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2865.59, `position_y` = -3666.23, `position_z` = 276.285, `orientation` = 0.506145, `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88137;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2846.03, `position_y` = -3673.73, `position_z` = 275.515, `orientation` = 6.21337,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88136;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2884.6,  `position_y` = -3610.1,  `position_z` = 270.105, `orientation` = 1.4284,   `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88135;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2894.74, `position_y` = -3608.56, `position_z` = 272.834, `orientation` = 2.2864,   `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88134;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2887.77, `position_y` = -3591.83, `position_z` = 270.716, `orientation` = 4.81711,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88133;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2759.66, `position_y` = -3575.94, `position_z` = 255.715, `orientation` = 4.08407,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88132;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2753.11, `position_y` = -3554.85, `position_z` = 255.363, `orientation` = 3.89208,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88131;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2773.7,  `position_y` = -3570.05, `position_z` = 253.263, `orientation` = 4.97419,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88130;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2773.89, `position_y` = -3553.93, `position_z` = 251.001, `orientation` = 1.65806,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88129;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2804.55, `position_y` = -3590.23, `position_z` = 255.311, `orientation` = 2.30383,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88128;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2820.91, `position_y` = -3611.12, `position_z` = 259.015, `orientation` = 3.45575,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88127;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2812.39, `position_y` = -3601.02, `position_z` = 258.005, `orientation` = 4.18879,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88126;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2756.84, `position_y` = -3593.13, `position_z` = 257.109, `orientation` = 0.890118, `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88125;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2746.83, `position_y` = -3596.91, `position_z` = 257.529, `orientation` = 3.61283,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88124;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2735.01, `position_y` = -3608.37, `position_z` = 258.858, `orientation` = 4.03171,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88123;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2679.47, `position_y` = -3611.75, `position_z` = 262.696, `orientation` = 4.50295,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88122;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2696.57, `position_y` = -3624.93, `position_z` = 262.695, `orientation` = 2.44346,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88121;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2798.75, `position_y` = -3551.8,  `position_z` = 250.509, `orientation` = 4.21708,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88120;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2796.43, `position_y` = -3568.79, `position_z` = 252.207, `orientation` = 4.89914,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88119;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2827.71, `position_y` = -3545.16, `position_z` = 253.835, `orientation` = 4.55531,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88118;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2726.71, `position_y` = -3594.92, `position_z` = 258.971, `orientation` = 4.00729,  `spawndist` = 8,`curhealth` = 10410, `curmana` = 0, `MovementType` = 1 WHERE `guid` = 88117;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2839.38, `position_y` = -3613.28, `position_z` = 260.343, `orientation` = 0.899918, `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88156;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2859.83, `position_y` = -3683.38, `position_z` = 279.276, `orientation` = 5.84685,  `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88155;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2841.54, `position_y` = -3686.11, `position_z` = 278.137, `orientation` = 1.09956,  `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88154;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2899.99, `position_y` = -3685.23, `position_z` = 284.385, `orientation` = 5.61996,  `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88153;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2885.92, `position_y` = -3667.93, `position_z` = 278.941, `orientation` = 2.00713,  `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88152;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2734.75, `position_y` = -3603.47, `position_z` = 258.694, `orientation` = 1.98968,  `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88151;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2712.69, `position_y` = -3607.78, `position_z` = 260.632, `orientation` = 5.14872,  `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88150;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2834.19, `position_y` = -3590.74, `position_z` = 257.507, `orientation` = 3.61283,  `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88149;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2763.86, `position_y` = -3577.34, `position_z` = 255.752, `orientation` = 0.802851, `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88148;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2785.11, `position_y` = -3584.64, `position_z` = 253.637, `orientation` = 2.05949,  `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88147;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2678.69, `position_y` = -3570.48, `position_z` = 261.942, `orientation` = 5.88176,  `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88146;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2689.72, `position_y` = -3579.8,  `position_z` = 261.325, `orientation` = 4.55531,  `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88145;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2877.03, `position_y` = -3584.53, `position_z` = 267.786, `orientation` = 2.68781,  `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88144;
UPDATE `creature` SET `id` = 16297, `modelid` = 7898, `position_x` = 2874.13, `position_y` = -3606.33, `position_z` = 267.582, `orientation` = 1.58825,  `curhealth` = 24843, `curmana` = 12000 WHERE `guid` =88143;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2713.67, `position_y` = -3599.83, `position_z` = 260.169, `orientation` = 5.06927,  `spawndist` = 8, `curhealth` = 10410, `MovementType` = 1 WHERE `guid` = 88200;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2882.52, `position_y` = -3683.1,  `position_z` = 281.918, `orientation` = 4.06662,  `spawndist` = 8, `curhealth` = 10410, `MovementType` = 1 WHERE `guid` = 88199;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2898.53, `position_y` = -3677.43, `position_z` = 281.721, `orientation` = 0.663225, `spawndist` = 8, `curhealth` = 10410, `MovementType` = 1 WHERE `guid` = 88198;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2907.45, `position_y` = -3716.59, `position_z` = 284.845, `orientation` = 0.506145, `spawndist` = 8, `curhealth` = 10410, `MovementType` = 1 WHERE `guid` = 88197;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2882.89, `position_y` = -3666.12, `position_z` = 278.247, `orientation` = 5.75694,  `spawndist` = 8, `curhealth` = 10410, `MovementType` = 1 WHERE `guid` = 88196;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2903.44, `position_y` = -3625.36, `position_z` = 276.342, `orientation` = 4.99541,  `spawndist` = 8, `curhealth` = 10410, `MovementType` = 1 WHERE `guid` = 88195;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2913.06, `position_y` = -3663.37, `position_z` = 278.465, `orientation` = 3.12807,  `spawndist` = 8, `curhealth` = 10410, `MovementType` = 1 WHERE `guid` = 88191;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2912.88, `position_y` = -3643.42, `position_z` = 276.294, `orientation` = 5.86337,  `spawndist` = 8, `curhealth` = 10410, `MovementType` = 1 WHERE `guid` = 88190;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x` = 2862.88, `position_y` = -3597.03, `position_z` = 264.963, `orientation` = 1.01229,  `spawndist` = 8, `curhealth` = 10410, `MovementType` = 1 WHERE `guid` = 88189;
UPDATE `creature` SET `position_x` = 2727.22,`position_y` = -3594.06, `position_z` = 258.886, `orientation` = 2.73, `movementtype` = 2  WHERE `guid` = 88194;
UPDATE `creature` SET `position_x` = 2847.41,`position_y` = -3611.5,  `position_z` = 261.861, `orientation` = 2.78, `movementtype` = 2  WHERE `guid` = 88193;
UPDATE `creature` SET `position_x` = 2777.6, `position_y` = -3575.9,  `position_z` = 253.75,  `orientation` = 3.19, `movementtype` = 2  WHERE `guid` = 88192;
UPDATE `creature` SET `position_x` = 2897.48,`position_y` = -3671.88, `position_z` = 280.394, `orientation` = 1.3, `movementtype` = 2   WHERE `guid` = 88188;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x`=2846.79, `position_y`= -3576.01, `position_z`= 256.709,  `orientation`=4.01426,   `spawndist` = 8, `curhealth`  = 10410, `MovementType` = 1 WHERE `guid`=88201;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x`=2841.3,  `position_y`=-3601.09,  `position_z`=260.275,   `orientation`=3.00807,   `spawndist` = 8, `curhealth` = 10410, `MovementType` = 1 WHERE `guid`=88202;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x`=2862.95, `position_y`= -3702.28, `position_z`=  283.375, `orientation`=4.93928,   `spawndist` = 8, `curhealth` = 10410, `MovementType` = 1 WHERE `guid`=88203;
UPDATE `creature` SET `id` = 16037, `modelid` = 1954, `position_x`=2869.8,  `position_y`=-3718.72,  `position_z`=284.162,   `orientation`=0.139626,  `spawndist` = 8, `curhealth` = 10410, `MovementType` = 1  WHERE `guid`=88204;
UPDATE `creature` SET `position_x`=2814.282, `position_y`=-3155.784, `position_z`=298.146, `orientation`=1.536 WHERE `guid`=88438;
UPDATE `creature` SET `position_x`=2858.524, `position_y`=-3187.774, `position_z`=298.152, `orientation`=6.189 WHERE `guid`=88437;
UPDATE `creature` SET `position_x`=2829.239, `position_y`=-3208.360, `position_z`=298.254, `orientation`=4.000 WHERE `guid`=88434;
UPDATE `creature` SET `position_x`=2857.766, `position_y`=-3180.223, `position_z`=298.152, `orientation`=0.000 WHERE `guid`=88436;
UPDATE `creature` SET `position_x`=2836.868, `position_y`=-3213.742, `position_z`=298.257, `orientation`=4.211 WHERE `guid`=88435;
UPDATE `creature` SET `position_x`=2834.102, `position_y`=-3205.778, `position_z`=298.236, `orientation`=4.373 WHERE `guid`=88431;
UPDATE `creature` SET `position_x`=2853.615, `position_y`=-3185.354, `position_z`=298.150, `orientation`=0.127 WHERE `guid`=88432;
UPDATE `creature` SET `position_x`=2825.402, `position_y`=-3156.504, `position_z`=298.146, `orientation`=1.479 WHERE `guid`=88439;
UPDATE `creature` SET `position_x`=2819.952, `position_y`=-3161.577, `position_z`=298.145, `orientation`=1.620 WHERE `guid`=88433;

-- These here are new guids, dont know what you wish to do with them guid wise.
DELETE FROM `creature` WHERE `guid` IN (154269,154270);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154269, 16037, 533, 1954, 0, 2876.12,  -3701.31,  284.433,  0.872665, 3600, 8, 0, 10410, 0, 0, 1);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154270, 16037, 533, 1954, 0, 2881.45,  -3723.31,  284.623,  0.663225, 3600, 8, 0, 10410, 0, 0, 1);

-- Again trinity sniffs and comparison on pathing. Not all changed
-- bats in plague wing on stairs statue when ooc turn rock
-- Source: http://www.youtube.com/watch?v=JIPkO0DphWk
-- Source: http://www.youtube.com/watch?v=7VcozSUZc9Y
-- Source: http://www.youtube.com/watch?v=agWfYn0piY8
-- Source: http://www.youtube.com/watch?v=KxITOD-fQ5g
-- Source: http://www.youtube.com/watch?v=PQ88MOZ-gGk
DELETE FROM `creature_addon` WHERE `guid` IN (88092,88093,88096,88097,88098,88099);
INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES
(88092, 0, 9, 1, 0, 0, 0, NULL);
INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES
(88093, 0, 9, 1, 0, 0, 0, NULL);
INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES
(88096, 0, 9, 1, 0, 0, 0, NULL);
INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES
(88097, 0, 9, 1, 0, 0, 0, NULL);
INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES
(88098, 0, 9, 1, 0, 0, 0, NULL);
INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES
(88099, 0, 9, 1, 0, 0, 0, NULL);

-- Added waypoints for 2 Stoneskin Gargoyle
DELETE FROM `creature_movement` WHERE `id` = 88095;
UPDATE `creature` SET `position_x` = 2864.62, `position_y` = -3468.97, `position_z` = 297.87, `orientation` = 3.73394, `movementtype` = 2 WHERE `guid` = 88095;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88095, 1,  2871.25, -3500.7,  297.619, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88095, 9,  2871.25, -3500.7,  297.619, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88095, 8,  2888.54, -3522.79, 297.615, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88095, 7,  2905.12, -3519.57, 297.863, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88095, 6,  2921.4,  -3509.92, 297.482, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88095, 5,  2944.05, -3494.68, 297.631, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88095, 4,  2921.4,  -3509.92, 297.482, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88095, 3,  2905.12, -3519.57, 297.863, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88095, 2,  2888.54, -3522.79, 297.615, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88095, 10, 2864.62, -3468.97, 297.87,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `creature_movement` WHERE `id` = 88094;
UPDATE `creature` SET `position_x` = 2854.79, `position_y` = -3489.83, `position_z` = 297.886, `orientation` = 6.28235, `movementtype` = 2 WHERE `guid` = 88094;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88094, 1,  2872.72, -3489.73, 297.62,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88094, 9,  2836.62, -3489.82, 297.864, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88094, 8,  2809.43, -3490.46, 285.972, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88094, 7,  2775.24, -3489.8,  274.027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88094, 6,  2728.6,  -3490.62, 262.131, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88094, 5,  2775.24, -3489.8,  274.027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88094, 4,  2809.43, -3490.46, 285.972, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88094, 3,  2836.62, -3489.82, 297.864, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88094, 2,  2855.09, -3489.83, 297.883, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88094, 10, 2854.79, -3489.83, 297.886, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Changed Name of Stitched Giant to Stitched Spewer.
-- (Stitched giant is the wrath name,also uses a larger different model)
-- Source: http://www.wowwiki.com/Stitched_Spewer
-- Source: http://wowd.org/creatures/16025.html]http://wowd.org/creatures/16025.html
UPDATE `creature_template` SET `name` = 'Stitched Spewer' WHERE `entry` = 16025;

-- Changed Scale on Naxxramas Combat Dummy
-- Source: http://www.youtube.com/watch?v=JIPkO0DphWk
-- Source: http://www.youtube.com/watch?v=7VcozSUZc9Y
-- Source: http://www.youtube.com/watch?v=agWfYn0piY8
-- Source: http://www.youtube.com/watch?v=KxITOD-fQ5g
-- Source: http://www.youtube.com/watch?v=PQ88MOZ-gGk
UPDATE `creature_template` SET `scale` = 1.4 WHERE `entry` = 16211;

-- Fix Death knight understudy locations
-- Source: http://www.youtube.com/watch?v=JIPkO0DphWk
-- Source: http://www.youtube.com/watch?v=7VcozSUZc9Y
-- Source: http://www.youtube.com/watch?v=agWfYn0piY8
-- Source: http://www.youtube.com/watch?v=KxITOD-fQ5g
-- Source: http://www.youtube.com/watch?v=PQ88MOZ-gGk
UPDATE `creature` SET `position_x` = 2758.28, `position_y` = -3111.99 WHERE `guid` = 88464;
UPDATE `creature` SET `position_x` = 2778.56, `position_y` = -3113.74 WHERE `guid` = 88463;
UPDATE `creature` SET `position_x` = 2782.45, `position_y` = -3088.03 WHERE `guid` = 88462;
UPDATE `creature` SET `position_x` = 2762.05, `position_y` = -3085.6 WHERE `guid` = 88461;

-- Added Naxxramas Combat Dummy Locations
-- Source: http://www.youtube.com/watch?v=JIPkO0DphWk
-- Source: http://www.youtube.com/watch?v=7VcozSUZc9Y
-- Source: http://www.youtube.com/watch?v=agWfYn0piY8
-- Source: http://www.youtube.com/watch?v=KxITOD-fQ5g
-- Source: http://www.youtube.com/watch?v=PQ88MOZ-gGk
DELETE FROM `creature` WHERE `id` = 16211;
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154200, 16211, 533, 16074, 0, 2859.65, -3180.16, 298.237, 3.24631, 3600, 0, 0, 860, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154201, 16211, 533, 16074, 0, 2851.85, -3162.62, 298.236, 4.08407, 3600, 0, 0, 860, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154202, 16211, 533, 16074, 0, 2827.83, -3209.98, 298.344, 0.994838, 3600, 0, 0, 860, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154203, 16211, 533, 16074, 0, 2844.48, -3157.53, 298.233, 4.2237, 3600, 0, 0, 860, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154204, 16211, 533, 16074, 0, 2825.51, -3154.79, 298.229, 4.5204, 3600, 0, 0, 860, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154205, 16211, 533, 16074, 0, 2760.84, -3082.67, 267.768, 5.25344, 3600, 0, 0, 860, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154206, 16211, 533, 16074, 0, 2860.08, -3187.86, 298.234, 3.08923, 3600, 0, 0, 860, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154207, 16211, 533, 16074, 0, 2779.97, -3115.92, 267.768, 2.16421, 3600, 0, 0, 860, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154208, 16211, 533, 16074, 0, 2814.28, -3154.13, 298.229, 4.76475, 3600, 0, 0, 860, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154209, 16211, 533, 16074, 0, 2756.07, -3113.2, 267.768, 0.890118, 3600, 0, 0, 860, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154210, 16211, 533, 16074, 0, 2835.89, -3215.61, 298.344, 1.01229, 3600, 0, 0, 860, 0, 0, 0);
INSERT INTO `creature` (`guid`, `id`, `map`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(154211, 16211, 533, 16074, 0, 2784.04, -3086.38, 267.768, 3.92699, 3600, 0, 0, 860, 0, 0, 0);

-- Rename Death Knight to Deathknight
-- Source: http://www.youtube.com/watch?v=JIPkO0DphWk
-- Source: http://www.youtube.com/watch?v=7VcozSUZc9Y
-- Source: http://www.youtube.com/watch?v=agWfYn0piY8
-- Source: http://www.youtube.com/watch?v=KxITOD-fQ5g
-- Source: http://www.youtube.com/watch?v=PQ88MOZ-gGk
UPDATE `creature_template` SET `name`='Deathknight Captain' WHERE `entry`=16145;
UPDATE `creature_template` SET `name`='Deathknight' WHERE `entry`=16146;
UPDATE `creature_template` SET `name`='Risen Deathknight' WHERE `entry`=16154;
UPDATE `creature_template` SET `name`='Deathknight Cavalier' WHERE `entry`=16163;
UPDATE `creature_template` SET `name`='Deathknight Understudy' WHERE `entry`=16803;

-- Added Pathing for Skeletal Smith as well as blacksmith emotes and positions
-- Source: http://www.youtube.com/watch?v=JIPkO0DphWk
-- Source: http://www.youtube.com/watch?v=7VcozSUZc9Y
-- Source: http://www.youtube.com/watch?v=agWfYn0piY8
-- Source: http://www.youtube.com/watch?v=KxITOD-fQ5g
-- Source: http://www.youtube.com/watch?v=PQ88MOZ-gGk
DELETE FROM `creature_addon` WHERE `guid` IN (88408,88409);
INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES
(88408, 0, 0, 1, 0, 173, 0, NULL);
INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `b2_0_sheath`, `b2_1_flags`, `emote`, `moveflags`, `auras`) VALUES
(88409, 0, 0, 1, 0, 173, 0, NULL);


UPDATE `creature` SET `position_x` = 2882.14, `position_y` = -3275.98, `position_z` = 298.141, `orientation` = 3.75233, `movementtype` = 2 WHERE `guid` = 88411;
UPDATE `creature` SET `position_x` = 2910.94, `position_y` = -3290.13, `position_z` = 298.547, `orientation` = 2.43248, `movementtype` = 2 WHERE `guid` = 88410;
UPDATE `creature` SET `position_x` = 2920.97, `position_y` = -3290.25, `position_z` = 298.229, `orientation` = 0.820305 WHERE `guid` = 88409;
UPDATE `creature` SET `position_x` = 2908.99, `position_y` = -3276.91, `position_z` = 298.229, `orientation` = 1.58825 WHERE `guid` = 88408;


DELETE FROM `creature_movement` WHERE `id` = 88410;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88410, 1, 2902.24, -3293.14, 298.547, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88410, 2, 2899.26, -3299.75, 298.146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88410, 3, 2902.87, -3306.91, 298.146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88410, 4, 2911.01, -3309.07, 298.146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88410, 5, 2920.52, -3308.82, 298.146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88410, 6, 2920.32, -3301.1,  298.547, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88410, 7, 2915.13, -3296.64, 298.547, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88410, 8, 2910.94, -3290.13, 298.547, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `creature_movement` WHERE `id` = 88411;
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88411, 1, 2899.5,  -3263.09, 298.146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88411, 2, 2899.09, -3280.57, 298.547, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88411, 3, 2902.46, -3288.92, 298.547, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88411, 4, 2889.02, -3298.33, 298.146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88411, 5, 2879.74, -3293.5,  298.146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature_movement` (`id`, `point`, `position_x`, `position_y`, `position_z`, `waittime`, `script_id`, `textid1`, `textid2`, `textid3`, `textid4`, `textid5`, `emote`, `spell`, `wpguid`, `orientation`, `model1`, `model2`) VALUES
(88411, 6, 2882.14, -3275.98, 298.141, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Added Weapons for Plagued Warrior
-- Source: http://www.youtube.com/watch?v=cxch-KEATeQ
-- Source: http://www.wowcr.net/videos/vid08-naxxramas/
UPDATE `creature_template` SET `equipment_id` = 150 WHERE `entry` = 16982;

-- Added Weapons for Plagued Warrior
-- Source: http://www.youtube.com/watch?v=cxch-KEATeQ
-- Source: http://www.wowcr.net/videos/vid08-naxxramas/
UPDATE `creature_template` SET `equipment_id` = 1872 WHERE `entry` = 16984;

-- Added Weapons for Plagued Champion
-- Source: http://www.youtube.com/watch?v=cxch-KEATeQ
-- Source: http://www.wowcr.net/videos/vid08-naxxramas/
UPDATE `creature_template` SET `equipment_id` = 149 WHERE `entry` = 16983;

-- Added Weapons for Plagued Guardian
-- Source: http://www.wowcr.net/videos/vid08-naxxramas/
-- Source: http://www.youtube.com/watch?v=cxch-KEATeQ
UPDATE `creature_template` SET `equipment_id` = 788 WHERE `entry` = 16981;

-- Added Correct Weapon and Equip Template Lady Blaumeux
-- Source: http://www.wowhead.com/npc=16065#screenshots
-- Source: http://www.wowwiki.com/Four_Horsemen_%28original%29?file=FourHorsemen.jpg
-- Source: http://evowde.lima-city.de/forum/tactics/www.wow-tactics.de/gfx/naxx/ss-reiter.jpg
DELETE FROM `creature_equip_template_raw` WHERE `entry` = 2406;
INSERT INTO `creature_equip_template_raw` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(2406, 35258, 0, 0, 13639426, 0, 0, 3, 3, 0);
UPDATE `creature_template` SET `equipment_id` = 2406 WHERE `entry` = 16065;

-- Added Correct Weapon and Equip Template for Sir Zeliek
-- Source: http://www.wowhead.com/npc=16063#screenshots
-- Source: http://www.wowwiki.com/Four_Horsemen_%28original%29?file=FourHorsemen.jpg
-- Source: http://evowde.lima-city.de/forum/tactics/www.wow-tactics.de/gfx/naxx/ss-reiter.jpg
DELETE FROM `creature_equip_template_raw` WHERE `entry` = 2405;
INSERT INTO `creature_equip_template_raw` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(2405, 35710, 0, 0, 13639426, 0, 0, 3, 3, 0);
UPDATE `creature_template` SET `equipment_id` = 2405 WHERE `entry` = 16063;

-- Added Weapons for Death Lord
-- Source: http://www.youtube.com/watch?v=7VcozSUZc9Y
-- Source: http://www.youtube.com/watch?v=KxITOD-fQ5g
-- Source: http://www.youtube.com/watch?v=PQ88MOZ-gGk
UPDATE `creature_template` SET `equipment_id` = 1268 WHERE `entry` = 16861;

-- Added Weapons for Unrelenting rider
-- Source: http://www.youtube.com/watch?v=FN2QtHx8_xw
UPDATE `creature_template` SET `equipment_id` = 1232 WHERE `entry` = 16126;

-- Added Weapons for Spectral Rider
-- Source: http://www.youtube.com/watch?v=FN2QtHx8_xw
UPDATE `creature_template` SET `equipment_id` = 1232 WHERE `entry` = 16150;

-- Added Weapons for Deathknight Vindicator
-- Source: http://www.wowhead.com/npc=16451#screenshots
UPDATE `creature_template` SET `equipment_id` = 1232 WHERE `entry` = 16451;

-- Added Weapons for Necropolis Acolyte
-- Source: http://www.wowhead.com/npc=16368#screenshots
UPDATE `creature_template` SET `equipment_id` = 954 WHERE `entry` = 16368;

-- Added Weapons for Necro Knight Guardian
-- Source: http://www.wowhead.com/npc=16452#screenshots
UPDATE `creature_template` SET `equipment_id` = 1451 WHERE `entry` = 16452;

-- Added Weapons and  Equip template for Necro Knight
-- Source: http://www.wowhead.com/npc=16165#screenshots
DELETE FROM `creature_equip_template_raw` WHERE `entry` = 2404;
INSERT INTO `creature_equip_template_raw` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(2404, 35712, 0, 0, 218171138, 0, 0, 3, 0, 0);
UPDATE `creature_template` SET `equipment_id` = 2404 WHERE `entry` = 16165;

-- Added Weapons and  Equip template for Thane Kor'thazz
-- Source: http://www.wowhead.com/npc=16064#screenshots
-- Source: http://evowde.lima-city.de/forum/tactics/www.wow-tactics.de/gfx/naxx/ss-reiter.jpg
-- Source: http://www.wowwiki.com/Four_Horsemen_%28original%29?file=FourHorsemen.jpg
DELETE FROM `creature_equip_template_raw` WHERE `entry` = 2403;
INSERT INTO `creature_equip_template_raw` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(2403, 35129, 0, 0, 218171138, 0, 0, 3, 0, 0);
UPDATE `creature_template` SET `equipment_id` = 2403 WHERE `entry` = 16064;

-- Added Weapons and  Equip template for Spectral/Unrelenting Deathknight
-- Source: http://www.youtube.com/watch?v=FN2QtHx8_xw
DELETE FROM `creature_equip_template_raw` WHERE `entry` = 2402;
INSERT INTO `creature_equip_template_raw` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(2402, 16128, 30993, 0, 218169346, 234948100, 0, 3, 4, 0);
UPDATE `creature_template` SET `equipment_id` = 2402 WHERE `entry` = 16125;
UPDATE `creature_template` SET `equipment_id` = 2402 WHERE `entry` = 16148;

-- Added Weapons to Npc Unholy Staff.
-- Source:http://www.wowhead.com/npc=16215#screenshots
-- Source: http://pacifistguild.org/index.cgi?start=24
UPDATE `creature_template` SET `equipment_id` = 1205 WHERE `entry` = 16215;

-- Added Weapons  and equip template for Npc Unholy Swords.
-- Source: http://www.wowhead.com/npc=16216#screenshots
DELETE FROM `creature_equip_template_raw` WHERE `entry` = 2401;
INSERT INTO `creature_equip_template_raw` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(2401, 23798, 23798, 0, 13639426, 13639426, 0, 3, 3, 0);
UPDATE `creature_template` SET `equipment_id` = 2401 WHERE `entry` = 16216;

-- Added Weapons and Equip Template for Unholy Axe
-- Source: http://www.wowhead.com/npc=16194#screenshots
-- Source: http://pacifistguild.org/index.cgi?start=24
DELETE FROM `creature_equip_template_raw` WHERE `entry` = 2400;
INSERT INTO `creature_equip_template_raw` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(2400, 21238, 21238, 0, 13639426, 13639426, 0, 3, 3, 0);
UPDATE `creature_template` SET `equipment_id` = 2400 WHERE `entry` = 16194;

-- Add gossip to npc (3144) for quest (4941)
SET @CONDITION_ENTRY                          = 718;
SET @CONDITION_QUESTTAKEN                     = 9;
SET @QUEST_EITRIGGS_WISDOM                    = 4941;
SET @NPC_EITRIGG                              = 3144;
SET @GOSSIP_MENU_ID                           = 2901;

UPDATE `creature_template` SET `gossip_menu_id`=@GOSSIP_MENU_ID WHERE `entry`=@NPC_EITRIGG;

DELETE FROM `conditions` WHERE `condition_entry`=@CONDITION_ENTRY;
INSERT INTO `conditions` (`condition_entry`, `type`, `value1`)
VALUES
(@CONDITION_ENTRY, @CONDITION_QUESTTAKEN, @QUEST_EITRIGGS_WISDOM);

DELETE FROM `gossip_menu_option` WHERE `menu_id`
BETWEEN @GOSSIP_MENU_ID AND @GOSSIP_MENU_ID+7;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_script_id`,`condition_id`) VALUES
(@GOSSIP_MENU_ID, 0, 0, 'Hello, Eitrigg. I bring news from Blackrock Spire.', 1, 1, @GOSSIP_MENU_ID+1, 0, @CONDITION_ENTRY),
(@GOSSIP_MENU_ID+1, 0, 0, 'There is only one Warchief, Eitrigg!', 1, 1, @GOSSIP_MENU_ID+2, 0, 0),
(@GOSSIP_MENU_ID+2, 0, 0, 'What do you mean?', 1, 1, @GOSSIP_MENU_ID+3, 0, 0),
(@GOSSIP_MENU_ID+3, 0, 0, 'Hearthglen? But...', 1, 1, @GOSSIP_MENU_ID+4, 0, 0),
(@GOSSIP_MENU_ID+4, 0, 0, 'I will take you up on that offer, Eitrigg.', 1, 1, @GOSSIP_MENU_ID+5, 0, 0),
(@GOSSIP_MENU_ID+5, 0, 0, 'Ah, so that is how they pushed the Dark Iron to the lower parts of the Spire.', 1, 1, @GOSSIP_MENU_ID+6, 0, 0),
(@GOSSIP_MENU_ID+6, 0, 0, 'Perhaps there exists a way?', 1, 1, @GOSSIP_MENU_ID+7, 0, 0),
(@GOSSIP_MENU_ID+7, 0, 0, 'As you wish, Eitrigg.', 1, 1, -1, @GOSSIP_MENU_ID+7, 0);

DELETE FROM `gossip_menu` WHERE `entry`
IN (@GOSSIP_MENU_ID, @GOSSIP_MENU_ID+1, @GOSSIP_MENU_ID+2, @GOSSIP_MENU_ID+3, @GOSSIP_MENU_ID+4, @GOSSIP_MENU_ID+5, @GOSSIP_MENU_ID+6, @GOSSIP_MENU_ID+7);
INSERT INTO `gossip_menu` (`entry`, `text_id`) VALUES
(@GOSSIP_MENU_ID, 3573),
(@GOSSIP_MENU_ID+1, 3574),
(@GOSSIP_MENU_ID+2, 3575),
(@GOSSIP_MENU_ID+3, 3576),
(@GOSSIP_MENU_ID+4, 3577),
(@GOSSIP_MENU_ID+5, 3578),
(@GOSSIP_MENU_ID+6, 3579),
(@GOSSIP_MENU_ID+7, 3580);

DELETE FROM `dbscripts_on_gossip` WHERE `id`=@GOSSIP_MENU_ID+7;
INSERT INTO `dbscripts_on_gossip` (`id`, `delay`, `command`, `datalong`, `datalong2`, `buddy_entry`, `search_radius`, `data_flags`, `dataint`, `dataint2`, `dataint3`, `dataint4`, `x`, `y`, `z`, `o`, `comments`)
VALUES
(@GOSSIP_MENU_ID+7, 0, 7, 4941, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Quest complete 4941');

-- Add condition to Love is in the Air vendor items
SET @CONDITION_ENTRY                         = 717;
SET @CONDITION_ACTIVE_EVENT                  = 12;
SET @LOVE_IS_IN_THE_AIR                      = 8;
SET @LOVE_TOKEN                              = 21815;
SET @PERFUME_BOTTLE                          = 21829;
SET @COLOGNE_BOTTLE                          = 21833;

DELETE FROM `conditions`
WHERE `condition_entry`=@CONDITION_ENTRY;

INSERT INTO `conditions` (`condition_entry`, `type`, `value1`) VALUES
(@CONDITION_ENTRY, @CONDITION_ACTIVE_EVENT, @LOVE_IS_IN_THE_AIR);

UPDATE `npc_vendor` SET `condition_id`=@CONDITION_ENTRY
WHERE `item` IN (@LOVE_TOKEN, @PERFUME_BOTTLE, @COLOGNE_BOTTLE);

-- Correct Vile Familiars Questline Warlock and no Warlock Questline
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 792;
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 350 WHERE `entry` = 1485;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 1499;
UPDATE `quest_template` SET `MinLevel` = 1 WHERE `entry` = 1499;

-- correct all reputation values for durotar
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 784;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 784;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 786;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 786;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 788;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 788;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 789;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 789;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 790;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 790;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 791;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 791;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 792;
UPDATE `quest_template` SET `RewRepValue2` = 150 WHERE `entry` = 792;
UPDATE `quest_template` SET `RewRepValue1` = 200 WHERE `entry` = 794;
UPDATE `quest_template` SET `RewRepValue2` = 200 WHERE `entry` = 794;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 805;
UPDATE `quest_template` SET `RewRepValue2` = 50 WHERE `entry` = 805;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 806;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 806;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 808;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 808;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 809;
UPDATE `quest_template` SET `RewRepValue2` = 50 WHERE `entry` = 809;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 812;
UPDATE `quest_template` SET `RewRepValue2` = 150 WHERE `entry` = 812;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 815;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 815;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 816;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 816;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 817;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 817;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 818;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 818;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 823;
UPDATE `quest_template` SET `RewRepValue2` = 50 WHERE `entry` = 823;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 825;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 825;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 826;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 826;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 827;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 827;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 829;
UPDATE `quest_template` SET `RewRepValue2` = 50 WHERE `entry` = 829;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 830;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 830;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 831;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 831;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 832;
UPDATE `quest_template` SET `RewRepValue2` = 75 WHERE `entry` = 832;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 834;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 834;
UPDATE `quest_template` SET `RewRepValue3` = 100 WHERE `entry` = 834;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 835;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 835;
UPDATE `quest_template` SET `RewRepValue3` = 100 WHERE `entry` = 835;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 837;
UPDATE `quest_template` SET `RewRepValue2` = 75 WHERE `entry` = 837;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 840;
UPDATE `quest_template` SET `RewRepValue2` = 50 WHERE `entry` = 840;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 842;
UPDATE `quest_template` SET `RewRepValue2` = 100 WHERE `entry` = 842;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 924;
UPDATE `quest_template` SET `RewRepValue1` = 200 WHERE `entry` = 4402;
UPDATE `quest_template` SET `RewRepValue2` = 200 WHERE `entry` = 4402;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 4641;
UPDATE `quest_template` SET `RewRepValue2` = 50 WHERE `entry` = 4641;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 5441;
UPDATE `quest_template` SET `RewRepValue2` = 150 WHERE `entry` = 5441;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 6394;
UPDATE `quest_template` SET `RewRepValue2` = 150 WHERE `entry` = 6394;

-- correct minLevel and Level for Durotar
UPDATE `quest_template` SET `MinLevel` = 4 WHERE `entry` = 806;
UPDATE `quest_template` SET `MinLevel` = 8 WHERE `entry` = 809;
UPDATE `quest_template` SET `QuestLevel` = 13 WHERE `entry` = 809;
UPDATE `quest_template` SET `MinLevel` = 7 WHERE `entry` = 812;
UPDATE `quest_template` SET `MinLevel` = 7 WHERE `entry` = 813;
UPDATE `quest_template` SET `MinLevel` = 5 WHERE `entry` = 825;
UPDATE `quest_template` SET `MinLevel` = 7 WHERE `entry` = 827;
UPDATE `quest_template` SET `MinLevel` = 6 WHERE `entry` = 828;
UPDATE `quest_template` SET `QuestLevel` = 12 WHERE `entry` = 828;
UPDATE `quest_template` SET `MinLevel` = 3 WHERE `entry` = 831;
UPDATE `quest_template` SET `MinLevel` = 8 WHERE `entry` = 924;

-- correct Required Races for Quests in Durotar which are horde only. Quest 784, 786, 791, 794, 805, 806, 808,
-- 809, 812, 813, 815, 816, 825, 826, 827, 828, 829, 830, 831, 832, 837, 840, 842, 924, 926
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` IN (784,786,791,794,805,806,808,809,812,813,815,816,825,826,827,828,829,830,831,832,837,840,842,924,926);

-- adding Quest 787 The New Horde completion questtext
UPDATE `quest_template` SET `OfferRewardText` = "Another one of Eitrigg's recruits, hm?$B$BA sorry state of affairs we find ourselves in if this is the best the Horde can produce. No matter. By the time we think you're ready to leave the Valley, you'll be a proud warrior of the Horde." WHERE `entry` = 787;

-- Correct Questlevel for Quest Welcome! all factions
UPDATE `quest_template` SET `QuestLevel` = 1 WHERE `entry` = 5841;
UPDATE `quest_template` SET `QuestLevel` = 1 WHERE `entry` = 5842;
UPDATE `quest_template` SET `QuestLevel` = 1 WHERE `entry` = 5843;
UPDATE `quest_template` SET `QuestLevel` = 1 WHERE `entry` = 5844;
UPDATE `quest_template` SET `QuestLevel` = 1 WHERE `entry` = 5847;

-- Correct Required Races for Quest 1049 Compendium of the fallen. Not available to undead
UPDATE `quest_template` SET `RequiredRaces` = 162 WHERE `entry` = 1049;

-- Fixed item GUID 32686 fathom stone should not disspawn when looted
UPDATE `gameobject` SET `spawntimesecs` = 0 WHERE `guid` = 32686;

-- Correct Required Races for Quest 656 Summoning the Princess
UPDATE `quest_template` SET `RequiredRaces` = 0 WHERE `entry` = 656;

-- Quest end script for Quest 524 Elixir Of Agony
UPDATE `creature` SET `spawntimesecs` = 180 WHERE `id` = 2284;
UPDATE `gameobject` SET `spawntimesecs` = -10 WHERE `guid` = 30031;
DELETE FROM `gameobject` WHERE `guid` = 55530;
INSERT INTO `gameobject` VALUES
(55530,1730,0,0.437117,-942.794,61.9384,-2.54818,0,0,0,0,-10,100,1);
UPDATE `quest_template` SET `CompleteScript` = 524 WHERE `entry` = 524;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 524;
INSERT INTO `dbscripts_on_quest_end` VALUES
(524,1,9,30031,30,0,0,0,0,0,0,0,0,0,0,0,'Spawn Keg');
INSERT INTO `dbscripts_on_quest_end` VALUES
(524,2,9,55530,30,0,0,0,0,0,0,0,0,0,0,0,'Spawn Keg Smoke');
INSERT INTO `dbscripts_on_quest_end` VALUES
(524,4,3,0,0,2284,15891,16,0,0,0,0,0.524,-944.41,61.93,1.66,'Move first');
INSERT INTO `dbscripts_on_quest_end` VALUES
(524,4,3,0,0,2284,15893,16,0,0,0,0,0.439,-940.84,61.93,4.94,'Move second');
INSERT INTO `dbscripts_on_quest_end` VALUES
(524,4,3,0,0,2284,15892,16,0,0,0,0,-1.632,-942.43,61.93,6.14,'Move third');
INSERT INTO `dbscripts_on_quest_end` VALUES
(524,7,15,5,0,2284,15891,17,0,0,0,0,0,0,0,0,'Kill first');
INSERT INTO `dbscripts_on_quest_end` VALUES
(524,8,15,5,0,2284,15893,17,0,0,0,0,0,0,0,0,'Kill second');
INSERT INTO `dbscripts_on_quest_end` VALUES
(524,9,15,5,0,2284,15892,17,0,0,0,0,0,0,0,0,'Kill third');

-- correct all reputation values for tirisfal
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 354;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 356;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 358;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 360;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 361;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 362;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 363;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 364;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 365;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 366;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 367;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 368;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 370;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 371;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 372;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 374;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 375;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 376;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 380;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 381;
UPDATE `quest_template` SET `RewRepValue1` = 200 WHERE `entry` = 382;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 383;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 398;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 404;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 408;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 409;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 411;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 426;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 427;
UPDATE `quest_template` SET `RewRepValue1` = 75 WHERE `entry` = 445;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 492;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 590;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 3901;
UPDATE `quest_template` SET `RewRepValue1` = 150 WHERE `entry` = 3902;
UPDATE `quest_template` SET `RewRepValue1` = 50 WHERE `entry` = 5481;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 5482;
UPDATE `quest_template` SET `RewRepValue1` = 100 WHERE `entry` = 6395;

-- fixing Quest 5151 Hypercapacitor Gizmo
UPDATE `creature_template` SET `unit_flags` = 832 WHERE `entry` = 10992;
UPDATE `creature_template` SET `flags_extra` = 0 WHERE `entry` = 10992;
DELETE FROM `dbscripts_on_go_use` WHERE `id` = 16775;
INSERT INTO `dbscripts_on_go_use` VALUES
(16775,1,3,0,0,10992,20,0,0,0,0,0,-4680.1,-1439.24,-50.49,5.77704,'Panther Move');
INSERT INTO `dbscripts_on_go_use` VALUES
(16775,2,22,16,49,10992,20,0,0,0,0,0,0,0,0,0,'Panther set faction');

-- Updatet values for deathstalker Faerleia from comments and db, mainly wowpedia she is lvl 18 instead of lvl 16, from comments she seems able to finish the quest nearly without any help.
-- DMG and ARMOR values are guessed by testing, no definite proof of this, but more correct than original values, HP is correct.
UPDATE `creature_template` SET `minlevel` = 18 WHERE `entry` = 2058;
UPDATE `creature_template` SET `maxlevel` = 18 WHERE `entry` = 2058;
UPDATE `creature_template` SET `minhealth` = 1251 WHERE `entry` = 2058;
UPDATE `creature_template` SET `maxhealth` = 1251 WHERE `entry` = 2058;
UPDATE `creature_template` SET `armor` = 1050 WHERE `entry` = 2058;
UPDATE `creature_template` SET `faction_A` = 71 WHERE `entry` = 2058;
UPDATE `creature_template` SET `faction_H` = 71 WHERE `entry` = 2058;
UPDATE `creature_template` SET `mindmg` = 90 WHERE `entry` = 2058;
UPDATE `creature_template` SET `maxdmg` = 99 WHERE `entry` = 2058;
UPDATE `creature_template` SET `attackpower` = 30 WHERE `entry` = 2058;
UPDATE `creature` SET `curhealth` = 1251 WHERE `guid` = 18352;

-- correct minLevel for quest 383 Vital Intelligence
UPDATE `quest_template` SET `MinLevel` = 4 WHERE `entry` = 383;

-- correct minLevel for quest 382 The Red Messenger
UPDATE `quest_template` SET `MinLevel` = 3 WHERE `entry` = 382;

-- Changed quest requirements for quest 590 a Rogues Deal, so that the quest can be completed also update minLevel
UPDATE `quest_template` SET `MinLevel` = 4 WHERE `entry` = 590;
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 0 WHERE `entry` = 590;
UPDATE `quest_template` SET `ReqCreatureOrGOCount1` = 0 WHERE `entry` = 590;

-- fix Rot Hide Gnoll cast Curse of thule as selfcast
UPDATE `creature_ai_scripts` SET `action1_param2` = 1 WHERE `id` = 167402;
UPDATE `creature_ai_scripts` SET `action1_param3` = 0 WHERE `id` = 167402;

-- correct minLevel for quest 5902 A Plague Upon Thee
UPDATE `quest_template` SET `MinLevel` = 49 WHERE `entry` = 5902;

-- Correcting to high XP for Quests 5901, 5902, A Plague Upon Thee
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 3450 WHERE `entry` = 5901;
UPDATE `quest_template` SET `RewMoneyMaxLevel` = 1680 WHERE `entry` = 5902;

-- correct minLevel for quest 398 Wanted Maggot Eye
UPDATE `quest_template` SET `MinLevel` = 4 WHERE `entry` = 398;

-- correct minLevel for quest 374 Proof of Demise
UPDATE `quest_template` SET `MinLevel` = 5 WHERE `entry` = 374;

-- correct minLevel for quest 431 Candles Of Beckoning
UPDATE `quest_template` SET `MinLevel` = 8 WHERE `entry` = 431;

-- correct minLevel for quest 372 At War With The Scarlett Crusade
UPDATE `quest_template` SET `MinLevel` = 7 WHERE `entry` = 372;

-- correct minLevel for quest 371 At War With The Scarlett Crusade
UPDATE `quest_template` SET `MinLevel` = 6 WHERE `entry` = 371;

-- correct minLevel for quest 370 At War With The Scarlett Crusade
UPDATE `quest_template` SET `MinLevel` = 5 WHERE `entry` = 370;

-- correct minLevel for quest 361 A Letter Undelivered
UPDATE `quest_template` SET `MinLevel` = 4 WHERE `entry` = 361;

-- correct minLevel for quest 355 Speak with Sevren
UPDATE `quest_template` SET `MinLevel` = 7 WHERE `entry` = 355;

-- correct Required Races for Quests all of them are horde Quests 354, 355, 356, 362, 364, 365, 366, 370, 371, 372,
-- 374, 376, 380, 381, 382, 383, 398, 404, 405, 407, 408, 409, 410, 411, 426, 427, 431, 445, 590, 3901, 3902, 5481, 5482
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 354;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 355;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 356;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 362;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 364;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 365;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 366;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 370;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 371;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 372;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 374;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 376;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 380;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 381;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 382;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 383;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 398;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 404;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 405;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 407;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 408;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 409;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 410;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 411;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 426;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 427;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 431;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 445;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 590;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 3901;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 3902;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 5481;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 5482;

-- rescripted the quest end script for quest 411 The prodigal lich returns. NEEDS COMMAND 35 TURN TO
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 411;
DELETE FROM `dbscripts_on_creature_movement` WHERE `id` = 566601;
DELETE FROM `creature_movement_template` WHERE `entry` = 5666;
INSERT INTO `dbscripts_on_quest_end` VALUES
(411,2,15,7673,0,0,0,4,0,0,0,0,0,0,0,0,'Bethor - Cast 7673');
INSERT INTO `dbscripts_on_quest_end` VALUES
(411,7,10,5666,23000,0,0,0,0,0,0,0,1768.58,55.4891,-46.3198,2.28248,'Summon Visage');
INSERT INTO `dbscripts_on_quest_end` VALUES
(411,10,3,0,0,5666,20,0,0,0,0,0,1766.39,65.0166,-46.3214,1.51672,'Visage move to Bethor');
INSERT INTO `dbscripts_on_quest_end` VALUES
(411,15,0,0,0,5666,20,0,2000000208,0,0,0,0,0,0,0,'Visage say 1');
INSERT INTO `dbscripts_on_quest_end` VALUES
(411,15,1,2,0,5666,20,0,0,0,0,0,0,0,0,0,'Visage Bow');
INSERT INTO `dbscripts_on_quest_end` VALUES
(411,18,0,0,0,5666,20,0,2000000209,0,0,0,0,0,0,0,'Visage say 2');
INSERT INTO `dbscripts_on_quest_end` VALUES
(411,22,35,0,0,5666,20,0,0,0,0,0,0,0,0,0,'Visage turn to player');
INSERT INTO `dbscripts_on_quest_end` VALUES
(411,23,0,0,0,5666,10,0,2000000210,0,0,0,0,0,0,0,'Visage Say 3');
INSERT INTO `dbscripts_on_quest_end` VALUES
(411,23,1,2,0,5666,10,0,0,0,0,0,0,0,0,0,'Visage Bow');
INSERT INTO `dbscripts_on_quest_end` VALUES
(411,30,0,0,0,0,0,0,2000000211,0,0,0,0,0,0,0,'Bethor Say');

-- fixing Quest 3567 this is removing the "You learn spell" from complete quest window and spell gets casted by Marli now, not by the player
UPDATE `quest_template` SET `RewSpellCast` = 0 WHERE `entry` = 3567;
UPDATE `quest_template` SET `RewSpell` = 0 WHERE `entry` = 3567;
UPDATE `quest_template` SET `CompleteScript` = 3567 WHERE `entry` = 3567;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 3567;
INSERT INTO `dbscripts_on_quest_end` VALUES
(3567,0,15,12242,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell 12242 on Player');

-- Added Spellspcripts for Spells 11885, 11886, 1887, 11888, 11889 Despawning the corpse after use of the vessel
DELETE FROM `dbscripts_on_spell` WHERE `id` = 11885;
INSERT INTO `dbscripts_on_spell` VALUES
(11885,3,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'Despawn treant corpse');
DELETE FROM `dbscripts_on_spell` WHERE `id` = 11886;
INSERT INTO `dbscripts_on_spell` VALUES
(11886,3,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'Despawn wildkin corpse');
DELETE FROM `dbscripts_on_spell` WHERE `id` = 11887;
INSERT INTO `dbscripts_on_spell` VALUES
(11887,3,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'Despawn hyppogryph corpse');
DELETE FROM `dbscripts_on_spell` WHERE `id` = 11888;
INSERT INTO `dbscripts_on_spell` VALUES
(11888,3,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'Despawn faerie dragon corpse');
DELETE FROM `dbscripts_on_spell` WHERE `id` = 11889;
INSERT INTO `dbscripts_on_spell` VALUES
(11889,3,18,0,0,0,0,0,0,0,0,0,0,0,0,0,'Despawn mountain giant corpse');

-- Correct Required Races for Quest 5156 Verifying the Corruption
UPDATE `quest_template` SET `RequiredRaces` = 0 WHERE `entry` = 5156;

-- correct minLevel for quest 8 a rogues deal and made it horde quest
UPDATE `quest_template` SET `MinLevel` = 1 WHERE `entry` = 8;
UPDATE `quest_template` SET `RequiredRaces` = 178 WHERE `entry` = 8;

-- Added spawn and attack script for Thenan when completing quest 652 Breaking the keystone
UPDATE `quest_template` SET `CompleteScript` = 652 WHERE `entry` = 652;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 652;
INSERT INTO `dbscripts_on_quest_end` VALUES
(652,1,10,2763,180000,0,0,0,0,0,0,0,-1539.12,-2172.93,17.29,0.56,'Summon Thenan');
INSERT INTO `dbscripts_on_quest_end` VALUES
(652,3,26,0,0,2763,50,0,0,0,0,0,0,0,0,0,'Start Attack');

-- Correct Minimum Questlevel for Quest 670 Sunken Treasure
UPDATE `quest_template` SET `MinLevel` = 35 WHERE `entry`=670;

-- backport: fixing Quest 1383 Questtext. deleting deepstrider tumor from dreaming whelps. Adding deepstrider tumor questdrop to deepstrider sea giants. Correcting questtext.
UPDATE quest_template SET Details="I have just the right serum in mind. It will deal with the truth in precisely the way the truth should be dealt with.$B$BFor this concoction I will need several Shadow Panther hearts from the Swamp. I also require the enchanted fungus off of the Mire Lord who resides there. I am sure one as able as you, $n, can persuade him to part with some.$B$BNow the hard part will be locating a Deepstrider tumor from far-off Desolace. Very rarely the giants there become ill and a tumor forms.$B$BNow, off you go!" WHERE entry=1383;
UPDATE quest_template SET Objectives="Apothecary Faustin at Beggar's Haunt needs 5 Shadow Panther Hearts, Mire Lord Fungus and a Deep Strider Tumor." WHERE entry=1383;
DELETE FROM `creature_loot_template` WHERE `item` = 6082;
INSERT INTO `creature_loot_template` VALUES
(4686,6082,-100,0,1,1,0);
INSERT INTO `creature_loot_template` VALUES
(4687,6082,-100,0,1,1,0);

-- fixing Quest 1388 previous questid, because quest where available before completing the first two quest of this questline.
UPDATE `quest_template` SET `PrevQuestId` = 1383 WHERE `entry` = 1388;

-- fixing the "you learn spell" from quest windows, from 6 Quest of Dalar Dawnweaver (Quest 99, 421, 422, 423, 424 1014) adding quest end scripts so dalar dawnweaver cast spell on Player, fixing the not enough mana bug.
UPDATE `quest_template` SET `RewSpellCast` = 0 WHERE `entry` = 99;
UPDATE `quest_template` SET `RewSpellCast` = 0 WHERE `entry` = 421;
UPDATE `quest_template` SET `RewSpellCast` = 0 WHERE `entry` = 422;
UPDATE `quest_template` SET `RewSpellCast` = 0 WHERE `entry` = 423;
UPDATE `quest_template` SET `RewSpellCast` = 0 WHERE `entry` = 424;
UPDATE `quest_template` SET `RewSpellCast` = 0 WHERE `entry` = 1014;
UPDATE `quest_template` SET `CompleteScript` = 99 WHERE `entry` = 99;
UPDATE `quest_template` SET `CompleteScript` = 421 WHERE `entry` = 421;
UPDATE `quest_template` SET `CompleteScript` = 422 WHERE `entry` = 422;
UPDATE `quest_template` SET `CompleteScript` = 423 WHERE `entry` = 423;
UPDATE `quest_template` SET `CompleteScript` = 424 WHERE `entry` = 424;
UPDATE `quest_template` SET `CompleteScript` = 1014 WHERE `entry` = 1014;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 99;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 421;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 422;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 423;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 424;
DELETE FROM `dbscripts_on_quest_end` WHERE `id` = 1014;
INSERT INTO `dbscripts_on_quest_end` VALUES
(99,0,15,8097,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Arcane Intellect on Player');
INSERT INTO `dbscripts_on_quest_end` VALUES
(421,0,15,8097,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Arcane Intellect on Player');
INSERT INTO `dbscripts_on_quest_end` VALUES
(422,0,15,8097,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Arcane Intellect on Player');
INSERT INTO `dbscripts_on_quest_end` VALUES
(423,0,15,8097,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Arcane Intellect on Player');
INSERT INTO `dbscripts_on_quest_end` VALUES
(424,0,15,8097,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Arcane Intellect on Player');
INSERT INTO `dbscripts_on_quest_end` VALUES
(1014,0,15,8097,0,0,0,0,0,0,0,0,0,0,0,0,'Cast spell Arcane Intellect on Player');

-- Replace graveyard for Blackrock mountains and related zones with Throrium point
SET @FACTION_ANY                                = 0;
SET @FACTION_ALLIANCE                           = 469;
SET @FACTION_HORDE                              = 67;
SET @ZONE_BLACKROCK_DEPTHS                      = 1584;
SET @ZONE_BLACKROCK_MOUNTAIN                    = 25;
SET @ZONE_BLACKROCK_SPIRE                       = 1583;
SET @ZONE_MOLTEN_CORE                           = 2717;
SET @ZONE_BLACKWING_LAIR                        = 2677;

-- Remove old graveyard links for Blackrock mountains and related zones
DELETE FROM `game_graveyard_zone`
WHERE `ghost_zone` IN (@ZONE_BLACKROCK_DEPTHS, @ZONE_BLACKROCK_MOUNTAIN, @ZONE_BLACKROCK_SPIRE, @ZONE_MOLTEN_CORE, @ZONE_BLACKWING_LAIR);

-- Add proper graveyards for Blackrock mountains and related zones
INSERT INTO `game_graveyard_zone` VALUES
    (636,   @ZONE_BLACKROCK_DEPTHS,             @FACTION_ANY),
    (636,   @ZONE_BLACKROCK_MOUNTAIN,           @FACTION_ANY),
    (636,   @ZONE_BLACKROCK_SPIRE,              @FACTION_ANY),
    (636,   @ZONE_MOLTEN_CORE,                  @FACTION_ANY),
    (636,   @ZONE_BLACKWING_LAIR,               @FACTION_ANY);

-- ACID

-- ScriptDev2

-- Cleanup
UPDATE `gameobject` SET `state` = 0 WHERE `id` IN (SELECT `entry` FROM `gameobject_template` WHERE `type` = 0 AND `data0` = 1);
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 2048 WHERE `unit_flags` & 2048 = 2048;
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 524288 WHERE `unit_flags` & 524288 = 524288;
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 67108864 WHERE `unit_flags` & 67108864 = 67108864;
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 8388608 WHERE `unit_flags` & 8388608 = 8388608;
UPDATE `creature`, `creature_template` SET `creature`.`curhealth` = `creature_template`.`minhealth`, `creature`.`curmana` = `creature_template`.`minmana` WHERE `creature`.`id` = `creature_template`.`entry` AND `creature_template`.`RegenHealth` = '1';
UPDATE `creature_template` SET `dynamicflags` = `dynamicflags` &~ 223;
UPDATE `creature_template` SET `npcflag` = `npcflag` &~ 16777216; -- UNIT_NPC_FLAG_SPELLCLICK
UPDATE `creature_template` SET `modelid_2` = 0 WHERE `modelid_1` = `modelid_2`;
-- UPDATE `creature_template` `c1`, `creature_template` `c2` SET `c2`.`unit_class` = `c1`.`unit_class`, `c2`.`npcflag` = `c1`.`npcflag`, `c2`.`faction_A` = `c1`.`faction_A`, `c2`.`faction_H` = `c1`.`faction_H`, `c2`.`speed_walk` = `c1`.`speed_walk`, `c2`.`speed_run` = `c1`.`speed_run`, `c2`.`scale` = `c1`.`scale`, `c2`.`InhabitType` = `c1`.`InhabitType`, `c2`.`MovementType` = `c1`.`MovementType`, `c2`.`unit_flags` = `c1`.`unit_flags` WHERE `c2`.`entry` = `c1`.`difficulty_entry_1`;
-- UPDATE `creature_template` `c1`, `creature_template` `c2` SET `c2`.`unit_class` = `c1`.`unit_class`, `c2`.`npcflag` = `c1`.`npcflag`, `c2`.`faction_A` = `c1`.`faction_A`, `c2`.`faction_H` = `c1`.`faction_H`, `c2`.`speed_walk` = `c1`.`speed_walk`, `c2`.`speed_run` = `c1`.`speed_run`, `c2`.`scale` = `c1`.`scale`, `c2`.`InhabitType` = `c1`.`InhabitType`, `c2`.`MovementType` = `c1`.`MovementType`, `c2`.`unit_flags` = `c1`.`unit_flags` WHERE `c2`.`entry` = `c1`.`difficulty_entry_2`;
-- UPDATE `creature_template` `c1`, `creature_template` `c2` SET `c2`.`unit_class` = `c1`.`unit_class`, `c2`.`npcflag` = `c1`.`npcflag`, `c2`.`faction_A` = `c1`.`faction_A`, `c2`.`faction_H` = `c1`.`faction_H`, `c2`.`speed_walk` = `c1`.`speed_walk`, `c2`.`speed_run` = `c1`.`speed_run`, `c2`.`scale` = `c1`.`scale`, `c2`.`InhabitType` = `c1`.`InhabitType`, `c2`.`MovementType` = `c1`.`MovementType`, `c2`.`unit_flags` = `c1`.`unit_flags` WHERE `c2`.`entry` = `c1`.`difficulty_entry_3`;
-- UPDATE `gameobject_template` SET `flags` = `flags` &~ 4 WHERE `type` IN (2, 19, 17);
UPDATE `creature` SET `MovementType` = 0 WHERE `spawndist` = 0 AND `MovementType` = 1;
UPDATE `creature` SET `spawndist` = 0 WHERE `MovementType` = 0;
UPDATE `quest_template` SET `SpecialFlags` = `SpecialFlags` | 1 WHERE `QuestFlags` = `QuestFlags` | 4096;
UPDATE `quest_template` SET `SpecialFlags` = `SpecialFlags` | 1 WHERE `QuestFlags` = `QuestFlags` | 32768;
DELETE FROM `go`,`gt` USING `gameobject` `go` LEFT JOIN `gameobject_template` `gt` ON `go`.`id` = `gt`.`entry` WHERE `gt`.`entry` IS NULL;
DELETE FROM `gi`,`gt` USING `gameobject_involvedrelation` `gi` LEFT JOIN `gameobject_template` `gt` ON `gi`.`id` = `gt`.`entry` WHERE `gt`.`entry` IS NULL;
DELETE FROM `gqr`,`gt` USING `gameobject_questrelation` `gqr` LEFT JOIN `gameobject_template` `gt` ON `gqr`.`id` = `gt`.`entry` WHERE `gt`.`entry` IS NULL;
DELETE FROM `ge`,`go` USING `game_event_gameobject` `ge` LEFT JOIN `gameobject` `go` ON `ge`.`guid` = `go`.`guid` WHERE `go`.`guid` IS NULL;
DELETE FROM `dbscripts_on_go_use` WHERE `id` NOT IN (SELECT `guid` FROM `gameobject`);
DELETE FROM `dbscripts_on_go_use` WHERE `command` IN (11, 12) AND `datalong` != 0 AND `datalong` NOT IN (SELECT `guid` FROM `gameobject`);
DELETE FROM `gameobject_battleground` WHERE `guid` NOT IN (SELECT `guid` FROM `gameobject`);
DELETE FROM `creature_battleground` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `creature_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
UPDATE `creature_addon` SET `moveflags` = `moveflags` &~ 0x00000100; -- SPLINEFLAG_DONE
UPDATE `creature_addon` SET `moveflags` = `moveflags` &~ 0x00000200; -- SPLINEFLAG_FALLING
UPDATE `creature_addon` SET `moveflags` = `moveflags` &~ 0x00000800; -- SPLINEFLAG_TRAJECTORY (can crash client)
UPDATE `creature_addon` SET `moveflags` = `moveflags` &~ 0x00200000; -- SPLINEFLAG_UNKNOWN3 (can crash client)
UPDATE `creature_addon` SET `moveflags` = `moveflags` &~ 0x08000000;
UPDATE `creature_template_addon` SET `moveflags` = `moveflags` &~ 0x00000100;
UPDATE `creature_template_addon` SET `moveflags` = `moveflags` &~ 0x00000200;
UPDATE `creature_template_addon` SET `moveflags` = `moveflags` &~ 0x00000800;
UPDATE `creature_template_addon` SET `moveflags` = `moveflags` &~ 0x00200000;
UPDATE `creature_template_addon` SET `moveflags` = `moveflags` &~ 0x08000000;
DELETE FROM `npc_gossip` WHERE `npc_guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `creature_movement` WHERE `id` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `game_event_creature` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `creature_questrelation` WHERE `id` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` NOT IN (SELECT `entry` FROM `creature_template`);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 2 WHERE `entry` IN (SELECT `id` FROM `creature_questrelation` UNION SELECT `id` FROM `creature_involvedrelation`);

-- Correct loot for Ragnaros
-- Clear the groups we are going to use
DELETE FROM `reference_loot_template` WHERE `entry`='34016';
DELETE FROM `reference_loot_template` WHERE `entry`='34017';
DELETE FROM `reference_loot_template` WHERE `entry`='34018';
-- Create groups for the drops
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
-- Tier 2 pants reference 34016
('34016', '16901', '0', '1', '1', '1', '0'),
('34016', '16909', '0', '1', '1', '1', '0'),
('34016', '16915', '0', '1', '1', '1', '0'),
('34016', '16922', '0', '1', '1', '1', '0'),
('34016', '16930', '0', '1', '1', '1', '0'),
('34016', '16938', '0', '1', '1', '1', '0'),
('34016', '16946', '0', '1', '1', '1', '0'),
('34016', '16954', '0', '1', '1', '1', '0'),
('34016', '16962', '0', '1', '1', '1', '0'),
-- Random epics reference 34017
('34017', '17063', '0', '1', '1', '1', '0'),
('34017', '17082', '0', '1', '1', '1', '0'),
('34017', '17102', '0', '1', '1', '1', '0'),
('34017', '17106', '0', '1', '1', '1', '0'),
('34017', '17107', '0', '1', '1', '1', '0'),
('34017', '18814', '0', '1', '1', '1', '0'),
('34017', '18815', '0', '1', '1', '1', '0'),
('34017', '18817', '0', '1', '1', '1', '0'),
('34017', '19137', '0', '1', '1', '1', '0'),
('34017', '19138', '0', '1', '1', '1', '0'),
-- epic weapons reference 34018
('34018', '17076', '0', '1', '1', '1', '0'),
('34018', '17104', '0', '1', '1', '1', '0'),
('34018', '18816', '0', '1', '1', '1', '0');

-- Remove current loot from ragnaros
DELETE FROM `creature_loot_template`
WHERE `entry`='11502';

-- Add new loot table
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `condition_id`) VALUES
-- Essence of fire
('11502', '7078', '40', '0', '1', '9', '0'),
-- Eye of sulfuras
('11502', '17204', '3', '0', '1', '1', '0'),
-- Essence of the firelord
('11502', '19017', '-100', '0', '1', '1', '0'),
-- Narain's Scrying Goggles
('11502', '20951', '-5', '0', '1', '1', '0'),
-- Draconic for Dummies
('11502', '21110', '3.4853', '0', '1', '1', '0'),
-- Random blues
('11502', '34002', '100', '1', '-34002', '3', '0'),
-- Drop 2 tier 2 pants
('11502', '34016', '100', '1', '-34016', '2', '0'),
-- random epic
('11502', '34017', '100', '1', '-34017', '1', '0'),
-- 50% chance of dropping an epic weapon.
('11502', '34018', '50', '1', '-34018', '1', '0');


-- UPDATE Database Version
UPDATE `db_version` SET `version` = 'ZeroDatabase 2.0.7 for MaNGOSZero z2426+ and ScriptDevZero z2676+';
