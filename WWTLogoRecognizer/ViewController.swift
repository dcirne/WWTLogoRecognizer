//
//  ViewController.swift
//  WWTLogoRecognizer
//
//  Created by Patrick Maltagliati on 10/18/17.
//  Copyright © 2017 Patrick Maltagliati. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private let captureSession = AVCaptureSession()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        startVideoPreview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoPreviewLayer?.frame = view.layer.frame
    }
    
    private func startVideoPreview() {
        guard let device = AVCaptureDevice.default(for: .video) else {
            print("Cannot create cature device")
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: device)
            captureSession.addInput(input)
            
            let output = AVCaptureVideoDataOutput()
            captureSession.addOutput(output)
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            view.layer.addSublayer(previewLayer)
            videoPreviewLayer = previewLayer
            
            captureSession.startRunning()
        } catch {
            print("Cannot start video session")
        }
    }
}
