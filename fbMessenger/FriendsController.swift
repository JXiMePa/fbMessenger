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
    
    var messages: [Message]?
    

    //MARK: ViewDidLoad-------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recent"
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        //.alwaysBounceVertical - only vertycal scrolling
        
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        setupData()
    }
    
    //MARK:CollectionViewDelegat
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0 }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        if let message = messages?[indexPath.item] {
            cell.message = message
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: CGFloat(100))
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


