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
            mark.name = "Mark Zuckerberg"
            mark.profileImageName = "zuckprofile"
            
            createMessage(text: "Hello my Name is Mark nice to meet you..", friend: mark, minutesAgo: 0, context: context)
            //-----
            
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "steveprofile"
            
            createMessage(text: "Hello, My name Steve.", friend: steve, minutesAgo: 6.0, context: context)
            createMessage(text: "If you haven't found it yet, keep looking. \n\nStay hungry, stay foolish.", friend: steve, minutesAgo: 2.0, context: context)
            createMessage(text: "You can’t connect the dots looking forward; you can connect them looking backwards. So you have to trust that the dots will somehow connect in your future. You have to trust in something – your gut, destiny, life, karma, whatever. This approach has never let me down, and it has made all the difference in my life!", friend: steve, minutesAgo: 1, context: context)
            
            let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            donald.name = "Donald Trump"
            donald.profileImageName = "donaldprofile"
            createMessage(text: "Make America Great Again", friend: donald, minutesAgo: 5.0, context: context)
            
            let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            gandhi.name = "Mahatma Gandhi"
            gandhi.profileImageName = "gandhiprofile"
            createMessage(text: "Love, Peace and Joy", friend: gandhi, minutesAgo: 60 * 24, context: context)
            
            let hillary = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            hillary.name = "Hillary Clinton"
            hillary.profileImageName = "hillaryprofile"
            createMessage(text: "Plese vote for me, you did for Billy!", friend: hillary, minutesAgo: 8 * 60 * 24, context: context)
            
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
                messages = messages?.sorted(by: ) {$0.date! > $1.date!}
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








