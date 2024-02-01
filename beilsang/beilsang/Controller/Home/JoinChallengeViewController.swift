//
//  JoinChallengeViewController.swift
//  beilsang
//
//  Created by Seyoung on 2/2/24.
//

import UIKit
import SnapKit

class JoinChallengeViewController: UIViewController {
    
    //MARK: - Properties
    
    let verticalScrollView = UIScrollView()
    let verticalContentView = UIView()
    
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .medium)
    
    lazy var representImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "representImage")
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "우리 가치 플로깅하자  👀👟"
        view.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var peopleNumLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .beBgSub
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.text = "62명 참여중"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        view.numberOfLines = 0
        view.textColor = .beNavy500
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        
        return view
    }()
    
    lazy var writerLabel: UILabel = {
        let view = UILabel()
        view.text = "작성자명"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextEx
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var writeDateLabel: UILabel = {
        let view = UILabel()
        view.text = "작성일"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextEx
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .beTextEx
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var categoryView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.beBorderDis.cgColor
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var categoryIcon: UILabel = {
        let view = UILabel()
        view.text = "👟"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var categoryLabel: UILabel = {
        let view = UILabel()
        view.text = "플로깅"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var progressTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "진행도"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextInfo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .beBgSub
        view.progressTintColor = .beScPurple400
        view.clipsToBounds = true
        view.subviews[1].clipsToBounds = true
        view.layer.cornerRadius = 8
        view.subviews[1].layer.cornerRadius = 8
        view.setProgress(0.25, animated: true)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var challengePeriodView: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var challengPeriodImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "challengePeriod")
        
        return view
    }()
    
    lazy var challengePeriodTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "실천 기간"
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var challengePeriodLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 12)
        view.numberOfLines = 0
        view.textColor = .beTextSub
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var divider1: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var galleryTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Medium", size: 18)
        view.numberOfLines = 0
        view.text = "인증 갤러리 🙌"
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var gallerySubTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Regular", size: 12)
        view.numberOfLines = 0
        view.text = "함께하는 챌린저들의 이야기를 봐볼까요? 🤩"
        view.textColor = .beTextEx
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var notStartedLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name:"NotoSansKR-Regular", size: 12)
        view.numberOfLines = 0
        view.text = "아직 챌린지가 시작되지 않았어요 👀"
        view.textColor = .beTextInfo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        
        return view
    }()
    
    lazy var homeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .beBgDef
        button.setTitle("홈으로 돌아가기", for: .normal)
        button.setTitleColor(.beTextDef, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.beBorderDis.cgColor
        button.layer.cornerRadius = 20
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(homeButtonTapped), for: .touchDown)
        
        return button
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.beTextDef.cgColor
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.backgroundColor = .beBgSub
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var bookMarkButton: UIButton = {
        let view = UIButton()
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        let selectedImage = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        
        view.setImage(image, for: .normal)
        view.tintColor = .beScPurple600
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addTarget(self, action: #selector(bookMarkTapped), for: .touchDown)
        return view
    }()
    
    lazy var bookMarkLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "NotoSansKR-Regular", size: 14)
        view.text = "121"
        view.numberOfLines = 0
        view.textColor = .beTextDef
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        
        return view
    }()
    
    lazy var proofButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .beScPurple400
        button.setTitle("인증하기", for: .normal)
        button.setTitleColor(.beTextWhite, for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(proofButtonTapped), for: .touchDown)
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        updateChallengeLabelText()
        
    }
    
    //MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .beBgDef
        view.addSubview(verticalScrollView)
        view.addSubview(bottomView)
        
        verticalScrollView.addSubview(verticalContentView)
        
        [representImageView, titleLabel,peopleNumLabel,writerLabel,writeDateLabel, lineView, categoryView, progressTitleLabel,progressView,challengePeriodView, divider1, galleryTitleLabel,gallerySubTitleLabel, notStartedLabel, homeButton].forEach{view in verticalContentView.addSubview(view)}
        
        [bookMarkButton, bookMarkLabel, proofButton].forEach{ view in bottomView.addSubview(view)}
        
        [categoryIcon, categoryLabel].forEach({view in categoryView.addSubview(view)})
        
        [challengePeriodTitleLabel,challengePeriodLabel,challengPeriodImageView].forEach({view in challengePeriodView.addSubview(view)})
    }
    
    private func setupLayout() {
        
        let width = UIScreen.main.bounds.width
        
        verticalScrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        verticalContentView.snp.makeConstraints { make in
            make.edges.equalTo(verticalScrollView.contentLayoutGuide)
            make.width.equalTo(verticalScrollView.frameLayoutGuide)
            make.height.equalTo(1164)
        }
        
        representImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(240)
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(representImageView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        peopleNumLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(86)
            make.height.equalTo(24)
        }
        
        writerLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
        }
        
        lineView.snp.makeConstraints{ make in
            make.centerY.equalTo(writerLabel)
            make.leading.equalTo(writerLabel.snp.trailing).offset(8)
            make.height.equalTo(18)
            make.width.equalTo(0.75)
        }
        
        writeDateLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalTo(lineView.snp.trailing).offset(8)
        }
        
        categoryView.snp.makeConstraints{ make in
            make.top.equalTo(writerLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(108)
            make.height.equalTo(40)
        }
        
        categoryIcon.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        categoryLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
        
        progressTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(categoryView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        
        progressView.snp.makeConstraints{ make in
            make.centerY.equalTo(progressTitleLabel)
            make.leading.equalTo(progressTitleLabel.snp.trailing).offset(24)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(16)
        }
        
        challengePeriodView.snp.makeConstraints{ make in
            make.top.equalTo(progressTitleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(72)
        }
        
        challengPeriodImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(19)
            make.width.height.equalTo(20)
        }
        
        challengePeriodTitleLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(challengPeriodImageView)
            make.leading.equalTo(challengPeriodImageView.snp.trailing).offset(4)
        }
        
        challengePeriodLabel.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-14)
            make.leading.equalToSuperview().offset(19)
        }
        
        divider1.snp.makeConstraints{ make in
            make.top.equalTo(challengePeriodView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(8)
        }
        
        galleryTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(divider1.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        gallerySubTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(galleryTitleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        notStartedLabel.snp.makeConstraints{ make in
            make.top.equalTo(gallerySubTitleLabel.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
        }
        
        homeButton.snp.makeConstraints{ make in
            make.top.equalTo(notStartedLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(75)
            make.trailing.equalToSuperview().offset(-75)
            make.height.equalTo(40)
        }
        
        bottomView.snp.makeConstraints{ make in
            make.bottom.equalToSuperview()
            make.height.equalTo(96)
            make.leading.trailing.equalToSuperview()
        }
        
        bookMarkButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(28)
            make.height.width.equalTo(30)
        }
        
        bookMarkLabel.snp.makeConstraints{ make in
            make.top.equalTo(bookMarkButton.snp.bottom)
            make.centerX.equalTo(bookMarkButton)
        }
        
        proofButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-28)
            make.width.equalTo(140)
            make.height.equalTo(52)
        }
    }
  
    //MARK: - UpdateLabel
    
    private func updateChallengeLabelText() {
        let weekCountText = "일주일"//"\(challengeModel.weekCount) weeks"
        let sessionCountText = "5"//"\(challengeModel.sessionCount) sessions"
        let startDateText = "1/11"
        
        let fullText = "시작일(\(startDateText))로부터 \(weekCountText) 동안 \(sessionCountText)회 진행"
        
        let attributedText = NSMutableAttributedString(string: fullText)
        
        let weekCountRange = (fullText as NSString).range(of: "\(weekCountText) 동안")
        let sessionCountRange = (fullText as NSString).range(of: "\(sessionCountText)회")

        attributedText.addAttribute(.foregroundColor, value: UIColor.beCta, range: weekCountRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.beCta, range: sessionCountRange)
        
        let font = UIFont(name: "NotoSansKR-Medium", size: 12)
        attributedText.addAttribute(.font, value: font!, range: weekCountRange)
        attributedText.addAttribute(.font, value: font!, range: sessionCountRange)
        
        challengePeriodLabel.attributedText = attributedText
    }
    
    //MARK: - Toast Popup
    
    private func showChallengeLeftDayToast() {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        toastLabel.textAlignment = .center
        toastLabel.text = "📆 챌린지가 1일 뒤 시작됩니다!"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 20
        toastLabel.clipsToBounds  =  true
        
        self.view.addSubview(toastLabel)
        
        toastLabel.snp.makeConstraints { make in
            make.bottom.equalTo(bottomView.snp.top).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(44)
        }
        
        UIView.animate(withDuration: 2, delay: 1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    // MARK: - Button Disabled
    
    private func challengeStartDateCheck() {
        // challengeStartDate가 현재 날짜이거나, 지남
        let check = false
        
        if check {
            proofButton.isEnabled = true
            proofButton.backgroundColor = .beScPurple600
        } else {
            proofButton.isEnabled = false
            proofButton.backgroundColor = .beScPurple400
        }
    }
    
    //MARK: - Actions
    
    @objc func proofButtonTapped(_ sender: UIButton) {
        print("인증인증")
    }
    
    @objc func bookMarkTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        let image = UIImage(systemName: "star", withConfiguration: imageConfig)
        let selectedImage = UIImage(systemName: "star.fill", withConfiguration: imageConfig)
        
        if sender.isSelected {
            bookMarkButton.setImage(selectedImage, for: .normal)
        } else {
            bookMarkButton.setImage(image, for: .normal)
        
        }
    }
    
    @objc func homeButtonTapped(_ sender: UIButton) {
        let homeVC = HomeMainViewController()

        if let navigationController = self.navigationController {
            navigationController.setViewControllers([homeVC], animated: true)
        }
    }
}
