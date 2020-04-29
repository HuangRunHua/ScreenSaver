//
//  ViewController.swift
//  ScreenSaver
//
//  Created by Runhua Huang on 2019/9/12.
//  Copyright © 2019 Runhua Huang. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Player
import CoreMotion

class ViewController: UIViewController {
    
    
    var looper: AVPlayerLooper?
    var player: Player = Player()
    var filePath: String?
    // 监测动作事件
    let motionManager = CMMotionManager()
    // 操作队列包含需要完成的任务
    let queue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 程序运行的时候不熄屏
        UIApplication.shared.isIdleTimerDisabled = true
        self.playVideo(player: self.player)
        
        testMotion()
    }
    
    // Hide home indicator.  
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    // 给player的视图添加约束
    func addConstrian(player: Player) {
        
        self.view.backgroundColor = .black
        
        self.player.view.frame = self.view.bounds
        
        self.addChild(self.player)
        self.view.addSubview(self.player.view)
        
        self.player.view.translatesAutoresizingMaskIntoConstraints = false
        
        let viewOfTopConstrian = NSLayoutConstraint(item: self.player.view as Any, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        self.view.addConstraint(viewOfTopConstrian)
        
        let viewOfBottomConstrian = NSLayoutConstraint(item: self.player.view as Any, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        self.view.addConstraint(viewOfBottomConstrian)
        
        let viewOfLeadingConstrian = NSLayoutConstraint(item: self.player.view as Any, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        self.view.addConstraint(viewOfLeadingConstrian)
        
        let viewOfTrailingConstrian = NSLayoutConstraint(item: self.player.view as Any, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        self.view.addConstraint(viewOfTrailingConstrian)
    }
    
    
    func playVideo(player: Player) {
        
        // 循环播放视频
        self.player.playbackLoops = true
        
        self.addConstrian(player: self.player)
        
        self.player.fillMode = .resizeAspect

        filePath = Bundle.main.path(forResource: "airpods", ofType: "mov")
        
        let videoURL = URL(fileURLWithPath: filePath!)
        self.player.url = videoURL
        // 不播放背景音乐
        self.player.muted = true
        
        self.player.didMove(toParent: self)
        self.player.playFromBeginning()
    }
    
    
    
    // 监测抖动的函数，如果出现抖动则退回主屏幕
    func testMotion() {
        if motionManager.isDeviceMotionAvailable {
            // 设置0.5是为了监测细微摇动
            let ds: Float = 0.4
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: queue, withHandler: { (motion: CMDeviceMotion?, error: Error?) -> Void in
                if let motion = motion {
                    let userAcc = motion.userAcceleration
                    if fabsf(Float(userAcc.x)) > ds || fabsf(Float(userAcc.y)) > ds || fabsf(Float(userAcc.z)) > ds {
                        DispatchQueue.main.async {
                            // 退出程序返回后台的方法
                            UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
                        }
                        // 使用exit(0)会导致类似程序闪退的动画，不建议使用
                        //exit(0)
                    }
                }
            })
        }
    }


}

