PresetsMenu100map:
    dw #presets_goto_100map_bombs
    dw #presets_goto_100map_varia
    dw #presets_goto_100map_upper_norfair
    dw #presets_goto_100map_grapple
    dw #presets_goto_100map_red_brinstar
    dw #presets_goto_100map_wrecked_ship
    dw #presets_goto_100map_forgotten_highway
    dw #presets_goto_100map_space_jump
    dw #presets_goto_100map_maridia_cleanup
    dw #presets_goto_100map_screw_attack
    dw #presets_goto_100map_lower_norfair
    dw #presets_goto_100map_begin_cleanup
    dw #presets_goto_100map_greenpink_brin_cleanup
    dw #presets_goto_100map_blue_brinstar_cleanup
    dw #presets_goto_100map_tourian
    dw #$0000
    %cm_header("MAP COMPLETION PRESETS")

presets_goto_100map_bombs:
    %cm_submenu("Bombs", #presets_submenu_100map_bombs)

presets_goto_100map_varia:
    %cm_submenu("Varia", #presets_submenu_100map_varia)

presets_goto_100map_upper_norfair:
    %cm_submenu("Upper Norfair", #presets_submenu_100map_upper_norfair)

presets_goto_100map_grapple:
    %cm_submenu("Grapple", #presets_submenu_100map_grapple)

presets_goto_100map_red_brinstar:
    %cm_submenu("Red Brinstar", #presets_submenu_100map_red_brinstar)

presets_goto_100map_wrecked_ship:
    %cm_submenu("Wrecked Ship", #presets_submenu_100map_wrecked_ship)

presets_goto_100map_forgotten_highway:
    %cm_submenu("Forgotten Highway", #presets_submenu_100map_forgotten_highway)

presets_goto_100map_space_jump:
    %cm_submenu("Space Jump", #presets_submenu_100map_space_jump)

presets_goto_100map_maridia_cleanup:
    %cm_submenu("Maridia Cleanup", #presets_submenu_100map_maridia_cleanup)

presets_goto_100map_screw_attack:
    %cm_submenu("Screw Attack", #presets_submenu_100map_screw_attack)

presets_goto_100map_lower_norfair:
    %cm_submenu("Lower Norfair", #presets_submenu_100map_lower_norfair)

presets_goto_100map_begin_cleanup:
    %cm_submenu("Begin Cleanup", #presets_submenu_100map_begin_cleanup)

presets_goto_100map_greenpink_brin_cleanup:
    %cm_submenu("Green-Pink Brin Cleanup", #presets_submenu_100map_greenpink_brin_cleanup)

presets_goto_100map_blue_brinstar_cleanup:
    %cm_submenu("Blue Brinstar Cleanup", #presets_submenu_100map_blue_brinstar_cleanup)

presets_goto_100map_tourian:
    %cm_submenu("Tourian", #presets_submenu_100map_tourian)

presets_submenu_100map_bombs:
    dw #presets_100map_bombs_ceres_elevator
    dw #presets_100map_bombs_ceres_escape
    dw #presets_100map_bombs_ceres_last_3_rooms
    dw #presets_100map_bombs_ship
    dw #presets_100map_bombs_parlor
    dw #presets_100map_bombs_climb_down
    dw #presets_100map_bombs_pit_room
    dw #presets_100map_bombs_morph
    dw #presets_100map_bombs_construction_zone_down
    dw #presets_100map_bombs_construction_zone_up
    dw #presets_100map_bombs_pit_room_revisit
    dw #presets_100map_bombs_climb_up
    dw #presets_100map_bombs_parlor_revisit
    dw #presets_100map_bombs_flyway
    dw #presets_100map_bombs_bomb_torizo
    dw #presets_100map_bombs_alcatraz
    dw #presets_100map_bombs_terminator
    dw #presets_100map_bombs_green_pirate_shaft
    dw #$0000
    %cm_header("BOMBS")

presets_submenu_100map_varia:
    dw #presets_100map_varia_green_brinstar_elevator
    dw #presets_100map_varia_early_supers
    dw #presets_100map_varia_brinstar_reserve
    dw #presets_100map_varia_reverse_mockball
    dw #presets_100map_varia_green_hill_zone
    dw #presets_100map_varia_red_tower_down
    dw #presets_100map_varia_skree_boost
    dw #presets_100map_varia_leaving_spazer
    dw #presets_100map_varia_kraid_kihunter_room
    dw #presets_100map_varia_kihunter_save_room
    dw #presets_100map_varia_kraid
    dw #presets_100map_varia_kraid_dboost_room_out
    dw #presets_100map_varia_leaving_kraid_refill
    dw #presets_100map_varia_kihunter_room_leaving
    dw #presets_100map_varia_mouthball
    dw #$0000
    %cm_header("VARIA")

presets_submenu_100map_upper_norfair:
    dw #presets_100map_upper_norfair_hi_jump_boots
    dw #presets_100map_upper_norfair_precathedral
    dw #presets_100map_upper_norfair_cathedral
    dw #presets_100map_upper_norfair_bubble_mountain
    dw #presets_100map_upper_norfair_bubble_mountain_climb
    dw #presets_100map_upper_norfair_bat_cave
    dw #presets_100map_upper_norfair_speed_hallway_in
    dw #presets_100map_upper_norfair_speed_booster
    dw #presets_100map_upper_norfair_single_chamber
    dw #presets_100map_upper_norfair_double_chamber
    dw #presets_100map_upper_norfair_double_chamber_out
    dw #presets_100map_upper_norfair_river_styx
    dw #presets_100map_upper_norfair_volcano_room
    dw #presets_100map_upper_norfair_reverse_magdollite_room
    dw #presets_100map_upper_norfair_purple_shaft
    dw #presets_100map_upper_norfair_bubble_mountain_corner
    dw #$0000
    %cm_header("UPPER NORFAIR")

presets_submenu_100map_grapple:
    dw #presets_100map_grapple_crocomire
    dw #presets_100map_grapple_leaving_croc
    dw #presets_100map_grapple_crocomire_shaft
    dw #presets_100map_grapple_cosine_missile_room
    dw #presets_100map_grapple_indiana_jones_room
    dw #presets_100map_grapple_grapple_beam
    dw #presets_100map_grapple_grapple_playground_1
    dw #presets_100map_grapple_grapple_playground_2
    dw #presets_100map_grapple_grapple_playground_final
    dw #presets_100map_grapple_crocomire_farm_room
    dw #presets_100map_grapple_crocomire_cac_shaft
    dw #presets_100map_grapple_crocomire_escape
    dw #presets_100map_grapple_business_center
    dw #$0000
    %cm_header("GRAPPLE")

presets_submenu_100map_red_brinstar:
    dw #presets_100map_red_brinstar_warehouse_entrance
    dw #presets_100map_red_brinstar_red_tower_climb
    dw #presets_100map_red_brinstar_xray_hall_in
    dw #presets_100map_red_brinstar_xray_hall_out
    dw #presets_100map_red_brinstar_red_tower_up
    dw #presets_100map_red_brinstar_hellway
    dw #presets_100map_red_brinstar_alpha_pbs
    dw #presets_100map_red_brinstar_caterpillar_room_up
    dw #presets_100map_red_brinstar_beta_pbs
    dw #presets_100map_red_brinstar_crateria_kihunters_room
    dw #$0000
    %cm_header("RED BRINSTAR")

presets_submenu_100map_wrecked_ship:
    dw #presets_100map_wrecked_ship_ws_shaft_down
    dw #presets_100map_wrecked_ship_basement
    dw #presets_100map_wrecked_ship_basement_speedball
    dw #presets_100map_wrecked_ship_phantoon
    dw #presets_100map_wrecked_ship_right_supers
    dw #presets_100map_wrecked_ship_main_shaft_climb
    dw #presets_100map_wrecked_ship_attic
    dw #presets_100map_wrecked_ship_robots_of_pain
    dw #presets_100map_wrecked_ship_west_ocean
    dw #presets_100map_wrecked_ship_bowling_area
    dw #presets_100map_wrecked_ship_leaving_gravity
    dw #presets_100map_wrecked_ship_sponge_bath
    dw #presets_100map_wrecked_ship_electric_death_room
    dw #presets_100map_wrecked_ship_wrecked_ship_etank
    dw #$0000
    %cm_header("WRECKED SHIP")

presets_submenu_100map_gravity:
    dw #$0000
    %cm_header("GRAVITY")

presets_submenu_100map_forgotten_highway:
    dw #presets_100map_forgotten_highway_east_ocean
    dw #presets_100map_forgotten_highway_kago_room
    dw #presets_100map_forgotten_highway_crab_maze
    dw #presets_100map_forgotten_highway_maridia_elevator
    dw #presets_100map_forgotten_highway_pancakes_from_hell
    dw #presets_100map_forgotten_highway_plasma_spark_room
    dw #presets_100map_forgotten_highway_west_sand_hall
    dw #presets_100map_forgotten_highway_crab_ggg
    dw #$0000
    %cm_header("FORGOTTEN HIGHWAY")

presets_submenu_100map_space_jump:
    dw #presets_100map_space_jump_main_street
    dw #presets_100map_space_jump_mama_turtle
    dw #presets_100map_space_jump_leaving_mama_turtle
    dw #presets_100map_space_jump_everest_post_fish_tank
    dw #presets_100map_space_jump_everest_post_crab_supers
    dw #presets_100map_space_jump_beach
    dw #presets_100map_space_jump_swiss_cheese_room
    dw #presets_100map_space_jump_swiss_cheese_revisit
    dw #presets_100map_space_jump_beach_revisit
    dw #presets_100map_space_jump_crab_shaft_down
    dw #presets_100map_space_jump_aqueduct_post_save
    dw #presets_100map_space_jump_prebotwoon
    dw #presets_100map_space_jump_botwoon
    dw #presets_100map_space_jump_over_under_spark
    dw #presets_100map_space_jump_under_over_spark
    dw #presets_100map_space_jump_colosseum
    dw #presets_100map_space_jump_draygon
    dw #$0000
    %cm_header("SPACE JUMP")

presets_submenu_100map_maridia_cleanup:
    dw #presets_100map_maridia_cleanup_reverse_halfie
    dw #presets_100map_maridia_cleanup_botwoon_hallway_revisit
    dw #presets_100map_maridia_cleanup_right_sand_pit
    dw #presets_100map_maridia_cleanup_east_sand_hall
    dw #presets_100map_maridia_cleanup_pants_room
    dw #presets_100map_maridia_cleanup_spring_ball_room
    dw #presets_100map_maridia_cleanup_pants_room_corner
    dw #presets_100map_maridia_cleanup_plasma_spark_room_revisit
    dw #presets_100map_maridia_cleanup_kassiuz_room
    dw #presets_100map_maridia_cleanup_plasma_room
    dw #presets_100map_maridia_cleanup_plasma_spark_room_final
    dw #presets_100map_maridia_cleanup_west_cac_alley
    dw #presets_100map_maridia_cleanup_east_cac_alley
    dw #presets_100map_maridia_cleanup_botwoon_hallway_final
    dw #presets_100map_maridia_cleanup_aqueduct_final
    dw #presets_100map_maridia_cleanup_left_sand_pit
    dw #presets_100map_maridia_cleanup_crab_hole
    dw #presets_100map_maridia_cleanup_kpdr_exit
    dw #$0000
    %cm_header("MARIDIA CLEANUP")

presets_submenu_100map_screw_attack:
    dw #presets_100map_screw_attack_business_center
    dw #presets_100map_screw_attack_ice_beam_snake_room
    dw #presets_100map_screw_attack_ice_beam_foosball
    dw #presets_100map_screw_attack_ice_beam_boyon_room
    dw #presets_100map_screw_attack_crocomire_speedway
    dw #presets_100map_screw_attack_kronic_boost_room
    dw #presets_100map_screw_attack_lava_dive_room
    dw #presets_100map_screw_attack_lower_norfair_main_hall
    dw #presets_100map_screw_attack_blue_fireball
    dw #presets_100map_screw_attack_golden_torizo
    dw #presets_100map_screw_attack_screw_attack
    dw #$0000
    %cm_header("SCREW ATTACK")

presets_submenu_100map_lower_norfair:
    dw #presets_100map_lower_norfair_fast_ripper_room
    dw #presets_100map_lower_norfair_worst_room_in_the_game
    dw #presets_100map_lower_norfair_mickey_mouse
    dw #presets_100map_lower_norfair_amphitheatre
    dw #presets_100map_lower_norfair_kihunter_stairs_down
    dw #presets_100map_lower_norfair_wasteland
    dw #presets_100map_lower_norfair_metal_pirates
    dw #presets_100map_lower_norfair_ridley
    dw #presets_100map_lower_norfair_leaving_ridley
    dw #presets_100map_lower_norfair_wasteland_revisit
    dw #presets_100map_lower_norfair_kihunter_stairs_up
    dw #presets_100map_lower_norfair_fireflea_room
    dw #presets_100map_lower_norfair_hotarubi_missile_room
    dw #presets_100map_lower_norfair_three_musketeers_room
    dw #$0000
    %cm_header("LOWER NORFAIR")

presets_submenu_100map_begin_cleanup:
    dw #presets_100map_begin_cleanup_single_chamber_revisit
    dw #presets_100map_begin_cleanup_bubble_mountain_dboost
    dw #presets_100map_begin_cleanup_norfair_reserve_front
    dw #presets_100map_begin_cleanup_norfair_reserve_back
    dw #presets_100map_begin_cleanup_bubble_mountain_final
    dw #presets_100map_begin_cleanup_tube
    dw #presets_100map_begin_cleanup_tube_climb
    dw #presets_100map_begin_cleanup_sephy_fish_room
    dw #presets_100map_begin_cleanup_crateria_kihunters_revisit
    dw #presets_100map_begin_cleanup_landing_site_revisit
    dw #presets_100map_begin_cleanup_crateria_pbs
    dw #presets_100map_begin_cleanup_gauntlet_etank
    dw #presets_100map_begin_cleanup_quickdrops
    dw #$0000
    %cm_header("BEGIN CLEANUP")

presets_submenu_100map_greenpink_brin_cleanup:
    dw #presets_100map_greenpink_brin_cleanup_green_brinstar_elevator
    dw #presets_100map_greenpink_brin_cleanup_brinstar_map_entrance
    dw #presets_100map_greenpink_brin_cleanup_green_brin_fireflea_room
    dw #presets_100map_greenpink_brin_cleanup_etecoons_etank_skip
    dw #presets_100map_greenpink_brin_cleanup_etecoons_dboosts
    dw #presets_100map_greenpink_brin_cleanup_etecoons_climb
    dw #presets_100map_greenpink_brin_cleanup_dachora_moonfall
    dw #presets_100map_greenpink_brin_cleanup_big_pink_climb
    dw #presets_100map_greenpink_brin_cleanup_spo_spo_kihunters_room
    dw #presets_100map_greenpink_brin_cleanup_spore_spawn
    dw #presets_100map_greenpink_brin_cleanup_spo_spo_moonfall
    dw #presets_100map_greenpink_brin_cleanup_spo_spo_farm_room
    dw #presets_100map_greenpink_brin_cleanup_wave_gate_room
    dw #presets_100map_greenpink_brin_cleanup_mission_impossible_room
    dw #presets_100map_greenpink_brin_cleanup_green_hill_zone_final
    dw #$0000
    %cm_header("GREEN-PINK BRIN CLEANUP")

presets_submenu_100map_blue_brinstar_cleanup:
    dw #presets_100map_blue_brinstar_cleanup_blue_brinstar_hoppers
    dw #presets_100map_blue_brinstar_cleanup_blue_brinstar_etank_room
    dw #presets_100map_blue_brinstar_cleanup_john_cena_bridge
    dw #presets_100map_blue_brinstar_cleanup_blue_brinstar_screwfall
    dw #presets_100map_blue_brinstar_cleanup_pit_room_final
    dw #presets_100map_blue_brinstar_cleanup_climb_supers
    dw #presets_100map_blue_brinstar_cleanup_parlor_again
    dw #presets_100map_blue_brinstar_cleanup_crateria_map_entry
    dw #presets_100map_blue_brinstar_cleanup_crateria_map_exit
    dw #presets_100map_blue_brinstar_cleanup_230_mockball
    dw #presets_100map_blue_brinstar_cleanup_parlor_not_final_climb
    dw #$0000
    %cm_header("BLUE BRINSTAR CLEANUP")

presets_submenu_100map_tourian:
    dw #presets_100map_tourian_tourian_elevator
    dw #presets_100map_tourian_metroids_1
    dw #presets_100map_tourian_metroids_2
    dw #presets_100map_tourian_metroids_3
    dw #presets_100map_tourian_metroids_4
    dw #presets_100map_tourian_baby_skip
    dw #presets_100map_tourian_dusty_shaft_revisit
    dw #presets_100map_tourian_zeb_skip
    dw #presets_100map_tourian_mother_brain_2
    dw #presets_100map_tourian_zebes_escape
    dw #presets_100map_tourian_escape_room_3
    dw #presets_100map_tourian_escape_room_4
    dw #presets_100map_tourian_escape_climb
    dw #presets_100map_tourian_escape_parlor
    dw #presets_100map_tourian_landing_site_final
    dw #$0000
    %cm_header("TOURIAN")

; Bombs
presets_100map_bombs_ceres_elevator:
    %cm_preset("Ceres Elevator", #preset_100map_bombs_ceres_elevator)

presets_100map_bombs_ceres_escape:
    %cm_preset("Ceres Escape", #preset_100map_bombs_ceres_escape)

presets_100map_bombs_ceres_last_3_rooms:
    %cm_preset("Ceres Last 3 Rooms", #preset_100map_bombs_ceres_last_3_rooms)

presets_100map_bombs_ship:
    %cm_preset("Ship", #preset_100map_bombs_ship)

presets_100map_bombs_parlor:
    %cm_preset("Parlor", #preset_100map_bombs_parlor)

presets_100map_bombs_climb_down:
    %cm_preset("Climb Down", #preset_100map_bombs_climb_down)

presets_100map_bombs_pit_room:
    %cm_preset("Pit Room", #preset_100map_bombs_pit_room)

presets_100map_bombs_morph:
    %cm_preset("Morph", #preset_100map_bombs_morph)

presets_100map_bombs_construction_zone_down:
    %cm_preset("Construction Zone Down", #preset_100map_bombs_construction_zone_down)

presets_100map_bombs_construction_zone_up:
    %cm_preset("Construction Zone Up", #preset_100map_bombs_construction_zone_up)

presets_100map_bombs_pit_room_revisit:
    %cm_preset("Pit Room Revisit", #preset_100map_bombs_pit_room_revisit)

presets_100map_bombs_climb_up:
    %cm_preset("Climb Up", #preset_100map_bombs_climb_up)

presets_100map_bombs_parlor_revisit:
    %cm_preset("Parlor Revisit", #preset_100map_bombs_parlor_revisit)

presets_100map_bombs_flyway:
    %cm_preset("Flyway", #preset_100map_bombs_flyway)

presets_100map_bombs_bomb_torizo:
    %cm_preset("Bomb Torizo", #preset_100map_bombs_bomb_torizo)

presets_100map_bombs_alcatraz:
    %cm_preset("Alcatraz", #preset_100map_bombs_alcatraz)

presets_100map_bombs_terminator:
    %cm_preset("Terminator", #preset_100map_bombs_terminator)

presets_100map_bombs_green_pirate_shaft:
    %cm_preset("Green Pirate Shaft", #preset_100map_bombs_green_pirate_shaft)


; Varia
presets_100map_varia_green_brinstar_elevator:
    %cm_preset("Green Brinstar Elevator", #preset_100map_varia_green_brinstar_elevator)

presets_100map_varia_early_supers:
    %cm_preset("Early Supers", #preset_100map_varia_early_supers)

presets_100map_varia_brinstar_reserve:
    %cm_preset("Brinstar Reserve", #preset_100map_varia_brinstar_reserve)

presets_100map_varia_reverse_mockball:
    %cm_preset("Reverse Mockball", #preset_100map_varia_reverse_mockball)

presets_100map_varia_green_hill_zone:
    %cm_preset("Green Hill Zone", #preset_100map_varia_green_hill_zone)

presets_100map_varia_red_tower_down:
    %cm_preset("Red Tower Down", #preset_100map_varia_red_tower_down)

presets_100map_varia_skree_boost:
    %cm_preset("Skree Boost", #preset_100map_varia_skree_boost)

presets_100map_varia_leaving_spazer:
    %cm_preset("Leaving Spazer", #preset_100map_varia_leaving_spazer)

presets_100map_varia_kraid_kihunter_room:
    %cm_preset("Kraid Kihunter Room", #preset_100map_varia_kraid_kihunter_room)

presets_100map_varia_kihunter_save_room:
    %cm_preset("Kihunter Save Room", #preset_100map_varia_kihunter_save_room)

presets_100map_varia_kraid:
    %cm_preset("Kraid", #preset_100map_varia_kraid)

presets_100map_varia_kraid_dboost_room_out:
    %cm_preset("Kraid D-Boost Room Out", #preset_100map_varia_kraid_dboost_room_out)

presets_100map_varia_leaving_kraid_refill:
    %cm_preset("Leaving Kraid Refill", #preset_100map_varia_leaving_kraid_refill)

presets_100map_varia_kihunter_room_leaving:
    %cm_preset("Kihunter Room Leaving", #preset_100map_varia_kihunter_room_leaving)

presets_100map_varia_mouthball:
    %cm_preset("Mouthball", #preset_100map_varia_mouthball)


; Upper Norfair
presets_100map_upper_norfair_hi_jump_boots:
    %cm_preset("Hi Jump Boots", #preset_100map_upper_norfair_hi_jump_boots)

presets_100map_upper_norfair_precathedral:
    %cm_preset("Pre-Cathedral", #preset_100map_upper_norfair_precathedral)

presets_100map_upper_norfair_cathedral:
    %cm_preset("Cathedral", #preset_100map_upper_norfair_cathedral)

presets_100map_upper_norfair_bubble_mountain:
    %cm_preset("Bubble Mountain", #preset_100map_upper_norfair_bubble_mountain)

presets_100map_upper_norfair_bubble_mountain_climb:
    %cm_preset("Bubble Mountain Climb", #preset_100map_upper_norfair_bubble_mountain_climb)

presets_100map_upper_norfair_bat_cave:
    %cm_preset("Bat Cave", #preset_100map_upper_norfair_bat_cave)

presets_100map_upper_norfair_speed_hallway_in:
    %cm_preset("Speed Hallway In", #preset_100map_upper_norfair_speed_hallway_in)

presets_100map_upper_norfair_speed_booster:
    %cm_preset("Speed Booster", #preset_100map_upper_norfair_speed_booster)

presets_100map_upper_norfair_single_chamber:
    %cm_preset("Single Chamber", #preset_100map_upper_norfair_single_chamber)

presets_100map_upper_norfair_double_chamber:
    %cm_preset("Double Chamber", #preset_100map_upper_norfair_double_chamber)

presets_100map_upper_norfair_double_chamber_out:
    %cm_preset("Double Chamber Out", #preset_100map_upper_norfair_double_chamber_out)

presets_100map_upper_norfair_river_styx:
    %cm_preset("River Styx", #preset_100map_upper_norfair_river_styx)

presets_100map_upper_norfair_volcano_room:
    %cm_preset("Volcano Room", #preset_100map_upper_norfair_volcano_room)

presets_100map_upper_norfair_reverse_magdollite_room:
    %cm_preset("Reverse Magdollite Room", #preset_100map_upper_norfair_reverse_magdollite_room)

presets_100map_upper_norfair_purple_shaft:
    %cm_preset("Purple Shaft", #preset_100map_upper_norfair_purple_shaft)

presets_100map_upper_norfair_bubble_mountain_corner:
    %cm_preset("Bubble Mountain Corner", #preset_100map_upper_norfair_bubble_mountain_corner)


; Grapple
presets_100map_grapple_crocomire:
    %cm_preset("Crocomire", #preset_100map_grapple_crocomire)

presets_100map_grapple_leaving_croc:
    %cm_preset("Leaving Croc", #preset_100map_grapple_leaving_croc)

presets_100map_grapple_crocomire_shaft:
    %cm_preset("Crocomire Shaft", #preset_100map_grapple_crocomire_shaft)

presets_100map_grapple_cosine_missile_room:
    %cm_preset("Cosine Missile Room", #preset_100map_grapple_cosine_missile_room)

presets_100map_grapple_indiana_jones_room:
    %cm_preset("Indiana Jones Room", #preset_100map_grapple_indiana_jones_room)

presets_100map_grapple_grapple_beam:
    %cm_preset("Grapple Beam", #preset_100map_grapple_grapple_beam)

presets_100map_grapple_grapple_playground_1:
    %cm_preset("Grapple Playground 1", #preset_100map_grapple_grapple_playground_1)

presets_100map_grapple_grapple_playground_2:
    %cm_preset("Grapple Playground 2", #preset_100map_grapple_grapple_playground_2)

presets_100map_grapple_grapple_playground_final:
    %cm_preset("Grapple Playground Final", #preset_100map_grapple_grapple_playground_final)

presets_100map_grapple_crocomire_farm_room:
    %cm_preset("Crocomire Farm Room", #preset_100map_grapple_crocomire_farm_room)

presets_100map_grapple_crocomire_cac_shaft:
    %cm_preset("Crocomire Cac Shaft", #preset_100map_grapple_crocomire_cac_shaft)

presets_100map_grapple_crocomire_escape:
    %cm_preset("Crocomire Escape", #preset_100map_grapple_crocomire_escape)

presets_100map_grapple_business_center:
    %cm_preset("Business Center", #preset_100map_grapple_business_center)


; Red Brinstar
presets_100map_red_brinstar_warehouse_entrance:
    %cm_preset("Warehouse Entrance", #preset_100map_red_brinstar_warehouse_entrance)

presets_100map_red_brinstar_red_tower_climb:
    %cm_preset("Red Tower Climb", #preset_100map_red_brinstar_red_tower_climb)

presets_100map_red_brinstar_xray_hall_in:
    %cm_preset("X-Ray Hall In", #preset_100map_red_brinstar_xray_hall_in)

presets_100map_red_brinstar_xray_hall_out:
    %cm_preset("X-Ray Hall Out", #preset_100map_red_brinstar_xray_hall_out)

presets_100map_red_brinstar_red_tower_up:
    %cm_preset("Red Tower Up", #preset_100map_red_brinstar_red_tower_up)

presets_100map_red_brinstar_hellway:
    %cm_preset("Hellway", #preset_100map_red_brinstar_hellway)

presets_100map_red_brinstar_alpha_pbs:
    %cm_preset("Alpha PBs", #preset_100map_red_brinstar_alpha_pbs)

presets_100map_red_brinstar_caterpillar_room_up:
    %cm_preset("Caterpillar Room Up", #preset_100map_red_brinstar_caterpillar_room_up)

presets_100map_red_brinstar_beta_pbs:
    %cm_preset("Beta PBs", #preset_100map_red_brinstar_beta_pbs)

presets_100map_red_brinstar_crateria_kihunters_room:
    %cm_preset("Crateria Kihunters Room", #preset_100map_red_brinstar_crateria_kihunters_room)


; Wrecked Ship
presets_100map_wrecked_ship_ws_shaft_down:
    %cm_preset("WS Shaft Down", #preset_100map_wrecked_ship_ws_shaft_down)

presets_100map_wrecked_ship_basement:
    %cm_preset("Basement", #preset_100map_wrecked_ship_basement)

presets_100map_wrecked_ship_basement_speedball:
    %cm_preset("Basement Speedball", #preset_100map_wrecked_ship_basement_speedball)

presets_100map_wrecked_ship_phantoon:
    %cm_preset("Phantoon", #preset_100map_wrecked_ship_phantoon)

presets_100map_wrecked_ship_right_supers:
    %cm_preset("Right Supers", #preset_100map_wrecked_ship_right_supers)

presets_100map_wrecked_ship_main_shaft_climb:
    %cm_preset("Main Shaft Climb", #preset_100map_wrecked_ship_main_shaft_climb)

presets_100map_wrecked_ship_attic:
    %cm_preset("Attic", #preset_100map_wrecked_ship_attic)

presets_100map_wrecked_ship_robots_of_pain:
    %cm_preset("Robots of Pain", #preset_100map_wrecked_ship_robots_of_pain)

presets_100map_wrecked_ship_west_ocean:
    %cm_preset("West Ocean", #preset_100map_wrecked_ship_west_ocean)

presets_100map_wrecked_ship_bowling_area:
    %cm_preset("Bowling Area", #preset_100map_wrecked_ship_bowling_area)

presets_100map_wrecked_ship_leaving_gravity:
    %cm_preset("Leaving Gravity", #preset_100map_wrecked_ship_leaving_gravity)

presets_100map_wrecked_ship_sponge_bath:
    %cm_preset("Sponge Bath", #preset_100map_wrecked_ship_sponge_bath)

presets_100map_wrecked_ship_electric_death_room:
    %cm_preset("Electric Death Room", #preset_100map_wrecked_ship_electric_death_room)

presets_100map_wrecked_ship_wrecked_ship_etank:
    %cm_preset("Wrecked Ship E-Tank", #preset_100map_wrecked_ship_wrecked_ship_etank)


; Forgotten Highway
presets_100map_forgotten_highway_east_ocean:
    %cm_preset("East Ocean", #preset_100map_forgotten_highway_east_ocean)

presets_100map_forgotten_highway_kago_room:
    %cm_preset("Kago Room", #preset_100map_forgotten_highway_kago_room)

presets_100map_forgotten_highway_crab_maze:
    %cm_preset("Crab Maze", #preset_100map_forgotten_highway_crab_maze)

presets_100map_forgotten_highway_maridia_elevator:
    %cm_preset("Maridia Elevator", #preset_100map_forgotten_highway_maridia_elevator)

presets_100map_forgotten_highway_pancakes_from_hell:
    %cm_preset("Pancakes From Hell", #preset_100map_forgotten_highway_pancakes_from_hell)

presets_100map_forgotten_highway_plasma_spark_room:
    %cm_preset("Plasma Spark Room", #preset_100map_forgotten_highway_plasma_spark_room)

presets_100map_forgotten_highway_west_sand_hall:
    %cm_preset("West Sand Hall", #preset_100map_forgotten_highway_west_sand_hall)

presets_100map_forgotten_highway_crab_ggg:
    %cm_preset("Crab GGG", #preset_100map_forgotten_highway_crab_ggg)


; Space Jump
presets_100map_space_jump_main_street:
    %cm_preset("Main Street", #preset_100map_space_jump_main_street)

presets_100map_space_jump_mama_turtle:
    %cm_preset("Mama Turtle", #preset_100map_space_jump_mama_turtle)

presets_100map_space_jump_leaving_mama_turtle:
    %cm_preset("Leaving Mama Turtle", #preset_100map_space_jump_leaving_mama_turtle)

presets_100map_space_jump_everest_post_fish_tank:
    %cm_preset("Everest Post Fish Tank", #preset_100map_space_jump_everest_post_fish_tank)

presets_100map_space_jump_everest_post_crab_supers:
    %cm_preset("Everest Post Crab Supers", #preset_100map_space_jump_everest_post_crab_supers)

presets_100map_space_jump_beach:
    %cm_preset("Beach", #preset_100map_space_jump_beach)

presets_100map_space_jump_swiss_cheese_room:
    %cm_preset("Swiss Cheese Room", #preset_100map_space_jump_swiss_cheese_room)

presets_100map_space_jump_swiss_cheese_revisit:
    %cm_preset("Swiss Cheese Revisit", #preset_100map_space_jump_swiss_cheese_revisit)

presets_100map_space_jump_beach_revisit:
    %cm_preset("Beach Revisit", #preset_100map_space_jump_beach_revisit)

presets_100map_space_jump_crab_shaft_down:
    %cm_preset("Crab Shaft Down", #preset_100map_space_jump_crab_shaft_down)

presets_100map_space_jump_aqueduct_post_save:
    %cm_preset("Aqueduct (Post Save)", #preset_100map_space_jump_aqueduct_post_save)

presets_100map_space_jump_prebotwoon:
    %cm_preset("Pre-Botwoon", #preset_100map_space_jump_prebotwoon)

presets_100map_space_jump_botwoon:
    %cm_preset("Botwoon", #preset_100map_space_jump_botwoon)

presets_100map_space_jump_over_under_spark:
    %cm_preset("Over Under Spark", #preset_100map_space_jump_over_under_spark)

presets_100map_space_jump_under_over_spark:
    %cm_preset("Under Over Spark", #preset_100map_space_jump_under_over_spark)

presets_100map_space_jump_colosseum:
    %cm_preset("Colosseum", #preset_100map_space_jump_colosseum)

presets_100map_space_jump_draygon:
    %cm_preset("Draygon", #preset_100map_space_jump_draygon)


; Maridia Cleanup
presets_100map_maridia_cleanup_reverse_halfie:
    %cm_preset("Reverse Halfie", #preset_100map_maridia_cleanup_reverse_halfie)

presets_100map_maridia_cleanup_botwoon_hallway_revisit:
    %cm_preset("Botwoon Hallway Revisit", #preset_100map_maridia_cleanup_botwoon_hallway_revisit)

presets_100map_maridia_cleanup_right_sand_pit:
    %cm_preset("Right Sand Pit", #preset_100map_maridia_cleanup_right_sand_pit)

presets_100map_maridia_cleanup_east_sand_hall:
    %cm_preset("East Sand Hall", #preset_100map_maridia_cleanup_east_sand_hall)

presets_100map_maridia_cleanup_pants_room:
    %cm_preset("Pants Room", #preset_100map_maridia_cleanup_pants_room)

presets_100map_maridia_cleanup_spring_ball_room:
    %cm_preset("Spring Ball Room", #preset_100map_maridia_cleanup_spring_ball_room)

presets_100map_maridia_cleanup_pants_room_corner:
    %cm_preset("Pants Room Corner", #preset_100map_maridia_cleanup_pants_room_corner)

presets_100map_maridia_cleanup_plasma_spark_room_revisit:
    %cm_preset("Plasma Spark Room Revisit", #preset_100map_maridia_cleanup_plasma_spark_room_revisit)

presets_100map_maridia_cleanup_kassiuz_room:
    %cm_preset("Kassiuz Room", #preset_100map_maridia_cleanup_kassiuz_room)

presets_100map_maridia_cleanup_plasma_room:
    %cm_preset("Plasma Room", #preset_100map_maridia_cleanup_plasma_room)

presets_100map_maridia_cleanup_plasma_spark_room_final:
    %cm_preset("Plasma Spark Room Final", #preset_100map_maridia_cleanup_plasma_spark_room_final)

presets_100map_maridia_cleanup_west_cac_alley:
    %cm_preset("West Cac Alley", #preset_100map_maridia_cleanup_west_cac_alley)

presets_100map_maridia_cleanup_east_cac_alley:
    %cm_preset("East Cac Alley", #preset_100map_maridia_cleanup_east_cac_alley)

presets_100map_maridia_cleanup_botwoon_hallway_final:
    %cm_preset("Botwoon Hallway Final", #preset_100map_maridia_cleanup_botwoon_hallway_final)

presets_100map_maridia_cleanup_aqueduct_final:
    %cm_preset("Aqueduct Final", #preset_100map_maridia_cleanup_aqueduct_final)

presets_100map_maridia_cleanup_left_sand_pit:
    %cm_preset("Left Sand Pit", #preset_100map_maridia_cleanup_left_sand_pit)

presets_100map_maridia_cleanup_crab_hole:
    %cm_preset("Crab Hole", #preset_100map_maridia_cleanup_crab_hole)

presets_100map_maridia_cleanup_kpdr_exit:
    %cm_preset("KPDR Exit", #preset_100map_maridia_cleanup_kpdr_exit)


; Screw Attack
presets_100map_screw_attack_business_center:
    %cm_preset("Business Center", #preset_100map_screw_attack_business_center)

presets_100map_screw_attack_ice_beam_snake_room:
    %cm_preset("Ice Beam Snake Room", #preset_100map_screw_attack_ice_beam_snake_room)

presets_100map_screw_attack_ice_beam_foosball:
    %cm_preset("Ice Beam Foosball", #preset_100map_screw_attack_ice_beam_foosball)

presets_100map_screw_attack_ice_beam_boyon_room:
    %cm_preset("Ice Beam Boyon Room", #preset_100map_screw_attack_ice_beam_boyon_room)

presets_100map_screw_attack_crocomire_speedway:
    %cm_preset("Crocomire Speedway", #preset_100map_screw_attack_crocomire_speedway)

presets_100map_screw_attack_kronic_boost_room:
    %cm_preset("Kronic Boost Room", #preset_100map_screw_attack_kronic_boost_room)

presets_100map_screw_attack_lava_dive_room:
    %cm_preset("Lava Dive Room", #preset_100map_screw_attack_lava_dive_room)

presets_100map_screw_attack_lower_norfair_main_hall:
    %cm_preset("Lower Norfair Main Hall", #preset_100map_screw_attack_lower_norfair_main_hall)

presets_100map_screw_attack_blue_fireball:
    %cm_preset("Blue Fireball", #preset_100map_screw_attack_blue_fireball)

presets_100map_screw_attack_golden_torizo:
    %cm_preset("Golden Torizo", #preset_100map_screw_attack_golden_torizo)

presets_100map_screw_attack_screw_attack:
    %cm_preset("Screw Attack", #preset_100map_screw_attack_screw_attack)


; Lower Norfair
presets_100map_lower_norfair_fast_ripper_room:
    %cm_preset("Fast Ripper Room", #preset_100map_lower_norfair_fast_ripper_room)

presets_100map_lower_norfair_worst_room_in_the_game:
    %cm_preset("Worst Room in the Game", #preset_100map_lower_norfair_worst_room_in_the_game)

presets_100map_lower_norfair_mickey_mouse:
    %cm_preset("Mickey Mouse", #preset_100map_lower_norfair_mickey_mouse)

presets_100map_lower_norfair_amphitheatre:
    %cm_preset("Amphitheatre", #preset_100map_lower_norfair_amphitheatre)

presets_100map_lower_norfair_kihunter_stairs_down:
    %cm_preset("Kihunter Stairs Down", #preset_100map_lower_norfair_kihunter_stairs_down)

presets_100map_lower_norfair_wasteland:
    %cm_preset("Wasteland", #preset_100map_lower_norfair_wasteland)

presets_100map_lower_norfair_metal_pirates:
    %cm_preset("Metal Pirates", #preset_100map_lower_norfair_metal_pirates)

presets_100map_lower_norfair_ridley:
    %cm_preset("Ridley", #preset_100map_lower_norfair_ridley)

presets_100map_lower_norfair_leaving_ridley:
    %cm_preset("Leaving Ridley", #preset_100map_lower_norfair_leaving_ridley)

presets_100map_lower_norfair_wasteland_revisit:
    %cm_preset("Wasteland Revisit", #preset_100map_lower_norfair_wasteland_revisit)

presets_100map_lower_norfair_kihunter_stairs_up:
    %cm_preset("Kihunter Stairs Up", #preset_100map_lower_norfair_kihunter_stairs_up)

presets_100map_lower_norfair_fireflea_room:
    %cm_preset("Fireflea Room", #preset_100map_lower_norfair_fireflea_room)

presets_100map_lower_norfair_hotarubi_missile_room:
    %cm_preset("Hotarubi Missile Room", #preset_100map_lower_norfair_hotarubi_missile_room)

presets_100map_lower_norfair_three_musketeers_room:
    %cm_preset("Three Musketeers Room", #preset_100map_lower_norfair_three_musketeers_room)


; Begin Cleanup
presets_100map_begin_cleanup_single_chamber_revisit:
    %cm_preset("Single Chamber Revisit", #preset_100map_begin_cleanup_single_chamber_revisit)

presets_100map_begin_cleanup_bubble_mountain_dboost:
    %cm_preset("Bubble Mountain D-Boost", #preset_100map_begin_cleanup_bubble_mountain_dboost)

presets_100map_begin_cleanup_norfair_reserve_front:
    %cm_preset("Norfair Reserve Front", #preset_100map_begin_cleanup_norfair_reserve_front)

presets_100map_begin_cleanup_norfair_reserve_back:
    %cm_preset("Norfair Reserve Back", #preset_100map_begin_cleanup_norfair_reserve_back)

presets_100map_begin_cleanup_bubble_mountain_final:
    %cm_preset("Bubble Mountain Final", #preset_100map_begin_cleanup_bubble_mountain_final)

presets_100map_begin_cleanup_tube:
    %cm_preset("Tube", #preset_100map_begin_cleanup_tube)

presets_100map_begin_cleanup_tube_climb:
    %cm_preset("Tube Climb", #preset_100map_begin_cleanup_tube_climb)

presets_100map_begin_cleanup_sephy_fish_room:
    %cm_preset("Sephy Fish Room", #preset_100map_begin_cleanup_sephy_fish_room)

presets_100map_begin_cleanup_crateria_kihunters_revisit:
    %cm_preset("Crateria Kihunters Revisit", #preset_100map_begin_cleanup_crateria_kihunters_revisit)

presets_100map_begin_cleanup_landing_site_revisit:
    %cm_preset("Landing Site Revisit", #preset_100map_begin_cleanup_landing_site_revisit)

presets_100map_begin_cleanup_crateria_pbs:
    %cm_preset("Crateria PBs", #preset_100map_begin_cleanup_crateria_pbs)

presets_100map_begin_cleanup_gauntlet_etank:
    %cm_preset("Gauntlet E-Tank", #preset_100map_begin_cleanup_gauntlet_etank)

presets_100map_begin_cleanup_quickdrops:
    %cm_preset("Quickdrops", #preset_100map_begin_cleanup_quickdrops)


; Green-Pink Brin Cleanup
presets_100map_greenpink_brin_cleanup_green_brinstar_elevator:
    %cm_preset("Green Brinstar Elevator", #preset_100map_greenpink_brin_cleanup_green_brinstar_elevator)

presets_100map_greenpink_brin_cleanup_brinstar_map_entrance:
    %cm_preset("Brinstar Map Entrance", #preset_100map_greenpink_brin_cleanup_brinstar_map_entrance)

presets_100map_greenpink_brin_cleanup_green_brin_fireflea_room:
    %cm_preset("Green Brin Fireflea Room", #preset_100map_greenpink_brin_cleanup_green_brin_fireflea_room)

presets_100map_greenpink_brin_cleanup_etecoons_etank_skip:
    %cm_preset("Etecoons E-Tank Skip", #preset_100map_greenpink_brin_cleanup_etecoons_etank_skip)

presets_100map_greenpink_brin_cleanup_etecoons_dboosts:
    %cm_preset("Etecoons D-Boosts", #preset_100map_greenpink_brin_cleanup_etecoons_dboosts)

presets_100map_greenpink_brin_cleanup_etecoons_climb:
    %cm_preset("Etecoons Climb", #preset_100map_greenpink_brin_cleanup_etecoons_climb)

presets_100map_greenpink_brin_cleanup_dachora_moonfall:
    %cm_preset("Dachora Moonfall", #preset_100map_greenpink_brin_cleanup_dachora_moonfall)

presets_100map_greenpink_brin_cleanup_big_pink_climb:
    %cm_preset("Big Pink Climb", #preset_100map_greenpink_brin_cleanup_big_pink_climb)

presets_100map_greenpink_brin_cleanup_spo_spo_kihunters_room:
    %cm_preset("Spo Spo Kihunters Room", #preset_100map_greenpink_brin_cleanup_spo_spo_kihunters_room)

presets_100map_greenpink_brin_cleanup_spore_spawn:
    %cm_preset("Spore Spawn", #preset_100map_greenpink_brin_cleanup_spore_spawn)

presets_100map_greenpink_brin_cleanup_spo_spo_moonfall:
    %cm_preset("Spo Spo Moonfall", #preset_100map_greenpink_brin_cleanup_spo_spo_moonfall)

presets_100map_greenpink_brin_cleanup_spo_spo_farm_room:
    %cm_preset("Spo Spo Farm Room", #preset_100map_greenpink_brin_cleanup_spo_spo_farm_room)

presets_100map_greenpink_brin_cleanup_wave_gate_room:
    %cm_preset("Wave Gate Room", #preset_100map_greenpink_brin_cleanup_wave_gate_room)

presets_100map_greenpink_brin_cleanup_mission_impossible_room:
    %cm_preset("Mission Impossible Room", #preset_100map_greenpink_brin_cleanup_mission_impossible_room)

presets_100map_greenpink_brin_cleanup_green_hill_zone_final:
    %cm_preset("Green Hill Zone Final", #preset_100map_greenpink_brin_cleanup_green_hill_zone_final)


; Blue Brinstar Cleanup
presets_100map_blue_brinstar_cleanup_blue_brinstar_hoppers:
    %cm_preset("Blue Brinstar Hoppers", #preset_100map_blue_brinstar_cleanup_blue_brinstar_hoppers)

presets_100map_blue_brinstar_cleanup_blue_brinstar_etank_room:
    %cm_preset("Blue Brinstar E-Tank Room", #preset_100map_blue_brinstar_cleanup_blue_brinstar_etank_room)

presets_100map_blue_brinstar_cleanup_john_cena_bridge:
    %cm_preset("John Cena Bridge", #preset_100map_blue_brinstar_cleanup_john_cena_bridge)

presets_100map_blue_brinstar_cleanup_blue_brinstar_screwfall:
    %cm_preset("Blue Brinstar Screwfall", #preset_100map_blue_brinstar_cleanup_blue_brinstar_screwfall)

presets_100map_blue_brinstar_cleanup_pit_room_final:
    %cm_preset("Pit Room Final", #preset_100map_blue_brinstar_cleanup_pit_room_final)

presets_100map_blue_brinstar_cleanup_climb_supers:
    %cm_preset("Climb Supers", #preset_100map_blue_brinstar_cleanup_climb_supers)

presets_100map_blue_brinstar_cleanup_parlor_again:
    %cm_preset("Parlor Again", #preset_100map_blue_brinstar_cleanup_parlor_again)

presets_100map_blue_brinstar_cleanup_crateria_map_entry:
    %cm_preset("Crateria Map Entry", #preset_100map_blue_brinstar_cleanup_crateria_map_entry)

presets_100map_blue_brinstar_cleanup_crateria_map_exit:
    %cm_preset("Crateria Map Exit", #preset_100map_blue_brinstar_cleanup_crateria_map_exit)

presets_100map_blue_brinstar_cleanup_230_mockball:
    %cm_preset("230 Mockball", #preset_100map_blue_brinstar_cleanup_230_mockball)

presets_100map_blue_brinstar_cleanup_parlor_not_final_climb:
    %cm_preset("Parlor (not) Final Climb", #preset_100map_blue_brinstar_cleanup_parlor_not_final_climb)


; Tourian
presets_100map_tourian_tourian_elevator:
    %cm_preset("Tourian Elevator", #preset_100map_tourian_tourian_elevator)

presets_100map_tourian_metroids_1:
    %cm_preset("Metroids 1", #preset_100map_tourian_metroids_1)

presets_100map_tourian_metroids_2:
    %cm_preset("Metroids 2", #preset_100map_tourian_metroids_2)

presets_100map_tourian_metroids_3:
    %cm_preset("Metroids 3", #preset_100map_tourian_metroids_3)

presets_100map_tourian_metroids_4:
    %cm_preset("Metroids 4", #preset_100map_tourian_metroids_4)

presets_100map_tourian_baby_skip:
    %cm_preset("Baby Skip", #preset_100map_tourian_baby_skip)

presets_100map_tourian_dusty_shaft_revisit:
    %cm_preset("Dusty Shaft Revisit", #preset_100map_tourian_dusty_shaft_revisit)

presets_100map_tourian_zeb_skip:
    %cm_preset("Zeb Skip", #preset_100map_tourian_zeb_skip)

presets_100map_tourian_mother_brain_2:
    %cm_preset("Mother Brain 2", #preset_100map_tourian_mother_brain_2)

presets_100map_tourian_zebes_escape:
    %cm_preset("Zebes Escape", #preset_100map_tourian_zebes_escape)

presets_100map_tourian_escape_room_3:
    %cm_preset("Escape Room 3", #preset_100map_tourian_escape_room_3)

presets_100map_tourian_escape_room_4:
    %cm_preset("Escape Room 4", #preset_100map_tourian_escape_room_4)

presets_100map_tourian_escape_climb:
    %cm_preset("Escape Climb", #preset_100map_tourian_escape_climb)

presets_100map_tourian_escape_parlor:
    %cm_preset("Escape Parlor", #preset_100map_tourian_escape_parlor)

presets_100map_tourian_landing_site_final:
    %cm_preset("Landing Site Final", #preset_100map_tourian_landing_site_final)


