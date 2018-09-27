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
import SVProgressHUD


class ShortVideoViewController: UIViewController, PLShortVideoRecorderDelegate {
    
    @IBOutlet weak var musicButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    var shortVideoRecorder: PLShortVideoRecorder!
    
    var filterView: FilterView!
    
    var currentFilter: PLSFilter?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.randomGradientColor(bounds: view.bounds)
        
        addShortVideoRecorder()
        
        addFilterView()
        
    }
    
    func addShortVideoRecorder() {
        // 1. 创建音视频的采集和编码配置对象
        let videoConfig = PLSVideoConfiguration.default()
        videoConfig?.position = .front
        videoConfig?.videoFrameRate = 25
        videoConfig?.averageVideoBitRate = 1024*1000
        videoConfig?.videoSize = CGSize(width: 544, height: 960)
        videoConfig?.videoOrientation = .portrait
        
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
        shortVideoRecorder.maxDuration = 20.0
        shortVideoRecorder.minDuration = 2.0
        shortVideoRecorder.setBeautifyModeOn(true) // 默认打开美颜
        shortVideoRecorder.outputFileType = .MPEG4
        shortVideoRecorder.innerFocusViewShowEnable = true // 显示 SDK 内部自带的对焦动画
        // 默认YES 从后台进入前台自动开始录制
        shortVideoRecorder.backgroundMonitorEnable = true
        // 5. 开始拍摄
//        shortVideoRecorder.startRecording()
        
    }
    
    
    func addFilterView() {
        filterView = FilterView.instanceFromNib() as? FilterView
        
        filterView.frame = CGRect(x: 60, y: 50, width: UIScreen.main.bounds.width - 120, height: 88)
        view.addSubview(filterView)
        
        filterView.didSelect { (filter) in
            self.currentFilter = filter
        }

    }
}

extension ShortVideoViewController {
    // MARK: - Action
    // 开始录制
    @IBAction func recordButtonClick(_ sender: UIButton) {
        if shortVideoRecorder.isRecording {
            shortVideoRecorder.stopRecording()
        }else{
            shortVideoRecorder.startRecording()
        }
    }
    
    // 返回
    @IBAction func backClick(_ sender: UIButton) {
        UIAlertController.showConfirm(message: "确定放弃这个视频?(共\(shortVideoRecorder.getFilesCount())个视频段)?", in: self) { (action) in
            print(action)
            self.shortVideoRecorder.cancelRecording()
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    // 切换摄像头
    @IBAction func toggleCameraClick(_ sender: UIButton) {
        print(sender)
        shortVideoRecorder.toggleCamera()
    }
    // 闪光灯
    @IBAction func flashClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        shortVideoRecorder.isTorchOn = !shortVideoRecorder.isTorchOn
    }
    
    // 截屏
    @IBAction func screenShotClick(_ sender: UIButton) {
        shortVideoRecorder.getScreenShot { (image) in
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
            self.view.makeToast("保存相片成功!")
        }
    }
    
    // 滤镜
    @IBAction func filterButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        filterView.isHidden = !sender.isSelected
    }
    
    // 美颜
    @IBAction func beatyButtonClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        shortVideoRecorder.setBeautifyModeOn(!sender.isSelected)
    }
    
    // 结束录制
    @IBAction func finishRecordButtonClick(_ sender: UIButton) {
        let asset = shortVideoRecorder.assetRepresentingAllFiles()
        playEvent(asset: asset)
        shortVideoRecorder.cancelRecording()
    }
    
    // 视频源处理
    func playEvent(asset: AVAsset) {
        // 获取当前会话的所有的视频段文件
        let filesURLArray = shortVideoRecorder.getAllFilesURL()
        print("filesURLArray:\(String(describing: filesURLArray))")
        
        var movieAsset: AVAsset? = asset
        if musicButton.isSelected {
            let semaphore = DispatchSemaphore(value: 0)
            SVProgressHUD.show()
            // MusicVolume：1.0，videoVolume:0.0 即完全丢弃掉拍摄时的所有声音，只保留背景音乐的声音
            shortVideoRecorder.mix(withMusicVolume: 1.0, videoVolume: 0.0, completionHandler: { composition, audioMix, error in
                var exporter: AVAssetExportSession? = nil
                if let aComposition = composition {
                    exporter = AVAssetExportSession(asset: aComposition, presetName: AVAssetExportPresetHighestQuality)
                }
                let outputPath: URL? = self.exportAudioMixPath()
                exporter?.outputURL = outputPath
                exporter?.outputFileType = .mp4
                exporter?.shouldOptimizeForNetworkUse = true
                exporter?.audioMix = audioMix
                exporter?.exportAsynchronously(completionHandler: {
                    switch exporter?.status {
                    case .failed?:
                        if let aDescription = exporter?.error.debugDescription {
                            print("audio mix failed：\(aDescription)")
                        }
                    case .cancelled?:
                        print("audio mix canceled")
                    case .completed?:
                        print("audio mix success")
                        if let aPath = outputPath {
                            movieAsset = AVAsset(url: aPath)
                        }
                    default: break
                    }
                    semaphore.signal()
                })
            })
            SVProgressHUD.dismiss()
            _ = semaphore.wait(timeout: .distantFuture)
        }
        // 设置音视频、水印等编辑信息
        var outputSettings: [AnyHashable : Any] = [:]
        // 待编辑的原始视频素材
        var plsMovieSettings: [AnyHashable : Any] = [:]
        plsMovieSettings[PLSAssetKey] = movieAsset
        plsMovieSettings[PLSStartTimeKey] = 0.0
        plsMovieSettings[PLSDurationKey] = shortVideoRecorder.getTotalDuration()
        plsMovieSettings[PLSVolumeKey] = 1.0
        outputSettings[PLSMovieSettingsKey] = plsMovieSettings
        
        performSegue(withIdentifier: "EditVideoViewController", sender: (outputSettings,filesURLArray))
    }
    // 输出路径
    func exportAudioMixPath() -> URL? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0]
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let nowTimeStr = formatter.string(from: Date(timeIntervalSinceNow: 0))
        let fileName = URL(fileURLWithPath: path).appendingPathComponent("\(nowTimeStr)_mix.mp4").absoluteString
        return URL(fileURLWithPath: fileName)
    }

    
    // 跳转到下一个ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is EditVideoViewController {
            
            let (setting,filesURLArray) = sender as! ([AnyHashable : Any],Array<Any>)
            
            let vc = segue.destination as! EditVideoViewController
            vc.settings = setting as? [String : Any]
            vc.filesURLArray = filesURLArray
        }
    }
}

// MARK: - PLShortVideoRecorderDelegate 视频录制回调 Short Video Delegate
extension ShortVideoViewController {
    // 获取录取原始数据(做滤镜处理)
    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, cameraSourceDidGet pixelBuffer: CVPixelBuffer) -> Unmanaged<CVPixelBuffer> {
        if let filter = currentFilter {
            return filter.process(pixelBuffer)
        }
        return PLSFilter()!.process(pixelBuffer)
    }
    
    // 开始录制一段视频时
    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didStartRecordingToOutputFileAt fileURL: URL) {
        print("didStartRecordingToOutputFileAt:" + fileURL.absoluteString)
//        view.makeToast("视频存储地址:" + fileURL.absoluteString, duration: 10, position: "CSToastPositionCenter")
    }
    
    // 正在录制的过程中
    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didRecordingToOutputFileAt fileURL: URL, fileDuration: CGFloat, totalDuration: CGFloat) {
        progressView.setProgress(Float(fileDuration/totalDuration), animated: false)
        durationLabel.text = fileDuration.format(f: ".2")
    }
    
    // 完成一段视频的录制时
    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didFinishRecordingToOutputFileAt fileURL: URL, fileDuration: CGFloat, totalDuration: CGFloat) {
        print("didFinishRecordingToOutputFileAt fileURL:\(fileURL.absoluteString) fileDuration:\(fileDuration) totalDuration:\(totalDuration)")
//        view.makeToast("didFinishRecordingToOutputFileAt fileURL:\(fileURL.absoluteString) fileDuration:\(fileDuration) totalDuration:\(totalDuration)")
    }
}



