if (sv_forceGear && Q_stricmp(sv_forceGear->string, "null")) {
	Info_SetValueForKey(cl->userinfo, "gear", sv_forceGear->string);
}