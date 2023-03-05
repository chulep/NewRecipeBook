//
//  PhotoTableViewHeader.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 17.01.2023.
//

import UIKit

class PhotoTableViewHeader: UITableViewHeaderFooterView {

    static let identifire = "photoView"
    
    //MARK: - UI Element
    
    private lazy var imageView: UIImageView = {
        $0.frame = bounds
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .white
        return $0
    }(UIImageView())
    
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(imageView)
    }
    
    //MARK: - Set Data
    
    func setImage(data: Data?) {
        if let data = data {
            imageView.image = UIImage(data: data)
        } 
    }
}
