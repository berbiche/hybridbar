/* libnma.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "NMA", gir_namespace = "NMA", gir_version = "1.0", lower_case_cprefix = "nma_")]
namespace NMA {
    [CCode (cheader_filename = "nma-cert-chooser.h", type_id = "nma_cert_chooser_get_type ()")]
    public class CertChooser : Gtk.Grid, Atk.Implementor, Gtk.Buildable, Gtk.Orientable {
        [CCode (has_construct_function = false, type = "GtkWidget*")]
        [Version (since = "1.8.0")]
        public CertChooser (string title, NMA.CertChooserFlags flags);
        [Version (since = "1.8.0")]
        public void add_to_size_group (Gtk.SizeGroup group);
        [Version (since = "1.8.0")]
        public string get_cert (out NM.Setting8021xCKScheme scheme);
        [Version (since = "1.8.0")]
        public unowned string get_cert_password ();
        [Version (since = "1.8.0")]
        public NM.SettingSecretFlags get_cert_password_flags ();
        [Version (since = "1.8.0")]
        public string get_cert_uri ();
        [Version (since = "1.8.0")]
        public string get_key (out NM.Setting8021xCKScheme scheme);
        [Version (since = "1.8.0")]
        public unowned string get_key_password ();
        [Version (since = "1.8.0")]
        public NM.SettingSecretFlags get_key_password_flags ();
        [Version (since = "1.8.0")]
        public string get_key_uri ();
        [Version (since = "1.8.0")]
        public void set_cert (string value, NM.Setting8021xCKScheme scheme);
        [Version (since = "1.8.0")]
        public void set_cert_password (string password);
        [Version (since = "1.8.0")]
        public void set_cert_uri (string uri);
        [Version (since = "1.8.0")]
        public void set_key (string value, NM.Setting8021xCKScheme scheme);
        [Version (since = "1.8.0")]
        public void set_key_password (string password);
        [Version (since = "1.8.0")]
        public void set_key_uri (string uri);
        [Version (since = "1.8.0")]
        public void setup_cert_password_storage (NM.SettingSecretFlags initial_flags, NM.Setting setting, string password_flags_name, bool with_not_required, bool ask_mode);
        [Version (since = "1.8.0")]
        public void setup_key_password_storage (NM.SettingSecretFlags initial_flags, NM.Setting setting, string password_flags_name, bool with_not_required, bool ask_mode);
        [Version (since = "1.8.0")]
        public void update_cert_password_storage (NM.SettingSecretFlags secret_flags, NM.Setting setting, string password_flags_name);
        [Version (since = "1.8.0")]
        public void update_key_password_storage (NM.SettingSecretFlags secret_flags, NM.Setting setting, string password_flags_name);
        [Version (since = "1.8.0")]
        public bool validate () throws GLib.Error;
        [NoAccessorMethod]
        public uint flags { construct; }
        [NoAccessorMethod]
        public string title { construct; }
        [Version (since = "1.8.0")]
        public signal GLib.Error cert_password_validate ();
        [Version (since = "1.8.0")]
        public signal GLib.Error cert_validate ();
        [Version (since = "1.8.0")]
        public signal void changed ();
        [Version (since = "1.8.0")]
        public signal GLib.Error key_password_validate ();
        [Version (since = "1.8.0")]
        public signal GLib.Error key_validate ();
    }
    [CCode (cheader_filename = "nma-mobile-providers.h", ref_function = "nma_country_info_ref", type_id = "nma_country_info_get_type ()", unref_function = "nma_country_info_unref")]
    [Compact]
    public class CountryInfo {
        public unowned string get_country_code ();
        public unowned string get_country_name ();
        public unowned GLib.SList<NMA.MobileProvider> get_providers ();
        public NMA.CountryInfo @ref ();
        public void unref ();
    }
    [CCode (cheader_filename = "nma-mobile-providers.h", ref_function = "nma_mobile_access_method_ref", type_id = "nma_mobile_access_method_get_type ()", unref_function = "nma_mobile_access_method_unref")]
    [Compact]
    public class MobileAccessMethod {
        public unowned string get_3gpp_apn ();
        [CCode (array_length = false, array_null_terminated = true)]
        public unowned string[] get_dns ();
        public NMA.MobileFamily get_family ();
        public unowned string get_gateway ();
        public unowned string get_name ();
        public unowned string get_password ();
        public unowned string get_username ();
        public NMA.MobileAccessMethod @ref ();
        public void unref ();
    }
    [CCode (cheader_filename = "nma-mobile-providers.h", ref_function = "nma_mobile_provider_ref", type_id = "nma_mobile_provider_get_type ()", unref_function = "nma_mobile_provider_unref")]
    [Compact]
    public class MobileProvider {
        [CCode (array_length = false, array_null_terminated = true)]
        public unowned string[] get_3gpp_mcc_mnc ();
        [CCode (array_length = false, array_null_terminated = true)]
        public unowned uint32[] get_cdma_sid ();
        public unowned GLib.SList<NMA.MobileAccessMethod> get_methods ();
        public unowned string get_name ();
        public NMA.MobileProvider @ref ();
        public void unref ();
    }
    [CCode (cheader_filename = "nma-mobile-providers.h", type_id = "nma_mobile_providers_database_get_type ()")]
    public class MobileProvidersDatabase : GLib.Object, GLib.AsyncInitable, GLib.Initable {
        [CCode (cname = "nma_mobile_providers_database_new", has_construct_function = false)]
        public async MobileProvidersDatabase (string? country_codes, string? service_providers, GLib.Cancellable? cancellable) throws GLib.Error;
        public void dump ();
        public unowned GLib.HashTable<string,NMA.CountryInfo> get_countries ();
        public unowned NMA.MobileProvider lookup_3gpp_mcc_mnc (string mccmnc);
        public unowned NMA.MobileProvider lookup_cdma_sid (uint32 sid);
        public unowned NMA.CountryInfo lookup_country (string country_code);
        [CCode (has_construct_function = false)]
        public MobileProvidersDatabase.sync (string? country_codes, string? service_providers, GLib.Cancellable? cancellable = null) throws GLib.Error;
        [NoAccessorMethod]
        public string country_codes { owned get; construct; }
        [NoAccessorMethod]
        public string service_providers { owned get; construct; }
    }
    [CCode (cheader_filename = "nma-mobile-wizard.h", type_id = "nma_mobile_wizard_get_type ()")]
    public class MobileWizard : Gtk.Assistant, Atk.Implementor, Gtk.Buildable {
        [CCode (has_construct_function = false)]
        protected MobileWizard ();
        public void destroy ();
        public void present ();
    }
    [CCode (cheader_filename = "nma-vpn-password-dialog.h", type_id = "nma_vpn_password_dialog_get_type ()")]
    public class VpnPasswordDialog : Gtk.Dialog, Atk.Implementor, Gtk.Buildable {
        [CCode (has_construct_function = false, type = "GtkWidget*")]
        public VpnPasswordDialog (string title, string message, string password);
        public void focus_password ();
        public void focus_password_secondary ();
        public void focus_password_ternary ();
        public unowned string get_password ();
        public unowned string get_password_secondary ();
        public unowned string get_password_ternary ();
        public bool run_and_block ();
        public void set_password (string password);
        public void set_password_label (string label);
        public void set_password_secondary (string password_secondary);
        public void set_password_secondary_label (string label);
        public void set_password_ternary (string password_ternary);
        public void set_password_ternary_label (string label);
        public void set_show_password (bool show);
        public void set_show_password_secondary (bool show);
        public void set_show_password_ternary (bool show);
    }
    [CCode (cheader_filename = "nma-wifi-dialog.h", type_id = "nma_wifi_dialog_get_type ()")]
    public class WifiDialog : Gtk.Dialog, Atk.Implementor, Gtk.Buildable {
        [CCode (has_construct_function = false, type = "GtkWidget*")]
        public WifiDialog (NM.Client client, NM.Connection connection, NM.Device device, NM.AccessPoint ap, bool secrets_only);
        [CCode (has_construct_function = false, type = "GtkWidget*")]
        public WifiDialog.for_create (NM.Client client);
        [CCode (has_construct_function = false, type = "GtkWidget*")]
        public WifiDialog.for_hidden (NM.Client client);
        [CCode (has_construct_function = false, type = "GtkWidget*")]
        public WifiDialog.for_other (NM.Client client);
        public NM.Connection get_connection (out NM.Device device, out NM.AccessPoint ap);
        public bool get_nag_ignored ();
        public Gtk.Widget nag_user ();
        public void set_nag_ignored (bool ignored);
    }
    [CCode (cheader_filename = "nma-mobile-wizard.h", has_type_id = false)]
    public struct MobileWizardAccessMethod {
        public weak string provider_name;
        public weak string plan_name;
        public NM.DeviceModemCapabilities devtype;
        public weak string username;
        public weak string password;
        public weak string gsm_apn;
    }
    [CCode (cheader_filename = "nma-cert-chooser.h", cprefix = "NMA_CERT_CHOOSER_FLAG_", has_type_id = false)]
    [Version (since = "1.8.0")]
    public enum CertChooserFlags {
        NONE,
        CERT,
        PASSWORDS,
        PEM
    }
    [CCode (cheader_filename = "nma-mobile-providers.h", cprefix = "NMA_MOBILE_FAMILY_", has_type_id = false)]
    public enum MobileFamily {
        UNKNOWN,
        @3GPP,
        CDMA
    }
    [CCode (cheader_filename = "nma-mobile-wizard.h", instance_pos = 3.9)]
    public delegate void MobileWizardCallback (NMA.MobileWizard self, bool canceled, NMA.MobileWizardAccessMethod method);
    [CCode (cheader_filename = "nma-version.h", cname = "NMA_MAJOR_VERSION")]
    public const int MAJOR_VERSION;
    [CCode (cheader_filename = "nma-version.h", cname = "NMA_MICRO_VERSION")]
    public const int MICRO_VERSION;
    [CCode (cheader_filename = "nma-version.h", cname = "NMA_MINOR_VERSION")]
    public const int MINOR_VERSION;
    [CCode (cheader_filename = "nma-mobile-providers.h")]
    public static bool mobile_providers_split_3gpp_mcc_mnc (string mccmnc, out string mcc, out string mnc);
    [CCode (cheader_filename = "nma-ui-utils.h")]
    public static NM.SettingSecretFlags utils_menu_to_secret_flags (Gtk.Widget passwd_entry);
    [CCode (cheader_filename = "nma-ui-utils.h")]
    public static void utils_setup_password_storage (Gtk.Widget passwd_entry, NM.SettingSecretFlags initial_flags, NM.Setting setting, string password_flags_name, bool with_not_required, bool ask_mode);
    [CCode (cheader_filename = "nma-ui-utils.h")]
    public static void utils_update_password_storage (Gtk.Widget passwd_entry, NM.SettingSecretFlags secret_flags, NM.Setting setting, string password_flags_name);
}
