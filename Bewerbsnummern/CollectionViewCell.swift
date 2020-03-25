//
//  CollectionViewCell.swift
//  Bewerbsnummern
//
//  Created by Paul Wiesinger on 29.01.20.
//  Copyright © 2020 Paul Wiesinger. All rights reserved.
//

import UIKit

@IBDesignable
class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var label: UILabel!
 
    fileprivate var isFlipped = false
    
    func setupView() {
        emptyView?.layer.cornerRadius = contentView.frame.width/2
        labelView?.layer.cornerRadius = contentView.frame.width/2
        labelView?.layer.borderWidth = 5
        labelView?.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    @objc func flip() {
        if !isFlipped {
            UIView.transition(from: emptyView, to: labelView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: labelView, to: emptyView, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
        isFlipped = !isFlipped
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        
        contentView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(flip)))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    override func prepareForReuse() {
        if isFlipped {
            emptyView.isHidden = false
            labelView.isHidden = true
            isFlipped = false
        }
    }
}
