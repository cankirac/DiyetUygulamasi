
import Foundation
import UIKit

class C1: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var dataCollectionView: UICollectionView!
    
    var containerYPos = 0
    var categoryIndex = 0
    var subCategoryIndex = 0
    var mealTitle = ""
    var mealPlanRoutine = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealTitle = getJSONFileName(categoryIndex: categoryIndex, subCategoryIndex: subCategoryIndex)
        mealPlanRoutine = getJSONData(jsonFile: mealTitle)
        
        setNavigationHeader()
        
        dataCollectionView.register(C1CellClass.self, forCellWithReuseIdentifier: "CCC")
        dataCollectionView.frame = CGRect(x: 0, y: containerYPos, width: Int(DeviceUtils.DEVICE_WIDTH), height: Int(DeviceUtils.DEVICE_HEIGHT) - containerYPos)
        dataCollectionView.backgroundColor = .clear
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: CGFloat(DeviceUtils.MARGIN), left: CGFloat(DeviceUtils.MARGIN), bottom: CGFloat(DeviceUtils.MARGIN), right: CGFloat(DeviceUtils.MARGIN))
        layout.itemSize = CGSize(width: ITEM_SIZE, height: ITEM_SIZE)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = CGFloat(DeviceUtils.MARGIN)
        layout.minimumLineSpacing = CGFloat(DeviceUtils.MARGIN)
        dataCollectionView.collectionViewLayout = layout
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
        let navigationView = getHeaderView(headerTitle: mealTitle)
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
            //print("Left")
            self.navigationController?.popViewController(animated: true)
            break
            
        case 102:
            print("Right")
            break
            
        default:
            print("Hello")
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mealPlanRoutine.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:C1CellClass = collectionView.dequeueReusableCell(withReuseIdentifier: "CCC", for: indexPath as IndexPath) as! C1CellClass
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        cell.prepareSubViews()
        cell.titleView.text = "Day \(indexPath.item + 1)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "T1") as! T1
        vc.mealPlanObj = mealPlanRoutine[indexPath.item]
        vc.titleHeader = "Diet Schedule - Day \(indexPath.item + 1)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

let ITEM_SIZE = (Int(DeviceUtils.DEVICE_WIDTH) - (DeviceUtils.MARGIN * 4))/3

class C1CellClass : UICollectionViewCell {
    var thumbView = UIView()
    var titleView = UILabel()
    var iconView = UIImageView()
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubViews()
    }

    func prepareSubViews() {
        let thumbSize = ITEM_SIZE
        let iconSize = thumbSize - (6 * DeviceUtils.MARGIN)
        let titleHeight = thumbSize - iconSize - (2 * DeviceUtils.MARGIN)
        
        thumbView.frame = CGRect(x: 0, y:  0, width: thumbSize, height: thumbSize)
        thumbView.backgroundColor = .white
        thumbView.layer.borderWidth = 2.0
        thumbView.layer.borderColor = DEFAULT_COLOR.cgColor
        
        iconView.frame = CGRect(x: (3 * DeviceUtils.MARGIN), y: (1 * DeviceUtils.MARGIN), width: iconSize, height: iconSize)
        iconView.backgroundColor = .clear
        iconView.image = UIImage(named: "Meal")
        
        titleView.frame = CGRect(x: 0, y: (1 * DeviceUtils.MARGIN) + iconSize + (1 * DeviceUtils.MARGIN), width: thumbSize, height: titleHeight)
        titleView.textAlignment = .center
        titleView.font = TEXT_FONT
        titleView.textColor = .darkGray
        titleView.backgroundColor = .systemGray6 //PRIMARY_COLOR
        titleView.text = ""
        
        addSubview(thumbView)
        addSubview(iconView)
        addSubview(titleView)
    }
}
