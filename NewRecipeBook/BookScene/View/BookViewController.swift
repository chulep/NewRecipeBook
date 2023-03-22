//
//  BookViewController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import UIKit

protocol BookDisplayLogic: AnyObject {
    func displaying(data: BookModels.FecthData.ViewModel)
}

protocol TableViewCellDelegate: AnyObject {
    func tapToCell(indexPath: IndexPath, text: String?)
}

final class BookViewController: UIViewController, BookDisplayLogic {
    
    //MARK: - Properties
    
    var interactor: BookBusinessLogic?
    private(set) var router: (BookRoutingLogic & BookDataPassing)?
    private var data: BookModels.FecthData.ViewModel?
    private var isSearch = false
    
    // MARK: - UI Element
    
    private var addButton: UIButton = {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = ColorHelper.orange
        $0.addTarget(nil, action: #selector(tapButton), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private var helpLabel = {
        $0.text = NameHelper.BookScene.helpLabelText
        $0.textColor = ColorHelper.gray
        $0.textAlignment = .center
        $0.isHidden = true
        return $0
    }(UILabel())
    
    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createUI()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchData()
    }
    
    // MARK: - Protocols Metods
    
    func displaying(data: BookModels.FecthData.ViewModel) {
        self.data = data
        collectionView.reloadData()
    }
    
    // MARK: - Setup VIP
    
    private func setup() {
        let interactor = BookInteractor()
        let presenter = BookPresenter()
        let router = BookRouter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
        
        self.interactor = interactor
        self.router = router
    }
    
    //MARK: - UI
    
    private func createUI() {
        view.addSubview(collectionView)
        view.addSubview(addButton)
        view.addSubview(helpLabel)
        
        helpLabel.frame = view.bounds
        
        addButton.layer.cornerRadius = view.bounds.width / 7 / 2
        addButton.clipsToBounds = true
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/7),
            addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor)
        ])
    }
    
    private func setupNavBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        navigationController?.hidesBarsOnSwipe = true
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let cellSide = view.bounds.width / 2
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: cellSide - 30, height: cellSide * 1.2 - 30)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        flowLayout.minimumLineSpacing = 20
        return flowLayout
    }
    
    //MARK: - Action Methods
    
    @objc private func tapButton() {
        router?.navigateToAdd()
    }
    
    //MARK: - Setup Collection View
    
    private func setupCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecipeTitleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecipeTitleCollectionReusableView.identifire)
        collectionView.register(CategoryCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryCollectionReusableView.identifire)
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.identifire)
    }
}

//MARK: - CollectionView Delegate & DataSource & FlowLayout

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return data?.displayRecipes.count ?? 0
        default:
            return 0
        }
    }
    
    // cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifire, for: indexPath) as! BookCollectionViewCell
            let image = data?.displayRecipes[indexPath.row].image
            let name = data?.displayRecipes[indexPath.row].name
            cell.setData(title: name, imageData: image)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    //navigate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.navigateToDetail(indexPath: indexPath)
    }
}

extension BookViewController: UICollectionViewDelegateFlowLayout {
    
    // headers & footers
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryCollectionReusableView.identifire, for: indexPath) as! CategoryCollectionReusableView
            header.cellDelegate = self
            return header
        case 1:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RecipeTitleCollectionReusableView.identifire, for: indexPath) as! RecipeTitleCollectionReusableView
            header.setTitle(text: NameHelper.BookScene.allRecipeLabelText)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    // headers sizes
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if isSearch {
            return CGSize(width: view.bounds.width, height: 0)
        } else {
            switch section {
            case 0:
                return CGSize(width: view.bounds.width, height: 170)
            default:
                return CGSize(width: view.bounds.width, height: 50)
            }
        }
    }
}

//MARK: - Select Category Delegate

extension BookViewController: TableViewCellDelegate {
    
    func tapToCell(indexPath: IndexPath, text: String?) {
        guard let text = text else { return }
        router?.navigateToCategory(category: text)
    }
}

//MARK: - SearchBar Delegate

extension BookViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(animated: true)
        isSearch = false
        helpLabel.isHidden = true
        navigationController?.hidesBarsOnSwipe = true
        interactor?.fetchData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearch = true
        interactor?.search(data: BookModels.FecthData.Request(searchText: searchBar.text))
        navigationController?.hidesBarsOnSwipe = false
        helpLabel.isHidden(count: data?.displayRecipes.count)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.endEditing(animated: true)
        isSearch = false
        return true
    }
}
