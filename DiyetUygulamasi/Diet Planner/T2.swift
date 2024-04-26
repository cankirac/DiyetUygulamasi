
import Foundation
import UIKit

class T2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var dataTableView: UITableView!
    
    var containerYPos = 0
    var planIndex = 0
    var subCategoryTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationHeader()

        switch planIndex {
        case 0:
            subCategoryTitles = kiloVerme
            break
        
        case 1:
            subCategoryTitles = kanBasinci
            break
        
        case 2:
            subCategoryTitles = gluttensiz
            break
        
        case 3:
            subCategoryTitles = sutsuz
            break
       
        case 4:
            subCategoryTitles = sekersiz
            break
        
        case 5:
            subCategoryTitles = temizBeslenme
            break
        
        case 6:
            subCategoryTitles = vejetaryen
            break
        
        case 7:
            subCategoryTitles = digerleri
            break
        
        default:
            subCategoryTitles = [""]
            break
        }
        
        if #available(iOS 15.0, *) {
            dataTableView.sectionHeaderTopPadding = 0
        }
        
        //print(subCategoryTitles)
        dataTableView.register(T2CellClass.self, forCellReuseIdentifier: "TTT")
        dataTableView.frame = CGRect(x: 0, y: containerYPos, width: Int(DeviceUtils.DEVICE_WIDTH), height: Int(DeviceUtils.DEVICE_HEIGHT) - containerYPos)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        let navigationView = getHeaderView(headerTitle: planCategories[planIndex])
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightRow = 70 //CELL_HEIGHT
        return CGFloat(heightRow)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategoryTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: T2CellClass = (tableView.dequeueReusableCell(withIdentifier: "TTT")) as! T2CellClass
        //cell.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: CGFloat(CELL_HEIGHT))
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        cell.prepareSubViews()
        cell.selectionStyle = .none
        cell.titleView.text = subCategoryTitles[indexPath.row]
        cell.titleView.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "C1") as! C1
        vc.categoryIndex = planIndex
        vc.subCategoryIndex = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
        //print(indexPath.item)
    }
}

class T2CellClass : UITableViewCell {
    var titleView = UILabel()
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
    
    func prepareSubViews() {
        let titleHeight = 50
        let iconSize = 50
        
        iconView.frame = CGRect(x: (1 * DeviceUtils.MARGIN), y: (1 * DeviceUtils.MARGIN), width: iconSize, height: iconSize)
        iconView.backgroundColor = .clear
        iconView.image = UIImage(named: "Meal")
        addSubview(iconView)
        
        titleView.frame = CGRect(x: iconSize + (2 * DeviceUtils.MARGIN), y: DeviceUtils.MARGIN, width: Int(DeviceUtils.DEVICE_WIDTH) - iconSize - (3 * DeviceUtils.MARGIN), height: titleHeight)
        titleView.textAlignment = .left
        titleView.font = TEXT_FONT
        titleView.textColor = .darkText //PRIMARY_COLOR
        titleView.numberOfLines = 2
        titleView.backgroundColor = .clear //DEFAULT_COLOR
        addSubview(titleView)
        
    }
}
