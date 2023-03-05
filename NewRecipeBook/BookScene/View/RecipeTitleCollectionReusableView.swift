//
//  RecipeTitleCollectionReusableView.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import UIKit

final class RecipeTitleCollectionReusableView: UICollectionReusableView {
    
    static let identifire = "titleView"
    
    private var titleLabel = UILabel()
    
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    //MARK: - Create UI
    
    private func createUI() {
        addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 20, y: 0, width: bounds.width, height: bounds.height)
        titleLabel.font = UIFont.boldSystemFont(ofSize: bounds.height / 2)
    }
    
    //MARK: - Set Title
    
    func setTitle(text: String) {
        titleLabel.text = text
    }
}
