/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2022 Andrew Vojak <andrew.vojak@gmail.com>
 */

public class Twitter.Services.WebsiteDataManager : WebKit.WebsiteDataManager {

    public WebsiteDataManager () {
        Object (
            base_cache_directory: get_config_path ("site-cache"),
            base_data_directory: get_config_path ("site-data"),
            disk_cache_directory: get_config_path ("http-cache"),
            indexeddb_directory: get_config_path ("indexeddb"),
            local_storage_directory: get_config_path ("local-storage"),
            offline_application_cache_directory: get_config_path ("offline-cache")
        );
    }

    public static string get_config_path (string dir) {
        return GLib.Path.build_path (GLib.Path.DIR_SEPARATOR_S, GLib.Environment.get_user_config_dir (), Constants.APP_ID, dir);
    }

}
