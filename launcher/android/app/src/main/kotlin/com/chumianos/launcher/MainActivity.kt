package com.chumianos.launcher

import android.app.WallpaperManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.drawable.BitmapDrawable
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import android.view.KeyEvent
import android.view.View
import android.view.WindowInsets
import android.view.WindowInsetsController
import android.view.WindowManager
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.chumianos.launcher/system"
    private var homeKeyReceiver: BroadcastReceiver? = null
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setupFullScreen()
        registerHomeKeyReceiver()
        hideSystemUI()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "setWallpaper" -> {
                    val path = call.argument<String>("path")
                    if (path != null) {
                        setWallpaperFromPath(path)
                        result.success(true)
                    } else {
                        result.error("INVALID_PATH", "Wallpaper path is null", null)
                    }
                }
                "hideNavigationBar" -> {
                    hideSystemUI()
                    result.success(true)
                }
                "showNavigationBar" -> {
                    showSystemUI()
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
                    if (key != null && value != null) {
                        Settings.System.putString(contentResolver, key, value)
                        result.success(true)
                    } else {
                        result.error("INVALID_PARAMS", "Key or value is null", null)
                    }
                }
                "getSystemSetting" -> {
                    val key = call.argument<String>("key")
                    if (key != null) {
                        val value = Settings.System.getString(contentResolver, key)
                        result.success(value)
                    } else {
                        result.error("INVALID_KEY", "Key is null", null)
                    }
                }
                "setSecureSetting" -> {
                    val key = call.argument<String>("key")
                    val value = call.argument<String>("value")
                    if (key != null && value != null) {
                        Settings.Secure.putString(contentResolver, key, value)
                        result.success(true)
                    } else {
                        result.error("INVALID_PARAMS", "Key or value is null", null)
                    }
                }
                "getSecureSetting" -> {
                    val key = call.argument<String>("key")
                    if (key != null) {
                        val value = Settings.Secure.getString(contentResolver, key)
                        result.success(value)
                    } else {
                        result.error("INVALID_KEY", "Key is null", null)
                    }
                }
                "enableDeveloperOptions" -> {
                    Settings.Global.putInt(contentResolver, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 1)
                    result.success(true)
                }
                "disableDeveloperOptions" -> {
                    Settings.Global.putInt(contentResolver, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 0)
                    result.success(true)
                }
                "isDeveloperOptionsEnabled" -> {
                    val enabled = Settings.Global.getInt(contentResolver, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 0) == 1
                    result.success(enabled)
                }
                "showAndroidEasterEgg" -> {
                    try {
                        val intent = Intent("android.settings.APPLICATION_DEVELOPMENT_SETTINGS")
                        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("FAILED", e.message, null)
                    }
                }
                "uninstallApp" -> {
                    val packageName = call.argument<String>("packageName")
                    if (packageName != null) {
                        uninstallApp(packageName)
                        result.success(true)
                    } else {
                        result.error("INVALID_PACKAGE", "Package name is null", null)
                    }
                }
                "killApp" -> {
                    val packageName = call.argument<String>("packageName")
                    if (packageName != null) {
                        val am = getSystemService(Context.ACTIVITY_SERVICE) as android.app.ActivityManager
                        am.killBackgroundProcesses(packageName)
                        result.success(true)
                    } else {
                        result.error("INVALID_PACKAGE", "Package name is null", null)
                    }
                }
                "clearAppData" -> {
                    val packageName = call.argument<String>("packageName")
                    if (packageName != null) {
                        val am = getSystemService(Context.ACTIVITY_SERVICE) as android.app.ActivityManager
                        am.clearApplicationUserData()
                        result.success(true)
                    } else {
                        result.error("INVALID_PACKAGE", "Package name is null", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun setupFullScreen() {
        WindowCompat.setDecorFitsSystemWindows(window, false)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            window.insetsController?.let { controller ->
                controller.hide(WindowInsets.Type.statusBars() or WindowInsets.Type.navigationBars())
                controller.systemBarsBehavior = WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            }
        } else {
            @Suppress("DEPRECATION")
            window.decorView.systemUiVisibility = (
                View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
                or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN
            )
        }
        window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
        window.addFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS)
        window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
        window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)
    }

    private fun hideSystemUI() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            window.insetsController?.let { controller ->
                controller.hide(WindowInsets.Type.statusBars() or WindowInsets.Type.navigationBars())
                controller.systemBarsBehavior = WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            }
        } else {
            @Suppress("DEPRECATION")
            window.decorView.systemUiVisibility = (
                View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
                or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_FULLSCREEN
            )
        }
    }

    private fun showSystemUI() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            window.insetsController?.show(WindowInsets.Type.statusBars() or WindowInsets.Type.navigationBars())
        } else {
            @Suppress("DEPRECATION")
            window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_VISIBLE
        }
    }

    private fun expandNotifications() {
        try {
            val service = getSystemService(Context.STATUS_BAR_SERVICE)
            val statusBarManager = Class.forName("android.app.StatusBarManager")
            val expand = statusBarManager.getMethod("expandNotificationsPanel")
            expand.invoke(service)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun expandQuickSettings() {
        try {
            val service = getSystemService(Context.STATUS_BAR_SERVICE)
            val statusBarManager = Class.forName("android.app.StatusBarManager")
            val expand = statusBarManager.getMethod("expandSettingsPanel")
            expand.invoke(service)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun lockScreen() {
        val policy = getSystemService(Context.DEVICE_POLICY_SERVICE) as android.app.admin.DevicePolicyManager
        policy.lockNow()
    }

    private fun rebootSystem() {
        try {
            val powerManager = getSystemService(Context.POWER_SERVICE) as android.os.PowerManager
            powerManager.reboot(null)
        } catch (e: Exception) {
            try {
                Runtime.getRuntime().exec("reboot")
            } catch (e2: Exception) {
                e2.printStackTrace()
            }
        }
    }

    private fun shutdownSystem() {
        try {
            val powerManager = getSystemService(Context.POWER_SERVICE) as android.os.PowerManager
            val shutdownMethod = powerManager.javaClass.getMethod("shutdown", Boolean::class.java, String::class.java, Boolean::class.java)
            shutdownMethod.invoke(powerManager, false, null, false)
        } catch (e: Exception) {
            try {
                Runtime.getRuntime().exec("reboot -p")
            } catch (e2: Exception) {
                e2.printStackTrace()
            }
        }
    }

    private fun setWallpaperFromPath(path: String) {
        try {
            val bitmap = BitmapFactory.decodeFile(path)
            val wallpaperManager = WallpaperManager.getInstance(this)
            wallpaperManager.setBitmap(bitmap)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun uninstallApp(packageName: String) {
        val intent = Intent(Intent.ACTION_DELETE)
        intent.data = android.net.Uri.parse("package:$packageName")
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
    }

    private fun registerHomeKeyReceiver() {
        homeKeyReceiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                if (intent?.action == Intent.ACTION_CLOSE_SYSTEM_DIALOGS) {
                    val reason = intent.getStringExtra("reason")
                    if (reason == "homekey" || reason == "recentapps") {
                        // Handle home key press
                    }
                }
            }
        }
        val filter = IntentFilter(Intent.ACTION_CLOSE_SYSTEM_DIALOGS)
        registerReceiver(homeKeyReceiver, filter)
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            hideSystemUI()
        }
    }

    override fun onResume() {
        super.onResume()
        hideSystemUI()
    }

    override fun onDestroy() {
        super.onDestroy()
        homeKeyReceiver?.let { unregisterReceiver(it) }
    }

    override fun onBackPressed() {
        // Disable back button to prevent exiting launcher
    }

    override fun onKeyDown(keyCode: Int, event: KeyEvent?): Boolean {
        return when (keyCode) {
            KeyEvent.KEYCODE_HOME -> true
            KeyEvent.KEYCODE_APP_SWITCH -> true
            else -> super.onKeyDown(keyCode, event)
        }
    }
}
