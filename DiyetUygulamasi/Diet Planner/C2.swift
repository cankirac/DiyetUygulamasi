
import Foundation
import UIKit

class C2: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var dataCollectionView: UICollectionView!
    var containerYPos = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationHeader()
        
        dataCollectionView.register(C2CellClass.self, forCellWithReuseIdentifier: "CCC")
        dataCollectionView.frame = CGRect(x: 0, y: containerYPos, width: Int(DeviceUtils.DEVICE_WIDTH), height:Int(DeviceUtils.DEVICE_HEIGHT) - containerYPos)
        dataCollectionView.backgroundColor = .clear
        dataCollectionView.tag = 1001
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: CGFloat(DeviceUtils.MARGIN), left: CGFloat(DeviceUtils.MARGIN), bottom: CGFloat(DeviceUtils.MARGIN), right: CGFloat(DeviceUtils.MARGIN))
        //layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: CELL_ITEM_WIDTH, height: CELL_ITEM_HEIGHT)
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
        let navigationView = getHeaderView(headerTitle: "Healthy Diet Plans")
        self.view.addSubview(navigationView.headerView)
        containerYPos = Int(navigationView.headerView.bounds.height)
        
        let btnBack = UIButton()
        btnBack.frame = CGRect(x: DeviceUtils.MARGIN, y: Int(navigationView.headerView.bounds.height) - navigationView.itemSize - DeviceUtils.MARGIN, width: navigationView.itemSize, height: navigationView.itemSize)
        btnBack.backgroundColor = .white
        btnBack.tag = 101
        btnBack.addTarget(self, action: #selector(onNavigationClick(_:)), for: .touchUpInside)
        
        let btnRight = UIButton()
        btnRight.frame = CGRect(x: Int(DeviceUtils.DEVICE_WIDTH) - navigationView.itemSize - DeviceUtils.MARGIN, y: Int(navigationView.headerView.bounds.height) - navigationView.itemSize - DeviceUtils.MARGIN, width: navigationView.itemSize, height: navigationView.itemSize)
        btnRight.backgroundColor = .white
        btnRight.tag = 102
        btnRight.addTarget(self, action: #selector(onNavigationClick(_:)), for: .touchUpInside)
        
        navigationView.headerView.addSubview(btnBack)
        navigationView.headerView.addSubview(btnRight)
        
        btnBack.isHidden = true
        btnRight.isHidden = true
    }
    
    @objc func onNavigationClick(_ sender: UIButton?) {
        switch sender?.tag {
        case 101:
            break
            
        case 102:
            break
            
        default:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:C2CellClass = collectionView.dequeueReusableCell(withReuseIdentifier: "CCC", for: indexPath as IndexPath) as! C2CellClass
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        cell.prepareSubViews()
        cell.titleView.text = planCategories[indexPath.item]
        cell.iconView.image = UIImage(named: "\(planCategories[indexPath.item]).jpg")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "T2") as! T2
        vc.planIndex = indexPath.item
        self.navigationController?.pushViewController(vc, animated: true)
        //print(indexPath.item)
    }
}

let CELL_ITEM_WIDTH = Int(DeviceUtils.DEVICE_WIDTH) - (DeviceUtils.MARGIN * 2)
let CELL_ITEM_HEIGHT = Int(DeviceUtils.DEVICE_HEIGHT * 1/4)

class C2CellClass : UICollectionViewCell {
    var thumbView = UIView()
    var titleView = UILabel()
    var iconView = UIImageView()
    var subTitleView = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubViews()
    }

    func prepareSubViews() {
        let thumbSizeW = CELL_ITEM_WIDTH
        let thumbSizeH = CELL_ITEM_HEIGHT
        
        let iconSizeW = thumbSizeW - (0 * DeviceUtils.MARGIN)
        let iconSizeH = thumbSizeH - (0 * DeviceUtils.MARGIN)
        
        let titleHeight = (3 * DeviceUtils.MARGIN)
        let subTitleHeight = (5 * DeviceUtils.MARGIN)
        
        thumbView.frame = CGRect(x: 0, y:  0, width: thumbSizeW, height: thumbSizeH)
        thumbView.backgroundColor = .white
        thumbView.layer.borderWidth = 2.0
        thumbView.layer.borderColor = DEFAULT_COLOR.cgColor
        
        iconView.frame = CGRect(x: (0 * DeviceUtils.MARGIN), y: (0 * DeviceUtils.MARGIN), width: iconSizeW, height: iconSizeH)
        iconView.backgroundColor = .orange
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        
        titleView.frame = CGRect(x: (1 * DeviceUtils.MARGIN), y: iconSizeH - (4 * DeviceUtils.MARGIN), width: iconSizeW - (2 * DeviceUtils.MARGIN), height: titleHeight)
        titleView.textAlignment = .left
        titleView.font = NAVIGATION_FONT
        titleView.textColor = .white
        titleView.backgroundColor = .clear
        titleView.text = ""
        
        subTitleView.frame = CGRect(x: 0, y: iconSizeH - (5 * DeviceUtils.MARGIN), width: iconSizeW, height: subTitleHeight)
        subTitleView.textAlignment = .left
        subTitleView.numberOfLines = 0
        subTitleView.font = TEXT_FONT_SMALL
        subTitleView.textColor = .white
        subTitleView.backgroundColor = .darkGray
        subTitleView.alpha = 0.7
        subTitleView.text = ""
        
        addSubview(thumbView)
        addSubview(iconView)
        addSubview(subTitleView)
        addSubview(titleView)

    }
}
