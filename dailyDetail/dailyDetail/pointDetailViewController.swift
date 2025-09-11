//
//  pointDetailViewController.swift
//  dailyDetail
//
//  Created by nan on 2025/9/11.
//

import UIKit

import UIKit
import SnapKit

// MARK: - GiftCardView (礼包卡片)
class GiftCardView: UIView {
    private let container = UIView()
    private let titleLabel = UILabel()
    private let descLabel = UILabel()
    private let priceLabel = UILabel()
    private let tagLabel = UILabel()
    private let selectDot = UIView()
    
    var onTap: ((GiftCardView) -> Void)?
    private(set) var isSelectedCard: Bool = false {
        didSet { updateSelectionUI() }
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(container)
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(84)
        }
        
        // tagLabel (right-top small badge)
        tagLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        tagLabel.textColor = .white
        tagLabel.backgroundColor = UIColor(red: 0.86, green: 0.22, blue: 0.61, alpha: 1)
        tagLabel.layer.cornerRadius = 12
        tagLabel.clipsToBounds = true
        tagLabel.textAlignment = .center
        container.addSubview(tagLabel)
        tagLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(56)
        }
        
        // selection dot (left)
        selectDot.backgroundColor = .clear
        selectDot.layer.borderWidth = 1.5
        selectDot.layer.cornerRadius = 10
        selectDot.layer.borderColor = UIColor.lightGray.cgColor
        container.addSubview(selectDot)
        selectDot.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        // title, desc, price
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        descLabel.font = .systemFont(ofSize: 12)
        descLabel.textColor = .gray
        descLabel.numberOfLines = 1
        priceLabel.font = .systemFont(ofSize: 15, weight: .bold)
        priceLabel.textColor = .black
        
        container.addSubview(titleLabel)
        container.addSubview(descLabel)
        container.addSubview(priceLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(selectDot.snp.right).offset(12)
            make.right.lessThanOrEqualTo(tagLabel.snp.left).offset(-8)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(titleLabel)
            make.right.lessThanOrEqualTo(priceLabel.snp.left).offset(-8)
        }
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(12)
            make.width.lessThanOrEqualTo(120)
        }
        
        updateSelectionUI()
    }
    
    private func updateSelectionUI() {
        if isSelectedCard {
            container.layer.borderColor = UIColor.systemPurple.cgColor
            selectDot.backgroundColor = UIColor.systemPurple
            selectDot.layer.borderColor = UIColor.systemPurple.cgColor
        } else {
            container.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
            selectDot.backgroundColor = .clear
            selectDot.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    @objc private func handleTap() {
        isSelectedCard.toggle()
        onTap?(self)
    }
    
    func configure(title: String, desc: String?, price: String, tag: String?, selected: Bool = false) {
        titleLabel.text = title
        descLabel.text = desc
        priceLabel.text = price
        tagLabel.text = tag
        tagLabel.isHidden = (tag == nil)
        isSelectedCard = selected
    }
}

// MARK: - HeaderView 包含两个礼包卡片
class GiftHeaderView: UICollectionReusableView {
    static let reuseId = "GiftHeaderView"
    
    private let firstCard = GiftCardView()
    private let secondCard = GiftCardView()
    private let container = UIView()
    
    // 外部可以监听选择行为
    var onSelectCard: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    private func setupUI() {
        addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        container.addSubview(firstCard)
        container.addSubview(secondCard)
        
        firstCard.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().inset(12)
            make.height.equalTo(84)
        }
        secondCard.snp.makeConstraints { make in
            make.top.equalTo(firstCard.snp.bottom).offset(12)
            make.left.right.equalTo(firstCard)
            make.height.equalTo(84)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    private func setupActions() {
        firstCard.onTap = { [weak self] card in
            guard let self = self else { return }
            self.firstCard.configure(title: "🎉 首充礼包", desc: "3500+3500 赠送=7000", price: "¥28", tag: "60% SAVE", selected: true)
            self.secondCard.configure(title: "🛡 活动礼包", desc: "10500+3500 赠送=14000", price: "¥78", tag: "立省 ¥19", selected: false)
            self.onSelectCard?(0)
        }
        secondCard.onTap = { [weak self] card in
            guard let self = self else { return }
            self.firstCard.configure(title: "🎉 首充礼包", desc: "3500+3500 赠送=7000", price: "¥28", tag: "60% SAVE", selected: false)
            self.secondCard.configure(title: "🛡 活动礼包", desc: "10500+3500 赠送=14000", price: "¥78", tag: "立省 ¥19", selected: true)
            self.onSelectCard?(1)
        }
    }
    
    func configure(firstSelected: Bool = true) {
        firstCard.configure(title: "🎉 首充礼包", desc: "3500+3500 赠送=7000", price: "¥28", tag: "60% SAVE", selected: firstSelected)
        secondCard.configure(title: "🛡 活动礼包", desc: "10500+3500 赠送=14000", price: "¥78", tag: "立省 ¥19", selected: !firstSelected)
    }
}

// MARK: - PointCell (网格中的积分选项)
class PointCell: UICollectionViewCell {
    static let reuseId = "PointCell"
    
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        contentView.backgroundColor = .white
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textAlignment = .center
        
        priceLabel.font = .systemFont(ofSize: 12)
        priceLabel.textAlignment = .center
        priceLabel.textColor = .gray
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.left.right.equalToSuperview().inset(6)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(points: String, price: String) {
        titleLabel.text = points
        priceLabel.text = price
    }
}

// MARK: - PointsViewController (示例)
class PointsViewController: UIViewController {
    private var collectionView: UICollectionView!
    
    private let pointsData: [(String, String)] = [
        ("5000 积分", "¥36"),
        ("50000 积分", "¥260"),
        ("100000 积分", "¥720"),
        ("200000 积分", "¥1440"),
        ("300000 积分", "¥2160"),
        ("500000 积分", "¥2880")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "积分购买"
        view.backgroundColor = UIColor(white: 0.98, alpha: 1)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(PointCell.self, forCellWithReuseIdentifier: PointCell.reuseId)
        collectionView.register(GiftHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: GiftHeaderView.reuseId)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Collection DataSource & Delegate
extension PointsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 0 : pointsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PointCell.reuseId, for: indexPath) as! PointCell
        let item = pointsData[indexPath.item]
        cell.configure(points: item.0, price: item.1)
        return cell
    }
    
    // header
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: GiftHeaderView.reuseId,
                                                                         for: indexPath) as! GiftHeaderView
            header.configure(firstSelected: true)
            header.onSelectCard = { idx in
                print("selected card index:", idx)
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    // layout sizes
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        // show header only for section 0
        return section == 0 ? CGSize(width: collectionView.bounds.width, height: 200) : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 3 columns grid
        let totalPadding: CGFloat = 12 * 4 // left + right + 2 interItem spaces
        let width = (collectionView.bounds.width - totalPadding) / 3
        return CGSize(width: width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = pointsData[indexPath.item]
        print("selected points item:", item)
    }
}
