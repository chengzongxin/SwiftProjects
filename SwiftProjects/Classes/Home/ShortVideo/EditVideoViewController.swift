//
//  EditVideoViewController.swift
//  SwiftProjects
//
//  Created by Jason on 2018/9/27.
//  Copyright © 2018年 Jason. All rights reserved.
//

import UIKit
import PLShortVideoKit

class EditVideoViewController: UIViewController {
    
    var settings: [String:Any]?
    
    var filesURLArray: Array<Any>?
    
    var playerItem: AVPlayerItem?
    
    var shortVideoEditor: PLShortVideoEditor!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let movieSettings = settings?[PLSMovieSettingsKey] as? [String:Any]
        let assets = movieSettings?[PLSAssetKey] as! AVAsset
        
        if let item = playerItem {
            shortVideoEditor = PLShortVideoEditor(playerItem: item, videoSize: CGSize.zero)
        }else{
            shortVideoEditor = PLShortVideoEditor(asset: assets, videoSize: CGSize.zero)
        }
        
//        shortVideoEditor.delegate = self;
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
    @IBAction func backButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
