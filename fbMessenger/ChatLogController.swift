//
//  ChatLogController.swift
//  fbMessenger
//
//  Created by Tarasenco Jurik on 14.05.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            if friend?.message?.allObjects != nil {
                if let messagesObjects = friend?.message?.allObjects as? [Message] {
                    messages = messagesObjects
                    messages = messages.sorted(by: ) {$0.date! < $1.date!}
                }
            }
        }
    }
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        collectionView?.register(ChatLogMassageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //MARK: ChatLogCell Implement
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count 
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMassageCell
        cell.messaageLabel.text = messages[indexPath.item].text
        
        if let messageText = messages[indexPath.item].text, let profileImageName = messages[indexPath.item].friend?.profileImageName {
            
            cell.chatLogProfileImageView.image = UIImage(named: profileImageName)
            
            cell.messaageLabel.frame = CGRect(x: 65 + 8, y: 0, width: 250 + 16, height: textFrame(text: messageText).height + 20)
            
            cell.textBubbleView.frame = CGRect(x: 65, y: 0, width: 250 + 16, height: textFrame(text: messageText).height + 20)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText = messages[indexPath.item].text {
            return CGSize(width: view.frame.width, height: textFrame(text: messageText).height + 20)
        }
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Отступи от cell.
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    private func textFrame(text: String) -> CGRect {
        let size = CGSize(width: 250, height: CGFloat(1000))
        let options = NSStringDrawingOptions.usesFontLeading.union(
            NSStringDrawingOptions.usesLineFragmentOrigin)
        
        let frameText = NSString(string: text).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedStringKey : UIFont.systemFont(ofSize: CGFloat(18))], context: nil)
        //.boundingRect -Вычисляет и возвращает ограничивающий frame.
        return frameText
    }
}

class ChatLogMassageCell: BaseCell {
    
    let messaageLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: CGFloat(18))
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
        chatLogProfileImageView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    }
}




