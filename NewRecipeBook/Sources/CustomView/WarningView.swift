//
//  WarningView.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 02.04.2023.
//

import UIKit

class WarningView: UIView {
    
    //MARK: - UI Element
    
    private let label: UILabel = {
        $0.textColor = ColorHelper.gray
        $0.textAlignment = .center
        $0.numberOfLines = 2
        return $0
    }(UILabel())
    
    private let imageView: UIImageView = {
        $0.tintColor = ColorHelper.lightGray
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    convenience init(text: String, image: UIImage?, frame: CGRect) {
        self.init(frame: frame)
        isHidden = true
        label.text = text
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        backgroundColor = ColorHelper.white
    }
    
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    //MARK: - Create UI
    
    private func createUI() {
        addSubview(label)
        addSubview(imageView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -5),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            
            imageView.topAnchor.constraint(equalTo: centerYAnchor, constant: 5),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: bounds.width / 2.7),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -bounds.width / 2.7),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    //MARK: - Is hidden
    
    func isHidden(count: Int?) {
        if count == 0 {
            isHidden = false
        } else if count == nil {
            isHidden = false
        } else {
            isHidden = true
        }
    }
    
    func navigateToAddButon() {
        imageView.transform = CGAffineTransform(rotationAngle: 2.5)
    }
}
