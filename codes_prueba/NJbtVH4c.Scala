 fun loadWidgetPreview() {
        try {
            val searchbox = ctx.findViewById(R.id.searchbox_holder) as ImageView
            val logo = ctx.findViewById(R.id.searchbox_logo) as ImageView
            val shortcutsHolder = ctx.findViewById(R.id.shortcut_list) as LinearLayout
            val shortcutViews = ArrayList<ImageView>()

            shortcutsHolder.removeAllViews()
            ctx.data.shortcuts.forEach {
                val shortcutView = LayoutInflater.from(ctx)
                        .inflate(R.layout.widget_shortcut_layout, shortcutsHolder, false) as ImageView
                shortcutView.setImageResource(it.icon)
                shortcutsHolder.addView(shortcutView)
                shortcutViews.add(shortcutView)
            }

            val (primary, secondary) = ctx.data.getColors(ctx)
            searchbox.setColorFilter(primary)
            logo.setColorFilter(secondary)
            shortcutViews.forEach { it.setColorFilter(secondary) }
        }
        catch(e: Exception) {
            async {
                Log.d(LOG_TAG, "widget preview error!")
                Thread.sleep(100)
                uiThread { loadShortcuts() }
            }
        }
    }