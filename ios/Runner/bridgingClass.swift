import Foundation
import Flutter

class FlutterBridgingHandler: NSObject {

    private let methodChannel: FlutterMethodChannel

    init(binaryMessenger: FlutterBinaryMessenger) {
        self.methodChannel = FlutterMethodChannel(name: "flutter_bridging", binaryMessenger: binaryMessenger)
        super.init()

        prepareMethodHandler(deviceChannel: methodChannel)
    }

    private func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
        
        deviceChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            if call.method == "getDeviceModel" {
                
                self.receiveDeviceModel(result: result)
            }
            else {
                result(FlutterMethodNotImplemented)
                return
            }
        })
    }
    private func receiveDeviceModel(result: FlutterResult) {
 
        let deviceModel = UIDevice.current.model
        
   
        result(deviceModel)
    }
}
