//
//  BasketTableViewCell.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 04.02.2023.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    static let identifire = "basketCell"
    
    //MARK: - UI Element
    
    private var label: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    var button: UIButton = {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = ColorHelper.orange
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    //MARK: - LayoutSubviews

    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    //MARK: - Create UI
    
    private func createUI() {
        addSubview(label)
        addSubview(button)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.rightAnchor.constraint(equalTo: button.leftAnchor),
            
            button.topAnchor.constraint(equalTo: topAnchor),
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.widthAnchor.constraint(equalTo: button.heightAnchor)
        ])
    }
    
    //MARK: - Set Data
    
    func setData(text: String?) {
        label.text = text
    }
    
    //MARK: - Select Method
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
