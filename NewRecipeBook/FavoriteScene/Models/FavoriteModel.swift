// 
//  FavoriteModel.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 02.02.2023.
//

import Foundation

enum FavoriteModels {
	enum FecthData {
        
        // запрос от интерактора к презентеру
        struct Response {
            var recipes: [Recipe]?
        }
        
        // запрос от презентера к вью
        struct ViewModel {
            struct FormattedRecipe {
                var name: String?
                var image: Data?
            }
            let displayRecipes: [FormattedRecipe]
        }
    }
}
