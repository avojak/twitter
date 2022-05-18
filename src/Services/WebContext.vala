/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

public class Twitter.Services.WebContext : WebKit.WebContext {

    public WebContext () {
        Object (
            website_data_manager: new Twitter.Services.WebsiteDataManager ()
        );
    }

    construct {
        unowned var cookie_manager = get_cookie_manager ();
        cookie_manager.set_persistent_storage (Twitter.Services.WebsiteDataManager.get_config_path ("cookie-persistent-storage"), WebKit.CookiePersistentStorage.SQLITE);
        cookie_manager.set_accept_policy (WebKit.CookieAcceptPolicy.ALWAYS);
    }

}
