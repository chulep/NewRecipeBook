//
//  UISearchBar+Extensions.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.03.2023.
//

import UIKit

extension UISearchBar {
    func endEditing(animated: Bool) {
        setShowsCancelButton(false, animated: animated)
        endEditing(true)
        text = ""
    }
}
