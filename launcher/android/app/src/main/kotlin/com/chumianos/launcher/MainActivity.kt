package com.chumianos.launcher

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.app.WallpaperManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.view.View
import android.view.WindowManager
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.chumianos.launcher/system"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "setWallpaper" -> {
                    val assetPath = call.argument<String>("asset")
                    setWallpaperFromAsset(assetPath ?: "assets/wallpapers/default.jpg")
                    result.success(true)
                }
                "hideNavigationBar" -> {
                    hideSystemNavigation()
                    result.success(true)
                }
                "showNavigationBar" -> {
                    showSystemNavigation()
                    result.success(true)
                }
                "expandNotifications" -> {
                    expandNotifications()
                    result.success(true)
                }
                "expandQuickSettings" -> {
                    expandQuickSettings()
                    result.success(true)
                }
                "lockScreen" -> {
                    lockScreen()
                    result.success(true)
                }
                "rebootSystem" -> {
                    rebootSystem()
                    result.success(true)
                }
                "shutdownSystem" -> {
                    shutdownSystem()
                    result.success(true)
                }
                "setSystemSetting" -> {
                    val key = call.argument<String>("key")
                    val value = call.argument<String>("value")
                    setSystemSetting(key ?: "", value ?: "")
                    result.success(true)
                }
                "getSystemSetting" -> {
                    val key = call.argument<String>("key")
                    val value = getSystemSetting(key ?: "")
                    result.success(value)
                }
                "setSecureSetting" -> {
                    val key = call.argument<String>("key")
                    val value = call.argument<String>("value")
                    setSecureSetting(key ?: "", value ?: "")
                    result.success(true)
                }
                "getSecureSetting" -> {
                    val key = call.argument<String>("key")
                    val value = getSecureSetting(key ?: "")
                    result.success(value)
                }
                "enableDeveloperOptions" -> {
                    enableDeveloperOptions()
                    result.success(true)
                }
                "disableDeveloperOptions" -> {
                    disableDeveloperOptions()
                    result.success(true)
                }
                "showAndroidEasterEgg" -> {
                    showAndroidEasterEgg()
                    result.success(true)
                }
                "uninstallApp" -> {
                    val packageName = call.argument<String>("packageName")
                    uninstallApp(packageName ?: "")
                    result.success(true)
                }
                "killApp" -> {
                    val packageName = call.argument<String>("packageName")
                    killApp(packageName ?: "")
                    result.success(true)
                }
                "clearAppData" -> {
                    val packageName = call.argument<String>("packageName")
                    clearAppData(packageName ?: "")
                    result.success(true)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun setWallpaperFromAsset(assetPath: String) {
        try {
            val wallpaperManager = WallpaperManager.getInstance(this)
            val inputStream = assets.open(assetPath)
            wallpaperManager.setStream(inputStream)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun hideSystemNavigation() {
        window.decorView.systemUiVisibility = (
            View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
            or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
            or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
            or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
            or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
            or View.SYSTEM_UI_FLAG_FULLSCREEN
        )
    }

    private fun showSystemNavigation() {
        window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_VISIBLE
    }

    private fun expandNotifications() {
        try {
            val statusBarService = getSystemService("statusbar")
            val statusBarManager = Class.forName("android.app.StatusBarManager")
            val expandMethod = statusBarManager.getMethod("expandNotificationsPanel")
            expandMethod.invoke(statusBarService)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun expandQuickSettings() {
        try {
            val statusBarService = getSystemService("statusbar")
            val statusBarManager = Class.forName("android.app.StatusBarManager")
            val expandMethod = statusBarManager.getMethod("expandSettingsPanel")
            expandMethod.invoke(statusBarService)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun lockScreen() {
        try {
            Runtime.getRuntime().exec("input keyevent 26")
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun rebootSystem() {
        try {
            Runtime.getRuntime().exec("su -c reboot")
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun shutdownSystem() {
        try {
            Runtime.getRuntime().exec("su -c reboot -p")
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun setSystemSetting(key: String, value: String) {
        try {
            Settings.System.putString(contentResolver, key, value)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun getSystemSetting(key: String): String {
        return try {
            Settings.System.getString(contentResolver, key) ?: ""
        } catch (e: Exception) {
            ""
        }
    }

    private fun setSecureSetting(key: String, value: String) {
        try {
            Settings.Secure.putString(contentResolver, key, value)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun getSecureSetting(key: String): String {
        return try {
            Settings.Secure.getString(contentResolver, key) ?: ""
        } catch (e: Exception) {
            ""
        }
    }

    private fun enableDeveloperOptions() {
        try {
            Settings.Global.putInt(contentResolver, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 1)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun disableDeveloperOptions() {
        try {
            Settings.Global.putInt(contentResolver, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 0)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun showAndroidEasterEgg() {
        try {
            val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
            intent.data = Uri.parse("package:com.android.systemui")
            startActivity(intent)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun uninstallApp(packageName: String) {
        try {
            val intent = Intent(Intent.ACTION_DELETE)
            intent.data = Uri.parse("package:$packageName")
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun killApp(packageName: String) {
        try {
            Runtime.getRuntime().exec("su -c am force-stop $packageName")
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun clearAppData(packageName: String) {
        try {
            Runtime.getRuntime().exec("su -c pm clear $packageName")
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
