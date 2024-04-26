
import Foundation
import UIKit

class T1: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var dataTableView: UITableView!
    
    var heightRow = [[String: Int]]()
    
    var containerYPos = 0
    var mealPlanObj = [String:String]()
    var titleArray = ["Kahvaltı", "Atıştırmalık", "Öğlen", "Atıştırmalık", "Akşam", "Toplam"]
    var subTitleArray = [String]()
    var titleHeader = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationHeader()

        dataTableView.separatorStyle = .none
        
        subTitleArray = [mealPlanObj["Kahvaltı"]!, mealPlanObj["Atıştırmalık"]!, mealPlanObj["Öğlen"]!, mealPlanObj["Atıştırmalık"]!, mealPlanObj["Akşam"]!, mealPlanObj["Toplam"]!]
        
        for i in 0...titleArray.count - 1 {
            setHeightForCell(textTitle: titleArray[i], textSubTitle: subTitleArray[i])
        }
        
        if #available(iOS 15.0, *) {
            dataTableView.sectionHeaderTopPadding = 0
        }
        
        dataTableView.register(T1CellClass.self, forCellReuseIdentifier: "TTT")
        dataTableView.frame = CGRect(x: 0, y: containerYPos, width: Int(DeviceUtils.DEVICE_WIDTH), height: Int(DeviceUtils.DEVICE_HEIGHT) - containerYPos)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dataTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    func setNavigationHeader(){
        let navigationView = getHeaderView(headerTitle: titleHeader)
        self.view.addSubview(navigationView.headerView)
        containerYPos = Int(navigationView.headerView.bounds.height)
        
        let btnBack = UIButton()
        btnBack.frame = CGRect(x: DeviceUtils.MARGIN, y: Int(navigationView.headerView.bounds.height) - navigationView.itemSize - DeviceUtils.MARGIN, width: navigationView.itemSize, height: navigationView.itemSize)
        btnBack.backgroundColor = .clear
        btnBack.setImage(UIImage(named: "Back"), for: .normal)
        btnBack.tag = 101
        btnBack.addTarget(self, action: #selector(onNavigationClick(_:)), for: .touchUpInside)
        
        let btnRight = UIButton()
        btnRight.frame = CGRect(x: Int(DeviceUtils.DEVICE_WIDTH) - navigationView.itemSize - DeviceUtils.MARGIN, y: Int(navigationView.headerView.bounds.height) - navigationView.itemSize - DeviceUtils.MARGIN, width: navigationView.itemSize, height: navigationView.itemSize)
        btnRight.backgroundColor = .white
        btnRight.tag = 102
        btnRight.addTarget(self, action: #selector(onNavigationClick(_:)), for: .touchUpInside)
        
        navigationView.headerView.addSubview(btnBack)
        navigationView.headerView.addSubview(btnRight)
        
        btnRight.isHidden = true
    }
    
    @objc func onNavigationClick(_ sender: UIButton?) {
        switch sender?.tag {
        case 101:
            self.navigationController?.popViewController(animated: true)
            break
            
        case 102:
            break
            
        default:
            break
        }
    }
    
    func setHeightForCell(textTitle:String, textSubTitle:String) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Int(DeviceUtils.DEVICE_WIDTH) - (2 * DeviceUtils.MARGIN), height: 9999))
        titleLabel.numberOfLines = 0
        titleLabel.font = NAVIGATION_FONT
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.text = textTitle
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.sizeToFit()
        titleLabel.layoutIfNeeded()
        let titleLabelHeight = Int(titleLabel.frame.height) + DeviceUtils.MARGIN/2
        
        let subTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Int(DeviceUtils.DEVICE_WIDTH) - (2 * DeviceUtils.MARGIN), height: 9999))
        subTitleLabel.numberOfLines = 0
        subTitleLabel.font = TEXT_FONT
        subTitleLabel.lineBreakMode = .byWordWrapping
        subTitleLabel.text = textSubTitle
        subTitleLabel.adjustsFontSizeToFitWidth = false
        subTitleLabel.sizeToFit()
        subTitleLabel.layoutIfNeeded()
        let subTitleLabelHeight = Int(subTitleLabel.frame.height) + DeviceUtils.MARGIN/2
        
        let rowHeightObj = ["TITLE": titleLabelHeight, "SUBTITLE": subTitleLabelHeight]
        heightRow.append(rowHeightObj)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let rowObj = heightRow[indexPath.row]
        return CGFloat(rowObj["TITLE"]! + rowObj["SUBTITLE"]! + (3 * DeviceUtils.MARGIN))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: T1CellClass = (tableView.dequeueReusableCell(withIdentifier: "TTT")) as! T1CellClass
        cell.frame = CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: Int(cell.bounds.height))
        
        let rowObj = heightRow[indexPath.row]
        cell.prepareSubViews(sizeTitle: rowObj["TITLE"]!, sizeSubTitle: rowObj["SUBTITLE"]!)
        cell.selectionStyle = .none
        
        cell.titleView.text = titleArray[indexPath.row]
        cell.titleView.numberOfLines = 0
        cell.subTitleView.text = subTitleArray[indexPath.row]
        cell.subTitleView.numberOfLines = 0
        
        let categoryImage = UIImage(named: titleArray[indexPath.row])
        let tintedImage = categoryImage?.withRenderingMode(.alwaysTemplate)
        cell.iconView.image = tintedImage
        cell.iconView.tintColor = PRIMARY_COLOR
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

var CELL_HEIGHT = 0

class T1CellClass : UITableViewCell {
    
    var titleView = UILabel()
    var subTitleView = UILabel()
    var iconView = UIImageView()
    
    init() {
        super.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "TTT")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func prepareSubViews(sizeTitle: Int, sizeSubTitle: Int) {
        let iconSize = sizeTitle
        
        iconView.frame = CGRect(x: DeviceUtils.MARGIN, y: DeviceUtils.MARGIN/2, width: iconSize, height: iconSize)
        
        let titleViewBG = UILabel()
        titleViewBG.frame = CGRect(x: 0, y: 0, width: Int(DeviceUtils.DEVICE_WIDTH)  - (0 * DeviceUtils.MARGIN), height: sizeTitle + DeviceUtils.MARGIN)
        titleViewBG.textAlignment = .left
        titleViewBG.font = NAVIGATION_FONT
        titleViewBG.textColor = .white
        titleViewBG.backgroundColor = .systemGray6
        titleViewBG.alpha = 1.0
        titleViewBG.numberOfLines = 0
        addSubview(titleViewBG)
        addSubview(iconView)

        //titleView.frame = CGRect(x: 120, y: DeviceUtils.MARGIN, width: Int(DeviceUtils.DEVICE_WIDTH)  - 100 - (3 * DeviceUtils.MARGIN), height: sizeTitle)
        titleView.frame = CGRect(x: (2 * DeviceUtils.MARGIN) + iconSize, y: DeviceUtils.MARGIN/2, width: Int(DeviceUtils.DEVICE_WIDTH) - iconSize - (2 * DeviceUtils.MARGIN), height: sizeTitle)
        titleView.textAlignment = .left
        titleView.font = NAVIGATION_FONT
        titleView.textColor = .white
        titleView.backgroundColor = .clear //PRIMARY_COLOR
        titleView.numberOfLines = 0
        titleView.textColor = PRIMARY_COLOR
        addSubview(titleView)

        //subTitleView.frame = CGRect(x: 120, y: DeviceUtils.MARGIN + sizeTitle + DeviceUtils.MARGIN, width: Int(DeviceUtils.DEVICE_WIDTH)  - 100 - (3 * DeviceUtils.MARGIN), height: sizeSubTitle)
        subTitleView.frame = CGRect(x: DeviceUtils.MARGIN, y: DeviceUtils.MARGIN + sizeTitle + DeviceUtils.MARGIN, width: Int(DeviceUtils.DEVICE_WIDTH)  - (2 * DeviceUtils.MARGIN), height: sizeSubTitle)
        subTitleView.textAlignment = .left
        subTitleView.font = TEXT_FONT
        subTitleView.textColor = .darkGray
        subTitleView.backgroundColor = .clear //DEFAULT_COLOR
        subTitleView.numberOfLines = 0
        addSubview(subTitleView)
    }
}
