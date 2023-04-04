//
//  SelectCategotyCollectionViewcell.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 23.03.2023.
//

import UIKit

class SelectCategotyCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "selectCategoryCell"
    
    //MARK: - UI Elements
    
    private var userImageView: UIImageView = {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    private let systemImageView: UIImageView = {
        $0.tintColor = ColorHelper.lightGray
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        return $0
    }(UIImageView())
    
    private var titleLabel: UILabel = {
        $0.textAlignment = .center
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private let lineView: UIView = {
        $0.backgroundColor = ColorHelper.gray
        return $0
    }(UIView())
    
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    //MARK: - Create UI
    
    private func createUI() {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = ColorHelper.babackgroundGrey
        
        addSubview(lineView)
        addSubview(systemImageView)
        addSubview(userImageView)
        addSubview(titleLabel)
        
        systemImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: bounds.width),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 7),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -7),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            lineView.leftAnchor.constraint(equalTo: leftAnchor),
            lineView.rightAnchor.constraint(equalTo: rightAnchor),
            
            userImageView.topAnchor.constraint(equalTo: topAnchor),
            userImageView.leftAnchor.constraint(equalTo: leftAnchor),
            userImageView.rightAnchor.constraint(equalTo: rightAnchor),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor),
            
            systemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            systemImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            systemImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -25),
            systemImageView.heightAnchor.constraint(equalTo: systemImageView.widthAnchor)
        ])
    
    }
    
    //MARK: - Set data
    
    func setData(title: String?, imageData: Data?) {
        
        titleLabel.text = title
        if imageData != nil {
            userImageView.image = UIImage(data: imageData!)
            systemImageView.isHidden = true
            userImageView.isHidden = false
        } else {
            systemImageView.image = ImageHelper.camera?.withRenderingMode(.alwaysTemplate)
            userImageView.isHidden = true
            systemImageView.isHidden = false
        }
    }
}
