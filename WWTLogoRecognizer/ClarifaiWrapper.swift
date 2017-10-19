
import Foundation
import Clarifai_Apple_SDK

class ClarifaiWrapper {
    static let shared = ClarifaiWrapper()
    
    private(set) var isModelAvailable = false
    private(set) var modelId: String?
    
    private init() {
        NotificationCenter.default.addObserver(forName: Notification.Name.CAIWillFetchModel,
                                               object: nil,
                                               queue: nil,
                                               using: willFetchModelNotification)
        
        NotificationCenter.default.addObserver(forName: Notification.Name.CAIDidFetchModel,
                                               object: nil,
                                               queue: nil,
                                               using: didFetchModelNotification)
        
        NotificationCenter.default.addObserver(forName: Notification.Name.CAIModelDidBecomeAvailable,
                                               object: nil,
                                               queue: nil,
                                               using: modelDidBecomeAvailable)
    }
    
    func start(key: String) {
        print("Start With Key: \(key)")
        Clarifai.sharedInstance().start(apiKey: key)
    }
    
    @objc
    private func willFetchModelNotification(_ notification: Notification) {
        print("will fetch model")
    }
    
    @objc
    private func didFetchModelNotification(_ notification: Notification) {
        print("will fetch model")
    }
    
    @objc
    private func modelDidBecomeAvailable(_ notification: Notification) {
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
