//
//  MyChallengeViewController.swift
//  beilsang
//
//  Created by 강희진 on 1/28/24.
//

import UIKit

class MyChallengeViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties
    
    // 전체 화면 scrollview
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    
    let menuList = ["참여중", "등록한", "완료됨"]
    
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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAttribute()
        viewConstraint()
        setNavigationBar()
        setCollectionView()
    }

}
extension MyChallengeViewController {
    
    func setupAttribute() {
        setFullScrollView()
        setLayout()
        setScrollViewLayout()
    }
    
    func setFullScrollView() {
        fullScrollView.showsVerticalScrollIndicator = true
        fullScrollView.delegate = self
        
        //스크롤 안보이게 설정
        fullScrollView.showsVerticalScrollIndicator = false
    }
    
    func setLayout() {
        view.addSubview(fullScrollView)
        fullScrollView.addSubview(fullContentView)
        addView()
    }
    func setScrollViewLayout(){
        fullScrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
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
        //상단부
        [menuCollectionView, menuUnderLine, categoryCollectionView].forEach{view in fullContentView.addSubview(view)}
        
    }
    
    //snp 설정
    func viewConstraint(){
        menuCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
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
        let leftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-navigation"), style: .plain, target: self, action: #selector(tabBarButtonTapped))
        leftBarButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    // 백버튼 액션
    @objc func tabBarButtonTapped() {
            print("뒤로 가기")
    }
}
// MARK: - collectionView setting(카테고리)
extension MyChallengeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // collectionView, delegate, datasorce 설정
    func setCollectionView() {
        [menuCollectionView, categoryCollectionView].forEach { view in
            view.delegate = self
            view.dataSource = self
        }
        
        //Cell 등록
        menuCollectionView.register(ChallengeMenuCollectionViewCell.self, forCellWithReuseIdentifier: ChallengeMenuCollectionViewCell.identifier)
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        // 컬렉션 뷰 첫 화면 선택
        setFirstIndexIsSelected()
        
        categoryCollectionView.showsHorizontalScrollIndicator = false
    }
    
    // cell 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case menuCollectionView:
            return menuList.count
        case categoryCollectionView:
            return categoryDataList.count
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as?
                    CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            let target = categoryDataList[indexPath.row]
            let img = UIImage(named: "\(target.image).svg")
            cell.keywordImage.image = img
            cell.keywordLabel.text = target.title
            
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
            
            let labelText = cell.menuLabel.text
            let challengeListVC = ChallengeListViewController()
            challengeListVC.categoryLabelText = labelText
        case categoryCollectionView:
            let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
            
            let labelText = cell.keywordLabel.text
            let challengeListVC = ChallengeListViewController()
            challengeListVC.categoryLabelText = labelText
        default:
            return
        }
    }
    
    // collectionCell 첫 화면 설정
    func setFirstIndexIsSelected() {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        menuCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom) // 0번째 Index로
    }

}

