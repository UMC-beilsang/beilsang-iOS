//
//  MyChallengeViewController.swift
//  beilsang
//
//  Created by 강희진 on 1/28/24.
//

import UIKit
import SwiftUI
import SnapKit
import Kingfisher

class MyChallengeViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties
    
    // 전체 화면 scrollview
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    let menuList = ["참여중", "등록한", "완료됨"]
    var cellList : [ChallengeModel] = []
    var medalCount: Int = 0
    
    var selectedMenu : String = "참여중" // 0: 참여중, 1: 등록한, 2: 완료됨
    var selectedCategory = "전체" //0:전체, ..., 10: 재활용
    
    var joinList = [[ChallengeModel]](repeating: Array(), count: 10)
    var enrollList = [[ChallengeModel]](repeating: Array(), count: 10)
    var finishList = [[ChallengeModel]](repeating: Array(), count: 10)
    
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.estimatedItemSize = .zero
        layout.itemSize = CGSize(width: 112, height: 40)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    //메뉴 하단 회색 바
    lazy var menuUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgDiv
        return view
    }()
    
    // categoriesView - 셀
    let categoryDataList = CategoryKeyword.data
    lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 72, height: 72)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    lazy var categoryUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        return view
    }()
    lazy var medalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width-32, height:148)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.isHidden = true
        return view
    }()
    lazy var challengeLabel: UILabel = {
        let label = UILabel()
        label.text = "참여 챌린지"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = .black
        return label
    }()
    lazy var challengeBoxCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 358, height: 140)
        layout.sectionInset = UIEdgeInsets(top: 35, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    lazy var toastLabel : UILabel = {
        let toastLabel = UILabel()
        toastLabel.text = "🏅 챌린지 30회 참여시 획득할 수 있어요"
        toastLabel.textColor = .white
        toastLabel.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        toastLabel.layer.cornerRadius = 20
        toastLabel.backgroundColor = .beTextDef.withAlphaComponent(0.8)
        toastLabel.isHidden = true
        return toastLabel
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setChallengeList()
        setupAttribute()
        setCollectionView()
        setNavigationBar()
        viewConstraint()
    }

}
extension MyChallengeViewController {
    
    func setupAttribute() {
        setFullScrollView()
        setLayout()
        setScrollViewLayout()
    }
    
    func setFullScrollView() {
        fullScrollView.delegate = self
        //스크롤 안움직이게 설정
        fullScrollView.isScrollEnabled = true
        medalCollectionView.isScrollEnabled = false
        //스크롤 안보이게 설정
        fullScrollView.showsVerticalScrollIndicator = false
        medalCollectionView.showsVerticalScrollIndicator = false
    }
    
    func setLayout() {
        view.addSubview(fullScrollView)
        fullScrollView.addSubview(fullContentView)
        addView()
    }
    func setScrollViewLayout(){
        fullScrollView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(categoryUnderLine.snp.bottom)
        }
        fullContentView.snp.makeConstraints { make in
            make.edges.equalTo(fullScrollView.contentLayoutGuide)
            make.width.equalTo(fullScrollView.frameLayoutGuide)
            make.height.equalTo(1056)
        }
    }
    // addSubview() 메서드 모음
    func addView() {
        // foreach문을 사용해서 클로저 형태로 작성
        [menuCollectionView, menuUnderLine, categoryCollectionView, categoryUnderLine,].forEach { view in
            self.view.addSubview(view)
        }
        [medalCollectionView, challengeBoxCollectionView, toastLabel].forEach{ view in fullContentView.addSubview(view)}
        
        challengeBoxCollectionView.addSubview(challengeLabel)
    }
    
    //snp 설정
    func viewConstraint(){
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        menuUnderLine.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(menuCollectionView.snp.bottom)
            make.leading.equalToSuperview()
        }
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(menuCollectionView.snp.bottom).offset(30)
            make.height.equalTo(72)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        categoryUnderLine.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(8)
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(24)
            make.leading.equalToSuperview()
        }
        medalCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(148)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        challengeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        challengeBoxCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        toastLabel.snp.makeConstraints { make in
            make.width.equalTo(332)
            make.height.equalTo(43)
            make.centerX.equalToSuperview()
            make.top.equalTo(challengeBoxCollectionView.snp.top).offset(330)
        }
    }
}
// MARK: - 네비게이션 바 커스텀
extension MyChallengeViewController{
    private func setNavigationBar() {
        self.navigationItem.titleView = attributeTitleView()
        
        // 백 버튼 설정
        setBackButton()
    }
    private func attributeTitleView() -> UIView {
        // title 설정
        let label = UILabel()
        let lightText: NSMutableAttributedString =
            NSMutableAttributedString(string: "나의 챌린지",attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont(name: "NotoSansKR-SemiBold", size: 20)!])
        let naviTitle: NSMutableAttributedString
            = lightText
        label.attributedText = naviTitle
          
        return label
    }
    // 백버튼 커스텀
    func setBackButton() {
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-navigation")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(tabBarButtonTapped))
        leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    // 백버튼 액션
    @objc func tabBarButtonTapped() {
        print("뒤로 가기")
        navigationController?.popViewController(animated: true)
    }
}
// MARK: - collectionView setting(카테고리)
extension MyChallengeViewController: UICollectionViewDataSource, UICollectionViewDelegate, CustomMedalCellDelegate {
    // collectionView, delegate, datasorce 설정
    func setCollectionView() {
        [menuCollectionView, categoryCollectionView, medalCollectionView, challengeBoxCollectionView,].forEach { view in
            view.delegate = self
            view.dataSource = self
        }
        
        //Cell 등록
        menuCollectionView.register(ChallengeMenuCollectionViewCell.self, forCellWithReuseIdentifier: ChallengeMenuCollectionViewCell.identifier)
        categoryCollectionView.register(MyPageCategoryCollectionViewCell.self, forCellWithReuseIdentifier: MyPageCategoryCollectionViewCell.identifier)
        medalCollectionView.register(MedalCollectionViewCell.self, forCellWithReuseIdentifier: MedalCollectionViewCell.identifier)
        challengeBoxCollectionView.register(ChallengeListCollectionViewCell.self, forCellWithReuseIdentifier: ChallengeListCollectionViewCell.identifier)
        
        // 컬렉션 뷰 첫 화면 선택
        setFirstIndexIsSelected()
        
        categoryCollectionView.showsHorizontalScrollIndicator = false
    }
    // section 개수 설정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // cell 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case menuCollectionView:
            return menuList.count
        case categoryCollectionView:
            return categoryDataList.count
        case medalCollectionView:
            return 1
        case challengeBoxCollectionView:
            return cellList.count
        default:
            return 0
        }
    }
    
    // cell 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case menuCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeMenuCollectionViewCell.identifier, for: indexPath) as?
                    ChallengeMenuCollectionViewCell else {
                return UICollectionViewCell()
            }
            let target = menuList[indexPath.row]
            cell.menuLabel.text = target
            
            return cell
        case categoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCategoryCollectionViewCell.identifier, for: indexPath) as?
                    MyPageCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            let target = categoryDataList[indexPath.row]
            let img = UIImage(named: "\(target.image).svg")
            cell.keywordImage.image = img
            cell.keywordLabel.text = target.title
            
            return cell
        case medalCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedalCollectionViewCell.identifier, for: indexPath) as?
                    MedalCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.delegate = self
            let medal : [UIButton] = [cell.medal1, cell.medal2, cell.medal3, cell.medal4, cell.medal5]
            
            medal.forEach { view in
                switch medalCount/10 {
                case 0: view.setImage(UIImage(named: "Ellipse 1674"), for: .normal)
                case 1: if view == medal[0]{
                    view.setImage(UIImage(named: "Group 1000002757"), for: .normal)
                    view.isUserInteractionEnabled = false
                } else {
                    view.setImage(UIImage(named: "Ellipse 1674"), for: .normal)
                }
                case 2: if medal[0...1].contains(view){
                    view.setImage(UIImage(named: "Group 1000002757"), for: .normal)
                    view.isUserInteractionEnabled = false
                } else {
                    view.setImage(UIImage(named: "Ellipse 1674"), for: .normal)
                }
                case 3: if medal[0...2].contains(view){
                    view.setImage(UIImage(named: "Group 1000002757"), for: .normal)
                    view.isUserInteractionEnabled = false
                } else {
                    view.setImage(UIImage(named: "Ellipse 1674"), for: .normal)
                }
                case 4: if medal[0...3].contains(view){
                    view.setImage(UIImage(named: "Group 1000002757"), for: .normal)
                    view.isUserInteractionEnabled = false
                } else {
                    view.setImage(UIImage(named: "Ellipse 1674"), for: .normal)
                }
                case 5: view.setImage(UIImage(named: "Group 1000002757"), for: .normal)
                    view.isUserInteractionEnabled = false
                default:
                    return
                }
            }
            return cell
        case challengeBoxCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeListCollectionViewCell.identifier, for: indexPath) as?
                    ChallengeListCollectionViewCell else {
                return UICollectionViewCell()
            }
            if !cellList.isEmpty{
                let target = cellList[indexPath.row]
                cell.challengeNameLabel.text = target.title
                cell.makerNickname.text = target.hostName
                cell.buttonLabel.text = "참여인원 \(target.attendeeCount)명"
                cell.challengeId = target.challengeId
                let url = URL(string: target.imageUrl)
                cell.challengeImage.kf.setImage(with: url)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    // cell 선택시 액션
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case menuCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! ChallengeMenuCollectionViewCell
            selectedMenu = cell.menuLabel.text!
            let str = cell.menuLabel.text?.prefix(2)
            challengeLabel.text = str! + " 챌린지"
            setChallengeList()
        case categoryCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! MyPageCategoryCollectionViewCell
            selectedCategory = cell.keywordLabel.text ?? ""
            if indexPath.row == 0{
                medalCollectionView.isHidden = true
                challengeBoxCollectionView.snp.remakeConstraints { make in
                    make.top.equalTo(categoryUnderLine.snp.bottom).offset(24)
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide)
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                }
            }
            else{
                medalCollectionView.isHidden = false
                challengeBoxCollectionView.snp.remakeConstraints { make in
                    make.top.equalTo(medalCollectionView.snp.bottom).offset(24)
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide)
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                }
            }
            setChallengeList()
        case challengeBoxCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! ChallengeListCollectionViewCell
            
            let challengeDetailVC = JoinChallengeViewController()
            challengeDetailVC.challengeId = cell.challengeId
            navigationController?.pushViewController(challengeDetailVC, animated: true)
        default:
            return
        }
    }
    // collectionCell 첫 화면 설정
    func setFirstIndexIsSelected() {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        menuCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom) // 0번째 Index로
        categoryCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom) // 0번째 Index로
    }
    
   
    // 델리게이트 메서드 구현
    func didTapButton(in cell: UICollectionViewCell, button : UIButton) {
        showToast(message: button.titleLabel?.text ?? "")
    }
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 166, y: self.view.frame.size.height-140, width: 332, height: 43))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        toastLabel.textAlignment = .center
        toastLabel.text = "🏅 챌린지 \(message)회 참여시 획득할 수 있어요"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.layer.cornerRadius = 20
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    private func setChallengeList(){
        let categoryIndex = changeCategoryToInt(category: selectedCategory)
        if selectedMenu == "참여중"{
            //api에서 data를 받아오지 않았다면
            if joinList[categoryIndex].isEmpty{
                joinList[categoryIndex] = requestChallengeList()
            } else {
                self.cellList = joinList[categoryIndex]
                challengeBoxCollectionView.reloadData()
            }
        } else if selectedMenu == "등록한"{
            if enrollList[categoryIndex].isEmpty{
                enrollList[categoryIndex] = requestChallengeList()
            } else{
                self.cellList = enrollList[categoryIndex]
                challengeBoxCollectionView.reloadData()
            }
        } else {
            if finishList[categoryIndex].isEmpty{
                finishList[categoryIndex] = requestChallengeList()
            } else{
                self.cellList = finishList[categoryIndex]
                challengeBoxCollectionView.reloadData()
            }
        }
    }
    private func requestChallengeList() -> [ChallengeModel]{
        var requestList : [ChallengeModel] = []
        MyPageService.shared.getMyPageChallengeList(baseEndPoint: .challenges, addPath: "/\(selectedMenu)/\(selectedCategory)"){response in
            requestList = self.reloadChallengeList(response.data)
        }
        return requestList
    }
    @MainActor
    private func reloadChallengeList(_ list: MyPageChallengeListModel) -> [ChallengeModel]{
        cellList = list.challenges.challenges ?? []
        challengeBoxCollectionView.reloadData()
        medalCount = list.count
        medalCollectionView.reloadData()
        return cellList
    }
    func changeCategoryToInt(category: String) -> Int{
        switch category{
        case CategoryKeyword.data[0].title: return 0
        case CategoryKeyword.data[1].title: return 1
        case CategoryKeyword.data[2].title: return 2
        case CategoryKeyword.data[3].title: return 3
        case CategoryKeyword.data[4].title: return 4
        case CategoryKeyword.data[5].title: return 5
        case CategoryKeyword.data[6].title: return 6
        case CategoryKeyword.data[7].title: return 7
        case CategoryKeyword.data[8].title: return 8
        case CategoryKeyword.data[9].title: return 9
        default:
            return 0
        }
    }
}
