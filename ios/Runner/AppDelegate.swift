import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: "com.tasogarei.test/web", binaryMessenger: controller.binaryMessenger)

    let reader = KXABarcodeReader.sharedInstance()
    reader?.reset()
    reader?.rotation = 1
    reader?.types = 255
    print("version string: \(String(describing: reader?.version))")
    print("version number: \(String(describing: reader?.versionNumber))")

    methodChannel.setMethodCallHandler(
{
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            if call.method == "web" {
                let arguments = call.arguments as? [String: Any]
                let buf = arguments?["bytes"] as! CMSampleBuffer
                let height = arguments?["height"] as? Int
                let width = arguments?["width"] as? Int
                print("height:\(String(describing: height)), width:\(String(describing: width))")

                let imageBuffer: CVImageBuffer = CMSampleBufferGetImageBuffer(buf)!
                // イメージバッファをロックする。
//                CVPixelBufferLockBaseAddress(imageBuffer!, []);

                let barcode = reader?.decode(imageBuffer)
                // イメージバッファをアンロックする。
//                CVPixelBufferUnlockBaseAddress(imageBuffer!, []);
                result(barcode)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    )


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    
    
  }
}
