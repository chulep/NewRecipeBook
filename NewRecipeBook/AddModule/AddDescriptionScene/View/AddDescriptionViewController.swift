// 
//  AddDescriptionSceneViewController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 08.01.2023.
//

import UIKit

protocol AddDescriptionDisplayLogic: AnyObject {
    func displaying(data: AddDescriptionModels.FetchData.ViewModel)
}

protocol TextTransferDelegate: AnyObject {
    func addNewSector(text: String)
}

class AddDescriptionViewController: UIViewController {
    
    var interactor: AddDescriptionBusinessLogic?
    private(set) var router: (AddDescriptionRoutingLogic & AddDescriptionDataPassing)?
    private var sectors = [String]()
    
    //MARK: - UI Elements
    
    private var tableView = UITableView()
    
    private var newSectorView = NewDesriptionSectorViewController()
    
    var nextSceneButton = {
        $0.setTitle(NameHelper.AddModule.DescriptionScene.confirmButton, for: .normal)
        $0.backgroundColor = .orange
        $0.layer.cornerRadius = ConstantHelper.radius
        $0.addTarget(nil, action: #selector(tapToNextPage), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy private var label: UILabel = {
        $0.text = NameHelper.AddModule.DescriptionScene.helpLabelText
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
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTableView()
        interactor?.fetchData()
    }
    
    //MARK: - Setup VIP
    
    private func setup() {
        let interactor = AddDescriptionSceneInteractor()
        let presenter = AddDescriptionPresenter()
        let router = AddDescriptionRouter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
        
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Create UI
    
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: view.bounds.width - 20, height: view.bounds.width / 2 - 20)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        flowLayout.sectionHeadersPinToVisibleBounds = true
        return flowLayout
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(AddDescriptionTableViewCell.self, forCellReuseIdentifier: AddDescriptionTableViewCell.identifire)
    }
    
    func createUI() {
        view.addSubview(label)
        view.addSubview(tableView)
        view.addSubview(nextSceneButton)
        
        view.backgroundColor = .white
        
        tableView.backgroundColor = .clear
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
    
    func setupNavigationBar() {
        title = NameHelper.AddModule.DescriptionScene.titleText
        let image = UIImage(systemName: "plus")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(tapToNewSector))
    }
    
    //MARK: - Action Methods
    
    @objc func tapToNewSector() {
        let newVC = NewDesriptionSectorViewController()
        newVC.textTransferDelegate = self
        let navController = UINavigationController(rootViewController: newVC)
        present(navController, animated: true)
    }
    
    @objc func tapToNextPage() {
        if sectors.count == 0 {
            label.center.x += 5
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0) {
                self.label.center.x -= 5
            }
        } else {
            interactor?.saveToCoreData()
            router?.dismissScene()
        }
    }
}

//MARK: - Displaying Method

extension AddDescriptionViewController: AddDescriptionDisplayLogic {
    func displaying(data: AddDescriptionModels.FetchData.ViewModel) {
        sectors = data.description
        tableView.reloadData()
    }
}

//MARK: - TableView Delegate & DataSource

extension AddDescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectors.count == 0 {
            label.isHidden = false
        } else {
            label.isHidden = true
        }
        return sectors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddDescriptionTableViewCell.identifire, for: indexPath) as! AddDescriptionTableViewCell
        cell.setData(text: sectors[indexPath.row], indexPath: indexPath)
        return cell
    }
}

//MARK: - Text Tranfer Delegate Method

extension AddDescriptionViewController: TextTransferDelegate {
    
    func addNewSector(text: String) {
        interactor?.saveData(text: text)
    }
}


