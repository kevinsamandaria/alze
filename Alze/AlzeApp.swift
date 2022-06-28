//
//  AlzeApp.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 06/06/22.
//

import SwiftUI
import AuthenticationServices
import Combine


class AppDelegate: NSObject, UIApplicationDelegate{
    @Published var isAuthorized: Bool = false
//    @StateObject var appManager = AppManager()


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let persistenceController = PersistenceController.shared
        
        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
            switch credentialState {
            case .authorized:
                print("Apple id credential")
                DispatchQueue.main.async {
//                    self.appManager.saveSession(isSuccess: true)
//                    print(self.appManager.isAuthorized)

                }
//                DispatchQueue.main.async {
//                    let rootView = Home().environment(\.managedObjectContext, persistenceController.container.viewContext)
//                    self.window?.rootViewController = UIHostingController(rootView: rootView)
//                    self.window?.makeKeyAndVisible()
//                }

//                break // The Apple ID credential is valid.
            case .revoked, .notFound:
                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                print("Not Found")
                self.isAuthorized = false
//                DispatchQueue.main.async {
//                    let rootView = Login().environment(\.managedObjectContext, persistenceController.container.viewContext)
//                    self.window?.rootViewController = UIHostingController(rootView: rootView)
//                    self.window?.makeKeyAndVisible()
//
//                }
            default:
                break
            }
        }
        print(isAuthorized)
        return true
    }
}

struct AppManager{

    static let Authenticated = PassthroughSubject<Bool, Never>()

    static func IsAuthenticated() -> Bool {
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let persistenceController = PersistenceController.shared
        
//        appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
//            switch credentialState {
//            case .authorized:
//                status = true
//                print(status)
//                print("Apple id credential")
//
//            case .revoked, .notFound:
//                // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
//                print("Not Found")
//                status = false
//            default:
//                break
//            }
//        }
//        print("Status:\(status)")
//        KeychainItem.deleteUserIdentifierFromKeychain()
        print("tesss :\(KeychainItem.currentUserIdentifier)")
        return KeychainItem.currentUserIdentifier != ""
    }
}
@main
struct AlzeApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @StateObject var appManager = AppManager()
    
    let persistenceController = PersistenceController.shared
    var body: some Scene {

        WindowGroup {
            
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)

            //            if appManager.isAuthorized{
//                Home().environmentObject(appManager)
////                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            }else{
//                Login().environmentObject(appManager)
//                    
////                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            }
                
        }
    }
}
