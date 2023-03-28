//
//  BookModel.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import Foundation

final class BookModels {
    
    enum FecthData {
        
        struct Request {
            var searchText: String?
        }
        
        struct Response {
            var recipes: [Recipe]?
        }
        
        struct ViewModel {
            struct FormattedRecipe {
                var name: String?
                var image: Data?
                var dateId: String?
            }
            var displayRecipes: [FormattedRecipe]
        }
    }
}
