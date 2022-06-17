import UIKit

class mainViewController: UIViewController {
    
    var username:String?
    
    @IBOutlet weak var welcomeuserlbl: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = self.username{
            self.welcomeuserlbl.text = "Welcome \(name)"
        }
        
    }
   override func viewWillAppear(_ animated: Bool) {
    
          self.navigationController?.setNavigationBarHidden(true, animated: true)
      }
  
    @IBAction func segmentchanged(_ sender: UISegmentedControl) {
        // when the user slids betwean the segment indexes.
        if sender.selectedSegmentIndex == 0{
            
        }else if sender.selectedSegmentIndex == 1{
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "PickanImageViewController") as! PickanImageViewController
            //return to the first index, to the main viewcontroller
            segment.selectedSegmentIndex = 0
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    

}
