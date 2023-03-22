// 
//  AddBaseInformationInteractor.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 11.01.2023.
//

import Foundation

protocol AddBaseInformationBusinessLogic {
    func fetchData()
    func saveData(name: String, category: String, image: Data?)
}

protocol AddBaseInformationDataStore {
    var saveData: AddBaseInformationModels.SaveData.Request? { get }
}

class AddBaseInformationInteractor: AddBaseInformationBusinessLogic, AddBaseInformationDataStore {
    
    //MARK: - Properties
    
    var presenter: AddBaseInformationPresentationLogic?
    var saveData: AddBaseInformationModels.SaveData.Request?
    
    //MARK: - Fetch Data
    
    func fetchData() {
        let category = NameHelper.allCategories
        presenter?.presentData(data: AddBaseInformationModels.FetchData.Response(category: category))
    }
    
    //MARK: - Save Data
    
    func saveData(name: String, category: String, image: Data?) {
        saveData = AddBaseInformationModels.SaveData.Request(name: name, category: category, image: image)
    }
}
