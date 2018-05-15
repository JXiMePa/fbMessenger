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
            mark.name = "Mark Zuckerberg"
            mark.profileImageName = "zuckprofile"
            //let message = Message()
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            message.friend = mark
            message.text = "Hello my Name is Mark nise to meet you.."
            message.date = Date()
            //-----
            
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "steveprofile"
            
            createMessage(text: "Hello", friend: steve, minutesAgo: 6.0, context: context)
            createMessage(text: "My name Steve", friend: steve, minutesAgo: 2.0, context: context)
            createMessage(text: "Apple Nado?", friend: steve, minutesAgo: 1, context: context)
            
            let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            donald.name = "Donald Trump"
            donald.profileImageName = "donaldprofile"
            createMessage(text: "Make America Great Again", friend: donald, minutesAgo: 5.0, context: context)
            
            
            
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
    
    private func createMessage(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext) {
        
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = Date().addingTimeInterval(-minutesAgo * Double(60))
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            if let friends = fetchFriends() {
                
                messages = [Message]()
                
                for friend in friends {
                    print(friend.name!)
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                    
                    //sort ----
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                    //Only Steve Jobs.
                    fetchRequest.fetchLimit = 1
                    
                    //---------
                    do {
                        let fetchedMessages = try context.fetch(fetchRequest) as? [Message]
                        messages? += fetchedMessages!
                    } catch let err {
                        print(err)
                    }
                }
                messages = messages?.sorted(by: ) {$0.date! < $1.date!}
            }
        }
    }
    
    private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
     if let context = delegate?.persistentContainer.viewContext {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
            
            do {
              return try context.fetch(request) as? [Friend]
            } catch let err {
                print(err)
            }
        }
        return nil
    }
}








