package com.example.flutter_application_1

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL
import org.json.JSONArray
import kotlin.concurrent.thread

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.flutter_application_1/comments"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getComments") {
                    val postId = call.argument<Int>("postId")
                    if (postId == null) {
                        result.error("INVALID_ARGUMENT", "postId is required", null)
                        return@setMethodCallHandler
                    }
                    fetchComments(postId, result)
                } else {
                    result.notImplemented()
                }
            }
    }

    /// fetchComments desde Kotlin by ID 
    private fun fetchComments(postId: Int, result: MethodChannel.Result) {
        thread {
            try {
                val url = URL("https://jsonplaceholder.typicode.com/comments?postId=$postId")
                val connection = url.openConnection() as HttpURLConnection
                connection.requestMethod = "GET"
                connection.connectTimeout = 5000
                connection.readTimeout = 5000

                val responseCode = connection.responseCode
                if (responseCode == HttpURLConnection.HTTP_OK) {
                    val reader = BufferedReader(InputStreamReader(connection.inputStream))
                    val response = StringBuilder()
                    var line: String?
                    while (reader.readLine().also { line = it } != null) {
                        response.append(line)
                    }
                    reader.close()

                    val jsonArray = JSONArray(response.toString())
                    val commentsList = mutableListOf<Map<String, Any>>()

                    for (i in 0 until jsonArray.length()) {
                        val obj = jsonArray.getJSONObject(i)
                        commentsList.add(
                            mapOf(
                                "postId" to obj.getInt("postId"),
                                "id" to obj.getInt("id"),
                                "name" to obj.getString("name"),
                                "email" to obj.getString("email"),
                                "body" to obj.getString("body")
                            )
                        )
                    }

                    runOnUiThread {
                        result.success(commentsList)
                    }
                } else {
                    runOnUiThread {
                        result.error("HTTP_ERROR", "Server responded with code $responseCode", null)
                    }
                }
                connection.disconnect()
            } catch (e: Exception) {
                runOnUiThread {
                    result.error("NETWORK_ERROR", e.message, null)
                }
            }
        }
    }
}
