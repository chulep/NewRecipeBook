// 
//  BasketViewController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 03.02.2023.
//

import UIKit

protocol BasketDisplayLogic: AnyObject {
    func displaying(data: BasketModels.FecthData.ViewModel)
}

class BasketViewController: UIViewController {
    
    //MARK: - Properties
    
    var interactor: BasketBusinessLogic?
    private(set) var router: (BasketRoutingLogic & BasketDataPassing)?
    private var data: [String]?
    
    //MARK: - UI Element
    
    var tableView = UITableView()
    
    private lazy var helpLabel: UILabel = {
        $0.text = NameHelper.BasketScene.helpLabelText
        $0.textColor = ColorHelper.gray
        $0.textAlignment = .center
        return $0
    }(UILabel(frame: view.bounds))
    
    private var clearButton: UIBarButtonItem?
    
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
        setupTableView()
        createUI()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchData()
    }
    
    //MARK: - SetupVIP

    private func setup() {
        let interactor = BasketInteractor()
        let presenter = BasketPresenter()
        let router = BasketRouter()

        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor

        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Create UI

    private func createUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        view.addSubview(helpLabel)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.identifire)
    }
    
    private func setupNavBar() {
        clearButton = UIBarButtonItem(title: NameHelper.BasketScene.clearButtonText, image: nil, target: self, action: #selector(clearBasket))
        navigationItem.rightBarButtonItem = clearButton
    }
    
    //MARK: - Action Methods
    
    @objc func clearBasket() {
        interactor?.clearAll()
        data = nil
        tableView.reloadData()
        isHidden(count: data?.count)
    }
}

//MARK: - Displaying

extension BasketViewController: BasketDisplayLogic {
    func displaying(data: BasketModels.FecthData.ViewModel) {
        self.data = data.ingredients
        isHidden(count: data.ingredients.count)
        tableView.reloadData()
    }
}

//MARK: - TableView Delegate & DataSourse

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifire, for: indexPath) as! BasketTableViewCell
        let dataFromCell = data?[indexPath.row]
        cell.setData(text: dataFromCell)
        cell.button.addTarget(self, action: #selector(tapToDelete(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    @objc func tapToDelete(_ sender: UIButton) {
        let hitPoint = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: hitPoint) {
            interactor?.deleteItem(indexPath: indexPath)
            data?.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
        }
        isHidden(count: data?.count)
    }
    
    //MARK: - Support Hide Method
    
    private func isHidden(count: Int?) {
        helpLabel.isHidden(count: count)
        clearButton?.isHidden(count: count)
    }
}
