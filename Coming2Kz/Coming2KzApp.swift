//
//  Coming2KzApp.swift
//  Coming2Kz
//
//  Created by Eniola Anthony on 12.07.2022.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification notification: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
     print("\(#function)")
     if Auth.auth().canHandleNotification(notification) {
       completionHandler(.noData)
       return
     }
   }
   
   func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
     print("\(#function)")
     if Auth.auth().canHandle(url) {
       return true
     }
     return false
   }
 }


@main
struct Coming2KzApp: App {
  // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
           RootView()
            .environmentObject(RootModel())
            .environmentObject(ContactsViewModel())
        }
    }
}


//import SwiftUI
//import FirebaseCore
//
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}
//
//@main
//struct YourApp: App {
//  // register app delegate for Firebase setup
//  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
//
//  var body: some Scene {
//    WindowGroup {
//      NavigationView {
//        ContentView()
//      }
//    }
//  }
//}
