//
//  ViewController.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import UIKit
import SnapKit

// MARK: - Section Header
class SectionHeaderView: UITableViewHeaderFooterView {
    static let reuseId = "SectionHeaderView"
    
    private let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGroupedBackground
        contentView.addSubview(titleLabel)
        
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}

// MARK: - 基础积分 Cell
class PointsHeaderCell: UITableViewCell {
    static let reuseId = "PointsHeaderCell"

    private let baseLabel = UILabel()
    private let baseValue = UILabel()
    private let dailyLabel = UILabel()
    private let dailyValue = UILabel()
    private let rechargeButton = UIButton(type: .system)

    private let card = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(card)
        card.backgroundColor = .white
        card.layer.cornerRadius = 12

        card.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
            make.height.equalTo(160)
        }

        baseLabel.text = "基础积分"
        baseValue.text = "1000"
        dailyLabel.text = "每日刷新积分"
        dailyValue.text = "300"

        [baseLabel, dailyLabel].forEach { $0.font = .systemFont(ofSize: 15) }
        [baseValue, dailyValue].forEach {
            $0.font = .systemFont(ofSize: 15, weight: .medium)
            $0.textAlignment = .right
        }

        rechargeButton.setTitle("充值", for: .normal)
        rechargeButton.setTitleColor(.white, for: .normal)
        rechargeButton.backgroundColor = .systemBlue
        rechargeButton.layer.cornerRadius = 10

        let row1 = row(baseLabel, baseValue)
        let row2 = row(dailyLabel, dailyValue)

        let stack = UIStackView(arrangedSubviews: [row1, row2, rechargeButton])
        stack.axis = .vertical
        stack.spacing = 16
        card.addSubview(stack)

        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        rechargeButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }

    private func row(_ left: UIView, _ right: UIView) -> UIView {
        let stack = UIStackView(arrangedSubviews: [left, right])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }
}
// MARK: - 积分明细 Cell
class PointRecordCell: UITableViewCell {
    static let reuseId = "PointRecordCell"
    
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let valueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(valueLabel)
        
        titleLabel.font = .systemFont(ofSize: 16)
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        valueLabel.font = .boldSystemFont(ofSize: 16)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(8)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
    }
    
    func configure(title: String, date: String, value: Int) {
        titleLabel.text = title
        dateLabel.text = date
        valueLabel.text = value > 0 ? "+\(value)" : "\(value)"
        valueLabel.textColor = value > 0 ? .systemGreen : .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewController
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private var records: [(title: String, date: String, value: Int)] = [
        ("每日签到", "2025-09-01", 10),
        ("分享任务", "2025-09-02", 20),
        ("兑换奖励", "2025-09-03", -50)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "积分明细"
        view.backgroundColor = .systemGroupedBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .zero
        tableView.register(PointsHeaderCell.self, forCellReuseIdentifier: PointsHeaderCell.reuseId)
        tableView.register(PointRecordCell.self, forCellReuseIdentifier: PointRecordCell.reuseId)
        tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseId)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: PointsHeaderCell.reuseId, for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PointRecordCell.reuseId, for: indexPath) as! PointRecordCell
            let record = records[indexPath.row]
            cell.configure(title: record.title, date: record.date, value: record.value)
            return cell
        }
    }
    
    // MARK: - Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseId) as? SectionHeaderView else {
            return nil
        }
        header.configure(title: section == 0 ? "基础积分" : "积分明细")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}
