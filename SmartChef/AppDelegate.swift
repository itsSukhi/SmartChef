//
//  AppDelegate.swift
//  SmartChef
//
//  Created by osx on 26/08/17.
//  Copyright © 2017 osx. All rights reserved.
// //com.exousia.GMapsDemo   com.codeApp.smartChef

import UIKit
import GoogleMaps
import GooglePlaces
import Google
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import StoreKit
import CoreLocation
import IQKeyboardManagerSwift
import TwitterKit
import SendBirdSDK
import Firebase
import UserNotifications
import UserNotificationsUI
import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate, UNUserNotificationCenterDelegate, FIRMessagingDelegate{
   
    
   
    var AppUserDefaults = UserDefaults.standard
    var window: UIWindow?
    var locationManager = CLLocationManager()
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      IQKeyboardManager.shared.enable = true
        
        UserStore.sharedInstace.feedId = "5"
        UserStore.sharedInstace.feedName = "Everyone"
        FIRApp.configure()
        FIRMessaging.messaging().remoteMessageDelegate = self
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: .firInstanceIDTokenRefresh,
                                               object: nil)
        SBDMain.initWithApplicationId("7235944B-A3EA-4923-B90F-DC268DB772F5")

      if (CLLocationManager.locationServicesEnabled()) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
      } else {
        print("Location services are not enabled");
      }
      LocationStore.sharedInstance.isLocationTypeCurrent = true
      
        GMSServices.provideAPIKey("AIzaSyDg8lsK9V2UmK3KV5pFrhSpMHQ2YiOWqqQ")
        
        // *** For Places ***************
        GMSPlacesClient.provideAPIKey("AIzaSyDg8lsK9V2UmK3KV5pFrhSpMHQ2YiOWqqQ")
        
        PayPalMobile .initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "Ab_EA6lpQXdn5lo6M8N2XlwSqUR-m1v4PXX6oK5yVGkyOteFr2KZHMagGo0WdXdmMRGPJRz16HrDqDri",PayPalEnvironmentSandbox: "hadi_jorjani-facilitator@yahoo.com"])

      TWTRTwitter.sharedInstance().start(withConsumerKey:"dTIFEvKTYAFK1T2gcqxo125ZT", consumerSecret:"fVMA5vnQkqXV3ItlvNkjdJFB18L1B6RgnRp5wJwC6V9yS1I5Ui")

        UNUserNotificationCenter.current().delegate = self
        let options:UNAuthorizationOptions = [UNAuthorizationOptions.alert, UNAuthorizationOptions.badge,UNAuthorizationOptions.sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            
        }
        
        FIRInstanceID.instanceID().getWithHandler { (result, error) in
            if let error = error{
                print("Error is..\(error)")
            }else if let result = result{
                print("Result is ..\(result)")
            }
        }
        
        application.registerForRemoteNotifications()
         return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          completionHandler(UNNotificationPresentationOptions.alert)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("user info for remote notification.\(userInfo)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("Unable to registered notiication.")
    }
    
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        print("Rmote notification..\(remoteMessage)")
    }
    
    func tokenRefreshNotification(_ notification: Notification) {
        
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
            UserDefaults.standard.set(refreshedToken, forKey: "deviceToken")
            let data = Data(refreshedToken.utf8)
            SBDMain.registerDevicePushToken(data, unique: true) { (status, error) in
                
                if error == nil {
                    if status == SBDPushTokenRegistrationStatus.pending {
                        // A token registration is pending.
                        // If this status is returned, invoke `+ registerDevicePushToken:unique:completionHandler:` with `[SBDMain getPendingPushToken]` after connection.
//                        SBDMain.connect(withUserId: "", completionHandler: { (user, error) in
//                            if error == nil {
//                                SBDMain.registerDevicePushToken(SBDMain.getPendingPushToken()!, unique: true, completionHandler: { (status, error) in
//
//                                })
//                            }
//                        })
                        
                    }
                    else {
                        // A device token is successfully registered.
                    }
                }
                else {
                    // Registration failure.
                }
            }
        
            
    }
        
        connectToFcm()
    }
   
    // [START connect_to_fcm]
    
    func connectToFcm() {
        
        // Won't connect since there is no token
        
        guard FIRInstanceID.instanceID().token() != nil else {
            return
        }
        
        // Disconnect previous FCM connection if it exists.
        FIRMessaging.messaging().disconnect()
        
        FIRMessaging.messaging().connect { (error) in
            if error != nil {
                print("Unable to connect with FCM. \(error?.localizedDescription ?? "")")
            } else {
                print("Connected to FCM.")
            }
        }
    }

    
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let locationArray = locations as NSArray
    let locationObj = locationArray.lastObject as! CLLocation
    let coord = locationObj.coordinate
    LocationStore.sharedInstance.latitude = String(describing: coord.latitude)
    LocationStore.sharedInstance.longitude = String(describing: coord.longitude)
  }
  
  
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func requestReview(){
         SKStoreReviewController.requestReview()
    }

    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])

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
        FBSDKAppEvents.activateApp()

        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        AppUserDefaults.set(deviceTokenString, forKey: "deviceToken")
        print("APNs device token: \(deviceTokenString)")
    }
    
}

