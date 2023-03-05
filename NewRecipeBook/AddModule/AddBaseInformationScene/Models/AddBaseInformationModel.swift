// 
//  AddBaseInformationModel.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 11.01.2023.
//

import Foundation

enum AddBaseInformationModels {
    // запрос от вью к интерактору
    
    enum FetchData {
        // запрос от интерактора к презентеру
        struct Response {
            let category: [NameHelper.Category]
        }
        
        // запрос от презентера к вью
        struct ViewModel {
            let category: [String]
        }
    }
    
    enum SaveData {
        struct Request {
            var name: String
            var category: String
            var image: Data?
        }
    }
}
