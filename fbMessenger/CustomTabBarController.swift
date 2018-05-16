//
//  CustomTabBarController.swift
//  fbMessenger
//
//  Created by Tarasenco Jurik on 15.05.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setut custom viewControllers
        
        //MARK: Controllers
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let viewController = UIViewController() // empty for now...
        
        //MARK: TabBarControllers create
        let recentMessageNavVC = createNavControllerWithTitle(title: "Recent", imageName: "recent", viewController: friendsController)
        
        let callsController = createNavControllerWithTitle(title: "Calls", imageName: "calls", viewController: viewController)
        
        let peapoleController = createNavControllerWithTitle(title: "People", imageName: "people", viewController: viewController)
        
        let groupsController = createNavControllerWithTitle(title: "Groups", imageName: "groups", viewController: viewController)
        
        let settingsController = createNavControllerWithTitle(title: "Settings", imageName: "settings", viewController: viewController)
        
        viewControllers = [recentMessageNavVC, callsController, peapoleController, groupsController, settingsController]
    }
    
    private func createNavControllerWithTitle(title: String, imageName: String, viewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
}









