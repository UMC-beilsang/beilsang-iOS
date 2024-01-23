//
//  PageViewController.swift
//  beilsang
//
//  Created by 곽은채 on 1/22/24.
//

import SnapKit
import UIKit

class PageViewController: UIViewController {
    
    // MARK: - properties
    let pageTitle: String
    let pageColor: UIColor
    
    lazy var button: UIButton = {
        let view = UIButton()

        view.backgroundColor = pageColor
        
        view.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        return view
    }()
    
    lazy var label: UILabel = {
        let view = UILabel()
        
        view.text = pageTitle
        view.numberOfLines = 2
        view.font = UIFont(name: "Noto Sans KR", size: 20)
        view.textColor = UIColor(red: 34/255, green: 34/255, blue: 34/255, alpha: 1)
        
        return view
    }()
    
    // MARK: - init setting
    init(pageTitle: String, pageColor: UIColor) {
        self.pageTitle = pageTitle
        self.pageColor = pageColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
  
        setLayout()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        print("\(pageTitle) 선택")
    }
}

// MARK: - Layout setting
extension PageViewController {
    func setLayout() {
        view.addSubview(button)
        view.addSubview(label)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalTo(button.snp.leading).offset(24)
            make.top.equalTo(button.snp.top).offset(32)
        }
    }
}
