//
//  CameraVC.swift
//  DevChat
//
//  Created by PRO on 4/24/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit


class CameraVC: CameraViewController, CameraProtocol {

    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var previewView: PreviewView!
    
    override func viewDidLoad() {
        
        self.previewView = _previewView
        
        super.viewDidLoad()
    
    }

    @IBAction func changeCameraBtnPressed(_ sender: Any) {
        changeCamera()
    }
    
    
    @IBAction func recordBtnPressed(_ sender: Any) {
        toggleMovieRecording()
    }
    
    func shouldEnableCameraUI(enable: Bool) {
        cameraBtn.isEnabled = enable
        print("Should enable camera ui")
    }
    
    func shouldEnableRecordingUI(enable: Bool) {
        recordBtn.isEnabled = enable
        print("Should enable recording ui")
    }
    
    func canStartRecording() {
        print("Can start recording")
    }
    
    func recordingHasStarted() {
        print("Recording has started")
    }

}

