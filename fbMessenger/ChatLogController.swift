//
//  ChatLogController.swift
//  fbMessenger
//
//  Created by Tarasenco Jurik on 14.05.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit
import CoreData

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
//            if friend?.message?.allObjects != nil {
//                if let messagesObjects = friend?.message?.allObjects as? [Message] {
//                    messages = messagesObjects
//                    messages = messages.sorted(by: ) {$0.date! < $1.date!}
//                }
//            }
        }
    }
    
   // var messages = [Message]()
    
    //MARK: Page Items.
    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
       return textField
    }()
    
    let senderButton: UIButton = {
       let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(senderButtonPush), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }()
    @objc private func senderButtonPush(_ sender: UIButton) {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            _ = FriendsController.createMessage(text: inputTextField.text!, friend: friend!, minutesAgo: 0, context: context, isSender: true)
            
            do {
                try context.save()
//                messages.append(newMessageSend)
//                let item = messages.count - 1
//                let insertionIndexPath = NSIndexPath(item: item, section: 0) as IndexPath
//
//                collectionView?.insertItems(at: [insertionIndexPath])
//                collectionView?.scrollToItem(at: insertionIndexPath, at: .top, animated: true)
                
                inputTextField.text?.removeAll()
                
            } catch let err {
                print(err)
            }
        }
    }
    
    @objc private func simulate() {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            _ = FriendsController.createMessage(text: "message send 5 minutes ago ...", friend: friend!, minutesAgo: 1, context: context, isSender: false)
            
            do {
                try context.save()
                
//                messages.append(newMessageSend)
//                messages = messages.sorted(by: ) {$0.date! < $1.date!}
//
//                if let item = messages.index(of: newMessageSend) {
//                let receivingIndexPath = NSIndexPath(item: item, section: 0) as IndexPath
//                collectionView?.insertItems(at: [receivingIndexPath])
//                }
                
            } catch let err {
                print(err)
            }
        }
    }

    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
        // Sort fetchRequest
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        //ascending - a->z (Восходящий)
        fetchRequest.predicate = NSPredicate(format: "friend.name = %@", self.friend!.name!)
        //.predicate - вибор нужного обекта
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        //sectionNameKeyPath - Request objects Name
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try fetchedResultsController.performFetch()
            
            //print(fetchedResultsController.sections?[0].numberOfObjects)
            
        } catch let err {
            print(err)
        }
        
        
        tabBarController?.tabBar.isHidden = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simulate", style: .plain, target: self, action: #selector(simulate))
        
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView?.register(ChatLogMassageCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(messageInputContainerView)
        view.addConstraintsWithVisualFormat(format: "H:|[v0]|", views: messageInputContainerView)
        view.addConstraintsWithVisualFormat(format: "V:[v0(50)]", views: messageInputContainerView)
        
        //Constraint for move
        bottomMessageInputContainerViewCounstreint = NSLayoutConstraint(item: messageInputContainerView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomMessageInputContainerViewCounstreint!)
        
        setupInputComponents()
        
        //Keyboard Notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillHide, object: nil)
    }
    
    var bottomMessageInputContainerViewCounstreint: NSLayoutConstraint?
    
    @objc private func handleKeyboardNotification(notification: NSNotification) {
        
        let isKeyboardShow = notification.name == .UIKeyboardWillShow
        
        // get frame keyBoard
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect
            if isKeyboardShow {
            bottomMessageInputContainerViewCounstreint?.constant = -keyboardFrame!.height
            } else {
            bottomMessageInputContainerViewCounstreint?.constant = 0
                
            }
            UIView.animate(withDuration: 0, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                if isKeyboardShow {
//                let indexPatch  = NSIndexPath(item: self.messages.count - 1, section: 0) as IndexPath
//                self.collectionView?.scrollToItem(at: indexPatch, at: .top, animated: true)
                }
            }
        }
    }
    
    private func setupInputComponents() {
        let topBorderView = UIView()
        topBorderView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(senderButton)
        messageInputContainerView.addSubview(topBorderView)
        
        messageInputContainerView.addConstraintsWithVisualFormat(format: "H:|-8-[v0][v1(60)]|", views: inputTextField, senderButton)
        messageInputContainerView.addConstraintsWithVisualFormat(format: "V:|[v0]|", views: inputTextField)
        messageInputContainerView.addConstraintsWithVisualFormat(format: "V:|[v0]|", views: senderButton)
        messageInputContainerView.addConstraintsWithVisualFormat(format: "H:|[v0]|", views: topBorderView)
        messageInputContainerView.addConstraintsWithVisualFormat(format: "V:|[v0(1)]", views: topBorderView)
        
    }
    
    //MARK: ChatLogCell Implement
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedResultsController.sections?[0].numberOfObjects {
            return count
        //return messages.count
        }
        return 0
    }
    
    //dismiss keyboard
   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMassageCell
        
        let message = fetchedResultsController.object(at: indexPath) as! Message
        
               cell.messaageLabel.text = message.text
        
        
        //let message = messages[indexPath.item]
        if let messageText = message.text, let profileImageName = message.friend?.profileImageName {
            
                cell.chatLogProfileImageView.image = UIImage(named: profileImageName)
            
            if !message.isSender {
                cell.messaageLabel.frame = CGRect(x: 65 + 8, y: 0,
                                                  width: textFrame(text: messageText).width + 16,
                                                  height: textFrame(text: messageText).height + 20)
                
                cell.textBubbleView.frame = CGRect(x: 65, y: 0,
                                                   width: textFrame(text: messageText).width + 16,
                                                   height: textFrame(text: messageText).height + 20)
                
                cell.chatLogProfileImageView.isHidden = false
                cell.textBubbleView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.messaageLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            } else {
                
                cell.messaageLabel.frame = CGRect(
                    x: view.frame.width - textFrame(text: messageText).width - 30,
                    y: 0,
                    width: textFrame(text: messageText).width + 16,
                    height: textFrame(text: messageText).height + 20)
                
                cell.textBubbleView.frame = CGRect(
                    x: view.frame.width - (textFrame(text: messageText).width + 35),
                    y: 0,
                    width: textFrame(text: messageText).width + 16,
                    height: textFrame(text: messageText).height + 20)
                
                cell.chatLogProfileImageView.isHidden = true
                cell.textBubbleView.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                cell.messaageLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let message = fetchedResultsController.object(at: indexPath) as! Message
        
        if let messageText = message.text {
            return CGSize(width: view.frame.width, height: textFrame(text: messageText).height + 20)
        }
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Отступи от cell.
        return UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
    }
    
    //MARK: -> CGRect trom text
    private func textFrame(text: String) -> CGRect {
        let size = CGSize(width: 250, height: view.frame.height)
        let options = NSStringDrawingOptions.usesFontLeading.union(
            NSStringDrawingOptions.usesLineFragmentOrigin)
        
        let frameText = NSString(string: text).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedStringKey : UIFont.systemFont(ofSize: CGFloat(20))], context: nil)
        //.boundingRect -Вычисляет и возвращает ограничивающий frame.
        return frameText
    }
}

//MARK: MassageCell Items
class ChatLogMassageCell: BaseCell {

    let messaageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(20))
        label.text = "...... text "
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        view.layer.cornerRadius = 13
        view.clipsToBounds = true
        return view
    }()
    
    let chatLogProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 23
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        addSubview(textBubbleView)
        addSubview(messaageLabel)
        addSubview(chatLogProfileImageView)
        addConstraintsWithVisualFormat(format: "H:|-8-[v0(50)]", views: chatLogProfileImageView)
        addConstraintsWithVisualFormat(format: "V:[v0(50)]|", views: chatLogProfileImageView)
        
    }
}




