/*
 * Copyright (c) 2011-2015 Wingpanel Developers (http://launchpad.net/wingpanel)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
 */

namespace Wingpanel.Services {
	public enum BackgroundState {
		LIGHT,
		DARK,
		TRANSLUCENT_LIGHT,
		TRANSLUCENT_DARK,
	}

	public struct Settings {
		public int panel_height { get; set; }
		public int panel_width { get; set; }
		public bool use_transparency { get; set; }
	}

	public class SettingsManager : Object {
		private static SettingsManager? instance = null;

		private BackgroundState current_state = BackgroundState.LIGHT;
		private Settings settings;

		public signal void background_state_changed (BackgroundState state, uint animation_duration_ms);
		public signal void settings_state_changed (Settings settings);

		public static void initialize (int panel_height) {
			var manager = SettingsManager.get_default ();
			manager.settings.panel_height = panel_height;
		}

		private SettingsManager () {
			var panel_gsettings = new GLib.Settings ("com.github.hcsubser.hybridbar");

			settings = Settings ();

			panel_gsettings.changed["use-transparency"].connect (() => {
				background_changed (panel_gsettings.get_boolean ("use-transparency"));
			});
			panel_gsettings.changed["panel-width"].connect (() => {
				panel_width_changed (panel_gsettings.get_int ("panel-width"));
			});
			panel_gsettings.changed["panel-height"].connect (() => {
				panel_height_changed (panel_gsettings.get_int ("panel-height"));
			});

			background_changed (panel_gsettings.get_boolean ("use-transparency"));
			panel_height_changed (panel_gsettings.get_int ("panel-height"), false);
			panel_width_changed (panel_gsettings.get_int ("panel-width"), false);

			GLib.Idle.add (() => {
				settings_state_changed (settings);
				return GLib.Source.REMOVE;
			}, GLib.Priority.HIGH_IDLE);
			// settings_state_changed (settings);

			// var granite_settings = Granite.Settings.get_default ();
			// var gtk_settings = Gtk.Settings.get_default ();

			// gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;

			// granite_settings.notify["prefers-color-scheme"].connect (() => {
			//    gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
			//});
		}

		public static SettingsManager get_default () {
			if (instance == null) {
				instance = new SettingsManager ();
			}

			return instance;
		}

		private void background_changed (bool use_transparency, uint animation_duration_ms = 200) {
			if (use_transparency) {
				current_state = current_state == BackgroundState.DARK ? BackgroundState.TRANSLUCENT_DARK : BackgroundState.TRANSLUCENT_LIGHT;
			} else {
				current_state = current_state == BackgroundState.TRANSLUCENT_DARK ? BackgroundState.DARK : BackgroundState.LIGHT;
			}
			background_state_changed (current_state, animation_duration_ms);
		}

		private void panel_height_changed (int panel_height, bool propagateChange = true) {
			if (panel_height > 0 || panel_height == -1) {
				settings.panel_height = panel_height;
			} else {
				warning ("settings: panel-height value ignored because outside of range -1..INT_MAX");
			}
			if (propagateChange) {
				debug ("panel_height_changed -> propagate");
				settings_state_changed (settings);
			}
		}

		private void panel_width_changed (int panel_width, bool propagateChange = true) {
			if (panel_width > 0 || panel_width == -1) {
				settings.panel_width = panel_width;
			} else {
				warning ("settings: panel-width value ignored because outside of range -1..INT_MAX");
			}
			if (propagateChange) {
				debug ("panel_width_changed -> propagate");
				settings_state_changed (settings);
			}
		}

	}
}
