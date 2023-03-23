// 
//  SelectCategoryModel.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 21.01.2023.
//

import Foundation

enum SelectCategoryModels {
	enum FecthData {
        
        struct Response {
            var recipes: [Recipe]?
        }
        
        struct ViewModel {
            struct FormattedRecipe {
                var name: String?
                var image: Data?
            }
            var displayRecipes: [FormattedRecipe]
        }
    }
}
