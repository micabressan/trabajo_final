   override fun getView(position: Int, convertView: View?, parent: ViewGroup): View? {
        val view = convertView ?: LayoutInflater.from(getContext())
                .inflate(R.layout.widget_preview_listitem, parent, false)

        val searchbox = view.findViewById(R.id.searchbox_holder) as ImageView
        val logo = view.findViewById(R.id.searchbox_logo) as ImageView
        val shortcutsHolder = view.findViewById(R.id.shortcut_list) as LinearLayout
        val editButton = view.findViewById(R.id.button_edit) as Button
        val shortcutViews = ArrayList<ImageView>()

        shortcutsHolder.removeAllViews()
        widgets[position].first.shortcuts.forEach {
            val shortcutView = LayoutInflater.from(getContext())
                    .inflate(R.layout.widget_shortcut_layout, shortcutsHolder, false) as ImageView
            shortcutView.setImageResource(it.icon)
            shortcutsHolder.addView(shortcutView)
            shortcutViews.add(shortcutView)
        }

        val (primary, secondary) = DataManager.getColors(getContext(), widgets[position].first)
        searchbox.setColorFilter(primary)
        logo.setColorFilter(secondary)
        shortcutViews.forEach { it.setColorFilter(secondary) }

        editButton.setOnClickListener {
            Log.d("TEMP", "id: ${widgets[position].second}")
            val configIntent = Intent(getContext(), javaClass<ConfigurationActivity>())
            configIntent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgets[position].second)
            val configPendingIntent = PendingIntent.getActivity(getContext(), 0, configIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT);
            configPendingIntent.send()
        }
        return view
    }

строго говоря, когда я стартую то, что в онклике, оно перезаписывает данные не только моего виджета, а и ИНОГДА соседний\или несколько соседних