//
//  PointViewController.swift
//  beilsang
//
//  Created by 강희진 on 2/1/24.
//

import UIKit
import SwiftUI

class PointViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Properties
    
    // 전체 화면 scrollview
    let fullScrollView = UIScrollView()
    let fullContentView = UIView()
    // parsing 정보
    var allList: [PointData] = []
    var earnList: [PointData] = []
    var useList: [PointData] = []
    var disappearList: [PointData] = []
    // cell들의 정보
    var cellList: [PointData] = []
   
    lazy var pointTitle: UILabel = {
        let label = UILabel()
        label.text = "현재 보유 포인트"
        label.font = UIFont(name: "NotoSansKR-SemiBold", size: 18)
        return label
    }()
    lazy var pointImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Group 1000002645")
        return view
    }()
    lazy var point: UILabel = {
        let label = UILabel()
        label.text = "916P"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 18)
        return label
    }()
    lazy var allButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .beScPurple600
        button.layer.cornerRadius = 14
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    lazy var earnButton: UIButton = {
        let button = UIButton()
        button.setTitle("적립", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .beBgSub
        button.layer.cornerRadius = 14
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    lazy var useButton: UIButton = {
        let button = UIButton()
        button.setTitle("사용", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .beBgSub
        button.layer.cornerRadius = 14
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    lazy var disappearButton: UIButton = {
        let button = UIButton()
        button.setTitle("소멸", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .beBgSub
        button.layer.cornerRadius = 14
        button.titleLabel?.font = UIFont(name: "NotoSansKR-Medium", size: 14)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    lazy var pointCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: self.view.frame.width - 32, height: 100)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        request()
        setupAttribute()
        setNavigationBar()
        viewConstraint()
    }

}
extension PointViewController {
    func request() {
        MyPageService.shared.getPoint(baseEndPoint: .mypage, addPath: "/points"){ response in
            self.point.text = String(response.data.total)
            if !response.data.points!.isEmpty{
                self.setPointList(response.data.points!)
            }
        }
    }
    @MainActor
    private func setPointList(_ points: [PointData]){
        for i in points {
            self.allList.append(i)
            if i.status == "EARN"{
                self.earnList.append(i)
            }
            else if i.status == "USE"{
                self.useList.append(i)
            } else {
                self.disappearList.append(i)
            }
        }
        cellList = self.allList
        pointCollectionView.reloadData()
    }
    
    func setupAttribute() {
        setFullScrollView()
        setLayout()
        setCollectionView()
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
        [pointTitle, pointImage, point, allButton, earnButton, useButton, disappearButton, pointCollectionView].forEach{ view in fullContentView.addSubview(view)}
        
    }
    
    //snp 설정
    func viewConstraint(){
        pointTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(16)
        }
        pointImage.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.top.equalTo(pointTitle.snp.bottom).offset(11)
            make.leading.equalTo(pointTitle)
        }
        point.snp.makeConstraints { make in
            make.centerY.equalTo(pointImage)
            make.leading.equalTo(pointImage.snp.trailing).offset(8)
        }
        allButton.snp.makeConstraints { make in
            make.width.equalTo(58)
            make.height.equalTo(28)
            make.top.equalTo(point).offset(36)
            make.leading.equalTo(pointTitle)
        }
        earnButton.snp.makeConstraints { make in
            make.width.equalTo(58)
            make.height.equalTo(28)
            make.centerY.equalTo(allButton)
            make.leading.equalTo(allButton.snp.trailing).offset(8)
        }
        useButton.snp.makeConstraints { make in
            make.width.equalTo(58)
            make.height.equalTo(28)
            make.centerY.equalTo(allButton)
            make.leading.equalTo(earnButton.snp.trailing).offset(8)
        }
        disappearButton.snp.makeConstraints { make in
            make.width.equalTo(58)
            make.height.equalTo(28)
            make.centerY.equalTo(allButton)
            make.leading.equalTo(useButton.snp.trailing).offset(8)
        }
        pointCollectionView.snp.makeConstraints { make in
            make.top.equalTo(allButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
// MARK: - 네비게이션 바 커스텀
extension PointViewController{
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
extension PointViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    // collectionView, delegate, datasorce 설정
    func setCollectionView() {
        [pointCollectionView].forEach { view in
            view.delegate = self
            view.dataSource = self
        }
        
        //Cell 등록
        pointCollectionView.register(PointCollectionViewCell.self, forCellWithReuseIdentifier: PointCollectionViewCell.identifier)
        
        
    }
    // section 개수 설정
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // cell 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case pointCollectionView:
            return cellList.count
        default:
            return 0
        }
    }
    
    // cell 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case pointCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PointCollectionViewCell.identifier, for: indexPath) as?
                    PointCollectionViewCell else {
                return UICollectionViewCell()
            }
            if !cellList.isEmpty{
                let target = cellList[indexPath.row]
                
                // "2024-02-10" -> "2024.02.10" 문자 변경
                cell.dateLabel.text = target.date.replacingOccurrences(of: "-", with: ".")
                
                // status에 따른 색상과 type 변경
                if target.status == "EARN"{
                    cell.typeLabel.text = "적립"
                    cell.pointLabel.textColor = .beScPurple600
                    cell.pointLabel.text = "+\(target.value)P"
                }
                else{
                    // 사용, 소멸 type 라벨 변경
                    if target.status == "USE"{
                        cell.typeLabel.text = "사용"
                    } else {
                        cell.typeLabel.text = "소멸"
                    }
                    
                    cell.pointLabel.textColor = .beTextInfo
                    cell.pointLabel.text = "-\(target.value)P"
                }
                cell.pointContent.text = "\(target.name)"
            }
            
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    // cell 선택시 액션
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch collectionView{
//        case pointCollectionView:
//            let cell = collectionView.cellForItem(at: indexPath) as! ChallengeMenuCollectionViewCell
//            if indexPath.row == 1{ //적립
//                
//            }
//        default:
//            return
//        }
//    }
}

// MARK: - function
extension PointViewController {
    @objc func tapButton(_ sender: UIButton) {
        [allButton, earnButton, useButton, disappearButton].forEach { view in
            if view == sender{
                view.setTitleColor(.white, for: .normal)
                view.backgroundColor = .beScPurple600
            }else {
                view.setTitleColor(.black, for: .normal)
                view.backgroundColor = .beBgSub
            }
        }
        if sender == allButton{
            cellList = allList
        } else if sender == earnButton {
            cellList = earnList
        } else if sender == useButton {
            cellList = useList
        } else {
            cellList = disappearList
        }
        pointCollectionView.reloadData()
    }
}
