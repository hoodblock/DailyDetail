//
//  ViewController.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import UIKit
import SnapKit

//// MARK: - Section Header
//class SectionHeaderView: UITableViewHeaderFooterView {
//    static let reuseId = "SectionHeaderView"
//    
//    private let titleLabel = UILabel()
//    
//    override init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//        
//        contentView.backgroundColor = .systemGroupedBackground
//        contentView.addSubview(titleLabel)
//        
//        titleLabel.font = .boldSystemFont(ofSize: 18)
//        titleLabel.textColor = .black
//        
//        titleLabel.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(16)
//            make.bottom.equalToSuperview().inset(8)
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure(title: String) {
//        titleLabel.text = title
//    }
//}
//
//// MARK: - 基础积分 Cell
//class PointsHeaderCell: UITableViewCell {
//    static let reuseId = "PointsHeaderCell"
//
//    private let baseLabel = UILabel()
//    private let baseValue = UILabel()
//    private let dailyLabel = UILabel()
//    private let dailyValue = UILabel()
//    private let rechargeButton = UIButton(type: .system)
//
//    private let card = UIView()
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        selectionStyle = .none
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupUI() {
//        contentView.addSubview(card)
//        card.backgroundColor = .white
//        card.layer.cornerRadius = 12
//
//        card.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(8)
//            make.height.equalTo(160)
//        }
//
//        baseLabel.text = "基础积分"
//        baseValue.text = "1000"
//        dailyLabel.text = "每日刷新积分"
//        dailyValue.text = "300"
//
//        [baseLabel, dailyLabel].forEach { $0.font = .systemFont(ofSize: 15) }
//        [baseValue, dailyValue].forEach {
//            $0.font = .systemFont(ofSize: 15, weight: .medium)
//            $0.textAlignment = .right
//        }
//
//        rechargeButton.setTitle("充值", for: .normal)
//        rechargeButton.setTitleColor(.white, for: .normal)
//        rechargeButton.backgroundColor = .systemBlue
//        rechargeButton.layer.cornerRadius = 10
//
//        let row1 = row(baseLabel, baseValue)
//        let row2 = row(dailyLabel, dailyValue)
//
//        let stack = UIStackView(arrangedSubviews: [row1, row2, rechargeButton])
//        stack.axis = .vertical
//        stack.spacing = 16
//        card.addSubview(stack)
//
//        stack.snp.makeConstraints { make in
//            make.edges.equalToSuperview().inset(16)
//        }
//
//        rechargeButton.snp.makeConstraints { make in
//            make.height.equalTo(44)
//        }
//    }
//
//    private func row(_ left: UIView, _ right: UIView) -> UIView {
//        let stack = UIStackView(arrangedSubviews: [left, right])
//        stack.axis = .horizontal
//        stack.distribution = .equalSpacing
//        return stack
//    }
//}
//// MARK: - 积分明细 Cell
//class PointRecordCell: UITableViewCell {
//    static let reuseId = "PointRecordCell"
//    
//    private let titleLabel = UILabel()
//    private let dateLabel = UILabel()
//    private let valueLabel = UILabel()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(dateLabel)
//        contentView.addSubview(valueLabel)
//        
//        titleLabel.font = .systemFont(ofSize: 16)
//        dateLabel.font = .systemFont(ofSize: 12)
//        dateLabel.textColor = .gray
//        valueLabel.font = .boldSystemFont(ofSize: 16)
//        
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(8)
//            make.left.equalToSuperview().offset(16)
//        }
//        
//        dateLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(4)
//            make.left.equalTo(titleLabel)
//            make.bottom.equalToSuperview().inset(8)
//        }
//        
//        valueLabel.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview().inset(16)
//        }
//    }
//    
//    func configure(title: String, date: String, value: Int) {
//        titleLabel.text = title
//        dateLabel.text = date
//        valueLabel.text = value > 0 ? "+\(value)" : "\(value)"
//        valueLabel.textColor = value > 0 ? .systemGreen : .systemRed
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//// MARK: - ViewController
//class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    private let tableView = UITableView(frame: .zero, style: .grouped)
//    
//    private var records: [(title: String, date: String, value: Int)] = [
//        ("每日签到", "2025-09-01", 10),
//        ("分享任务", "2025-09-02", 20),
//        ("兑换奖励", "2025-09-03", -50)
//    ]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = "积分明细"
//        view.backgroundColor = .systemGroupedBackground
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.separatorInset = .zero
//        tableView.register(PointsHeaderCell.self, forCellReuseIdentifier: PointsHeaderCell.reuseId)
//        tableView.register(PointRecordCell.self, forCellReuseIdentifier: PointRecordCell.reuseId)
//        tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseId)
//        
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        let viewController = ImageUploadViewController()
//        self.present(viewController, animated: true)
//    }
//    
//    // MARK: - TableView
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return section == 0 ? 1 : records.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            return tableView.dequeueReusableCell(withIdentifier: PointsHeaderCell.reuseId, for: indexPath)
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: PointRecordCell.reuseId, for: indexPath) as! PointRecordCell
//            let record = records[indexPath.row]
//            cell.configure(title: record.title, date: record.date, value: record.value)
//            return cell
//        }
//    }
//    
//    // MARK: - Header
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseId) as? SectionHeaderView else {
//            return nil
//        }
//        header.configure(title: section == 0 ? "基础积分" : "积分明细")
//        return header
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 44
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let viewController = PointsViewController()
//        self.present(viewController, animated: true)
//    }
//}


//import UIKit
//import SnapKit
//import PhotosUI
//
//// MARK: - Image Cell
//class ImagePickerCell: UICollectionViewCell {
//    static let reuseId = "ImagePickerCell"
//
//    let imageView = UIImageView()
//    private let deleteButton = UIButton(type: .custom)
//    var deleteAction: (() -> Void)?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(imageView)
//        contentView.addSubview(deleteButton)
//
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        deleteButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
//        deleteButton.tintColor = .white
//        deleteButton.backgroundColor = UIColor(white: 0, alpha: 0.35)
//        deleteButton.layer.cornerRadius = 12
//        deleteButton.clipsToBounds = true
//        deleteButton.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(-6)
//            make.right.equalToSuperview().offset(6)
//            make.width.height.equalTo(24)
//        }
//        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        imageView.layer.cornerRadius = bounds.width / 2
//    }
//
//    @objc private func deleteTapped() {
//        deleteAction?()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//// MARK: - Add Cell
//class AddImageCell: UICollectionViewCell {
//    static let reuseId = "AddImageCell"
//
//    let addButton = UIButton(type: .system)
//    var addAction: (() -> Void)?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(addButton)
//
//        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
//        addButton.tintColor = .lightGray
//        addButton.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.width.height.equalTo(frame.width * 0.5)
//        }
//        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
//        contentView.layer.cornerRadius = frame.width / 2
//        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
//    }
//
//    @objc private func addTapped() {
//        addAction?()
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.layer.cornerRadius = bounds.width / 2
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//// MARK: - ViewController
//@available(iOS 14.0, *)
//class ViewController: UIViewController {
//
//    private var images: [UIImage] = []
//    private var collectionView: UICollectionView!
//
//    private let maxImages = 6
//    private let spacing: CGFloat = 12
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        title = "选择图片"
//        setupCollectionView()
//    }
//
//    private func setupCollectionView() {
//        let layout = UICollectionViewFlowLayout()
//
//        let totalHorizontalInset: CGFloat = 40 // 左右各20 (和之前一致)
//        let availableWidth = view.bounds.width - totalHorizontalInset - spacing * 2
//        let itemWidth = floor(availableWidth / 3.0)
//
//        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
//        layout.minimumLineSpacing = spacing
//        layout.minimumInteritemSpacing = spacing
//        layout.sectionInset = UIEdgeInsets(top: spacing, left: 20, bottom: spacing, right: 20)
//
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .white
//        collectionView.register(ImagePickerCell.self, forCellWithReuseIdentifier: ImagePickerCell.reuseId)
//        collectionView.register(AddImageCell.self, forCellWithReuseIdentifier: AddImageCell.reuseId)
//
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//        view.addSubview(collectionView)
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//
//        // 长按拖拽
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
//        collectionView.addGestureRecognizer(longPress)
//    }
//
//    // 计算当前展示的 cell 数（如果小于 max 则包含加号）
//    private var displayedItemCount: Int {
//        return images.count < maxImages ? images.count + 1 : images.count
//    }
//
//    // MARK: - Picker
//    @objc private func presentPicker() {
//        var config = PHPickerConfiguration()
//        config.selectionLimit = maxImages - images.count
//        config.filter = .images
//        let picker = PHPickerViewController(configuration: config)
//        picker.delegate = self
//        present(picker, animated: true)
//    }
//
//    private func appendImage(_ image: UIImage) {
//        images.append(image)
//        collectionView.reloadData()
//    }
//
//    private func removeImage(at index: Int) {
//        guard index >= 0 && index < images.count else { return }
//        images.remove(at: index)
//        collectionView.reloadData()
//    }
//}
//
//// MARK: - DataSource & Delegate
//@available(iOS 14.0, *)
//extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return displayedItemCount
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        // 如果是最后一个并且尚未达到上限 => 加号 cell
//        if images.count < maxImages && indexPath.item == images.count {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddImageCell.reuseId, for: indexPath) as! AddImageCell
//            cell.addAction = { [weak self] in
//                self?.presentPicker()
//            }
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCell.reuseId, for: indexPath) as! ImagePickerCell
//            let idx = indexPath.item
//            cell.imageView.image = images[idx]
//            // 把 index 用局部常量捕获，避免复用时索引错乱
//            cell.deleteAction = { [weak self, weak cell] in
//                guard let self = self, let cell = cell else { return }
//                if let indexPath = self.collectionView.indexPath(for: cell) {
//                    self.removeImage(at: indexPath.item)
//                }
//            }
//            return cell
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // 点击加号也走 addAction，通过 cell 的回调已经处理
//    }
//
//    // 只允许图片 cell 可移动（加号 cell 不可移动）
//    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
//        return indexPath.item < images.count
//    }
//
//    // 拖拽目标位置限制（关键）：禁止目标落到“加号 cell”的位置
//    func collectionView(_ collectionView: UICollectionView,
//                        targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath,
//                        toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
//        // 最大允许的目标索引为 images.count - 1（最后一个图片的位置）
//        let maxTarget = max(0, images.count - 1)
//        var proposed = proposedIndexPath
//
//        // 如果当前显示加号（images.count < maxImages），则加号在 index = images.count，禁止落到该位置
//        if images.count < maxImages {
//            if proposed.item >= images.count {
//                proposed = IndexPath(item: maxTarget, section: proposed.section)
//            }
//        } else {
//            // 不存在加号时，允许目标 index 在 [0, images.count-1]
//            if proposed.item > maxTarget {
//                proposed = IndexPath(item: maxTarget, section: proposed.section)
//            }
//        }
//        return proposed
//    }
//
//    // 当移动完成后更新数据源
//    func collectionView(_ collectionView: UICollectionView,
//                        moveItemAt sourceIndexPath: IndexPath,
//                        to destinationIndexPath: IndexPath) {
//        // 双重保护：确保目标不是加号位置
//        guard sourceIndexPath.item < images.count, destinationIndexPath.item < images.count else {
//            // 如果异常，reload 回滚
//            collectionView.reloadData()
//            return
//        }
//        let moved = images.remove(at: sourceIndexPath.item)
//        images.insert(moved, at: destinationIndexPath.item)
//    }
//}
//
//// MARK: - Long press interactive movement
//@available(iOS 14.0, *)
//extension ViewController {
//
//    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
//        let location = gesture.location(in: collectionView)
//        switch gesture.state {
//        case .began:
//            guard let indexPath = collectionView.indexPathForItem(at: location),
//                  indexPath.item < images.count
//            else { return }
//            let cell = collectionView.cellForItem(at: indexPath)
//            animateCellScaling(cell: cell, scale: 1.1, shadow: true)
//            collectionView.beginInteractiveMovementForItem(at: indexPath)
//        case .changed:
//            collectionView.updateInteractiveMovementTargetPosition(location)
//        case .ended:
//            collectionView.endInteractiveMovement()
//            resetAllCellAnimations()
//        default:
//            collectionView.cancelInteractiveMovement()
//            resetAllCellAnimations()
//        }
//    }
//
//    private func animateCellScaling(cell: UICollectionViewCell?, scale: CGFloat, shadow: Bool) {
//        guard let cell = cell else { return }
//        UIView.animate(withDuration: 0.2) {
//            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
//            if shadow {
//                cell.layer.shadowColor = UIColor.black.cgColor
//                cell.layer.shadowOpacity = 0.3
//                cell.layer.shadowRadius = 8
//                cell.layer.shadowOffset = CGSize(width: 0, height: 4)
//            }
//        }
//    }
//
//    private func resetAllCellAnimations() {
//        for cell in collectionView.visibleCells {
//            UIView.animate(withDuration: 0.2) {
//                cell.transform = .identity
//                cell.layer.shadowOpacity = 0
//            }
//        }
//    }
//}
//
//// MARK: - PHPicker Delegate
//@available(iOS 14.0, *)
//extension ViewController: PHPickerViewControllerDelegate {
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//        picker.dismiss(animated: true)
//        guard !results.isEmpty else { return }
//
//        // 异步加载所有图片并追加
//        let group = DispatchGroup()
//        var loaded: [UIImage] = []
//
//        for result in results {
//            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
//                group.enter()
//                result.itemProvider.loadObject(ofClass: UIImage.self) { object, _ in
//                    if let img = object as? UIImage {
//                        loaded.append(img)
//                    }
//                    group.leave()
//                }
//            }
//        }
//
//        group.notify(queue: .main) { [weak self] in
//            guard let self = self else { return }
//            // 保证不超过 maxImages（即使 PHPicker 返回更多）
//            let space = self.maxImages - self.images.count
//            let toAppend = Array(loaded.prefix(space))
//            self.images.append(contentsOf: toAppend)
//            self.collectionView.reloadData()
//        }
//    }
//}


import UIKit
import SnapKit
import PhotosUI

// MARK: - ImagePickerCell
class ImagePickerCell: UICollectionViewCell {
    static let reuseId = "ImagePickerCell"

    let imageView = UIImageView()
    private let deleteButton = UIButton(type: .custom)
    var deleteAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        deleteButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        deleteButton.tintColor = .white
        deleteButton.backgroundColor = UIColor(white: 0, alpha: 0.35)
        deleteButton.layer.cornerRadius = 12
        deleteButton.clipsToBounds = true
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-6)
            make.right.equalToSuperview().offset(6)
            make.width.height.equalTo(24)
        }
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = bounds.width / 2
    }

    @objc private func deleteTapped() {
        deleteAction?()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - AddImageCell
class AddImageCell: UICollectionViewCell {
    static let reuseId = "AddImageCell"

    let addButton = UIButton(type: .system)
    var addAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(addButton)

        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .lightGray
        addButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(1) // 占位，layoutSubviews 会重置
        }
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)

        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(white: 0.9, alpha: 1).cgColor
        contentView.clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = bounds.width / 2
        addButton.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(bounds.width * 0.5)
        }
    }

    @objc private func addTapped() {
        addAction?()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ImagePickerManager (Block 回调)
class ImagePickerManager: NSObject {

    private weak var presentingVC: UIViewController?
    private let maxSelection: Int
    private var completion: (([UIImage]) -> Void)?

    init(presentingVC: UIViewController, maxSelection: Int) {
        self.presentingVC = presentingVC
        self.maxSelection = maxSelection
        super.init()
    }

    func presentPicker(completion: @escaping ([UIImage]) -> Void) {
        self.completion = completion
        guard let vc = presentingVC else { return }

        if #available(iOS 14, *) {
            var config = PHPickerConfiguration()
            config.selectionLimit = maxSelection
            config.filter = .images
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
            vc.present(picker, animated: true)
        } else {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            vc.present(picker, animated: true)
        }
    }
}

@available(iOS 14.0, *)
extension ImagePickerManager: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard !results.isEmpty else { return }

        let group = DispatchGroup()
        var loaded: [UIImage] = []

        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                group.enter()
                result.itemProvider.loadObject(ofClass: UIImage.self) { object, _ in
                    defer { group.leave() }
                    if let img = object as? UIImage {
                        loaded.append(img)
                    }
                }
            }
        }

        group.notify(queue: .main) { [weak self] in
            self?.completion?(loaded)
        }
    }
}

extension ImagePickerManager: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let image = info[.originalImage] as? UIImage {
            completion?([image])
        }
    }
}

// MARK: - ViewController (拖拽排序 + 加号 cell + 删除动画)
//@available(iOS 13.0, *)
class ViewController: UIViewController {

    private var images: [UIImage] = []
    private var collectionView: UICollectionView!
    private var pickerManager: ImagePickerManager!
    private let maxImages = 6
    private let spacing: CGFloat = 12

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "选择图片"


        setupCollectionView()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let totalHorizontalInset: CGFloat = 40
        let availableWidth = view.bounds.width - totalHorizontalInset - spacing * 2
        let itemWidth = floor(availableWidth / 3.0)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 20, bottom: spacing, right: 20)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ImagePickerCell.self, forCellWithReuseIdentifier: ImagePickerCell.reuseId)
        collectionView.register(AddImageCell.self, forCellWithReuseIdentifier: AddImageCell.reuseId)

        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        // 长按拖拽
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        collectionView.addGestureRecognizer(longPress)
    }

    private var displayedItemCount: Int {
        return images.count < maxImages ? images.count + 1 : images.count
    }

    private func addImageAction() {
        pickerManager = ImagePickerManager(presentingVC: self, maxSelection: maxImages - images.count)
        pickerManager.presentPicker { [weak self] pickedImages in
            guard let self = self else { return }
            let space = self.maxImages - self.images.count
            let toAppend = Array(pickedImages.prefix(space))
            self.images.append(contentsOf: toAppend)
            self.collectionView.reloadData()
        }
    }

    private func removeImage(at index: Int) {
        guard index >= 0 && index < images.count else { return }
        images.remove(at: index)
        collectionView.reloadData()
        
    }
}

// MARK: - DataSource & Delegate
//@available(iOS 13.0, *)
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedItemCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if images.count < maxImages && indexPath.item == images.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddImageCell.reuseId, for: indexPath) as! AddImageCell
            cell.addAction = { [weak self] in
                self?.addImageAction()
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagePickerCell.reuseId, for: indexPath) as! ImagePickerCell
            cell.imageView.image = images[indexPath.item]
            cell.deleteAction = { [weak self, weak cell] in
                guard let self = self, let cell = cell,
                      let indexPath = self.collectionView.indexPath(for: cell)
                else { return }
                self.removeImage(at: indexPath.item)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return indexPath.item < images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath,
                        toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        let maxTarget = max(0, images.count - 1)
        var proposed = proposedIndexPath
        if images.count < maxImages {
            if proposed.item >= images.count {
                proposed = IndexPath(item: maxTarget, section: proposed.section)
            }
        } else {
            if proposed.item > maxTarget {
                proposed = IndexPath(item: maxTarget, section: proposed.section)
            }
        }
        return proposed
    }

   
                       
    func collectionView(_ collectionView: UICollectionView,
                        moveItemAt sourceIndexPath: IndexPath,
                        to destinationIndexPath: IndexPath) {
        guard sourceIndexPath.item < images.count, destinationIndexPath.item < images.count else {
            collectionView.reloadData()
            return
        }
        destinationIndexPath.row
        let moved = images.remove(at: sourceIndexPath.item)
        images.insert(moved, at: destinationIndexPath.item)
    }
}

// MARK: - Long press interactive movement
//@available(iOS 13.0, *)
extension ViewController {

    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        switch gesture.state {
        case .began:
            guard let indexPath = collectionView.indexPathForItem(at: location),
                  indexPath.item < images.count
            else { return }
            let cell = collectionView.cellForItem(at: indexPath)
            animateCellScaling(cell: cell, scale: 1.1, shadow: true)
            collectionView.beginInteractiveMovementForItem(at: indexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(location)
        case .ended:
            collectionView.endInteractiveMovement()
            resetAllCellAnimations()
        default:
            collectionView.cancelInteractiveMovement()
            resetAllCellAnimations()
        }
    }

    private func animateCellScaling(cell: UICollectionViewCell?, scale: CGFloat, shadow: Bool) {
        guard let cell = cell else { return }
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
            if shadow {
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.layer.shadowOpacity = 0.3
                cell.layer.shadowRadius = 8
                cell.layer.shadowOffset = CGSize(width: 0, height: 4)
            }
        }
    }

    private func resetAllCellAnimations() {
        for cell in collectionView.visibleCells {
            UIView.animate(withDuration: 0.2) {
                cell.transform = .identity
                cell.layer.shadowOpacity = 0
            }
        }
    }
}
