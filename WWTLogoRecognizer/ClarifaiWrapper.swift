
import Foundation
import Clarifai_Apple_SDK

class ClarifaiWrapper {
    static let shared = ClarifaiWrapper()
    
    private(set) var isModelAvailable = false
    private(set) var modelId: String?
    private(set) var wwtLogoModel: Model?
    
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
    
    func loadModels(completion: @escaping  (Bool) -> ()) {
        Clarifai.sharedInstance().load(entityType: .model, range: NSMakeRange(0, 1)) { _, loadModelsError in
            guard loadModelsError == nil else {
                print("Could not load models")
                return
            }
            Clarifai.sharedInstance().load(entityId: "wwtLogoModel", entityType: .model) { (dataModel, error) in
                guard let model = dataModel as? Model else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    return
                }
                self.wwtLogoModel = model
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        }
    }
    
    func predict(image: UIImage, completion: @escaping (Bool) -> ()) {
        let image = Image(image: image)
        let dataAsset = DataAsset(image: image)
        let input = Input(dataAsset: dataAsset)
        wwtLogoModel?.predict([input]) { (outputs, error) in
            print("\(error)")
            print("\(outputs)")
            completion(error != nil)
        }
    }
}
