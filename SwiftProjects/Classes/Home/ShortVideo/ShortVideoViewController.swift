//
//  ShortVideoViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/25.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import PLShortVideoKit
import PLPlayerKit

class ShortVideoViewController: UIViewController, PLShortVideoRecorderDelegate {
    
    var shortVideoRecorder: PLShortVideoRecorder!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.randomGradientColor(bounds: view.bounds)
        
        showVideo()
    }
    
    func showVideo() {
        // 1. 创建音视频的采集和编码配置对象
        let videoConfig = PLSVideoConfiguration.default()
        let audioConfig = PLSAudioConfiguration.default()
        // 2. 创建拍摄 recorder 对象
        shortVideoRecorder = PLShortVideoRecorder(videoConfiguration: videoConfig, audioConfiguration: audioConfig)
        shortVideoRecorder.delegate = self
        // 3. 添加摄像头预览视图
//        view.addSubview(shortVideoRecorder.previewView!)
        view.insertSubview(shortVideoRecorder.previewView!, at: 0)
        // 4. 开始采集 在开始录制前需要开启采集，开启采集后才能看到摄像头预览
        shortVideoRecorder.startCaptureSession()
        // 默认为 PLSVideoRecoderRateNormal
        shortVideoRecorder.recoderRate = .normal
        // 设置拍摄时长
        // 单位为秒
        shortVideoRecorder.maxDuration = 60.0
        shortVideoRecorder.minDuration = 2.0
        // 默认YES 从后台进入前台自动开始录制
        shortVideoRecorder.backgroundMonitorEnable = true
        // 5. 开始拍摄
        shortVideoRecorder.startRecording()
    }
}

extension ShortVideoViewController {
    // MARK: - Action
    @IBAction func backClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toggleCameraClick(_ sender: UIButton) {
        print(sender)
        shortVideoRecorder.toggleCamera()
    }
    
    @IBAction func flashClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func screenShotClick(_ sender: UIButton) {
        print(sender)
    }
}


extension ShortVideoViewController {
    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, cameraSourceDidGet pixelBuffer: CVPixelBuffer) -> Unmanaged<CVPixelBuffer> {
        return (PLSFilter()?.process(pixelBuffer))!
    }
}
