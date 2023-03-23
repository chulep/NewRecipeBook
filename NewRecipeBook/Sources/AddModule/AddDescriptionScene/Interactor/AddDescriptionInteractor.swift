// 
//  AddDescriptionSceneInteractor.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 08.01.2023.
//

import Foundation

protocol AddDescriptionBusinessLogic {
    func fetchData()
    func saveData(text: String)
    func saveToCoreData()
}

protocol AddDescriptionDataStore {
    var saveData: AddIngredientModels.SaveData.Request? { get set }
    var saveDescriptionData: AddDescriptionModels.SaveData.Request? { get set }
}

class AddDescriptionSceneInteractor: AddDescriptionBusinessLogic, AddDescriptionDataStore {
    
    //MARK: - Properties
    
    var presenter: AddDescriptionPresentationLogic?
    var saveData: AddIngredientModels.SaveData.Request?
    var saveDescriptionData: AddDescriptionModels.SaveData.Request?
    
    //MARK: - Fetch Data
    
    func fetchData() {
        guard let data = saveDescriptionData?.description else { return }
        let model = AddDescriptionModels.FetchData.Response(description: data)
        presenter?.presentData(data: model)
    }
    
    //MARK: - Save Data
    
    func saveData(text: String) {
        guard let saveIngredientData = saveData else { return }
        if saveDescriptionData == nil {
            saveDescriptionData = AddDescriptionModels.SaveData.Request(name: saveIngredientData.name, category: saveIngredientData.category, imageData: saveIngredientData.imageData, ingredients: saveIngredientData.ingredients, description: [text])
        } else {
            saveDescriptionData?.description.append(text)
        }
        fetchData()
    }
    
    //MARK: - Save to CoreData
    
    func saveToCoreData() {
        guard let data = saveDescriptionData else { return }
        CoreDataManager.execute.saveDataTask(data: data)
    }
}
