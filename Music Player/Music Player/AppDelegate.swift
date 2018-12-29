//
//  AppDelegate.swift
//  Music Player
//
//  Created by JeremyXue on 2018/6/9.
//  Copyright © 2018年 JeremyXue. All rights reserved.
//

import UIKit
import GCDWebServer


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // initWebServer()
        // Override point for customization after application launch.
        application.beginReceivingRemoteControlEvents()
        return true
    }

    //Remote Control控制音乐的播放
    override func remoteControlReceived(with event: UIEvent?) {
        switch event?.subtype {
        case UIEventSubtype.remoteControlPlay?: // 音乐播放
//            how to get the reference to the player, then control it
            break
        case UIEventSubtype.remoteControlPause?: // 音乐暂停
            
            break
        case UIEventSubtype.remoteControlPreviousTrack?: //上一首
            break;
        case UIEventSubtype.remoteControlNextTrack?: //下一首
            
            break;
        case UIEventSubtype.remoteControlTogglePlayPause?: //耳机线控的播放暂停
            break
        default:
            break
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func initWebServer() {
        
        let webServer = GCDWebServer()
        
//        webServer.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: {request in
//            return GCDWebServerDataResponse(html:"<html><body><p>Hello World</p></body></html>")
//
//        })
        let documentsPath = NSHomeDirectory() + "/Documents"
        let webUploader = GCDWebUploader(uploadDirectory: documentsPath)
        
        webUploader.start(withPort: 8080, bonjourName: "Web Based Uploads")
        
        print("Visit \(webServer.serverURL) in your web browser")
        
    }

    
}

