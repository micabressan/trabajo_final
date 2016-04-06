    /**
     * Not supported via OK sdk.
     * @throws com.github.gorbin.asne.core.SocialNetworkException
     * @param message  message that should be shared
     * @param onPostingCompleteListener listener for posting request
     */
    @Override
    public void requestPostMessage(String message, OnPostingCompleteListener onPostingCompleteListener) {
        super.requestPostMessage(message, onPostingCompleteListener);
        if (TextUtils.isEmpty(message)) {
            throw new SocialNetworkException("message can't be null or empty");
        }

        final String text = Base64.encodeToString(mGson.toJson(new PostMessage().addMedia(new PostMessage.PostMediaText(
                message
        ))).getBytes(), Base64.DEFAULT);
        final Pair<AlertDialog.Builder, WebView> pair = Util.createWebView(mActivity);

        final Map<String, String> params = MapUtils.asMap(
                entry("st.app", mAppId),
                entry("st.attachment", text),
                entry("st.return", REDIRECT_URI),
                entry("st.popup", "on"),
                entry("st.silent", "on")
        );
        final String signature = DigestUtils.md5Hex(
                MapFormat.format("st.attachment={st.attachment}st.return={st.return}{secret}", params)
        );
        params.put("signature", signature);
        final String urlTemplate = "http://connect.ok.ru/dk?st.cmd=WidgetMediatopicPost&st.access_token={access_token}&st.app={st.app}&st.attachment={st.attachment}&st.signature={signature}&st.return={st.return}&st.popup={st.popup}&st.silent={st.silent}";
        final String url = MapFormat.format(urlTemplate, params);

        pair.second.loadUrl(url);
        pair.first.show();

//        final Intent intent = new Intent(Intent.ACTION_VIEW);
//        intent.setData(Uri.parse(url));
//        intent.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
//        mActivity.startActivity(intent);


//        Bundle args = new Bundle();
//        args.putString(RequestPostMessageAsyncTask.PARAM_TEXT, message);
//        executeRequest(new RequestPostMessageAsyncTask(), args, REQUEST_POST_MESSAGE);
    }