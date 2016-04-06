SELECT m.id_match, m.duration, m.radiant_win, m.game_mode, p.hero_id, p.player_slot, h.name, h.localized_name
FROM (tbl_matches m LEFT JOIN tbl_players p ON m.id_match = p.id_match)
LEFT JOIN tbl_heroes h ON p.hero_id = h.id_hero
ORDER BY m.seq_num DESC
LIMIT 10