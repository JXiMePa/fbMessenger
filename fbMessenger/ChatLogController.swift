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
    
    //MARK: Cell
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count 
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogMassageCell
        cell.messaageLabel.text = messages[indexPath.item].text
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}

class ChatLogMassageCell: BaseCell {
    
    let messaageLabel: UILabel = {
       let label = UILabel()
      label.font = UIFont.systemFont(ofSize: CGFloat(16))
        label.text = "Sample text "
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
       backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        addSubview(messaageLabel)
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: messaageLabel)
        addConstraintsWithVisualFormat(format: "V:|[v0]|", views: messaageLabel)
    }
}




