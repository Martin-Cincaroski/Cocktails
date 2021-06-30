//
//  AppDelegate.swift
//  Cocktails
//
//  Created by Martin on 6/21/21.
//

import UIKit
import FBSDKCoreKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(
          _ application: UIApplication,
          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
      ) -> Bool {
            
          ApplicationDelegate.shared.application(
              application,
              didFinishLaunchingWithOptions: launchOptions
          )

          return true
      }
            
      func application(
          _ app: UIApplication,
          open url: URL,
          options: [UIApplication.OpenURLOptionsKey : Any] = [:]
      ) -> Bool {

          ApplicationDelegate.shared.application(
              app,
              open: url,
              sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
              annotation: options[UIApplication.OpenURLOptionsKey.annotation]
          )

      }

  }
