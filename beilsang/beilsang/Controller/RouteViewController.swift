//
//  RouteViewController.swift
//  beilsang
//
//  Created by Seyoung on 1/22/24.
//

import UIKit
import SnapKit

class RouteViewController: UIViewController {
    
    //MARK: - Properties
    
    let pickerView = UIPickerView()
    let routeOptions = ["지인 추천", "직접 검색", "인스타그램", "에브리타임", "기타"]
    let imageContainer = UIView()
    let arrowImageView = UIImageView(image: UIImage(named: "arrow_gray"))
    var selectedRoute: String?
 
    /*
     
     lazy var menuItems: [UIAction] = {
     return [
     UIAction(title: "지인 추천", handler: { _ in self.handleMenuSelection("지인 추천") }),
     UIAction(title: "직접 검색", handler: { _ in self.handleMenuSelection("직접 검색") }),
     UIAction(title: "인스타그램", handler: { _ in self.handleMenuSelection("인스타그램") }),
     UIAction(title: "에브리타임", handler: { _ in self.handleMenuSelection("에브리타임") }),
     UIAction(title: "기타", handler: { _ in self.handleMenuSelection("기타") })
     ]
     }()
     
     lazy var menu: UIMenu = {
     return UIMenu(
     title: "",
     options: [],
     children: menuItems
     )
     }()
     */
    
    lazy var joinRouteLabel: UILabel = {
        let view = UILabel()
        view.text = "비일상을 알게된 경로가\n있을까요?"
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        view.numberOfLines = 2
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var joinRouteSmallLabel: UILabel = {
        let view = UILabel()
        view.text = "없다면 바로 비일상을 시작해 보세요"
        view.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var routeLabel: UILabel = {
        let view = UILabel()
        view.text = "알게된 경로"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var routeField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.autocorrectionType = .no
        view.spellCheckingType = .no
        view.autocapitalizationType = .none
        view.setPlaceholderColor(.beTextEx)
        view.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 19.0, height: 0.0))
        view.leftViewMode = .always
        view.rightView = imageContainer
        view.rightViewMode = .always
        
        let placeholderText = "알게된 경로 선택하기"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]
        view.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        
        return view
    }()
    /*
     lazy var routeButton: UIButton = {
     let view = UIButton()
     let img = UIImage(named: "arrow_gray")
     view.backgroundColor = .beBgCard
     view.setTitle("알게된 경로 선택하기", for: .normal)
     view.setTitleColor(.beTextEx, for: .normal)
     view.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 14)
     view.titleLabel?.textAlignment = .left
     view.layer.borderWidth = 1
     view.layer.borderColor = UIColor.beBorderDis.cgColor
     view.layer.cornerRadius = 8
     view.imageEdgeInsets = UIEdgeInsets(top: 21, left: 318, bottom: 21, right: 22)
     view.titleEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 200)
     //엣지 조정 필요
     view.setImage(img, for: .normal)
     view.translatesAutoresizingMaskIntoConstraints = false
     view.adjustsImageWhenHighlighted = false
     view.menu = menu
     view.showsMenuAsPrimaryAction = true
     
     return view
     }()
     */
    
    lazy var nextButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .beScPurple600
        view.setTitle("다음으로", for: .normal)
        view.setTitleColor(.beTextWhite, for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(nextAction), for: .touchDown)
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        createPickerView()
        setupToolBar()
        setupUI()
        setupLayout()
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .beBgDef
        view.addSubview(joinRouteLabel)
        view.addSubview(joinRouteSmallLabel)
        view.addSubview(routeLabel)
        view.addSubview(routeField)
        view.addSubview(nextButton)
        
        imageContainer.addSubview(arrowImageView)
    }
    
    private func setupLayout() {
        
        joinRouteLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(230)
            make.top.equalToSuperview().offset(116)
        }
        
        joinRouteSmallLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(joinRouteLabel.snp.bottom).offset(8)
        }
        
        routeLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(joinRouteSmallLabel.snp.bottom).offset(32)
        }
        
        routeField.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
            make.top.equalTo(routeLabel.snp.bottom).offset(12)
        }
        
        nextButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        
        imageContainer.snp.makeConstraints{ make in
            make.height.equalTo(48)
            make.width.equalTo(40)
        }
        
        arrowImageView.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Navigation Bar
    
    private func setNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.hidesBarsOnSwipe = false
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //MARK: - Picker View
    
    private func createPickerView() {
        /// 피커 세팅
        pickerView.delegate = self
        pickerView.dataSource = self
        routeField.tintColor = .clear
        
        /// 텍스트필드 입력 수단 연결
        routeField.inputView = pickerView
    }
    
    //MARK: - Tool Bar
    
    private func setupToolBar() {
        
        let toolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandeler))
        
        toolBar.items = [flexibleSpace, doneButton]
        // 적절한 사이즈로 toolBar의 크기를 만들어 줍니다.
        toolBar.sizeToFit()
        
        routeField.inputAccessoryView = toolBar
    }
    
    // MARK: - Actions
    
    @objc private func nextAction() {
        print("Next button tapped")
        let startViewController = StartViewController()
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(startViewController, animated: true)
        } else {
            print("Error")
            
        }
    }
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        //birthField.text = dateFormat(date: datePicker.date)
        // 키보드 내리기
        routeField.resignFirstResponder()
    }
    //모달로 바뀔듯, 바뀌면 수정
    /*
     private func handleMenuSelection(_ selectedItem: String) {
     // 여기에서 UILabel의 text를 변경
     routeField.setTitle(selectedItem, for: .normal)
     }
     */
}

extension RouteViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return routeOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedRoute = routeOptions[row]
        default:
            break
        }
        
        routeField.text = selectedRoute
    }
}

