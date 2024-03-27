//
//  LearnMoreViewController.swift
//  beilsang
//
//  Created by 강희진 on 2/17/24.
//

import UIKit
import SnapKit

class LearnMoreViewController: UIViewController, UIScrollViewDelegate {
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    
    lazy var subView : UIView = {
        let view = UIView()
        view.backgroundColor = .beScPurple400
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    
    lazy var subLabel : UILabel = {
        let label = UILabel()
        label.text = "지도에서 가까운 친환경 스팟📌을 찾아보세요!"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = .beTextSub
        return label
    }()
    
    lazy var mapView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setFullScrollView()
        viewConstraint()
        setNavigationBar()
    }
    
    func setFullScrollView() {
        fullScrollView.delegate = self
        //스크롤 안움직이게 설정
        fullScrollView.isScrollEnabled = false
        //스크롤 안보이게 설정
        fullScrollView.showsVerticalScrollIndicator = false
        
        fullScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalToSuperview()
        }
    }
    
    // addSubview() 메서드 모음
    func addView() {
        // foreach문을 사용해서 클로저 형태로 작성
        view.addSubview(fullScrollView)
        fullScrollView.addSubview(fullContentView)
        [subView, mapView].forEach{ view in fullContentView.addSubview(view)}
        subView.addSubview(subLabel)
    }
    
    //snp 설정
    func viewConstraint(){
        subView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        subLabel.snp.makeConstraints {make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(180)
        }
        mapView.snp.makeConstraints{ make in
            make.top.equalTo(subView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - navigationBar Setting
extension LearnMoreViewController{
    private func setNavigationBar() {
        self.navigationItem.titleView = attributeTitleView()
        setBackButton()
        
    }
    private func attributeTitleView() -> UIView {
        // 네비게이션 바에 타이틀을 왼쪽으로 옮기기 위해 커스텀 뷰 생성
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        
        // 커스텀 뷰 내에 타이틀 레이블 추가
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        titleLabel.text = "더알아보기"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "NotoSansKR-SemiBold", size: 22)
        view.addSubview(titleLabel)
        
        return view
    }
    // 백버튼 커스텀
    func setBackButton() {
        let notiButton = UIBarButtonItem(image: UIImage(named: "iconamoon_notification-bold")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(tabBarButtonTapped))
        notiButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = notiButton
    }
    // 사이드 버튼 액션
    @objc func tabBarButtonTapped() {
        print("알림버튼")
        let notificationVC = NotificationViewController()
        navigationController?.pushViewController(notificationVC, animated: true)
    }
}
