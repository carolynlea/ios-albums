//
//  AppDelegate.swift
//  Albums
//
//  Created by Carolyn Lea on 9/1/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let albumController = AlbumController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        let url = URL(string: "https://lastfm-img2.akamaized.net/i/u/174s/1918fe81bb68441d96b2247682bfda21.png")!
//        let song1 = albumController.createSong(duration: "3:25", identifier: "82BDE132-E492-4FED-9A77-B49CADBC2BFD", name: "My Name Is Jonas")
//        let song2 = albumController.createSong(duration: "3:05", identifier: "6E8AC92B-ABB4-4303-89CC-51020CEBB557", name: "No One Else")
//        
//        albumController.createAlbum(artist: "Weezer", coverArt: [url], genres: ["Alternative"], identifier: "5E58FA0F-7DBD-4F1D-956F-89756CF1EB22", albumName: "Weezer (The Blue Album)", songs: [["3:25", "82BDE132-E492-4FED-9A77-B49CADBC2BFD", "My Name Is Jonas"], ["3:05", "6E8AC92B-ABB4-4303-89CC-51020CEBB557", "No One Else"]]) { (error) in
//            if error != nil
//            {
//
//            }
//        }
        
        //albumController.testEncodingExampleAlbum()
        //albumController.testDecodingExampleAlbum()
        
//        albumController.createSong(duration: "3:02", identifier: "322542", name: "My Song") { (error) in
//            if error != nil
//            {
//                return
//            }
        
//        }
        return true
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


}

