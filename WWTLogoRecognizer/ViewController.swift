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
    private let photoOutput = AVCapturePhotoOutput()
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        ClarifaiWrapper.shared.loadModels { success in
            if success {
                print("!!!")
                self.setUpTapGesture()
            }
        }
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
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
            let videoOutput = AVCaptureVideoDataOutput()
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            }
            
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
            }
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            view.layer.addSublayer(previewLayer)
            videoPreviewLayer = previewLayer
            
            captureSession.startRunning()
        } catch {
            print("Cannot start video session")
        }
    }
    
    private func setUpTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func viewTapped() {
        if captureSession.outputs.contains(photoOutput), captureSession.isRunning {
            photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)            
        }
    }
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let cgImage = photo.cgImageRepresentation()?.takeUnretainedValue() else {
            return
        }
        let uiImage = UIImage(cgImage: cgImage, scale: 1, orientation: .right)
        let imageRecognizerViewController = ImageRecognizerViewController(image: uiImage)
        present(imageRecognizerViewController, animated: true)
    }
}
