//
//  AddDescriptionTableViewCell.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 09.01.2023.
//

import UIKit

class AddDescriptionTableViewCell: UITableViewCell {
    
    static let identifire = "descriptionCell"
    
    //MARK: - UI Elements
    
    private let numberLabel: UILabel = {
        $0.textAlignment = .center
        $0.backgroundColor = ColorHelper.orange
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    
    private let descriptionLabel: UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        return $0
    }(UILabel())
    
    private let backView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = ColorHelper.lightGray
        return $0
    }(UIView())
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
    
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        numberLabel.layer.cornerRadius = numberLabel.bounds.height / 2
        numberLabel.clipsToBounds = true
        
        backView.layer.cornerRadius = 5
        descriptionLabel.clipsToBounds = true
    }
    
    //MARK: - Create UI
    
    private func createUI() {
        addSubview(backView)
        addSubview(descriptionLabel)
        addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            numberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            numberLabel.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1/12),
            numberLabel.widthAnchor.constraint(equalTo: numberLabel.heightAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            descriptionLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: 20),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            backView.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -10),
            backView.leftAnchor.constraint(equalTo: descriptionLabel.leftAnchor, constant: -10),
            backView.rightAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: 10),
            backView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10)
        ])
    }
    
    //MARK: - Set Data Methods
    
    func setData(text: String?
                 , indexPath: IndexPath) {
        numberLabel.text = String(indexPath.row + 1)
        descriptionLabel.text = text
    }
    
    //MARK: - Selected
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
        
    }

    
}
