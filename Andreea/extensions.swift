import Foundation
import UIKit

extension UIView{
    
    // to make a shdow.
    @IBInspectable var shadowColor: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }

    @IBInspectable var shadowOpacity: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
            
        }
    }
    @IBInspectable var shadowRadius: CGFloat{
           set {
               layer.shadowRadius = newValue
           }
           get{
            return self.layer.shadowRadius
               
           }
       }
}
extension UIViewController{
    // to present an aleart view on the screen with some text.
    func showaleart(msg:String,title:String){
        let aleartview = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default) { (_) in
            
        }
        aleartview.addAction(action)
        self.present(aleartview, animated: true) {
            
        }
    }
}
