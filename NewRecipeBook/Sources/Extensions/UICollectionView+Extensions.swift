//
//  UICollectionView+Extensions.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 02.04.2023.
//

import UIKit

extension UINavigationBar {
    func isHidden(count: Int?) {
        if count == 0 {
            isHidden = true
        } else if count == nil {
            isHidden = true
        } else {
            isHidden = false
        }
    }
}
