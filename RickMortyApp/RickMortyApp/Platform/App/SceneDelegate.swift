//
//  SceneDelegate.swift
//  RickMortyApp
//
//  Created by Héctor Rogel on 11/2/23.
//

import UIKit
import SwiftUI

@main
class SceneDelegate: UIResponder, UIApplicationDelegate, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        let rootView = CharacterListConnector().assembleModule()
        if let windowScene = scene as? UIWindowScene {
            let rootWindow = UIWindow(windowScene: windowScene)
            rootWindow.rootViewController = UIHostingController(rootView: rootView)
            self.window = rootWindow
            rootWindow.makeKeyAndVisible()
        }
    }
}
