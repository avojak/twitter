/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

public class Twitter.Layouts.MainLayout : Gtk.Grid {

    public unowned Twitter.Windows.MainWindow window { get; construct; }

    private WebKit.WebView web_view;

    public MainLayout (Twitter.Windows.MainWindow window) {
        Object (
            window: window
        );
    }

    construct {
        var header_bar = new Twitter.Widgets.HeaderBar ();

        web_view = new Twitter.Views.WebView ();

        var base_grid = new Gtk.Grid () {
            expand = true
        };
        base_grid.attach (web_view, 0, 0);

        attach (header_bar, 0, 0);
        attach (base_grid, 0, 1);

        web_view.load_uri ("https://twitter.com/?utm_source=homescreen&utm_medium=shortcut");

        show_all ();

        web_view.load_changed.connect (update_progress);
        web_view.notify["uri"].connect (update_progress);
        web_view.notify["estimated-load-progress"].connect (update_progress);
        web_view.notify["is-loading"].connect (update_progress);

        
    }

    // TODO: Do this in a way without causing a reload of the page
    public void open_url (string url) {
        //  debug ("URL: %s", url);
        //  debug ("Current URI: %s", web_view.get_uri ());
        var uri = new Soup.URI.with_base (new Soup.URI (web_view.get_uri ()), url);
        //  debug ("New URI: %s", uri.to_string (false));
        web_view.load_uri (uri.to_string (false));
    }

    private void update_progress () {
        
    }

}
