//
//  LikeViewController.swift
//  beilsang
//
//  Created by 강희진 on 2/1/24.
//

import UIKit

class LikeViewController: UIViewController, UIScrollViewDelegate {

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
    let categoryDataList = CategoryKeyword.data[1...]
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
    
    lazy var categoryUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .beBgSub
        return view
    }()
    lazy var challengeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 16)
        label.textColor = .black
        label.text = "다회용기 챌린지"
        return label
    }()
    
    lazy var challengeBoxCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.makeFlowLayout())
        return view
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAttribute()
        setCollectionView()
        setNavigationBar()
        viewConstraint()
    }

}
extension LikeViewController {
    
    func setupAttribute() {
        setFullScrollView()
        setLayout()
        setScrollViewLayout()
    }
    
    func setFullScrollView() {
        fullScrollView.delegate = self
        //스크롤 안움직이게 설정
        fullScrollView.isScrollEnabled = false
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
        [menuCollectionView, menuUnderLine, categoryCollectionView, categoryUnderLine, challengeLabel, challengeBoxCollectionView].forEach{ view in fullContentView.addSubview(view)}
        
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
        categoryUnderLine.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(8)
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(24)
            make.leading.equalToSuperview()
        }
        challengeLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryUnderLine.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(16)
        }
        challengeBoxCollectionView.snp.makeConstraints { make in
            make.top.equalTo(challengeLabel.snp.bottom).offset(12)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
    }
}
// MARK: - 네비게이션 바 커스텀
extension LikeViewController{
    private func setNavigationBar() {
        self.navigationItem.titleView = attributeTitleView()
        
        // 백 버튼 설정
        setBackButton()
    }
    private func attributeTitleView() -> UIView {
        // title 설정
        let label = UILabel()
        let lightText: NSMutableAttributedString =
            NSMutableAttributedString(string: "찜",attributes: [
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
extension LikeViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    // collectionView, delegate, datasorce 설정
    func setCollectionView() {
        [menuCollectionView, categoryCollectionView, challengeBoxCollectionView].forEach { view in
            view.delegate = self
            view.dataSource = self
        }
        
        //Cell 등록
        menuCollectionView.register(ChallengeMenuCollectionViewCell.self, forCellWithReuseIdentifier: ChallengeMenuCollectionViewCell.identifier)
        categoryCollectionView.register(MyPageCategoryCollectionViewCell.self, forCellWithReuseIdentifier: MyPageCategoryCollectionViewCell.identifier)
        challengeBoxCollectionView.register(ChallengeListCollectionViewCell.self, forCellWithReuseIdentifier: ChallengeListCollectionViewCell.identifier)
        
        // 컬렉션 뷰 첫 화면 선택
        setFirstIndexIsSelected()
        
        // 스크롤 감추기
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
        case challengeBoxCollectionView:
            return 5
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
            
            let target = categoryDataList[indexPath.row+1]
            let img = UIImage(named: "\(target.image).svg")
            cell.keywordImage.image = img
            cell.keywordLabel.text = target.title
            
            return cell
        case challengeBoxCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeListCollectionViewCell.identifier, for: indexPath) as?
                    ChallengeListCollectionViewCell else {
                return UICollectionViewCell() }
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
            let cell = categoryCollectionView.cellForItem(at: indexPath) as! MyPageCategoryCollectionViewCell
            
            challengeLabel.text = "\(cell.keywordLabel.text!) 챌린지"
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
    
    // 섹션 별 크기 설정을 위한 함수
    // challengeBoxCollectionView layout 커스텀
    private func makeFlowLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, ev -> NSCollectionLayoutSection? in
            
            makeChallengeSectionLayout()
        }
        func makeChallengeSectionLayout() -> NSCollectionLayoutSection? {
            // item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            /// 아이템들이 들어갈 Group 설정
            /// groupSize 설정
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(140))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
            // section
            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .continuous // 섹션 내 가로 스크롤
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: 16,
                bottom: 0,
                trailing: 16)
            
            return section
        }
    }
}
