//
//  UINavigationItem+Extensions.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 26.02.2023.
//

import UIKit

extension UINavigationItem {
    
    func setBarColor(backgroundColor: UIColor, itemsColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: backgroundColor]
        appearance.largeTitleTextAttributes  = [.foregroundColor: itemsColor]
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        compactAppearance = appearance
    }
}
