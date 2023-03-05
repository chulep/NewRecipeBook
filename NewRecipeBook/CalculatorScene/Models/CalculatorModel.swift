// 
//  CalculatorModel.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.02.2023.
//

import Foundation

enum CalculatorModels {
	enum FecthData {
        
        struct Request {
            var number: Double
            var select: Int
            
            //мука
            let flourCup: Double = 145
            let flourSpoon: Double = 30
            //сахар
            let sugarCup: Double = 190
            let sugarSpoon: Double = 25
            //крупы
            let grainCup: Double = 240
            let grainSpoon: Double = 20
        }
        
        struct Response {
            let cup: Double
            let spoon: Double
        }
        
        struct ViewModel {
            let cup: String
            let spoon: String
        }
    }
}
