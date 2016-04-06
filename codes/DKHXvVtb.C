    hfile = CreateFileA("bmp48x48.bmp", GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0);
    if (hfile == INVALID_HANDLE_VALUE)
        goto cleanup;

    size = GetFileSize(hfile, NULL);
    if (size == INVALID_FILE_SIZE)
        goto cleanup;

    hmapping = CreateFileMappingA(hfile, NULL, PAGE_READONLY, 0, 0, NULL);
    if (!hmapping)
        goto cleanup;

    buffer = MapViewOfFile(hmapping, FILE_MAP_READ, 0, 0, 0);
    if (buffer == NULL)
        goto cleanup;

//Runs well till here
    bmp_header = (BITMAPINFOHEADER *)buffer;
//Shows garbage when seen via the watch window..