
import Foundation
import Clarifai_Apple_SDK

class ClarifaiWrapper {
    static let shared = ClarifaiWrapper()
    
    private(set) var isModelAvailable = false
    private(set) var modelId: String?
    
    private init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willFetchModelNotification(notification:)),
                                               name: NSNotification.Name.CAIWillFetchModel,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didFetchModelNotification(notification:)),
                                               name: NSNotification.Name.CAIDidFetchModel,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(modelDidBecomeAvailable(notification:)),
                                               name: NSNotification.Name.CAIModelDidBecomeAvailable,
                                               object: nil)
    }
    
    func start(key: String) {
        print("Start With Key: \(key)")
        Clarifai.sharedInstance().start(apiKey: key)
    }
    
    @objc
    private func willFetchModelNotification(notification: NSNotification) {
        print("will fetch model")
    }
    
    @objc
    private func didFetchModelNotification(notification: NSNotification) {
        print("will fetch model")
    }
    
    @objc
    private func modelDidBecomeAvailable(notification: NSNotification) {
        print("model did become available")
        guard let userInfo = notification.userInfo,
            let modelId = userInfo[CAIModelUniqueIdentifierKey] as? String else
        {
            return
        }
        print("model id: \(modelId)")
        self.modelId = modelId
    }
}
