// 
//  CalculatorViewController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.02.2023.
//

import UIKit

protocol CalculatorDisplayLogic: AnyObject {
    func displaying(data: CalculatorModels.FecthData.ViewModel)
}

class CalculatorViewController: UIViewController {
    
    //MARK: - Properties
    
    var interactor: CalculatorBusinessLogic?
    private(set) var router: (CalculatorRoutingLogic & CalculatorDataPassing)?
    
    //MARK: - UI Elements
    
    private let productSegment = UISegmentedControl(items: NameHelper.CalculatorScene.productSegmentText)
    private let cupResultView = ResultCalculatorView(title: NameHelper.CalculatorScene.cupViewText)
    private let spoonResultView = ResultCalculatorView(title: NameHelper.CalculatorScene.spoonViewText)
    private let inputNumberView = InputCalculatorView(title: NameHelper.CalculatorScene.inputViewText)
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        setupNavBar()
    }
    
    //MARK: - Setuo VIP

    private func setup() {
        let interactor = CalculatorInteractor()
        let presenter = CalculatorPresenter()
        let router = CalculatorRouter()

        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor

        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Create UI

    private func createUI() {
        view.backgroundColor = .white
        productSegment.selectedSegmentIndex = 0
        
        for i in [cupResultView, spoonResultView, inputNumberView, productSegment] {
            i.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(i)
        }
        
        NSLayoutConstraint.activate([
            cupResultView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cupResultView.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            cupResultView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            spoonResultView.topAnchor.constraint(equalTo: cupResultView.bottomAnchor, constant: 10),
            spoonResultView.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 5),
            spoonResultView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            inputNumberView.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -5),
            inputNumberView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            inputNumberView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            productSegment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productSegment.heightAnchor.constraint(equalToConstant: 35),
            productSegment.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            productSegment.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            productSegment.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -5)
        ])
    }
    
    private func setupNavBar() {
        title = NameHelper.CalculatorScene.titleText
        navigationController?.navigationBar.tintColor = ColorHelper.white
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.setBarColor(color: UIColor.orange)
    }
    
    //MARK: - Action Methods
    
    @objc func editInput(_ textField: UITextField) {
        let number = Double(textField.text ?? "") ?? 0
        let dataFromInteractor = CalculatorModels.FecthData.Request(number: number, select: productSegment.selectedSegmentIndex)
        interactor?.fetchData(data: dataFromInteractor)
    }
}

//MARK: - Displaying Method

extension CalculatorViewController: CalculatorDisplayLogic {
    func displaying(data: CalculatorModels.FecthData.ViewModel) {
        cupResultView.setData(result: data.cup)
        spoonResultView.setData(result: data.spoon)
    }
}
