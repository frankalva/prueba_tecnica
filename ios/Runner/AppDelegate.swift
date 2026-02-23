// AppDelegate.swift
// Configura el MethodChannel para obtener comentarios de un post
// desde la capa nativa iOS. En un contexto eCommerce, esto permite
// delegar llamadas de red pesadas al lado nativo para mejor rendimiento,
// por ejemplo al cargar resenas de productos desde un backend propio.

import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
      name: "com.example.flutter_application_1/comments",
      binaryMessenger: controller.binaryMessenger
    )

    channel.setMethodCallHandler { (call, result) in
      if call.method == "getComments" {
        guard let args = call.arguments as? [String: Any],
              let postId = args["postId"] as? Int else {
          result(FlutterError(
            code: "INVALID_ARGUMENT",
            message: "postId is required",
            details: nil
          ))
          return
        }
        self.fetchComments(postId: postId, result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  /// Realiza la peticion HTTP nativa a la API de comentarios
  private func fetchComments(postId: Int, result: @escaping FlutterResult) {
    let urlString = "https://jsonplaceholder.typicode.com/comments?postId=\(postId)"
    guard let url = URL(string: urlString) else {
      result(FlutterError(
        code: "INVALID_URL",
        message: "Could not build URL for postId \(postId)",
        details: nil
      ))
      return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        DispatchQueue.main.async {
          result(FlutterError(
            code: "NETWORK_ERROR",
            message: error.localizedDescription,
            details: nil
          ))
        }
        return
      }

      guard let data = data else {
        DispatchQueue.main.async {
          result(FlutterError(
            code: "NO_DATA",
            message: "No data received from server",
            details: nil
          ))
        }
        return
      }

      do {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        DispatchQueue.main.async {
          result(json)
        }
      } catch {
        DispatchQueue.main.async {
          result(FlutterError(
            code: "PARSE_ERROR",
            message: "Failed to parse JSON response",
            details: error.localizedDescription
          ))
        }
      }
    }
    task.resume()
  }
}
