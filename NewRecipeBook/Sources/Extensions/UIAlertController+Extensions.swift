//
//  UIAlertController+Extensions.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 11.01.2023.
//

import UIKit

extension UIAlertController {
    
    enum Factory {
        static func categoryAlert(names: [String], completion: @escaping (String) -> Void) -> UIAlertController {
            let alertController = UIAlertController(title: NameHelper.Alert.Category.titleText, message: nil, preferredStyle: .actionSheet)
            for i in names {
                let button = UIAlertAction(title: i, style: .default) { action in
                    completion(i)
                }
                alertController.addAction(button)
            }
            return alertController
        }
        
        static func inBasketAlert(completion: @escaping () -> Void) -> UIAlertController {
            let alertController = UIAlertController(title: NameHelper.Alert.InBasket.titleText, message: nil, preferredStyle: .alert)
            let confirmButton = UIAlertAction(title: NameHelper.Alert.InBasket.confirmButtonText, style: .default) { action in
                completion()
            }
            let cancelButton = UIAlertAction(title: NameHelper.Alert.InBasket.cancelButtonText, style: .cancel)
            alertController.addAction(confirmButton)
            alertController.addAction(cancelButton)
            return alertController
        }
        
        static func deleteAlert(completion: @escaping () -> Void) -> UIAlertController {
            let alertController = UIAlertController(title: NameHelper.Alert.Delete.titleText, message: nil, preferredStyle: .alert)
            let confirmButton = UIAlertAction(title: NameHelper.Alert.Delete.confirmButtonText, style: .default) { action in
                completion()
            }
            let cancelButton = UIAlertAction(title: NameHelper.Alert.Delete.cancelButtonText, style: .cancel)
            alertController.addAction(confirmButton)
            alertController.addAction(cancelButton)
            return alertController
        }
    }
}
