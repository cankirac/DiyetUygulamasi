
import UIKit

class ViewController: UIViewController {
   
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
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

    @objc func timerAction() {
        timer.invalidate()
        showHome()
    }
    
    func showHome() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "C2") as! C2
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
