diff --git headers/os/interface/Screen.h headers/os/interface/Screen.h
index 58cb2e4..0e7584f 100644
--- headers/os/interface/Screen.h
+++ headers/os/interface/Screen.h
@@ -44,7 +44,7 @@ public:
 
 			const color_map*	ColorMap();
 
-			status_t			GetBitmap(BBitmap** _bitmap,
+			status_t			GetBitmap(BBitmap** bitmap,
 									bool drawCursor = true,
 									BRect* frame = NULL);
 			status_t			ReadBitmap(BBitmap* bitmap,
@@ -52,7 +52,7 @@ public:
 									BRect* frame = NULL);
 
 			rgb_color			DesktopColor();
-			rgb_color			DesktopColor(uint32 index);
+			rgb_color			DesktopColor(uint32 workspace);
 			void				SetDesktopColor(rgb_color color,
 									bool makeDefault = true);
 			void				SetDesktopColor(rgb_color color,
@@ -61,11 +61,11 @@ public:
 			status_t			ProposeMode(display_mode* target,
 									const display_mode* low,
 									const display_mode* high);
-			status_t			GetModeList(display_mode** _modeList,
-									uint32* _count);
-			status_t			GetMode(display_mode* _mode);
+			status_t			GetModeList(display_mode** modeList,
+									uint32* count);
+			status_t			GetMode(display_mode* mode);
 			status_t			GetMode(uint32 workspace,
-									display_mode* _mode);
+									display_mode* mode);
 			status_t			SetMode(display_mode* mode,
 									bool makeDefault = false);
 			status_t			SetMode(uint32 workspace,
diff --git src/kits/interface/Screen.cpp src/kits/interface/Screen.cpp
index 7c75a55..1ca0831 100644
--- src/kits/interface/Screen.cpp
+++ src/kits/interface/Screen.cpp
@@ -215,10 +215,10 @@ BScreen::ColorMap()
 	\return \c B_OK if the operation was succesful, \c B_ERROR on failure.
 */
 status_t
-BScreen::GetBitmap(BBitmap** _bitmap, bool drawCursor, BRect* bounds)
+BScreen::GetBitmap(BBitmap** bitmap, bool drawCursor, BRect* bounds)
 {
 	if (fScreen != NULL)
-		return fScreen->GetBitmap(_bitmap, drawCursor, bounds);
+		return fScreen->GetBitmap(bitmap, drawCursor, bounds);
 	return B_ERROR;
 }
 
@@ -329,10 +329,10 @@ BScreen::ProposeMode(display_mode* target, const display_mode* low,
 	\return \c B_OK.
 */
 status_t
-BScreen::GetModeList(display_mode** _modeList, uint32* _count)
+BScreen::GetModeList(display_mode** modeList, uint32* count)
 {
 	if (fScreen != NULL)
-		return fScreen->GetModeList(_modeList, _count);
+		return fScreen->GetModeList(modeList, count);
 	return B_ERROR;
 }
 
@@ -428,10 +428,10 @@ BScreen::GetMonitorInfo(monitor_info* info)
 	\return \c B_OK if the operation went fine, otherwise an error code.
 */
 status_t
-BScreen::GetPixelClockLimits(display_mode* mode, uint32* _low, uint32* _high)
+BScreen::GetPixelClockLimits(display_mode* mode, uint32* low, uint32* high)
 {
 	if (fScreen != NULL)
-		return fScreen->GetPixelClockLimits(mode, _low, _high);
+		return fScreen->GetPixelClockLimits(mode, low, high);
 	return B_ERROR;
 }