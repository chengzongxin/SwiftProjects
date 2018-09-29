//
//  EditVideoViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/27.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import PLShortVideoKit

class EditVideoViewController: UIViewController, PLShortVideoEditorDelegate {
    
    
    var settings: [String:Any]?
    
    var filesURLArray: Array<Any>?
    
    var playerItem: AVPlayerItem?
    
    var shortVideoEditor: PLShortVideoEditor!
    
    var movieSettings: [String : Any]?
    
    var outputSettings: [String : Any]!
    
    lazy var videoSize: CGSize = {
        var videoSize = CGSize.zero
        var movieSettings = settings?[PLSMovieSettingsKey] as? [String:Any]
        var movieAsset = movieSettings?[PLSAssetKey] as? AVAsset
        if movieAsset == nil {
            var movieURL = movieSettings?[PLSURLKey] as? URL
            if let anURL = movieURL {
                movieAsset = AVAsset(url: anURL)
            }
        }
        videoSize = movieAsset?.pls_videoSize ?? CGSize.zero
        return videoSize
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 编辑
        // outputSettings 中的字典元素为 movieSettings, audioSettings, watermarkSettings
        var outputSettings = [AnyHashable : Any]() as? [String : Any]
        let watermarkSettings = [AnyHashable : Any]()
        var originMovieSettings = [AnyHashable : Any]()
        let stickerSettingsArray = [AnyHashable]()
        let audioSettingsArray = [AnyHashable]()
        
        outputSettings?[PLSMovieSettingsKey] = movieSettings
        outputSettings?[PLSWatermarkSettingsKey] = watermarkSettings
        outputSettings?[PLSStickerSettingsKey] = stickerSettingsArray
        outputSettings?[PLSAudioSettingsKey] = audioSettingsArray
        
        // 原始视频
        settings?.forEach { (arg) in let (k, v) = arg; movieSettings?[k] = v }
//        for (k, v) in settings?[PLSMovieSettingsKey] { movieSettings[k] = v }
        movieSettings?[PLSVolumeKey] = 1.0
        
        // 备份原始视频的信息
        movieSettings?.forEach { (k, v) in originMovieSettings[k] = v }
//        currentRateType = PLSVideoRecoderRateNormal
        
        // 背景音乐
//        backgroundAudioSettings = [AnyHashable : Any]()
//        backgroundAudioSettings[PLSVolumeKey] = 1.0
        
        // 水印图片路径
//        var watermarkPath = Bundle.main.path(forResource: "qiniu_logo", ofType: ".png")
//        watermarkImage = UIImage(contentsOfFile: watermarkPath ?? "")
//        watermarkURL = URL(string: watermarkPath ?? "")
//        watermarkSize = watermarkImage.size
//        watermarkPosition = CGPoint(x: 10, y: 65)
//        // 水印
//        watermarkSettings[PLSURLKey] = watermarkURL
//        watermarkSettings[PLSSizeKey] = NSValue(cgSize: watermarkSize)
//        watermarkSettings[PLSPointKey] = NSValue(cgPoint: watermarkPosition)

        movieSettings = settings?[PLSMovieSettingsKey] as? [String:Any]
        let assets = movieSettings?[PLSAssetKey] as! AVAsset
        
//        if let item = playerItem {
//            shortVideoEditor = PLShortVideoEditor(playerItem: item, videoSize: CGSize.zero)
//        }else{
//            shortVideoEditor = PLShortVideoEditor(asset: assets, videoSize: CGSize.zero)
//        }
        shortVideoEditor = PLShortVideoEditor.init(asset: assets)
        
//        shortVideoEditor.delegate = self
        shortVideoEditor.loopEnabled = true
        
        // 要处理的视频的时间区域
        let startF = Int64(movieSettings?[PLSStartTimeKey] as! Double * 1000) // Double
        let durationF = Int64(movieSettings?[PLSDurationKey] as! CGFloat * 1000) // CGFloat
        let start = CMTimeMake(startF, 1000)
        let duration = CMTimeMake(durationF, 1000)
        shortVideoEditor.timeRange = CMTimeRangeMake(start, duration)
        
        view.insertSubview(shortVideoEditor.previewView, at: 0)
        
        shortVideoEditor.startEditing()
        
        
    }
    
    
//    func shortVideoEditor(_ editor: PLShortVideoEditor!, didGetOriginPixelBuffer pixelBuffer: CVPixelBuffer!, timestamp: CMTime) -> Unmanaged<CVPixelBuffer>! {
//        return (pixelBuffer as? Unmanaged<CVPixelBuffer>)!
//    }
    
    
    @IBAction func backButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func nextButtonClick(_ sender: Any) {
        shortVideoEditor.stopEditing()
        
        var asset: AVAsset? = movieSettings?[PLSAssetKey] as? AVAsset
        var exportSession: PLSAVAssetExportSession? = nil
        if let anAsset = asset {
            exportSession = PLSAVAssetExportSession(asset: anAsset)
        }
        exportSession?.outputFileType = .MPEG4
        exportSession?.shouldOptimizeForNetworkUse = true
        exportSession?.outputSettings = outputSettings
//        exportSession?.delegate = self
        exportSession?.isExportMovieToPhotosAlbum = true
        //    // 设置视频的码率
        exportSession?.bitrate = 3000*1000
        //    // 设置视频的输出路径
        //    exportSession.outputURL = [self getFileURL:@"outputMovie"];
        
        // 设置视频的导出分辨率，会将原视频缩放
        exportSession?.outputVideoSize = videoSize
        
        // 旋转视频
//        exportSession?.videoLayerOrientation = videoLayerOrientation
//        exportSession?.addFilter(colorImagePath)
//        exportSession?.addMVLayer(withColor: colorURL, alpha: alphaURL)
        
        exportSession?.completionBlock = {
            url in
            print("Asset Export Completed")

            DispatchQueue.main.async(execute: {
                joinNextViewController(url)
            })
        }
        
        exportSession?.failureBlock = { error in
            if let anError = error {
                self.view.makeToast("Asset Export Failed: \(anError)")
            }
        }
        
        exportSession?.processingBlock = { progress in
            // 更新进度 UI
            print("Asset Export Progress: \(progress)")
            print(String(format: "%d%%", Int(progress * 100)))
        }
        
        exportSession?.exportAsynchronously()
        
        func joinNextViewController(_ url: URL?) {
        }

    }
    
}
