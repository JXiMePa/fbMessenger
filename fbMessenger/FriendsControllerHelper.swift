//
//  FriendsControllerHelper.swift
//  fbMessenger
//
//  Created by Tarasenco Jurik on 10.05.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit
import CoreData

extension FriendsController {
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                let entityNames = ["Friend","Message"]
                for entityName in entityNames {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
                    
                    for i in objects! {
                        context.delete(i)
                    }
                }

         try context.save() //save
                
            } catch let err { print(err) }
        }
    }
    
    //MARK: DATA Setup
    func setupData() {
        
        //MARK: CLEAR DATA!
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            
            let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            //let mark = Friend()
            mark.name = "Mark! Zuckerberg"
            mark.profileImageName = "zuckprofile"
            //let message = Message()
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            message.friend = mark
            message.text = "Hello my Name is Mark nise to meet you.."
            message.date = NSDate() as Date
            //-----
            
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "steveprofile"
            let messageSteve = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageSteve.friend = steve
            messageSteve.text = "Apple create greats iOS Devices for the world.."
            messageSteve.date = NSDate() as Date
            
            //MARK: SAVE DATA!
            do {
                try context.save()
            } catch let err {
                print(err)
            }
            
            //MARK: LOAD DATA!
            loadData()
            
            //  messages = [message, messageSteve] // old "data"
        }
    }
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            do {
                messages = try (context.fetch(fetchRequest)) as? [Message]
            } catch let err {
                print(err)
            }
        }
    }
}
