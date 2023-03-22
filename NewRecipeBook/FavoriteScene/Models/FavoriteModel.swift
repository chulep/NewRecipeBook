// 
//  FavoriteModel.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 02.02.2023.
//

import Foundation

enum FavoriteModels {
	enum FecthData {
        
        struct Response {
            var recipes: [Recipe]?
        }
        
        struct ViewModel {
            struct FormattedRecipe {
                var name: String?
                var image: Data?
            }
            let displayRecipes: [FormattedRecipe]
        }
    }
}
