package com.chumianos.launcher

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Intent
import android.graphics.Path
import android.graphics.PixelFormat
import android.graphics.Rect
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.DisplayMetrics
import android.util.Log
import android.view.*
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo
import kotlin.math.abs

class GestureService : AccessibilityService() {
    private var gestureOverlay: View? = null
    private var windowManager: WindowManager? = null
    private val handler = Handler(Looper.getMainLooper())
    private var startX = 0f
    private var startY = 0f
    private var startTime = 0L
    private var isGestureActive = false
    private var lastX = 0f
    private var lastY = 0f
    private val SWIPE_THRESHOLD = 100
    private val SWIPE_VELOCITY_THRESHOLD = 100
    private val LONG_PRESS_DURATION = 400L
    private var longPressRunnable: Runnable? = null
    private var isLongPress = false

    override fun onServiceConnected() {
        super.onServiceConnected()
        serviceInfo = AccessibilityServiceInfo().apply {
            eventTypes = AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED or
                    AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED
            feedbackType = AccessibilityServiceInfo.FEEDBACK_GENERIC
            flags = AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS
            notificationTimeout = 100
        }
        setupGestureOverlay()
    }

    private fun setupGestureOverlay() {
        windowManager = getSystemService(WINDOW_SERVICE) as WindowManager
        val metrics = DisplayMetrics()
        windowManager?.defaultDisplay?.getRealMetrics(metrics)

        gestureOverlay = object : View(this) {
            private val gestureDetector = GestureDetector(context, object : GestureDetector.SimpleOnGestureListener() {
                override fun onSingleTapUp(e: MotionEvent): Boolean {
                    return false
                }

                override fun onFling(e1: MotionEvent?, e2: MotionEvent, velocityX: Float, velocityY: Float): Boolean {
                    if (e1 == null) return false
                    val diffX = e2.x - e1.x
                    val diffY = e2.y - e1.y
                    
                    if (abs(diffX) > abs(diffY)) {
                        if (abs(diffX) > SWIPE_THRESHOLD && abs(velocityX) > SWIPE_VELOCITY_THRESHOLD) {
                            if (diffX > 0) {
                                performGlobalAction(GLOBAL_ACTION_BACK)
                            } else {
                                performGlobalAction(GLOBAL_ACTION_RECENTS)
                            }
                            return true
                        }
                    } else {
                        if (abs(diffY) > SWIPE_THRESHOLD && abs(velocityY) > SWIPE_VELOCITY_THRESHOLD) {
                            if (diffY > 0) {
                                // Swipe down - expand notifications
                                expandNotifications()
                            } else {
                                // Swipe up - home
                                performGlobalAction(GLOBAL_ACTION_HOME)
                            }
                            return true
                        }
                    }
                    return false
                }

                override fun onLongPress(e: MotionEvent) {
                    isLongPress = true
                    performGlobalAction(GLOBAL_ACTION_BACK)
                }
            })

            override fun onTouchEvent(event: MotionEvent): Boolean {
                when (event.action) {
                    MotionEvent.ACTION_DOWN -> {
                        startX = event.x
                        startY = event.y
                        lastX = event.x
                        lastY = event.y
                        startTime = System.currentTimeMillis()
                        isGestureActive = true
                        isLongPress = false
                        
                        longPressRunnable = Runnable {
                            if (isGestureActive && !isLongPress) {
                                isLongPress = true
                                performHapticFeedback(HapticFeedbackConstants.LONG_PRESS)
                            }
                        }
                        handler.postDelayed(longPressRunnable!!, LONG_PRESS_DURATION)
                    }
                    MotionEvent.ACTION_MOVE -> {
                        lastX = event.x
                        lastY = event.y
                        
                        if (abs(event.x - startX) > 20 || abs(event.y - startY) > 20) {
                            longPressRunnable?.let { handler.removeCallbacks(it) }
                        }
                    }
                    MotionEvent.ACTION_UP, MotionEvent.ACTION_CANCEL -> {
                        isGestureActive = false
                        longPressRunnable?.let { handler.removeCallbacks(it) }
                        
                        if (!isLongPress) {
                            val diffX = event.x - startX
                            val diffY = event.y - startY
                            val duration = System.currentTimeMillis() - startTime
                            
                            if (abs(diffX) < SWIPE_THRESHOLD && abs(diffY) < SWIPE_THRESHOLD && duration < LONG_PRESS_DURATION) {
                                // Single tap - let it pass through
                            }
                        }
                    }
                }
                return gestureDetector.onTouchEvent(event)
            }
        }

        val params = WindowManager.LayoutParams(
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.MATCH_PARENT,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
            } else {
                @Suppress("DEPRECATION")
                WindowManager.LayoutParams.TYPE_SYSTEM_ALERT
            },
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
            WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL or
            WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS or
            WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN or
            WindowManager.LayoutParams.FLAG_LAYOUT_INSET_DECOR,
            PixelFormat.TRANSLUCENT
        )

        params.gravity = Gravity.TOP or Gravity.START
        windowManager?.addView(gestureOverlay, params)
    }

    private fun expandNotifications() {
        try {
            val service = getSystemService(STATUS_BAR_SERVICE)
            val statusBarManager = Class.forName("android.app.StatusBarManager")
            val expand = statusBarManager.getMethod("expandNotificationsPanel")
            expand.invoke(service)
        } catch (e: Exception) {
            Log.e("GestureService", "Failed to expand notifications", e)
        }
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {}

    override fun onInterrupt() {}

    override fun onDestroy() {
        super.onDestroy()
        gestureOverlay?.let { windowManager?.removeView(it) }
    }
}
