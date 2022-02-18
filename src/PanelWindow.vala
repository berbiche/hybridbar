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

public class Wingpanel.PanelWindow : Gtk.Window {
    private const int ANCHOR_TO_EDGES = -1;

    public Services.PopoverManager popover_manager;

    private Widgets.Panel panel;
    private int panel_height = 30;
    private int panel_width = ANCHOR_TO_EDGES;
    private bool expanded = false;
    private int panel_displacement;

    public PanelWindow (Gtk.Application application) {
        Object (
            application: application,
            app_paintable: true,
            decorated: false,
            resizable: false,
            skip_pager_hint: true,
            skip_taskbar_hint: true,
            type_hint: Gdk.WindowTypeHint.DOCK,
            vexpand: false
        );

        var style_context = get_style_context ();
        style_context.add_class (Widgets.StyleClass.PANEL);
        style_context.add_class (Gtk.STYLE_CLASS_MENUBAR);

        var panel_provider = new Gtk.CssProvider ();
        panel_provider.load_from_resource ("com/github/hcsubser/hybridbar/panel.css");
        style_context.add_provider (panel_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        var app_provider = new Gtk.CssProvider ();
        app_provider.load_from_resource ("com/github/hcsubser/hybridbar/application.css");
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), app_provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        this.screen.size_changed.connect (update_panel_dimensions);
        this.screen.monitors_changed.connect (update_panel_dimensions);
        this.screen_changed.connect (update_visual);

        update_visual ();

        popover_manager = new Services.PopoverManager (this);

        panel = new Widgets.Panel (popover_manager);
        panel.realize.connect (on_realize);

        var cycle_action = new SimpleAction ("cycle", null);
        cycle_action.activate.connect (() => panel.cycle (true));

        var cycle_back_action = new SimpleAction ("cycle-back", null);
        cycle_back_action.activate.connect (() => panel.cycle (false));

        application.add_action (cycle_action);
        application.add_action (cycle_back_action);
        application.set_accels_for_action ("app.cycle", {"<Control>Tab"});
        application.set_accels_for_action ("app.cycle-back", {"<Control><Shift>Tab"});

        add (panel);

        GtkLayerShell.init_for_window(this);
        GtkLayerShell.set_layer (this, GtkLayerShell.Layer.TOP);
        GtkLayerShell.auto_exclusive_zone_enable (this);
        GtkLayerShell.set_margin(this, GtkLayerShell.Edge.TOP, 5);
        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.TOP, true);
        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.LEFT, this.panel_width == ANCHOR_TO_EDGES);
        GtkLayerShell.set_anchor(this, GtkLayerShell.Edge.RIGHT, this.panel_width == ANCHOR_TO_EDGES);
    }

    private bool animation_step () {
        if (panel_displacement <= panel_height * (-1)) {
            return false;
        }

        panel_displacement--;

        update_panel_dimensions ();

        return true;
    }

    private void on_realize () {
        update_panel_dimensions ();

        Services.SettingsManager.initialize (panel_height);

        var background_manager = Services.SettingsManager.get_default ();
        background_manager.settings_state_changed.connect (update_settings);

        Timeout.add (300 / panel_height, animation_step);
    }

    private void update_settings (Services.Settings settings) {
        panel_height = settings.panel_height;
        panel_width = settings.panel_width;
        update_panel_dimensions ();
    }

    private void update_panel_dimensions () {
        debug ("update_panel_dimensions");
        panel_height = panel.get_allocated_height ();

        Gdk.Monitor monitor = get_display ().get_primary_monitor () ?? get_display ().get_monitor (0);
        Gdk.Rectangle monitor_dimensions = monitor.get_geometry ();

        panel_width = int.min (monitor_dimensions.width, panel_width);
        panel_height = int.min (monitor_dimensions.height, panel_height);

        GtkLayerShell.set_anchor (this, GtkLayerShell.Edge.LEFT, panel_width == ANCHOR_TO_EDGES);
        GtkLayerShell.set_anchor (this, GtkLayerShell.Edge.RIGHT, panel_width == ANCHOR_TO_EDGES);
        // note: width request is useless if the panel is anchored (but the height request is useful?)
        this.set_size_request (panel_width, (popover_manager.current_indicator != null ? panel_height : -1));
    }

    private void update_visual () {
        var visual = this.screen.get_rgba_visual ();

        if (visual == null) {
            warning ("Compositing not available, things will Look Bad (TM)");
        } else {
            this.set_visual (visual);
        }
    }

    public void set_expanded (bool expand) {
        if (expand && !this.expanded) {
            this.expanded = true;
            GtkLayerShell.set_keyboard_interactivity (this, true);
        } else if (!expand) {
            this.expanded = false;
            GtkLayerShell.set_keyboard_interactivity (this, false);
            this.set_size_request (panel_width, expanded ? panel_height : -1);
        }
    }
}
