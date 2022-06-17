import UIKit
import FirebaseAuth
import FirebaseDatabase

class signupViewController: UIViewController {
    @IBOutlet weak var emailtv: UITextField!
    @IBOutlet weak var passwordtv: UITextField!
    
    @IBOutlet weak var nametv: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // here we creat the animation object.
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        //the color which will be repleaced for one second
        animation.fromValue = UIColor.white.cgColor
        //the color which will the screen display for one second:
        animation.toValue = UIColor(hue: 0, saturation: 0.4, brightness: 0.8, alpha: 1.0).cgColor
        //the animation duration
        animation.duration = 5
        //delay the animation for 0.3 second
        animation.beginTime = CACurrentMediaTime() + 0.5
        animation.autoreverses = true
        view.layer.add(animation, forKey: "backgroundColor")

        
    }
    @IBAction func signup(_ sender: Any) {
        guard let email = self.emailtv.text else {
            //show msg if the user didn't enter his email.
            self.showaleart(msg: "Enter email address", title: "Missing data.")
            return
        }
        guard let password = self.passwordtv.text else {
                    //show msg if the user didn't enter his password.
                   self.showaleart(msg: "Enter your Password", title: "Missing data.")
                   return
               }
        guard let name = self.nametv.text else {
            //show msg if the user didn't enter his name.
                   self.showaleart(msg: "Enter Your name", title: "Missing data.")
                   return
               }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            //if there is any error:
            if let err = error{
                self.showaleart(msg: err.localizedDescription, title: "Error.")
                return
            }
            // if there are no errors:
            //geting the created user id:
            let uid = result?.user.uid
            //store the new use in firebase data base.
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            //the user's info to store in the firebasedatabase.
            let dic = [
                "Email":email,
                "name":name,
                "id":(uid ?? "NiledID")
            ]
            //storing the data in firebase.
            ref.child("users").child("\(uid ?? "NiledID")").setValue(dic)
            self.performSegue(withIdentifier: "gotosignin", sender: nil)
        }
    }
    


}
