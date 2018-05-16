//
//  AppDelegate.swift
//  fbMessenger
//
//  Created by Tarasenco Jurik on 10.05.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        // window - okno ekrana pri vklu4enii
        
        //        let layout = UICollectionViewFlowLayout() 
        //        let friendsController = FriendsController(collectionViewLayout: layout)
        //        window?.rootViewController = UINavigationController(rootViewController: friendsController)
        
        window?.rootViewController = CustomTabBarController()
        
        
        // Override point for customization after application launch.
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
        // Вызывается, когда приложение вот-вот завершится. Сохраните данные, если это необходимо. См. Также applicationDidEnterBackground :.
        // Сохраняет изменения в контексте управляемого объекта приложения до истечения срока действия приложения.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        //  - Контейнер, который инкапсулирует стек Core Data в ваше приложение.
        // - NSPersistentContainer упрощает создание и управление стекю Core Data, обрабатывая создание модели управляемых объектов Постоянный контейнер для приложения.
        /// - Эта реализация создает и возвращает контейнер, загрузив хранилище для приложение к нему. Это свойство является необязательным, поскольку существуют законные которые могут привести к сбою в создании store .
        
        let container = NSPersistentContainer(name: "fbMessenger")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                // Замените эту реализацию кодом для правильной обработки ошибки.
                // fatalError () заставляет приложение генерировать журнал сбоев и завершать работу. Вы не должны использовать эту функцию в приложении для доставки, хотя это может быть полезно во время разработки.
                //
                //
                //Типичными причинами ошибки здесь являются:
                // * Родительский каталог не существует, не может быть создан или запрещен для записи.
                // * Постоянное хранилище недоступно из-за разрешений или защиты данных при блокировке устройства.
                // * Устройство не работает.
                // * Не удалось перенести хранилище в текущую версию модели.
                // Проверьте сообщение об ошибке, чтобы определить, какова была фактическая проблема.
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Замените эту реализацию кодом для правильной обработки ошибки.
                // fatalError () заставляет приложение генерировать журнал сбоев и завершать работу. Вы не должны использовать эту функцию в приложении для доставки, хотя это может быть полезно во время разработки.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

