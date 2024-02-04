//
//  FindViewController.swift
//  beilsang
//
//  Created by 강희진 on 2/3/24.
//

import UIKit

class FindViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Properties
    
    // 전체 화면 scrollview
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()

    //검색창
    lazy var searchBar: UITextField = {
        let view = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "NotoSansKR-Medium", size: 14) as Any,
            .foregroundColor : UIColor.beTextSub
        ]
        view.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        view.textColor = .beTextSub
        view.backgroundColor = .beBgSub
        view.layer.cornerRadius = 24
        view.attributedPlaceholder = NSAttributedString(string: "누구나 즐길 수 있는 대중교통 챌린지! 🚌", attributes: attributes)
        view.leftSearchPadding()
        return view
    }()
    lazy var searchIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon-search")
        return view
    }()
    
    // 명예의 전당 챌린지
    lazy var HofChallengeListLabel: UILabel = {
        let label = UILabel()
        label.text = "명예의 전당 챌린지 모음집 💾"
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        label.textColor = .black
        return label
    }()
    let HofChallengeCategoryList = CategoryKeyword.find
    lazy var HofChallengeCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    lazy var HofChallengeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: 160, height: 160)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.decelerationRate = .fast
        return view
    }()
    lazy var scrollIndicator: ScrollIndicatorView = {
        let view = ScrollIndicatorView()
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
extension FindViewController {
    
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
        [searchBar, searchIcon, HofChallengeListLabel, HofChallengeCategoryCollectionView, HofChallengeCollectionView, scrollIndicator].forEach{ view in fullContentView.addSubview(view)}
    }
    
    //snp 설정
    func viewConstraint(){
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(24)
        }
        searchIcon.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(searchBar)
            make.leading.equalTo(searchBar).offset(20)
        }
        HofChallengeListLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchBar)
            make.top.equalTo(searchBar.snp.bottom).offset(29)
        }
        HofChallengeCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(HofChallengeListLabel.snp.bottom).offset(12)
            make.leading.equalTo(searchBar)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(28)
        }
        HofChallengeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(HofChallengeCategoryCollectionView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(HofChallengeCategoryCollectionView)
            make.height.equalTo(160)
        }
        scrollIndicator.snp.makeConstraints { make in
            make.top.equalTo(HofChallengeCollectionView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(78)
            make.trailing.equalToSuperview().offset(-78)
            make.height.equalTo(4)
        }
    }
}
// MARK: - 네비게이션 바 커스텀
extension FindViewController{
    private func setNavigationBar() {
        self.navigationItem.titleView = attributeTitleView()
        setBackButton()
    }
    private func attributeTitleView() -> UIView {
        // 네비게이션 바에 타이틀을 왼쪽으로 옮기기 위해 커스텀 뷰 생성
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        // 커스텀 뷰 내에 타이틀 레이블 추가
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        titleLabel.text = "발견"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "NotoSansKR-SemiBold", size: 22)
        view.addSubview(titleLabel)
          
        return view
    }
    // 백버튼 커스텀
    func setBackButton() {
        let notiButton = UIBarButtonItem(image: UIImage(named: "iconamoon_notification-bold"), style: .plain, target: self, action: #selector(tabBarButtonTapped))
        notiButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = notiButton
    }
    // 백버튼 액션
    @objc func tabBarButtonTapped() {
            print("알림")
    }
}
// MARK: - collectionView setting(카테고리)
extension FindViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    // collectionView, delegate, datasorce 설정
    func setCollectionView() {
        [HofChallengeCategoryCollectionView, HofChallengeCollectionView].forEach { view in
            view.delegate = self
            view.dataSource = self
        }
        //Cell 등록
        HofChallengeCategoryCollectionView.register(HofChallengeCategoryCollectionViewCell.self, forCellWithReuseIdentifier: HofChallengeCategoryCollectionViewCell.identifier)            
        HofChallengeCollectionView.register(HofChallengeCollectionViewCell.self, forCellWithReuseIdentifier: HofChallengeCollectionViewCell.identifier)
        
        [HofChallengeCategoryCollectionView, HofChallengeCollectionView].forEach { view in
            view.showsHorizontalScrollIndicator = false
        }
        setFirstIndexIsSelected()
    }
    // section 개수 설정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // cell 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case HofChallengeCategoryCollectionView:
            return HofChallengeCategoryList.count
        case HofChallengeCollectionView:
            return 5
        default:
            return 0
        }
    }
    // cell 사이즈( 옆 라인을 고려하여 설정 ) - 순서 1
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case HofChallengeCategoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HofChallengeCategoryCollectionViewCell.identifier, for: indexPath) as?
                    HofChallengeCategoryCollectionViewCell else {
                return .zero
            }
            let target = HofChallengeCategoryList[indexPath.row]
            cell.categoryLabel.text = "\(target.image)\(target.title)"
            cell.categoryLabel.sizeToFit()
            return CGSize(width: cell.categoryLabel.frame.width + 20, height: 28)
        case HofChallengeCollectionView:
            return  CGSize(width: 160, height: 160)
        default:
            return CGSizeZero
        }
    }
    
    // cell 설정 - 순서 2
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case HofChallengeCategoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HofChallengeCategoryCollectionViewCell.identifier, for: indexPath) as?
                    HofChallengeCategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            let target = HofChallengeCategoryList[indexPath.row]
            cell.categoryLabel.text = "\(target.image)\(target.title)"
            cell.categoryLabel.sizeToFit()
            return cell
        case HofChallengeCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HofChallengeCollectionViewCell.identifier, for: indexPath) as?
                    HofChallengeCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    // cell 선택시 액션
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch collectionView{
//        case challengeCategoryCollectionView:
//            let cell = collectionView.cellForItem(at: indexPath) as! ChallengeCategoryCollectionViewCell
//
//        default:
//            return
//        }
    }
    // collectionCell 첫 화면 설정
    func setFirstIndexIsSelected() {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        HofChallengeCategoryCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom) // 0번째 Index로
    }
    // 스크롤 설정
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scroll = scrollView.contentOffset.x + scrollView.contentInset.left
        if scroll.isZero { //처음 view 보여줄 때는 scroll시작 위치 = 0이므로 0으로 설정해준다
            let scrollRatio = 0.0
            self.scrollIndicator.leftOffsetRatio = scrollRatio
        } else{ // 스크롤을 움직이면 위치에 따라 leftOffsetRatio를 설정해준다.
            let width = scrollView.contentSize.width + scrollView.contentInset.left + scrollView.contentInset.right
            let scrollRatio = scroll / width
            self.scrollIndicator.leftOffsetRatio = scrollRatio
        }
      }
}
// MARK: - function
extension FindViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let allWidth = self.HofChallengeCollectionView.contentSize.width + self.HofChallengeCollectionView.contentInset.left + self.HofChallengeCollectionView.contentInset.right
        let showingWidth = self.HofChallengeCollectionView.bounds.width
        // 움직일 scroll 길이 설정
        self.scrollIndicator.widthRatio = showingWidth / allWidth
        self.scrollIndicator.layoutIfNeeded()
    }
}

// 텍스트필드 placeholder 왼쪽에 padding 추가
extension UITextField{
    func leftSearchPadding() {
        // 1
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 52, height: self.frame.height))        
        // 2
        self.leftView = leftView
        // 3
        self.leftViewMode = ViewMode.always
    }
}
