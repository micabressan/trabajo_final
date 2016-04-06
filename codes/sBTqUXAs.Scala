package com.pavelsikun.customizablesearchwidget

import android.content.Context
import android.graphics.Color
import android.util.Log
import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import java.util.*

/**
 * Created by mrbimc on 11.08.15.
 */
public object DataManager {
    val PREFS_NAME = "com.pavelsikun.customizablesearchwidget.CustomizableSearchWidget"
    val PREFIX_KEY = "appwidget_"

    data class WidgetShortcut(var appAction: String = "com.google.android.googlequicksearchbox.VoiceSearchActivity",
                          var appPackage: String = "com.google.android.googlequicksearchbox",
                          var icon: Int = R.drawable.ic_mic)

    data class WidgetData(var primaryColor: Int = Color.WHITE,
                          var secondaryColor: Int = Color.DKGRAY,
                          var autoTheme: Boolean = true,
                          var autoThemeReversed: Boolean = false,
                          var searchAsOverlay: Boolean = true,
                          val shortcuts: ArrayList<WidgetShortcut> = arrayListOf(WidgetShortcut())) {

        fun getColors(context: Context): Pair<Int, Int> {
            val primary: Int
            val secondary: Int

            if(autoTheme) {
                val palette = getWallpaperPalette(context)
                if(autoThemeReversed) {
                    primary = palette.getDarkVibrantColor(Color.DKGRAY)
                    secondary = palette.getLightVibrantColor(Color.WHITE)
                }
                else {
                    primary = palette.getLightVibrantColor(Color.WHITE)
                    secondary = palette.getDarkMutedColor(Color.DKGRAY)
                }
            }
            else {
                primary = primaryColor
                secondary = secondaryColor
            }
            return Pair(primary, secondary)
        }
    }

    fun getWidgetData(context: Context, id: Int): WidgetData {
        context.getSharedPreferences(PREFS_NAME, 0).getString(PREFIX_KEY + id, null)?.let {
            return jacksonObjectMapper().readValue(it, javaClass<WidgetData>())
        }
        return WidgetData()
    }

    fun saveWidgetData(context: Context, id: Int, data: WidgetData) {
        jacksonObjectMapper().writeValueAsString(data).let {
            context.getSharedPreferences(PREFS_NAME, 0)
                    .edit()
                    .putString(PREFIX_KEY + id, it)
                    .commit()
        }
    }

    fun deleteWidgetData(context: Context, id: Int) {
        val prefs = context.getSharedPreferences(PREFS_NAME, 0).edit()
        prefs.remove(PREFIX_KEY + id)
        prefs.commit()
    }
}