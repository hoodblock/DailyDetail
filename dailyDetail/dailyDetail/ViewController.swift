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


import UIKit
import SnapKit

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let slider = UISlider()
    private let valueLabel = UILabel()
    
    private let values: [Float] = [1, 2, 3, 4, 5] // 固定点数（秒数）
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        // 设置 UISlider
        slider.minimumValue = values.first!
        slider.maximumValue = values.last!
        slider.value = values.first!
        slider.isContinuous = true
        slider.tintColor = .blue
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        // 添加松手事件，触发吸附操作
        slider.addTarget(self, action: #selector(sliderTouchUp), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderTouchUp), for: .touchUpOutside)
        
        view.addSubview(slider)
        
        // 设置标签，显示当前值
        valueLabel.text = "\(Int(slider.value))s"
        valueLabel.font = .systemFont(ofSize: 14, weight: .bold)
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center
        valueLabel.layer.backgroundColor = UIColor.blue.cgColor
        valueLabel.layer.cornerRadius = 12
        valueLabel.clipsToBounds = true
        
        view.addSubview(valueLabel)
        
        // 使用 SnapKit 布局
        slider.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)
            make.left.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(slider)
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
        // 显示固定秒数选择的按钮
        let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.spacing = 10
        buttonStack.distribution = .fillEqually
        view.addSubview(buttonStack)
        
        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(slider.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }
        
        // 创建可点击的固定秒数按钮
        for value in values {
            let button = UIButton(type: .system)
            button.setTitle("\(Int(value))s", for: .normal)
            button.tag = Int(value)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            buttonStack.addArrangedSubview(button)
        }
    }
    
    @objc private func sliderValueChanged() {
        // 在滑动时更新标签文本，但不进行吸附
        valueLabel.text = "\(Int(slider.value))s"
        
        // 计算标签的位置
        updateLabelPosition()
    }
    
    @objc private func sliderTouchUp() {
        // 松手时进行吸附，找到最接近的秒数
        let closestValue = values.min(by: { abs($0 - slider.value) < abs($1 - slider.value) }) ?? 1
        slider.setValue(closestValue, animated: true)
        valueLabel.text = "\(Int(closestValue))s"
        
        // 更新标签位置
        updateLabelPosition()
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        // 获取点击的秒数值
        let selectedValue = Float(sender.tag)
        
        // 更新 slider 和标签显示
        slider.setValue(selectedValue, animated: true)
        valueLabel.text = "\(Int(selectedValue))s"
        
        // 更新标签位置
        updateLabelPosition()
    }
    
    private func updateLabelPosition() {
        // 计算标签位置
        let sliderWidth = slider.bounds.width
        let minValue = slider.minimumValue
        let maxValue = slider.maximumValue
        let normalizedValue = (slider.value - minValue) / (maxValue - minValue)
        let offset = normalizedValue * (Float(sliderWidth) - 40)
        
        // 更新标签位置
        valueLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(slider).offset(offset)
        }
    }
}

