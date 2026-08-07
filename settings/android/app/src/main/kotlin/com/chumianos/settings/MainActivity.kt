package com.chumianos.settings

import android.content.Context
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.view.WindowManager
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.chumianos.settings/system"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "setBrightness" -> {
                    val value = call.argument<Double>("value") ?: 0.5
                    try {
                        Settings.System.putInt(contentResolver, Settings.System.SCREEN_BRIGHTNESS, (value * 255).toInt())
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("FAILED", e.message, null)
                    }
                }
                "setVolume" -> {
                    result.success(true)
                }
                "enableDeveloperOptions" -> {
                    try {
                        Settings.Global.putInt(contentResolver, Settings.Global.DEVELOPMENT_SETTINGS_ENABLED, 1)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("FAILED", e.message, null)
                    }
                }
                "showAndroidEasterEgg" -> {
                    try {
                        val intent = android.content.Intent("android.settings.APPLICATION_DEVELOPMENT_SETTINGS")
                        intent.flags = android.content.Intent.FLAG_ACTIVITY_NEW_TASK
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("FAILED", e.message, null)
                    }
                }
                "rebootSystem" -> {
                    try {
                        val powerManager = getSystemService(Context.POWER_SERVICE) as android.os.PowerManager
                        powerManager.reboot(null)
                        result.success(true)
                    } catch (e: Exception) {
                        try {
                            Runtime.getRuntime().exec("reboot")
                            result.success(true)
                        } catch (e2: Exception) {
                            result.error("FAILED", e2.message, null)
                        }
                    }
                }
                "shutdownSystem" -> {
                    try {
                        val powerManager = getSystemService(Context.POWER_SERVICE) as android.os.PowerManager
                        val shutdownMethod = powerManager.javaClass.getMethod("shutdown", Boolean::class.java, String::class.java, Boolean::class.java)
                        shutdownMethod.invoke(powerManager, false, null, false)
                        result.success(true)
                    } catch (e: Exception) {
                        try {
                            Runtime.getRuntime().exec("reboot -p")
                            result.success(true)
                        } catch (e2: Exception) {
                            result.error("FAILED", e2.message, null)
                        }
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}
