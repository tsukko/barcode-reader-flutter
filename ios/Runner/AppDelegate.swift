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
// https://news.mynavi.jp/itsearch/article/devsoft/1218
// https://github.com/OpenFlutter/fluwx/issues/110
//if ([StringUtil isBlank:imagePath]) {
//        NSData *imageData = [FlutterStandardTypedData typedDataWithBytes:call.arguments[fluwxKeyImageData]].data;
//        [self shareMemoryImage:call result:result imageData:imageData];
//    }
        //planeAddress = CVPixelBufferGetBaseAddress(pixelBuffer);
        //NSData *bytes = [NSData dataWithBytes:planeAddress length:length.unsignedIntegerValue];
        //planeBuffer[@"bytes"] = [FlutterStandardTypedData typedDataWithBytes:bytes];
              //https://gist.github.com/kazz12211/3c8b7aa4c05260298130ba89dde2b22a
                //https://dev.classmethod.jp/smartphone/ios-11-code-ml/
                //https://developers.cyberagent.co.jp/blog/archives/8803/
                
                let ssss = CameraSmaple()
                
                let arguments = call.arguments as? [String: Any]
                let buf = arguments?["bytes"] as! FlutterStandardTypedData
                let height = arguments?["height"] as? Int
                let width = arguments?["width"] as? Int
                let bytesPerRow = arguments?["bytesPerRow"] as? Int
                let base = buf.data

                print("buf: ", buf)
                print("buf.data: ", buf.data)

                // ビットマップコンテキスト作成
                let colorSpace = CGColorSpaceCreateDeviceRGB()
                let bitsPerCompornent = 8
                let bitmapInfo = CGBitmapInfo(rawValue: (CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue) as UInt32)
                let newContext = CGContext(data: base, width: Int(width), height: Int(height), bitsPerComponent: Int(bitsPerCompornent), bytesPerRow: Int(bytesPerRow), space: colorSpace, bitmapInfo: bitmapInfo.rawValue)! as CGContext

                // 画像作成
                let imageRef = newContext.makeImage()!
                let image = UIImage(cgImage: imageRef, scale: 1.0, orientation: UIImageOrientation.up)
                
//                ssss.testMethod2(buf)
                print("height:\(String(describing: height)), width:\(String(describing: width))")

//                Data() *imageData = buf.data;
//                let imageBuffer: CVImageBuffer = CMSampleBufferGetImageBuffer(buf)!
//                let barcode = reader?.decode(buf as! CVImageBuffer)
                let barcode = "123"
                result(barcode)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    )


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    
    
  }
}
