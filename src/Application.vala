/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

public class Twitter.Application : Gtk.Application {

    public static GLib.Settings settings;

    private Twitter.Windows.MainWindow main_window;

    public Application () {
        Object (
            application_id: Constants.APP_ID,
            flags: ApplicationFlags.HANDLES_COMMAND_LINE
        );
    }

    static construct {
        info ("%s version: %s", Constants.APP_ID, Constants.VERSION);
        info ("Kernel version: %s", Posix.utsname ().release);
    }

    construct {
        settings = new GLib.Settings (Constants.APP_ID);
        startup.connect ((handler) => {
            Hdy.init ();
        });
    }

    private void add_new_window () {
        if (main_window == null) {
            this.main_window = new Twitter.Windows.MainWindow (this);
            main_window.destroy.connect (() => {
                main_window = null;
            });
            this.add_window (main_window);
        }
        main_window.present ();
    }

    protected override void activate () {
        force_elementary_style ();

        // Respect the system color scheme preference
        var granite_settings = Granite.Settings.get_default ();
        var gtk_settings = Gtk.Settings.get_default ();
        gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
        });

        this.add_new_window ();
    }

    protected override int command_line (GLib.ApplicationCommandLine command_line) {
        activate ();

        string[] argv = command_line.get_arguments ();
        if (argv.length > 1) {
            main_window.open_url (argv[1]);
        }

        return 0;
    }

    /**
     * Sets the app's icons, cursors, and stylesheet to elementary defaults.
     * See: https://github.com/elementary/granite/pull/501
     */
     private void force_elementary_style () {
        const string STYLESHEET_PREFIX = "io.elementary.stylesheet";
        unowned var gtk_settings = Gtk.Settings.get_default ();

        gtk_settings.gtk_cursor_theme_name = "elementary";
        gtk_settings.gtk_icon_theme_name = "elementary";

        if (!gtk_settings.gtk_theme_name.has_prefix (STYLESHEET_PREFIX)) {
            gtk_settings.gtk_theme_name = string.join (".", STYLESHEET_PREFIX, "blueberry");
        }
    }

    public static int main (string[] args) {
        var app = new Twitter.Application ();
        return app.run (args);
    }

}
