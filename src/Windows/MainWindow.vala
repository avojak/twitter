/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

public class Twitter.Windows.MainWindow : Hdy.Window {

    public weak Twitter.Application app { get; construct; }

    private Twitter.Services.ActionManager action_manager;
    private Gtk.AccelGroup accel_group;

    private Twitter.Layouts.MainLayout layout;

    public MainWindow (Twitter.Application application) {
        Object (
            title: Constants.APP_NAME,
            application: application,
            app: application,
            border_width: 0,
            resizable: true,
            window_position: Gtk.WindowPosition.CENTER
        );
    }

    construct {
        accel_group = new Gtk.AccelGroup ();
        add_accel_group (accel_group);
        action_manager = new Twitter.Services.ActionManager (app, this);

        layout = new Twitter.Layouts.MainLayout (this);

        add (layout);

        restore_window_position ();

        this.destroy.connect (() => {
            // Do stuff before closing the application
        });

        this.delete_event.connect (before_destroy);

        show_app ();
    }

    private void restore_window_position () {
        move (Twitter.Application.settings.get_int ("pos-x"), Twitter.Application.settings.get_int ("pos-y"));
        resize (Twitter.Application.settings.get_int ("window-width"), Twitter.Application.settings.get_int ("window-height"));
    }

    private void show_app () {
        show_all ();
        present ();
    }

    public bool before_destroy () {
        update_position_settings ();
        destroy ();
        return true;
    }

    private void update_position_settings () {
        int width, height, x, y;

        get_size (out width, out height);
        get_position (out x, out y);

        Twitter.Application.settings.set_int ("pos-x", x);
        Twitter.Application.settings.set_int ("pos-y", y);
        Twitter.Application.settings.set_int ("window-width", width);
        Twitter.Application.settings.set_int ("window-height", height);
    }

    public void show_preferences_dialog () {
        
    }

    public void open_url (string url) {
        layout.open_url (url);
    }

}
