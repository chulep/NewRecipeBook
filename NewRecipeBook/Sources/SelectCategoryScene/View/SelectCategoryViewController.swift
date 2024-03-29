// 
//  SelectCategoryViewController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 21.01.2023.
//

import UIKit

protocol SelectCategoryDisplayLogic: AnyObject {
    func displaying(category: String?, data: SelectCategoryModels.FecthData.ViewModel)
}

class SelectCategoryViewController: UIViewController {
    
    var interactor: SelectCategoryBusinessLogic?
    private(set) var router: (SelectCategoryRoutingLogic & SelectCategoryDataPassing)?
    private var data: SelectCategoryModels.FecthData.ViewModel?
    
    //MARK: - UI Elements
    
    lazy private var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
    lazy private var warningView = WarningView(text: NameHelper.SelectCategoryScene.noRecipes, image: ImageHelper.noyhing, frame: view.bounds)
    
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
        setupCollectionView()
        interactor?.fetchData()
    }
    
    //MARK: - Setup VIP

    private func setup() {
        let interactor = SelectCategoryInteractor()
        let presenter = SelectCategoryPresenter()
        let router = SelectCategoryRouter()

        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor

        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - Create UI
    
    private func createUI() {
        view.addSubview(collectionView)
        view.addSubview(warningView)
        warningView.frame.origin.y -= 44
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NameHelper.SelectCategoryScene.backButtonText, image: nil, target: self, action: #selector(tapToCancel))
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SelectCategotyCollectionViewCell.self, forCellWithReuseIdentifier: SelectCategotyCollectionViewCell.identifire)
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let cellSide = view.bounds.width / 2
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: cellSide - 30, height: cellSide * 1.2 - 28)
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        flowLayout.minimumLineSpacing = 20
        return flowLayout
    }
    
    //MARK: - Action Methods
    
    @objc func tapToCancel() {
        router?.dismiss()
    }
}

//MARK: - Displaying Methiod

extension SelectCategoryViewController: SelectCategoryDisplayLogic {
    func displaying(category: String?, data: SelectCategoryModels.FecthData.ViewModel) {
        title = category
        self.data = data
        collectionView.reloadData()
        warningView.isHidden(count: data.displayRecipes.count)
    }
}

//MARK: - CollectionView Delegate & DataSourse

extension SelectCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.displayRecipes.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategotyCollectionViewCell.identifire, for: indexPath) as! SelectCategotyCollectionViewCell
        let name = data?.displayRecipes[indexPath.row].name
        let image = data?.displayRecipes[indexPath.row].image
        cell.setData(title: name, imageData: image)
        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.navigateToDetailScene(indexPath: indexPath)
    }
}
