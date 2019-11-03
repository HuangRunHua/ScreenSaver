# ScreenSaver

This is a demo that mimics the screensaver program on the Apple retail store prototype. Tap the picture to see the video.

[![Whatch demo video](https://github.com/HuangRunHua/ScreenSaver/blob/master/example.jpg)](https://youtu.be/H4onP8Ujb4s)


Now it has a new animation!!!
![](https://github.com/HuangRunHua/ScreenSaver/blob/master/ScreenSaver/Screenshot/intro%20Airpods.jpg)

## Requirements

- Xcode 11 and later
- iOS 12 and later
- Swift 4.2 and later

## Installation

If you want to run this project on your iPhone, you have to prepare for a Mac and have Xcode installed.

## Usage

There is no special way to use it. 
If you don't want to play with your phone, you can open this app and enjoy the animation.
It's also easy to exit the animation, press the home button (if your device is iPhone 8 and below) or swipe to exit the background (if your device is iPhone X and above). Of course, I offer an easier way, **as long as your phone has a large swing, the software will return to the main screen**, similar to the prototype of the Apple retail store.

## Customize some parameters

If you want to customize some parameters, you can modify some of the following parameters in the program.

## Modify sensitivity

If you think the program monitoring device is not very sensitive, you can make it more sensitive by modifying the value of ds.
```swift
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
                    }
                }
            })
        }
    }
```

## Change videos

If you want to switch to another video, you can modify the incoming video name to achieve the goal.
```swift
if UIDevice.current.userInterfaceIdiom == .pad {
    filePath = Bundle.main.path(forResource: "3", ofType: "mov")
} else if UIDevice.current.userInterfaceIdiom == .phone {
    filePath = Bundle.main.path(forResource: "6", ofType: "mov")
}
```

## License

ScreenSaver is available under the MIT license.
