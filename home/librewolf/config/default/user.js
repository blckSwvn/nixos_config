//dont work with RFP
user_pref("ui.systemUsesDarkTheme", 1);

// user_pref("browser.theme.system_theme", false);
user_pref("browser.fullscreen.autohide", false);

user_pref("browser.toolbars.bookmarks.visibility", "never");

user_pref("privacy.resistFingerprinting", true);
user_pref("privacy.trackingprotection.enabled", true);

// Force HTTPS
user_pref("dom.security.https_only_mode", true);

// Strong site isolation
user_pref("privacy.firstparty.isolate", true);

// Total cookie isolation
user_pref("network.cookie.cookieBehavior", 5);

// Disable geolocation, sensors, and push
user_pref("geo.enabled", false);
user_pref("device.sensors.enabled", false);
user_pref("dom.push.enabled", false);
user_pref("dom.webnotifications.enabled", false);

// No session restore
user_pref("browser.startup.page", 0);

// Disable battery API
user_pref("dom.battery.enabled", false);

// Telemetry and data reporting
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.aboutHomeSnippets.updateUrl", "");
