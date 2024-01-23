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
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .beBgDiv
        view.progressTintColor = .bePrPurple500
        view.progress = 0.75
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
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
    
    lazy var routeButton: UIButton = {
        let view = UIButton()
        let img = UIImage(named: "arrow_gray")
        view.backgroundColor = .beBgCard
        view.setTitle("알게된 경로 선택하기", for: .normal)
        view.setTitleColor(.beTextEx, for: .normal)
        view.titleLabel?.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.layer.cornerRadius = 8
        view.imageEdgeInsets = UIEdgeInsets(top: 21, left: 318, bottom: 21, right: 22)
        view.titleEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 200)
        view.setImage(img, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adjustsImageWhenHighlighted = false
        view.menu = menu
        view.showsMenuAsPrimaryAction = true
        
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
        setupUI()
        setupLayout()
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        navigationBarHidden()
        view.backgroundColor = .beBgDef
        view.addSubview(progressView)
        view.addSubview(joinRouteLabel)
        view.addSubview(joinRouteSmallLabel)
        view.addSubview(routeLabel)
        view.addSubview(routeButton)
        view.addSubview(nextButton)
    }
    
    private func setupLayout() {
        progressView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(84)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(192)
            make.height.equalTo(8)
        }
        
        joinRouteLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(230)
            make.top.equalTo(progressView.snp.bottom).offset(32)
        }
        
        joinRouteSmallLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(joinRouteLabel.snp.bottom).offset(8)
        }
        
        routeLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(joinRouteSmallLabel.snp.bottom).offset(32)
        }
        
        routeButton.snp.makeConstraints{ make in
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
    }
    
    // MARK: - Navigation Bar
    
    private func navigationBarHidden() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
    
    private func handleMenuSelection(_ selectedItem: String) {
        // 여기에서 UILabel의 text를 변경
        routeButton.setTitle(selectedItem, for: .normal)
    }
}
