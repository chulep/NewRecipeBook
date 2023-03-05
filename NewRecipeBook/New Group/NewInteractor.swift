// 
//  NewInteractor.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 06.01.2023.
//

import Foundation

protocol NewBusinessLogic {
    func fetchData()
}

protocol NewDataStore {
    var data: String? { get }
}

class NewInteractor: NewBusinessLogic, NewDataStore {
    
    var presenter: NewPresentationLogic?
    
    var data: String?
    
    func fetchData() {
        //data to presenter
    }
}
