//
//  UILabel+Extensions.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 28.02.2023.
//

import UIKit

extension UILabel {
    func isHidden(count: Int?) {
        if count == 0 {
            isHidden = false
        } else if count == nil {
            isHidden = false
        } else {
            isHidden = true
        }
    }
}
