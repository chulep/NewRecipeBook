//
//  RecipeTitleCollectionReusableView.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import UIKit

class RecipeTitleCollectionReusableView: UICollectionReusableView {
    
    static let identifire = "titleView"
    
    private var label = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    private func createUI() {
        addSubview(label)
        label.frame = CGRect(x: 20, y: 0, width: bounds.width, height: bounds.height)
        label.font = UIFont.boldSystemFont(ofSize: bounds.height / 2)
    }
    
    func setTitle(text: String) {
        label.text = text
    }
}
