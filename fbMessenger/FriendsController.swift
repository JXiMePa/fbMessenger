//
//  ViewController.swift
//  fbMessenger
//
//  Created by Tarasenco Jurik on 10.05.2018.
//  Copyright © 2018 Tarasenko Jurik. All rights reserved.
//

import UIKit

class FriendsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recent"
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        //.alwaysBounceVertical - only vertycal scrolling
        
        collectionView?.register(FriendCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    //MARK:CollectionViewDelegat
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: CGFloat(100))
    }
}

class FriendCell: BaseCell {
    
    //MARK: Cell Items
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
        label.text = "Mark Zuckerberg"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "bla bla =) massage and something else..."
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:05"
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        //layer.masksToBounds - подрезаны ли подслои к границам слоя
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
        
        //Constraint conteinerView & subViews
        addSubview(conteinerView)
        addConstraintsWithVisualFormat(format: "H:|-90-[v0]|", views: conteinerView)
        addConstraintsWithVisualFormat(format: "V:[v0(50)]", views: conteinerView)
        addConstraint(NSLayoutConstraint(item: conteinerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        //subViews
        addConstraintsWithVisualFormat(format: "H:|[v0][v1(80)]-10-|", views: nameLabel, timeLabel)
        addConstraintsWithVisualFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        
        addConstraintsWithVisualFormat(format: "H:|[v0]-8-[v1(20)]-12-|",
                                       views: messageLabel, hasReadImageView)

        addConstraintsWithVisualFormat(format: "V:|[v0(26)]|", views: timeLabel)
        
        addConstraintsWithVisualFormat(format: "V:[v0(20)]|", views: hasReadImageView)
    }
    
    //MARK: setupViews()
    override func setupViews() {
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubview(profileImageView)
        addSubview(dividerLineView)
        
        
        setupCntainerView()
        
        profileImageView.image = UIImage(named: "zuckprofile")
        hasReadImageView.image = UIImage(named: "zuckprofile")
        
        //profileImageView
        addConstraintsWithVisualFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithVisualFormat(format: "V:[v0(68)]", views: profileImageView)
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //dividerLineView
        addConstraintsWithVisualFormat(format: "H:|-82-[v0]|", views: dividerLineView)
        addConstraintsWithVisualFormat(format: "V:[v0(3)]|", views: dividerLineView)
        
        
    }
    
    
}

extension UIView {
    
    //MARK: constraintsWithVisualFormat
    func addConstraintsWithVisualFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            //.enumerated() - Возвращает последовательность пар ( n , x ), где "n" представляет собой последовательное целое число, начинающееся с нуля, и "x" представляет собой элемент последовательности.
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
//------------   ConstraintWithVisualFormat   -----------
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-82-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : dividerLineView]))
//
/// "H:|-10-[v0(25)]-10-|"
//"H/V" - горизонтальное направление.
//"|" - граница екрана
//"-20-" - Отступ
//"v0" - view in superViews
//"(25)" - size
//-----------------------------------------------------
    }
}


//create Cell
class BaseCell: UICollectionViewCell {
    
    //MARK: init Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = #colorLiteral(red: 0.2709437468, green: 1, blue: 0.2488278626, alpha: 1)
    }
}
