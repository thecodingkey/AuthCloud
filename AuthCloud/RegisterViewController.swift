//
//  RegisterViewController.swift
//  AuthCloud
//
//  Created by Rosendo Vazquez on 01/11/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var tfusername: UITextField!
    @IBOutlet weak var tfPassword01: UITextField!
    @IBOutlet weak var tfPassword02: UITextField!
    @IBOutlet weak var status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func register(_ sender: Any) {
        
        guard let username = tfusername.text,
                let password01 = tfPassword01.text,
                let password02 = tfPassword02.text
        else { return }
        
        
        if password01 == password02 {
            registerOnFirebase(user:username, pass: password01)
        }else{
            status.text = "Verifique sus datos por favor"
        }
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func registerOnFirebase(user:String, pass: String){
        print(user)
        print(pass)
        
        Auth.auth().createUser(withEmail: user, password: pass){ [weak self] resultFB, error in
            if error == nil {
                self?.status.text = "Registro exitoso"
                self?.tfusername.text = ""
                self?.tfPassword01.text = ""
                self?.tfPassword02.text = ""
            }else{
                self?.status.text = error?.localizedDescription
            }
        }
    }
    
    


}
