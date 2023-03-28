//
//  UIImage+Extensions.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 01.02.2023.
//

import UIKit

extension UIImage {
    
    convenience init?(isFavorite: Bool?) {
        switch isFavorite {
        case true:
            self.init(systemName: "heart.fill")
        default:
            self.init(systemName: "heart")
        }
    }
    
}
