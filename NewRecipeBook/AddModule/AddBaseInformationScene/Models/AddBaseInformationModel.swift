// 
//  AddBaseInformationModel.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 11.01.2023.
//

import Foundation

enum AddBaseInformationModels {
    
    enum FetchData {

        struct Response {
            let category: [NameHelper.Category]
        }
        

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
