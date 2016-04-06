    public static void checkLocale(@NonNull Context context) {
        Locale locale = KConfig.getInstance(context).getLocale();
        final Configuration configuration = context.getResources().getConfiguration();
        if (configuration != null && !locale.equals(configuration.locale)) {
            KLog.i(TAG, "Setting language to: " + locale.getLanguage());
            configuration.locale = locale;
            final Resources resources = context.getResources();
            resources.updateConfiguration(configuration, resources.getDisplayMetrics());
        }
    }