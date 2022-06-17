import UIKit
import FirebaseDatabase
import FirebaseAuth
import CoreData
import Firebase
import GoogleSignIn

class ViewController: UIViewController {
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var emailtv: UITextField!
    @IBOutlet weak var passwordtv: UITextField!
    
    
 @IBOutlet weak var signInButton: GIDSignInButton!
    
    var thisuser:user?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
        
        let colorketframeAnimation = CAKeyframeAnimation(keyPath: "backgroundColor")
        colorketframeAnimation.values = [UIColor(hue: 0, saturation: 0.4, brightness: 0.8, alpha: 1.0).cgColor, UIColor(hue: 0, saturation: 0.07, brightness: 0.96, alpha: 1.0).cgColor,UIColor.darkGray.cgColor]
        colorketframeAnimation.keyTimes = [0,0.5,1.25]
        colorketframeAnimation.duration = 2.5
        colorketframeAnimation.autoreverses = true
        colorketframeAnimation.repeatCount = 1
        mainview.layer.add(colorketframeAnimation, forKey: nil)
    }

    @IBAction func login(_ sender: Any) {
        guard let email = self.emailtv.text else {
            self.showaleart(msg: "Please enter your Email.", title: "Missing Data.")
            return
        }
        guard let password = self.passwordtv.text else {
            self.showaleart(msg: "Please enter your Password.", title: "Missing Data.")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            // if there is any errors.
            if let err = error{
                self.showaleart(msg: err.localizedDescription, title: "Error.")
                return
            }
            //if loged in succesfully.
            let uid = result?.user.uid
            //store the id in userDefuals
            UserDefaults.standard.set(uid, forKey: "userid")
            var ref: DatabaseReference!
            ref = Database.database().reference()
            // we have to fetch the loged in user's data, and store it thisuser object.
            ref.child("users").child("\(uid ?? "Niledkey")").observe(.value) { (snapshot) in
                let dic = snapshot.value as? [String:AnyObject] ?? [:]
                self.thisuser = user.init(fromDictionary: dic)
                self.performSegue(withIdentifier: "gotomain", sender: nil)
            }
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotomain"{
            let vc = segue.destination as! mainViewController
            //to cahnge the maincontroller's name label.
            vc.username = self.thisuser?.name ?? "Nilname"
        }
    }
    
}
