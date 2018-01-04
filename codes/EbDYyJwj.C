#if ( audio_artist_sort == TRUE )
	d_log("audioSort:   Sorting mp3 by artist\n");
	if (*info->id3_artist) {
		d_log("audioSort:     - artist: %s\n", info->id3_artist);
		if (!strncasecmp(link_target, "VA", 2) && (link_target[2] == '-' || link_target[2] == '_'))
			memcpy(info->id3_artist, "VA", 3);
		if (memcmp(info->id3_artist, "VA", 3)) {
	#if ( audio_artist_nosub == FALSE )
		#if ( audio_artist_noid3 == FALSE )

			temp_p = ng_realloc(temp_p, 2, 1, 0, NULL, 1);
			snprintf(temp_p, 2, "%c", toupper(*info->id3_artist));
			createlink(audio_artist_path, temp_p, link_source, link_target);
		#else
			temp_p = ng_realloc(temp_p, 2, 1, 0, NULL, 1);
			snprintf(temp_p, 2, "%c", toupper(*link_target));
			createlink(audio_artist_path, temp_p, link_source, link_target);
		#endif
	#else
			temp_p = ng_realloc(temp_p, strlen(info->id3_artist)+1, 1, 0, NULL, 1);
			snprintf(temp_p, strlen(info->id3_artist)+1, "%s", info->id3_artist);
			temp_p = check_nocase_linkname(audio_artist_path, temp_p);
			space_to_dot(temp_p);
			createlink(audio_artist_path, temp_p, link_source, link_target);
#endif
#if ( audio_weird_sort == TRUE )
			temp_p = ng_realloc(temp_p, 2, 1, 0, NULL, 1);
			snprintf(temp_p, 2, "%c", toupper(*link_target));
			createlink(audio_artist_path, temp_p, link_source, link_target);
			
			temp_p = ng_realloc(temp_p, strlen(info->id3_artist)+1, 1, 0, NULL, 1);
			snprintf(temp_p, strlen(info->id3_artist)+1, "%s", info->id3_artist);
			temp_p = check_nocase_linkname(audio_artist_path, temp_p);
			space_to_dot(temp_p);
			createlink(audio_artist_path, temp_p, link_source, link_target);
#endif