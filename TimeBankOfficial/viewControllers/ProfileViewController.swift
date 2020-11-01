import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import Foundation

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var timeOwned: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        let docRef = db.collection("userInfo").document(user!.uid)
        docRef.getDocument { QuerySnapshot, Error in
            guard let snapshot = QuerySnapshot else {
                print("Error retreiving snapshots \(Error!)")
                return
            }
            let uName = snapshot["name"] as? String ?? ""
            self.name.text = uName
            let uEmail = snapshot["email"] as? String ?? ""
            self.email.text = uEmail
            let uGender = snapshot["gender"] as? String ?? ""
            if (uGender == "male") {
                self.profileImage.image = UIImage(named: "male")
            }
            else if (uGender == "female") {
                self.profileImage.image = UIImage(named: "female")
            }
            else{
                self.profileImage.image = UIImage(named: "myApp")
            }
            let uTimeOwned = snapshot["timeOwned"] as? Int
            self.timeOwned.text = ("Time Owned:  \(String(describing: uTimeOwned))")
        }
    } // end of viewDidLoad
    
    
    @IBAction func signOutPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        performSegue(withIdentifier: "logout", sender: self)
    }
}
