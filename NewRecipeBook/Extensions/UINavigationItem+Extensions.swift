//
//  UINavigationItem+Extensions.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 26.02.2023.
//

import UIKit

extension UINavigationItem {
    
    func setBarColor(color: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = color
        appearance.titleTextAttributes = [.foregroundColor: color]
        appearance.largeTitleTextAttributes  = [.foregroundColor: UIColor.white]
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
        compactAppearance = appearance
    }
}
