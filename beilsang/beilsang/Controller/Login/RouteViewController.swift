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
    let arrowImageView = UIImageView(image: UIImage(named: "arrow_gray"))
    var selectedRoute: String?
    var attributedStr: NSMutableAttributedString!
    
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
        
        let placeholderText = "알게된 경로 선택하기"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]
        view.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        
        return view
    }()
    
    lazy var recommendLabel: UILabel = {
        let view = UILabel()
        view.text = "추천인 닉네임"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var recommendPointLabel: UILabel = {
        let view = UILabel()
        view.text = "+ 1000P"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.textColor = .beCta
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var recommendField: UITextField = {
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
        
        let placeholderText = "추천인 닉네임 입력하기"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14)
        ]
        view.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        
        return view
    }()
    
    lazy var bubbleLabel: UILabel = {
        let view = UILabel()
        view.text = "🌱 추천인 닉네임 입력시 +1000P 바로 지급!"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var bubbleView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bubble")
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.16
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowPath = nil
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
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
        setupAttributedStr()
        setTextField()
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
        view.addSubview(recommendLabel)
        view.addSubview(recommendPointLabel)
        view.addSubview(recommendField)
        view.addSubview(bubbleView)
        view.addSubview(nextButton)
        
        bubbleView.addSubview(bubbleLabel)
        
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
        
        recommendLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(routeField.snp.bottom).offset(24)
        }
        
        recommendPointLabel.snp.makeConstraints{ make in
            make.leading.equalTo(recommendLabel.snp.trailing).offset(16)
            make.centerY.equalTo(recommendLabel)
        }
        
        recommendField.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
            make.top.equalTo(recommendLabel.snp.bottom).offset(12)
        }
        
        bubbleView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-12)
            make.height.equalTo(44)
        }
        
        bubbleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(8)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        
    }
    
    // MARK: - Navigation Bar
    
    private func setNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.hidesBarsOnSwipe = false
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - TextField Set up
    
    private func setTextField() {
        routeField.delegate = self
        recommendField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
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
    
    //MARK: - setupAttributeStr
    
    func setupAttributedStr() {
        attributedStr = NSMutableAttributedString(string: bubbleLabel.text!)

        attributedStr.addAttribute(.foregroundColor, value: UIColor.beCta , range: (bubbleLabel.text! as NSString).range(of: "+1000P"))

        bubbleLabel.attributedText = attributedStr
    }
    
    // MARK: - Actions
    
    @objc private func nextAction() {
        print("Next button tapped")
        
        SignUpData.shared.discoveredPath = routeField.text ?? ""
        SignUpData.shared.recommendNickname = recommendField.text ?? ""
        
        let startViewController = StartViewController()
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(startViewController, animated: true)
        } else {
            print("Error")
            
        }
    }
    
    @objc func doneButtonHandeler(_ sender: UIBarButtonItem) {
        routeField.resignFirstResponder()
    }
    
    @objc private func handleTap() {
        view.endEditing(true)
    }
}

extension RouteViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        recommendField.resignFirstResponder()
        
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == routeField {
            routeField.layer.borderColor = UIColor.bePsBlue500.cgColor
            routeField.layer.backgroundColor = UIColor.bePsBlue100.cgColor
            routeField.textColor = UIColor.bePsBlue500
            routeField.setPlaceholderColor(.bePsBlue500)
        }
        else if textField == recommendField {
            recommendField.layer.borderColor = UIColor.bePsBlue500.cgColor
            recommendField.layer.backgroundColor = UIColor.bePsBlue100.cgColor
            recommendField.textColor = UIColor.bePsBlue500
            recommendField.setPlaceholderColor(.bePsBlue500)
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == routeField {
            routeField.layer.borderColor = UIColor.beBorderDis.cgColor
            routeField.layer.backgroundColor = UIColor.clear.cgColor
            routeField.textColor = UIColor.beTextDef
            routeField.setPlaceholderColor(.beTextEx)
        }
        else if textField == recommendField {
            recommendField.layer.borderColor = UIColor.beBorderDis.cgColor
            recommendField.layer.backgroundColor = UIColor.clear.cgColor
            recommendField.textColor = UIColor.beTextDef
            recommendField.setPlaceholderColor(.beTextEx)
        }
    }

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
