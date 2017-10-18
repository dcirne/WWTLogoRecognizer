
import Foundation
import Clarifai_Apple_SDK

class ClarifaiWrapper {
    static let shared = ClarifaiWrapper()
    
    private(set) var isModelAvailable = false
    private(set) var modelId: String?
    
    private init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(modelDidBecomeAvailable(notification:)),
                                               name: Notification.Name("CAIModelDidBecomeAvailable"),
                                               object: nil)
    }
    
    func start(key: String = "") {
        Clarifai.sharedInstance().start(apiKey: key)
    }
    
    @objc
    private func modelDidBecomeAvailable(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let modelId = userInfo[CAIModelUniqueIdentifierKey] as? String else
        {
            return
        }
        self.modelId = modelId
    }
}
