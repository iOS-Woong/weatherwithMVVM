//
//  SceneDelegate.swift
//  Weather
//
//  Created by 서현웅 on 2023/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let pageViewController = PageViewController()
        
        window.rootViewController = pageViewController
        window.makeKeyAndVisible()
        self.window = window

    }



}

