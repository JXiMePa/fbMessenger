//
//  FriendsControllerHelper.swift
//  fbMessenger
//
//  Created by Tarasenco Jurik on 10.05.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit

extension FriendsController {
    
    //MARK: DATA Setup
    func setupData() {
        
        let mark = Friend()
        mark.name = "Mark! Zuckerberg"
        mark.profileImageName = "zuckprofile"
        let message = Message()
        message.friend = mark
        message.text = "Hello my Name is Mark nise to meet you.."
        message.date = NSDate()
        messages = [message]
        //-----
        let steve = Friend()
        steve.name = "Steve Jobs"
        steve.profileImageName = "steveprofile"
        let messageSteve = Message()
        messageSteve.friend = steve
        messageSteve.text = "Apple create greats iOS Devices for the world.."
        messageSteve.date = NSDate()
        messages = [message, messageSteve]
    }
}
