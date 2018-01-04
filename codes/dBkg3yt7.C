/*

 * Copyright (C) 2015 Red Hat

 * Author: steamport <gameexpertnetwork@gmail.com>

 * This is based off of Rob Clark's panel-lg-novatek-1080p-vid.c (thanks rob for your help!)

 *

 * This program is free software; you can redistribute it and/or modify it

 * under the terms of the GNU General Public License version 2 as published by

 * the Free Software Foundation.

 *

 * This program is distributed in the hope that it will be useful, but WITHOUT

 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or

 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for

 * more details.

 *

 * You should have received a copy of the GNU General Public License along with

 * this program.  If not, see <http://www.gnu.org/licenses/>.

 */



#include <linux/backlight.h>

#include <linux/gpio/consumer.h>

#include <linux/module.h>

#include <linux/of.h>

#include <linux/regulator/consumer.h>



#include <drm/drmP.h>

#include <drm/drm_crtc.h>

#include <drm/drm_mipi_dsi.h>

#include <drm/drm_panel.h>



#include <video/mipi_display.h>



struct lg_panel {

	struct drm_panel base;

	struct mipi_dsi_device *dsi;



	struct backlight_device *backlight;

	struct regulator *supply;

	struct gpio_desc *reset_gpio;



	bool prepared;

	bool enabled;



	const struct drm_display_mode *mode;

};



static inline struct lg_panel *to_lg_panel(struct drm_panel *panel)

{

	return container_of(panel, struct lg_panel, base);

}



static int lg_panel_init(struct lg_panel *lg) //translated from https://github.com/LineageOS/android_kernel_amazon_hdx-common/blob/cm-14.1/arch/arm/boot/dts/dsi-panel-novatek-1080p-video.dtsi

{

	struct mipi_dsi_device *dsi = lg->dsi;

	int ret;



	dsi->mode_flags |= MIPI_DSI_MODE_LPM;

		

	msleep(5);

	ret = mipi_dsi_turn_on_peripheral(dsi); /* peripheral on, change the delay from 100 to 5ms */

	if (ret < 0)

		return ret;

	

	ret = mipi_dsi_generic_write(dsi, (u8[]){0xf3, 0xa8}, 2); /* unlock page 8 */

	if (ret < 0)

		return ret;

	

	ret = mipi_dsi_generic_write(dsi, (u8[]){0x7a, 0x2b}, 2); /* 0x87a = 2b, this and below relate to garbage screen */

	if (ret < 0)

		return ret;

	

	ret = mipi_dsi_generic_write(dsi, (u8[]){0x7b, 0x63}, 2); /* 0x87b = 63 */

	if (ret < 0)

		return ret;

	

	ret = mipi_dsi_generic_write(dsi, (u8[]){0x7c, 0x0d}, 2); /* 0x87c = 0d */

	if (ret < 0)

		return ret;

		

	ret = mipi_dsi_generic_write(dsi, (u8[]){0x7e, 0x60}, 2); /* 0x87e = 60 */

	if (ret < 0)

		return ret;

	

	ret = mipi_dsi_generic_write(dsi, (u8[]){0x80, 0x00}, 2); /* 0x880 = 00 */

	if (ret < 0)

		return ret;

	

	ret = mipi_dsi_generic_write(dsi, (u8[]){0x81, 0x00}, 2); /* 0x881 = 00 */

	if (ret < 0)

		return ret;

		

	msleep(1);

	ret = mipi_dsi_generic_write(dsi, (u8[]){}, 0); /* lock page 8 */

	if (ret < 0)

		return ret;

	

	ret = mipi_dsi_generic_write(dsi, (u8[]){0xf3, 0xa1}, 2); /* unlock page 1 */

	if (ret < 0)

		return ret;

	

	ret = mipi_dsi_generic_write(dsi, (u8[]){0x53, 0x83}, 2); /* 0x153 = 80 */

	if (ret < 0)

		return ret;

	return 0;

	

	msleep(1);

	ret = mipi_dsi_generic_write(dsi, (u8[]){}, 0); /* lock page 1 */

	if (ret < 0)

		return ret;

}



static int lg_panel_on(struct lg_panel *lg)

{

	struct mipi_dsi_device *dsi = lg->dsi;

	int ret;



	dsi->mode_flags |= MIPI_DSI_MODE_LPM;



	ret = mipi_dsi_dcs_set_display_on(dsi);

	if (ret < 0)

		return ret;



	msleep(40);



	return 0;

}



static int lg_panel_off(struct lg_panel *lg)

{

	struct mipi_dsi_device *dsi = lg->dsi;

	int ret;



	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;



	ret = mipi_dsi_dcs_write(dsi, 0xff, (u8[]){ 0x10 }, 1);

	if (ret < 0)

		return ret;



	ret = mipi_dsi_dcs_set_display_off(dsi);

	if (ret < 0)

		return ret;



	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);

	if (ret < 0)

		return ret;



	msleep(100);



	return 0;

}



static int lg_panel_disable(struct drm_panel *panel)

{

	struct lg_panel *lg = to_lg_panel(panel);



	if (!lg->enabled)

		return 0;



	DRM_DEBUG("disable\n");



	if (lg->backlight) {

		lg->backlight->props.power = FB_BLANK_POWERDOWN;

		backlight_update_status(lg->backlight);

	}



	lg->enabled = false;



	return 0;

}



static int lg_panel_unprepare(struct drm_panel *panel)

{

	struct lg_panel *lg = to_lg_panel(panel);

	int ret;



	if (!lg->prepared)

		return 0;



	DRM_DEBUG("unprepare\n");



	ret = lg_panel_off(lg);

	if (ret) {

		dev_err(panel->dev, "failed to set panel off: %d\n", ret);

		return ret;

	}



	regulator_disable(lg->supply);

	if (lg->reset_gpio)

		gpiod_set_value(lg->reset_gpio, 0);



	lg->prepared = false;



	return 0;

}



static int lg_panel_prepare(struct drm_panel *panel)

{

	struct lg_panel *lg = to_lg_panel(panel);

	int ret;



	if (lg->prepared)

		return 0;



	DRM_DEBUG("prepare\n");



	if (lg->reset_gpio) {

		gpiod_set_value(lg->reset_gpio, 0);

		msleep(5);

	}



	ret = regulator_enable(lg->supply);

	if (ret < 0)

		return ret;



	msleep(20);



	if (lg->reset_gpio) {

		gpiod_set_value(lg->reset_gpio, 1);

		msleep(10);

	}



	msleep(150);



	ret = lg_panel_init(lg);

	if (ret) {

		dev_err(panel->dev, "failed to init panel: %d\n", ret);

		goto poweroff;

	}



	ret = lg_panel_on(lg);

	if (ret) {

		dev_err(panel->dev, "failed to set panel on: %d\n", ret);

		goto poweroff;

	}



	lg->prepared = true;



	return 0;



poweroff:

	regulator_disable(lg->supply);

	if (lg->reset_gpio)

		gpiod_set_value(lg->reset_gpio, 0);

	return ret;

}



static int lg_panel_enable(struct drm_panel *panel)

{

	struct lg_panel *lg = to_lg_panel(panel);



	if (lg->enabled)

		return 0;



	DRM_DEBUG("enable\n");



	if (lg->backlight) {

		lg->backlight->props.power = FB_BLANK_UNBLANK;

		backlight_update_status(lg->backlight);

	}



	lg->enabled = true;



	return 0;

}



static const struct drm_display_mode default_mode = {

		.clock = 165080,

		.hdisplay = 1200,

		.hsync_start = 1200 + 56,

		.hsync_end = 1200 + 56 + 8,

		.htotal = 1200 + 56 + 8 + 8,

		.vdisplay = 1920,

		.vsync_start = 1920 + 233,

		.vsync_end = 1920 + 233 + 2,

		.vtotal = 1920 + 233 + 2 + 8,

		.vrefresh = 60,

};



static int lg_panel_get_modes(struct drm_panel *panel)

{

	struct drm_display_mode *mode;



	mode = drm_mode_duplicate(panel->drm, &default_mode);

	if (!mode) {

		dev_err(panel->drm->dev, "failed to add mode %ux%ux@%u\n",

				default_mode.hdisplay, default_mode.vdisplay,

				default_mode.vrefresh);

		return -ENOMEM;

	}



	drm_mode_set_name(mode);



	drm_mode_probed_add(panel->connector, mode);



	panel->connector->display_info.width_mm = 64;

	panel->connector->display_info.height_mm = 114;



	return 1;

}



static const struct drm_panel_funcs lg_panel_funcs = {

		.disable = lg_panel_disable,

		.unprepare = lg_panel_unprepare,

		.prepare = lg_panel_prepare,

		.enable = lg_panel_enable,

		.get_modes = lg_panel_get_modes,

};



static const struct of_device_id lg_of_match[] = {

		{ .compatible = "novatek,nt71392qg", },

		{ }

};

MODULE_DEVICE_TABLE(of, lg_of_match);



static int lg_panel_add(struct lg_panel *lg)

{

	struct device *dev= &lg->dsi->dev;

	struct device_node *np;

	int ret;



	lg->mode = &default_mode;



	lg->supply = devm_regulator_get(dev, "power");

	if (IS_ERR(lg->supply))

		return PTR_ERR(lg->supply);



	lg->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);

	if (IS_ERR(lg->reset_gpio)) {

		dev_err(dev, "cannot get reset-gpios %ld\n",

			PTR_ERR(lg->reset_gpio));

		lg->reset_gpio = NULL;

	} else {

		gpiod_direction_output(lg->reset_gpio, 0);

	}



	np = of_parse_phandle(dev->of_node, "backlight", 0);

	if (np) {

		lg->backlight = of_find_backlight_by_node(np);

		of_node_put(np);



		if (!lg->backlight)

			return -EPROBE_DEFER;

	}



	drm_panel_init(&lg->base);

	lg->base.funcs = &lg_panel_funcs;

	lg->base.dev = &lg->dsi->dev;



	ret = drm_panel_add(&lg->base);

	if (ret < 0)

		goto put_backlight;



	return 0;



	put_backlight:

	if (lg->backlight)

		put_device(&lg->backlight->dev);



	return ret;

}



static void lg_panel_del(struct lg_panel *lg)

{

	if (lg->base.dev)

		drm_panel_remove(&lg->base);



	if (lg->backlight)

		put_device(&lg->backlight->dev);

}



static int lg_panel_probe(struct mipi_dsi_device *dsi)

{

	struct lg_panel *lg;

	int ret;



	dsi->lanes = 4;

	dsi->format = MIPI_DSI_FMT_RGB888;

	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |

			MIPI_DSI_MODE_VIDEO_HSE |

			MIPI_DSI_CLOCK_NON_CONTINUOUS |

			MIPI_DSI_MODE_EOT_PACKET;



	lg = devm_kzalloc(&dsi->dev, sizeof(*lg), GFP_KERNEL);

	if (!lg) {

		return -ENOMEM;

	}



	mipi_dsi_set_drvdata(dsi, lg);



	lg->dsi = dsi;



	ret = lg_panel_add(lg);

	if (ret < 0) {

		return ret;

	}



	return mipi_dsi_attach(dsi);

}



static int lg_panel_remove(struct mipi_dsi_device *dsi)

{

	struct lg_panel *lg = mipi_dsi_get_drvdata(dsi);

	int ret;



	ret = lg_panel_disable(&lg->base);

	if (ret < 0)

		dev_err(&dsi->dev, "failed to disable panel: %d\n", ret);



	ret = mipi_dsi_detach(dsi);

	if (ret < 0)

		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);



	drm_panel_detach(&lg->base);

	lg_panel_del(lg);



	return 0;

}



static void lg_panel_shutdown(struct mipi_dsi_device *dsi)

{

	struct lg_panel *lg = mipi_dsi_get_drvdata(dsi);



	lg_panel_disable(&lg->base);

}



static struct mipi_dsi_driver lg_panel_driver = {

	.driver = {

		.name = "novatek-1080p-video-mode-dsi-panel",

		.of_match_table = lg_of_match,

	},

	.probe = lg_panel_probe,

	.remove = lg_panel_remove,

	.shutdown = lg_panel_shutdown,

};

module_mipi_dsi_driver(lg_panel_driver);



MODULE_AUTHOR("steamport <gameexpertnetwork@gmail.com>");

MODULE_DESCRIPTION("Novatek panel driver (linux-mainline, for amazon-thor)");

MODULE_LICENSE("GPL v2");