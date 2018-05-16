//
//  MessageCell.swift
//  fbMessenger
//
//  Created by Tarasenco Jurik on 10.05.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit
import Foundation

//MARK: create Abstract class Cell
class BaseCell: UICollectionViewCell {
    
    // init Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    func setupViews() { }
}

//MARK: create class Cell
class MessageCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ?  #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            nameLabel.textColor = isHighlighted ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            timeLabel.textColor = isHighlighted ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            messageLabel.textColor = isHighlighted ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    var message: Message? {
        didSet {
            nameLabel.text = message?.friend?.name
            
            if let profileImageName = message?.friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
                hasReadImageView.image = UIImage(named: profileImageName)
            }
            messageLabel.text = message?.text
            
            if let date = message?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a" //24h"HH:MM" //12h("h:mm a")
                let elapsedTimeInSeconds = Date().timeIntervalSince(date)
                let secondsInDey:Double = 60 * 60 * 24
                if elapsedTimeInSeconds > secondsInDey * Double(7) {
                    dateFormatter.dateFormat = "MM/dd/yy"
                } else if elapsedTimeInSeconds > secondsInDey {
                    dateFormatter.dateFormat = "EEE"
                }
                timeLabel.text = dateFormatter.string(from: date)
            }
        }
    }
    
    //MARK: --- Cell Items
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.5)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Xxxxx Xxxxxx"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = ".... ...... (Oo) "
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .right
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        //layer.masksToBounds - подрезаны -> cornerRadius
        return imageView
    }()
    
    private func setupCntainerView() {
        
        let conteinerView = UIView()
        conteinerView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.4858732877)
        
        ///first add then counstraints!
        conteinerView.addSubview(nameLabel)
        conteinerView.addSubview(messageLabel)
        conteinerView.addSubview(timeLabel)
        conteinerView.addSubview(hasReadImageView)
        
        //MARK: Constraint conteinerView & subViews
        addSubview(conteinerView)
        addConstraintsWithVisualFormat(format: "H:|-90-[v0]|", views: conteinerView)
        addConstraintsWithVisualFormat(format: "V:[v0(70)]", views: conteinerView)
        addConstraint(NSLayoutConstraint(item: conteinerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        //subViews
        addConstraintsWithVisualFormat(format: "H:|[v0][v1(80)]-15-|", views: nameLabel, timeLabel)
        addConstraintsWithVisualFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        addConstraintsWithVisualFormat(format: "H:|[v0]-8-[v1(20)]-15-|",
                                       views: messageLabel, hasReadImageView)
        addConstraintsWithVisualFormat(format: "V:|[v0(25)]", views: timeLabel)
        addConstraintsWithVisualFormat(format: "V:[v0(20)]|", views: hasReadImageView)
    }
    
    //MARK: override setupViews() in Abstract class
    override func setupViews() {
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubview(profileImageView)
        addSubview(dividerLineView)
        
        
        setupCntainerView()
        
        
        //profileImageView
        addConstraintsWithVisualFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithVisualFormat(format: "V:[v0(68)]", views: profileImageView)
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //dividerLineView
        addConstraintsWithVisualFormat(format: "H:|-82-[v0]|", views: dividerLineView)
        addConstraintsWithVisualFormat(format: "V:[v0(3)]|", views: dividerLineView)
        
        
    }
}
