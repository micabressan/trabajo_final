        async {
            javaClass<R.drawable>()
                    .getDeclaredFields()
                    .filter { it.getName().startsWith("icn_") }
                    .forEach {
                        val id = it.getInt(drawableRes)
                        val name = it.getName().removePrefix("icn_").replace('_', ' ').capitalize()
                        adapter.add(Pair(id, name))
                    }
            uiThread { adapter.notifyDataSetChanged() }
        }