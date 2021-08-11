/*
 * Copyright (c) 2021 and later Renault S.A.S. / Nissan Motor Company, Limited
 * Developed by Renault S.A.S. / Nissan Motor Company, Limited and affiliates
 * which hold all intellectual property rights. Use of this software is subject
 * to a specific license granted by RENAULT S.A.S. / Nissan Motor Company, Limited.
 */

package com.renault.car.boschradar

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.IBinder
import android.util.Log

import java.util.Objects

class BoschRadarSystemService : Service() {

    companion object {
        const val TAG = "BoschRadar.SystemService"
        const val NOTIFICATION_CHANNEL_ID = "com.renault.car.boschradar"
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        startForeground(2, startForegroundService(this, javaClass.simpleName))
        Log.d(TAG, "BoschRadar system service started")

        return START_STICKY
    }

    override fun onCreate() {
        super.onCreate()
    }

    override fun onDestroy() {
        Log.d(TAG, "BoschRadar system service stopped")
        super.onDestroy()
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    private fun startForegroundService(context: Context, className: String): Notification {
        val chan = NotificationChannel(NOTIFICATION_CHANNEL_ID, className, NotificationManager.IMPORTANCE_NONE)
        chan.lightColor = Color.BLUE
        chan.lockscreenVisibility = Notification.VISIBILITY_SECRET
        val manager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        Objects.requireNonNull(manager, "manager is NULL").createNotificationChannel(chan)

        val notificationBuilder = Notification.Builder(context, NOTIFICATION_CHANNEL_ID)

        return notificationBuilder.setOngoing(true)
            .setContentTitle("App is running in background")
            .setCategory(Notification.CATEGORY_SERVICE)
            .setVisibility(Notification.VISIBILITY_SECRET)
            .setSmallIcon(R.mipmap.ic_launcher)
            .build()
    }
}
