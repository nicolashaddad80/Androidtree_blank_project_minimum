/*
 * Copyright (c) 2021 and later Renault S.A.S. / Nissan Motor Company, Limited
 * Developed by Renault S.A.S. / Nissan Motor Company, Limited and affiliates
 * which hold all intellectual property rights. Use of this software is subject
 * to a specific license granted by RENAULT S.A.S. / Nissan Motor Company, Limited.
 */

package com.renault.car.boschradar

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.UserManager

class BootReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        val userManager = context.getSystemService(Context.USER_SERVICE) as UserManager

        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            if (userManager.isSystemUser) {
                val boschRadarSystemServiceIntent = Intent(context, BoschRadarSystemService::class.java)
                context.startForegroundService(boschRadarSystemServiceIntent)
            }
        }
    }
}
