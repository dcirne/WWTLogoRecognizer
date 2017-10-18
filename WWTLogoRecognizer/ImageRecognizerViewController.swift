//
//  ImageRecognizerViewController.swift
//  WWTLogoRecognizer
//
//  Created by Patrick Maltagliati on 10/18/17.
//  Copyright © 2017 Patrick Maltagliati. All rights reserved.
//

import UIKit
import Clarifai_Apple_SDK

class ImageRecognizerViewController: UIViewController {
    let image: UIImage
    @IBOutlet weak var imageView: UIImageView?

    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView?.image = image
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        predict()
    }
    
    private func predict() {}
}
