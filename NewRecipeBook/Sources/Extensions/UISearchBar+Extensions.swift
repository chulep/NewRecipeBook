//
//  UISearchBar+Extensions.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.03.2023.
//

import UIKit

extension UISearchBar {
    func cancel(animated: Bool) {
        setShowsCancelButton(false, animated: animated)
        endEditing(true)
        text = ""
    }
}
