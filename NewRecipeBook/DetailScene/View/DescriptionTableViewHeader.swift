//
//  NameTableViewHeader.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 20.01.2023.
//

import UIKit

class TitleTableViewHeader: UITableViewHeaderFooterView {
    
    static let identifire = "TitleTableView"
    
    //MARK: - UI Element
    
    private let nameLabel = UILabel()
    
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    //MARK: - Create UI
    
    func createUI() {
        addSubview(nameLabel)
        nameLabel.frame = CGRect(x: 20, y: 0, width: bounds.width - 40, height: bounds.height)
        nameLabel.font = UIFont.boldSystemFont(ofSize: bounds.height / 2)
    }
    
    //MARK: - Set Data
    
    func setTitle(text: String?, aligment: NSTextAlignment) {
        nameLabel.text = text
        nameLabel.textAlignment = aligment
    }
}
