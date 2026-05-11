package com.example.fluttertest

import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.telephony.SubscriptionInfo
import android.telephony.SubscriptionManager
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "sim_reader"

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {

        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            if (call.method == "getSimNumbers") {

                val list = mutableListOf<Map<String, String>>()

                try {

                    if (
                        ActivityCompat.checkSelfPermission(
                            this,
                            Manifest.permission.READ_PHONE_STATE
                        ) != PackageManager.PERMISSION_GRANTED
                    ) {

                        result.error(
                            "PERMISSION",
                            "Permission denied",
                            null
                        )

                        return@setMethodCallHandler
                    }

                    val manager =
                        getSystemService(
                            SubscriptionManager::class.java
                        )

                    val subscriptions:
                            List<SubscriptionInfo>? =
                        manager.activeSubscriptionInfoList

                    subscriptions?.forEach {

                        val map = mapOf(
                            "number" to (it.number ?: ""),
                            "carrier" to
                                    (it.carrierName?.toString()
                                        ?: "")
                        )

                        list.add(map)
                    }

                    result.success(list)

                } catch (e: Exception) {

                    result.error(
                        "ERROR",
                        e.message,
                        null
                    )
                }
            }
        }
    }
}
