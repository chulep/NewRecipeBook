// 
//  AddDescriptionSceneModel.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 08.01.2023.
//

import Foundation

enum AddDescriptionModels {
    enum FetchData {
        struct Request {
            var description: [String]
        }
        struct Response {
            var description: [String]
        }
        struct ViewModel {
            var description: [String]
        }
    }
    
    enum SaveData {
        struct Request {
            var name: String
            var category: String
            var imageData: Data?
            var ingredients: [String]
            var description: [String]
        }
    }
    

}
