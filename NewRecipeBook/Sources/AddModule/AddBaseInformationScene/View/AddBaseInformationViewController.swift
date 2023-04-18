// 
//  AddBaseInformationViewController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 11.01.2023.
//

import UIKit

protocol AddBaseInformationDisplayLogic: AnyObject {
    func displaying(data: AddBaseInformationModels.FetchData.ViewModel)
}

final class AddBaseInformationViewController: UIViewController {
    
    var interactor: AddBaseInformationBusinessLogic?
    private(set) var router: (AddBaseInformationRoutingLogic & AddBaseInformationDataPassing)?
    private var saveImageData: Data? {
        didSet {
            imageButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    //MARK: - UI Element
    
    private lazy var imageButton: UIButton = {
        $0.addTarget(self, action: #selector(tapToImage), for: .touchUpInside)
        $0.backgroundColor = ColorHelper.babackgroundGrey
        $0.setImage(UIImage(named: "camera")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        $0.imageView?.contentMode = .scaleAspectFill
        $0.tintColor = ColorHelper.gray
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorHelper.gray.cgColor
        return $0
    } (UIButton())
    
    private let nameTextField: UITextField = {
        $0.textAlignment = .center
        $0.attributedPlaceholder = NSAttributedString(string: NameHelper.AddModule.BaseInformationScene.nameTextFieldPlaceholderText, attributes: [NSAttributedString.Key.foregroundColor: ColorHelper.gray])
        $0.backgroundColor = ColorHelper.babackgroundGrey
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorHelper.gray.cgColor
        return $0
    }(UITextField())
    
    private let categoryButton: UIButton = {
        $0.setTitle(NameHelper.AddModule.BaseInformationScene.categoryLabelText, for: .normal)
        $0.addTarget(nil, action: #selector(tapToCategory), for: .touchUpInside)
        $0.backgroundColor = ColorHelper.babackgroundGrey
        $0.setTitleColor(ColorHelper.gray, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorHelper.gray.cgColor
        return $0
    }(UIButton())
    
    private let confirmButton: UIButton = {
        $0.addTarget(nil, action: #selector(tapToNextScene), for: .touchUpInside)
        $0.setTitle(NameHelper.AddModule.BaseInformationScene.confirmButtonText, for: .normal)
        $0.backgroundColor = ColorHelper.orange
        return $0
    }(UIButton())
    
    private var categoryAlertController = UIAlertController()
    
    private var imagePicker: UIImagePickerController?
    
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
        interactor?.fetchData()
        
    }
    
    //MARK: - Setup VIP

    private func setup() {
        let interactor = AddBaseInformationInteractor()
        let presenter = AddBaseInformationPresenter()
        let router = AddBaseInformationRouter()

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
        
        for i in [imageButton, nameTextField, categoryButton, confirmButton] {
            view.addSubview(i)
            i.translatesAutoresizingMaskIntoConstraints = false
            i.layer.cornerRadius = ConstantHelper.radius
            i.clipsToBounds = true
        }

        NSLayoutConstraint.activate([
            imageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            imageButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            imageButton.heightAnchor.constraint(equalTo: imageButton.widthAnchor),
            imageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 10),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.5/2),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            categoryButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            categoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryButton.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: 50),
            
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            confirmButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -5)
        ])
    }
    
    private func setupNavBar() {
        title = NameHelper.AddModule.BaseInformationScene.titleText
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NameHelper.AddModule.BaseInformationScene.cancelButtonText, image: nil, target: self, action: #selector(tapToCancel))
    }
    
    //MARK: - Action Methods
    
    @objc private func tapToCancel() {
        router?.dismissScene()
    }
    
    @objc private func tapToCategory() {
        present(categoryAlertController, animated: true)
    }
    
    @objc private func tapToNextScene() {
        if nameTextField.text == "" || categoryButton.titleLabel?.text == "Выберите категорию" {
            nameTextField.center.x += 5
            categoryButton.center.x += 5
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0) {
                self.nameTextField.center.x -= 5
                self.categoryButton.center.x -= 5
            }
        } else {
            view.endEditing(true)
            interactor?.saveData(name: nameTextField.text ?? "", category: categoryButton.title(for: .normal) ?? "", image: saveImageData)
            router?.navigateToNextScene()
        }
    }
}

//MARK: - Displaying Method

extension AddBaseInformationViewController: AddBaseInformationDisplayLogic {
    func displaying(data: AddBaseInformationModels.FetchData.ViewModel) {
        categoryAlertController = UIAlertController.Factory.categoryAlert(names: data.category, completion: { [weak self] category in
            self?.categoryButton.setTitle(category, for: .normal)
            self?.categoryButton.setTitleColor(ColorHelper.orange, for: .normal)
        })
    }
}

//MARK: - Image Picker Delegate

extension AddBaseInformationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc private func tapToImage() {
        imagePicker = UIImagePickerController()
        imagePicker?.sourceType = .savedPhotosAlbum
        imagePicker?.allowsEditing = true
        imagePicker?.delegate = self
        present(imagePicker!, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker?.dismiss(animated: true)
        let image = info[.originalImage] as! UIImage
        saveImageData = image.jpegData(compressionQuality: 0.0)
        imageButton.setImage(image, for: .normal)
        imagePicker = nil
    }
}
