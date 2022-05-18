/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

public class Twitter.Views.WebView : WebKit.WebView {

    public WebView () {
        Object (
            expand: true,
            web_context: new Twitter.Services.WebContext ()
        );
    }

    construct {
        settings = new WebKit.Settings () {
            allow_file_access_from_file_urls = false,
            enable_back_forward_navigation_gestures = false,
            enable_developer_extras = false,
            enable_java = false,
            enable_javascript = true,
            enable_mediasource = true,
            enable_plugins = false,
            enable_smooth_scrolling = true
        };
    }

}
