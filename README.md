# Hybridbar
The extensible top panel for Wayland forked from [wingpanel](https://github.com/elementary/wingpanel). Hybridbar is an empty container that accepts indicators as extensions, including the applications menu. Individual indicators are located in this repository under the indicators directory.

Supported Wayland compositors are : [Wayfire](https://github.com/WayfireWM/wayfire), [Sway](https://github.com/swaywm/sway/), [River](https://github.com/ifreund/river), [labwc](https://github.com/johanmalm/labwc), [Mir](https://github.com/MirServer/mir), [Kwin(kde)](https://invent.kde.org/plasma/kwin), [Liri Shell](https://github.com/lirios/shell)
and pretty much any other compositor that supports wlr-layer-shell. Gnome is not supported and probably won't be.

Here is a screenshot of it running on Wayfire:
![Screenshot](/data/picture.png)

There was already a fork of wingpanel [here](https://github.com/psnszsn/wingpanel-layer-shell) which worked on wayland, however this one removes all elementary os specific dependencies (such as granite, libgala, switchboard, appstore, libplank) so that it can be easly used on a non-patheon wm.

## Building Hybridbar

You'll need the following dependencies:

* libgee-0.8-dev
* libglib2.0-dev
* libgtk-3-dev
* meson
* valac
* [gtk-layer-shell](https://github.com/wmww/gtk-layer-shell)

Run `meson` to configure the build environment and then `ninja` to build

    meson build --prefix=/usr
    ninja -C build

To install, use `ninja install` then execute with `hybridbar`

    sudo ninja -C build install
    hybridbar

***Note this will only compile an empty bar, indicators have to be compiled manually, see below how***

## Building Indicators
To build indicators there is a custom build script to do it all at once, otherwise you have to compile them manually, note that some indicators have extra dependencies not listed above

    cd indicators
    ./build.sh --prefix=/usr

There are currently 6 indicators all forked from elementary os indicators, those include: applications menu. sound widget, calendar/clock, network applet, session manager and system tray(which currently does not seem to work under wayland, PRs welcome)

## Settings
Change settings using dconf-editor or gsettings
Examples with gsettings:

    gsettings set com.github.hcsubser.hybridbar use-transparency false

To turn off transparency.

    gsettings set com.github.hcsubser.hybridbar.calendar menu-command [command]
    gsettings set com.github.hcsubser.hybridbar.network menu-command [command]
    gsettings set com.github.hcsubser.hybridbar.sound menu-command [command]
    
To set the command used when you click on the Settings... button of the corresponding widget.

    gsettings set com.github.hcsubser.hybridbar.session logout [command]
    gsettings set com.github.hcsubser.hybridbar.session shutdown [command]
    gsettings set com.github.hcsubser.hybridbar.session reboot [command]
    
To change actions corresponding to each button, if you use systemd there is no need to change, defaults will work.

I will eventually make a GUI for these settings but for now this will do it. There are some extra settings with formatting for clock, check them out using dconf-editor.

