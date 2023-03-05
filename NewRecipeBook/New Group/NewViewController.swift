// 
//  NewViewController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 06.01.2023.
//

import UIKit

protocol NewDisplayLogic: AnyObject {
    func displaying()
}

class NewViewController: UIViewController {
    
    var interactor: NewBusinessLogic?
    private(set) var router: (NewRoutingLogic & NewDataPassing)?
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func setup() {
        let interactor = NewInteractor()
        let presenter = NewPresenter()
        let router = NewRouter()

        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor

        self.interactor = interactor
        self.router = router
    }

}

extension MainViewController: NewDisplayLogic {
    func displaying() {
        //display data
    }
}