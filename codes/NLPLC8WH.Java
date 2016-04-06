
// METODOS DE ENTRADA DE COMANDO, CHAMADOS PELO USUARIO

public void playPlayer() {
        stopPlayer();

        mPlayer = new MultiPlayer(this, MultiPlayer.DEFAULT_AUDIO_BUFFER_CAPACITY_MS, MultiPlayer.DEFAULT_DECODE_BUFFER_CAPACITY_MS);
        mPlayer.playAsync(getResources().getString(R.string.url_streaming));

        String stringTimeLimit = PreferenceManager.getDefaultSharedPreferences(this)
                .getString(getResources().getString(R.string.PREFKEY_LIMITCONNECTION), "10");

        int limit = Integer.parseInt(stringTimeLimit);

        startTimeLimitCountDown(limit);
    }

    public void stopPlayer() {
        if (mPlayer != null) {
            mPlayer.stop();
        }
    }

// METODOS CALLBACK, CHAMADOS PELO PLAYER

  @Override
    public void playerStarted() {
        // O player acabou de começar a bufferizar apenas.

        playerState = PlayerState.BUFFERING;

        if (mRadioInterfaceUI != null) {
            mRadioInterfaceUI.onPlayerStarted();
        }

    }

    @Override
    public void playerPCMFeedBuffer(boolean isPlaying, int audioBufferSizeMs, int audioBufferCapacityMs) {

        if(isPlaying){

            if(playerState != PlayerState.PLAYING){

                playerState = PlayerState.PLAYING;

                if (mRadioInterfaceUI != null) {
                    mRadioInterfaceUI.onBufferingComplete();
                }

                // SE A NOTIFICAÇÃO ESTÁ SENDO EXIBIDA, SIGNIFICA QUE O PLAY VEIO DA NOTIFICAÇÃO.
                // NESSE CASO, VAMOS MANTER RENOVAR A NOTIFICAÇÃO;
                if (mNotificationControl.SHOWN) {
                    mNotificationControl.setNotification(getResources().getString(R.string.app_name), MUSICA_ATUAL, true);
                }

                if (mTimeLimitConnection != null) {
                    mTimeLimitConnection.cancel();
                    mTimeLimitConnection = null;
                }

            } else {

                playerState = PlayerState.STOPPED;

            }

        }

    }

    @Override
    public void playerStopped(int i) {
        // ESTE MÉTODO NÃO É CHAMADO QUANDO É DADO O PLAY SEM CONEXÃO ALGUMA COM A INTERNET,
        // OU SEJA, NÃO VAI NEM PARA O ESTADO DE BUFFERING, É APENAS STOP DIRETO.

        playerState = PlayerState.STOPPED;

        if (mNotificationControl.SHOWN) {
            mNotificationControl.setNotification(getResources().getString(R.string.app_name), MUSICA_ATUAL, false);
        }

        if (mRadioInterfaceUI != null) {
            mRadioInterfaceUI.onPlayerStopped();
        }

        if (myTimer.TIMING) {
            myTimer.cancel();
        }

        if (mTimeLimitConnection != null) {
            mTimeLimitConnection.cancel();
            mTimeLimitConnection = null;
        }

    }

    @Override
    public void playerException(Throwable throwable) {
        // Primeiro stopPlayer() para retirar o dialog de buffering,
        // Depois onPlayerException() na interface para exibir o dialog da exception.

        stopPlayer();

        if (mRadioInterfaceUI != null) {
            mRadioInterfaceUI.onPlayerException();
        }

    }

    @Override
    public void playerMetadata(final String key, final String value) {

        if (key == null || key.isEmpty()) {
            return;
        }

        if ("StreamTitle".equals(key)) {
            MUSICA_ATUAL = value;
        } else if ("icy-name".equals(key)) {
            PROGRAMA_ATUAL = value;
        } else {
            return;
        }

        if (mRadioInterfaceUI != null) {
            mRadioInterfaceUI.onPlayerMetadata();
        } else {

            if (mNotificationControl.SHOWN) {
                mNotificationControl.setNotification(getResources().getString(R.string.app_name), MUSICA_ATUAL, true);
            }

        }

    }

    @Override
    public void playerAudioTrackCreated(AudioTrack audioTrack) {

    }