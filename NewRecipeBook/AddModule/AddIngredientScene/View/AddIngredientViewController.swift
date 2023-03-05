//
//  AddRecipeViewController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import UIKit

protocol AddIngredientDisplayLigic: AnyObject {
    func displaying(viewModel: AddIngredientModels.FetchData.ViewModel)
}

final class AddIngredientViewController: UIViewController {
    
    var interactor: AddIngredientBusinessLogic?
    private(set) var router: (AddIngredientRoutingLogic & AddIngredientDataPassing)?
    private var ingredients = [String]()
    
    //MARK: - UI Element
    
    private var tableView: UITableView = {
        $0.backgroundColor = .clear
        return $0
    }(UITableView())
    
    private var nextSceneButton = {
        $0.setTitle(NameHelper.AddModule.IngredientScene.confirmButton, for: .normal)
        $0.backgroundColor = .orange
        $0.addTarget(nil, action: #selector(tapToNextPage), for: .touchUpInside)
        $0.layer.cornerRadius = ConstantHelper.radius
        return $0
    }(UIButton())
    
    private lazy var label: UILabel = {
        $0.text = NameHelper.AddModule.IngredientScene.helpLabelText
        $0.textColor = ColorHelper.gray
        $0.textAlignment = .center
        return $0
    }(UILabel(frame: view.bounds))
    
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
        setupTableView()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchData()
    }
    
    //MARK: - Setup VIP
    
    private func setup() {
        let interactor = AddIngredientInteractor()
        let presenter = AddIngredientPresenter()
        let router = AddIngredientRouter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
        
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Create UI
    
    func createUI() {
        view.backgroundColor = .white
        
        view.addSubview(label)
        view.addSubview(tableView)
        view.addSubview(nextSceneButton)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        nextSceneButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: nextSceneButton.topAnchor, constant: -10),
            
            nextSceneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextSceneButton.heightAnchor.constraint(equalToConstant: 50),
            nextSceneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            nextSceneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
    
    private func setupNavBar() {
        title = NameHelper.AddModule.IngredientScene.titleText
        let image = UIImage(systemName: "plus")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: image, target: self, action: #selector(tapToNewIngredient))
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddTableViewCell.self, forCellReuseIdentifier: AddTableViewCell.identifire)
    }
    
    //MARK: - Action MEthods
    
    @objc private func tapToNextPage() {
        if ingredients.count == 0 {
            label.center.x += 5
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0) {
                self.label.center.x -= 5
            }
        } else {
            router?.tapToNextScreen()
        }
    }
    
    @objc private func tapToNewIngredient() {
        let newIngredientController = NewIngredientViewController()
        newIngredientController.delegate = self
        let navigationController = UINavigationController(rootViewController: newIngredientController)
        present(navigationController, animated: true)
    }
}

//MARK: - TableView Delegate & DataSource

extension AddIngredientViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        label.isHidden(count: ingredients.count)
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddTableViewCell.identifire) as! AddTableViewCell
        cell.setData(text: ingredients[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

//MARK: - Displaying Method

extension AddIngredientViewController: AddIngredientDisplayLigic {
    func displaying(viewModel: AddIngredientModels.FetchData.ViewModel) {
        ingredients = viewModel.ingredients
        tableView.reloadData()
    }
}

//MARK: - Cell Text Delegate

extension AddIngredientViewController: TextTransferDelegate {
    func addNewSector(text: String) {
        ingredients.append(text)
        interactor?.saveData(text: text)
        tableView.reloadData()
    }
}
