//
//  ViewController.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import UIKit
import SnapKit
import RxSwift

private let currentSelectedLanguageKey = "CurrentSelectedLanguage"

/// App 自定义语言
public enum CurrentLanguageType: String, CaseIterable {
    /// 英语
    case english = "en-US"
    /// 印尼语
    case indonesian = "id-ID"
    /// 中文
    case chinese = "zh-CN"
//    /// 法语
//    case french = "fr-FR"
//    /// 日语
//    case japanese = "ja-JP"
//    /// 泰语
//    case thai = "th-TH"
//    /// 阿拉伯语
//    case arabic = "ar"
}

extension CurrentLanguageType {

    /// 系统语言代码（对应 Locale 标识符）
    public var systemLanguageCode: String {
        switch self {
        case .english: return "en-US"
        case .indonesian: return "id-ID"
        case .chinese: return "zh-Hans-CN"
//        case .french: return "fr-FR"
//        case .japanese: return "ja-JP"
//        case .thai: return "th-TH"
//        case .arabic: return "ar-SA"
        }
    }

    /// 官方语言名（语言自身环境下的名称）
    public var systemLanguageName: String {
        let locale = Locale(identifier: self.systemLanguageCode)
        return locale.localizedString(forLanguageCode: self.systemLanguageCode) ?? self.rawValue
    }

    /// 当前 App 语言下的翻译名
    public var systemLanguageTranslateName: String {
        let current = Locale(identifier: currentAppLanguage.systemLanguageCode)
        return current.localizedString(forLanguageCode: self.systemLanguageCode) ?? self.rawValue
    }

}

/// 检测系统语言属于哪种
private func detectLanguageType(from lang: String) -> CurrentLanguageType {
    switch lang {
    case let s where s.hasPrefix("id"):
        return .indonesian
    case let s where s.hasPrefix("zh"):
        return .chinese
//    case let s where s.hasPrefix("fr"):
//        return .french
//    case let s where s.hasPrefix("ja"):
//        return .japanese
//    case let s where s.hasPrefix("th"):
//        return .thai
//    case let s where s.hasPrefix("ar"):
//        return .arabic
    default:
        return .english
    }
}

/// 当前 App 语言（优先取用户选择）

public var currentAppLanguage: CurrentLanguageType {
       get {
           if let langString = UserDefaults.standard.string(forKey: currentSelectedLanguageKey),
              let lang = CurrentLanguageType(rawValue: langString) {
               return lang
           }
           let preferred = Locale.preferredLanguages.first ?? "en"
           return detectLanguageType(from: preferred)
       }
       set {
           UserDefaults.standard.set(newValue.rawValue, forKey: currentSelectedLanguageKey)
           UserDefaults.standard.synchronize()
       }
   }


//"account_terms_refund_policy" = "退款条款";
//"account_terms_terms_service" = "服务条款";
//"account_terms_content_review" = "内容审核条款";
//"account_terms_privacy_policy" = "隐私政策";

enum AccountTermsItemType: CaseIterable {
    
    /// 退款条款
    case refundPolicy
    /// 服务条款
    case termsService
    /// 内容审核条款
    case contentReviewPolicy
    /// 隐私政策
    case privacyPolicy
}

extension AccountTermsItemType {
    
    public var title: String {
        switch self {
        case .refundPolicy:
            return "account_terms_refund_policy"
        case .termsService:
            return "account_terms_terms_service"
        case .contentReviewPolicy:
            return "account_terms_content_review"
        case .privacyPolicy:
            return "account_terms_privacy_policy"
        }
    }
    
    public var imageName: String {
        switch self {
        case .refundPolicy:
            break
        case .termsService:
            break
        case .contentReviewPolicy:
            break
        case .privacyPolicy:
            break
        }
        return ""
    }
    
    public var webUrl: String {
        switch self {
        case .refundPolicy:
            return "https://www.vinabot.ai/return_policy.html"
        case .termsService:
            return "https://www.vinabot.ai/TermsOfService.html"
        case .contentReviewPolicy:
            return "https://www.vinabot.ai/ContentModerationPolicy.html"
        case .privacyPolicy:
            return "https://fresource.laihua.com/2025-7-28/06466a9a-b607-4e98-8a8f-56e6d4246b91.html"
        }
    }
}

// MARK: - 用户信息管理类
class AccountInfoViewModel {

    
    // MARK: - 隐私条款
    private(set) var termsList = AccountTermsItemType.allCases
}


class AccountDefaultCell: UITableViewCell {
    
    private var titleLabelLeftConstraint: Constraint?
    
    private lazy var mainView: UIView = {
        
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var headImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Fire"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//        label.textColor = UIColor.hexColor("#333333")
        label.textColor = .red
        return label
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    public func bind(imageName: String, title: String) {
        headImageView.image = UIImage(named: "")
        if !imageName.isEmpty {
            titleLabelLeftConstraint?.update(offset: (16 + 20 + 16))
        } else {
            titleLabelLeftConstraint?.update(offset: (16))
        }
        nameLabel.text = title
    }

}

// MARK: - configure UI
extension AccountDefaultCell {
    
    private func configureUI() {
        
        self.backgroundColor = .clear
        
        contentView.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.bottom.equalToSuperview()
        }
        headImageView.backgroundColor = .blue
        mainView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        mainView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            titleLabelLeftConstraint = make.left.equalTo(16).constraint
        }
    }
}



class AccountLanguageCell: UITableViewCell {
        
    private lazy var mainView: UIView = {
        
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var selectedImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Fire"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//        label.textColor = UIColor.hexColor("#333333")
        label.textColor = .red
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Fire"
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//        label.textColor = UIColor.hexColor("#333333")
        label.textColor = .red
        return label
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    public func bind(type: CurrentLanguageType) {
        titleLabel.text = type.systemLanguageName
        subTitleLabel.text = type.systemLanguageTranslateName
        selectedImageView.isHidden = type == currentAppLanguage ? false : true
    }

}

// MARK: - configure UI
extension AccountLanguageCell {
    
    private func configureUI() {
        
        self.backgroundColor = .clear
        
        contentView.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.bottom.equalToSuperview()
        }
        selectedImageView.backgroundColor = .blue
        mainView.addSubview(selectedImageView)
        selectedImageView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
        
        mainView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(mainView.snp.centerY).offset(-5)
            make.left.equalToSuperview().inset(16)
        }
        
        mainView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.centerY).offset(5)
            make.left.equalToSuperview().inset(16)
        }
    }
}



//// MARK: - 账号信息界面
//class ViewController: UIViewController {
//    
//    private let disposeBag = DisposeBag()
//    
//    private lazy var tableView: UITableView = {
//        
//        let tableView = UITableView(frame: .zero, style: .grouped)
////        tableView.backgroundColor = UIColor.hexColor("#F7F7F7")
//        tableView.backgroundColor = UIColor.gray
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.separatorStyle = .none
//        tableView.showsVerticalScrollIndicator = false
//        tableView.register(AccountDefaultCell.self, forCellReuseIdentifier: "AccountDefaultCell")
////        tableView.register(cellWithClass: AccountDefaultCell.self)
//        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.01))
//        return tableView
//    }()
//
//    
//    
//    // MARK: - 用户信息管理类
//    private lazy var viewModel = AccountInfoViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureUI()
//        
//        currentAppLanguage = .indonesian
//        for lang in CurrentLanguageType.allCases {
//            print("\(lang.systemLanguageName) — \(lang.systemLanguageTranslateName)")
//        }
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//    }
//}
//
//// MARK: - configure UI
//extension ViewController {
//    
//    private func configureUI() {
//        view.backgroundColor = .gray
//      
//        self.view.addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.top.equalTo(120)
//            make.left.right.equalToSuperview()
//            make.bottom.equalToSuperview()
//        }
//      
//    }
//}
//
//// MARK: - UITableViewDelegate, UITableViewDataSource
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 16))
//    }
//    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.01))
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 16
//    }
//    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.01
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 52
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return viewModel.termsList.count
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountDefaultCell", for: indexPath) as! AccountDefaultCell
//        cell.backgroundColor = .gray
//        cell.selectionStyle = .none
//        let type = viewModel.termsList[indexPath.section]
//        cell.bind(imageName: type.imageName, title: type.title)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
////        let webVC = LHWebViewController()
////        webVC.webUrl = viewModel.termsList[indexPath.section].webUrl
////        self.navigationController?.pushViewController(webVC)
//    }
//}
//
//extension ViewController {
//    
//    private func loginOut() {
//       
//    }
//}
//
//



// MARK: - 账号信息界面
class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.backgroundColor = UIColor.hexColor("#F7F7F7")
        tableView.backgroundColor = UIColor.gray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AccountLanguageCell.self, forCellReuseIdentifier: "AccountLanguageCell")
//        tableView.register(cellWithClass: AccountDefaultCell.self)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.01))
        return tableView
    }()

    
    
    // MARK: - 用户信息管理类
    private lazy var viewModel = CurrentLanguageType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - configure UI
extension ViewController {
    
    private func configureUI() {
        view.backgroundColor = .gray
      
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(120)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
      
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 16))
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.01))
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountLanguageCell", for: indexPath) as! AccountLanguageCell
        cell.backgroundColor = .gray
        cell.selectionStyle = .none
        cell.bind(type: viewModel[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        currentAppLanguage = viewModel[indexPath.section]
        tableView.reloadData()
    }
}

extension ViewController {
    
    private func loginOut() {
       
    }
}


