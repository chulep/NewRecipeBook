//
//  UIBarButtonItem+Extensions.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 04.03.2023.
//

import UIKit

extension UIBarButtonItem {
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
