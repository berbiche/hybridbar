project(
    'sound',
    'vala', 'c',
    version: '6.0.1'
)

gettext_name = meson.project_name() + '-indicator'
gnome = import('gnome')
i18n = import('i18n')

prefix = get_option('prefix')
datadir = join_paths(prefix, get_option('datadir'))
libdir = join_paths(prefix, get_option('libdir'))

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(gettext_name), language: 'c')
add_project_arguments('-DG_LOG_DOMAIN="wingpanel-indicator-sound"', language: 'c')
add_project_arguments('-DUSE_PREFERRED_DEVICES', language: 'c')

add_project_arguments(
    ['--vapidir', join_paths(meson.current_source_dir(), 'vapi')],
    language: 'vala'
)

asresources = gnome.compile_resources(
    'as-resources', 'data/mask.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

wingpanel_dep = dependency('hybridbar-1.0')
wingpanel_indicatorsdir = wingpanel_dep.get_pkgconfig_variable('indicatorsdir', define_variable: ['libdir', libdir])

config_data = configuration_data()
config_data.set_quoted('LOCALEDIR', join_paths(get_option('prefix'), get_option('localedir')))
config_data.set_quoted('GETTEXT_PACKAGE', meson.project_name() + '-indicator')
config_file = configure_file(
    input: 'src/Config.vala.in',
    output: '@BASENAME@',
    configuration: config_data
)

libpulse_dep = meson.get_compiler('vala').find_library('libpulse-ext', dirs: join_paths(meson.source_root(), 'vapi'))

shared_module(
    meson.project_name(),
    config_file,
    'src/Device.vala',
    'src/Indicator.vala',
    'src/Widgets/DisplayWidget.vala',
    'src/Widgets/Scale.vala',
    'src/Widgets/PlayerRow.vala',
    'src/Widgets/PlayerList.vala',
    'src/Widgets/DeviceManagerWidget.vala',
    'src/Widgets/DeviceItem.vala',
    'src/Services/PulseAudioManager.vala',
    'src/Services/MprisClient.vala',
    'src/Services/Volume-control.vala',
    'src/Services/Manager.vala',
    'src/Services/Device.vala',
    'src/Services/MediaPlayer.vala',
    asresources,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gio-2.0'),
        dependency('gobject-2.0'),
		dependency('gio-unix-2.0'),
        dependency('gtk+-3.0'),
        dependency('libpulse'),
        dependency('libpulse-mainloop-glib'),
        dependency('libnotify'),
        dependency('libcanberra'),
        dependency('libcanberra-gtk3'),
        libpulse_dep,
        wingpanel_dep
    ],
    install: true,
    install_dir : wingpanel_indicatorsdir,
)

subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')
