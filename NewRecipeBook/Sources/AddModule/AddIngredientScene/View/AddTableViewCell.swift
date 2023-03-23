//
//  AddTableViewCell.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 06.01.2023.
//

import UIKit

final class AddTableViewCell: UITableViewCell {
    
    static let identifire = "addCell"

    //MARK: - UI Elements
    
    private let ingredientLabel: UILabel = {
        $0.textAlignment = .justified
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var dotView: UIView = {
        $0.layer.cornerRadius = bounds.height / 6
        $0.backgroundColor = ColorHelper.orange
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    //MARK: - Init
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    //MARK: - Create UI
    
    private func createUI() {
        addSubview(ingredientLabel)
        addSubview(dotView)
        
        NSLayoutConstraint.activate([
            dotView.centerYAnchor.constraint(equalTo: centerYAnchor),
            dotView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            dotView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3),
            dotView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3),
            
            ingredientLabel.topAnchor.constraint(equalTo: topAnchor),
            ingredientLabel.leftAnchor.constraint(equalTo: dotView.rightAnchor, constant: 10),
            ingredientLabel.rightAnchor.constraint(equalTo: rightAnchor),
            ingredientLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            ingredientLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    //MARK: - Set Data
    
    func setData(text: String?) {
        ingredientLabel.text = text
    }

    //MARK: - Selected
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
