// 
//  DetailModel.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 17.01.2023.
//

import Foundation

enum DetailModels {
	enum FecthData {
        struct Request {
            
        }
        
        // запрос от интерактора к презентеру
        struct Response {
            var recipe: Recipe
        }
        
        // запрос от презентера к вью
        struct ViewModel {
            var name: String?
            var image: Data?
            var ingredients: [String]?
            var description: [String]?
            var isFavorite: Bool?
        }
    }
}
