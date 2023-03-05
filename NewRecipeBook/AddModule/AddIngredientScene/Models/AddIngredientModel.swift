//
//
//  AddRecipeModel.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import Foundation

enum AddIngredientModels {
    
    enum FetchData {
        struct Response {
            var ingredients: [String]
        }
        
        struct ViewModel {
            var ingredients: [String]
        }
    }
    
    enum SaveData {
        struct Request {
            var name: String
            var category: String
            var imageData: Data?
            var ingredients: [String]
        }
    }
    
}
