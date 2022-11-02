//
//  ViewController.swift
//  AuthCloud
//
//  Created by Rosendo Vazquez on 01/11/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func loginWithEmail(user:String, password:String) {
        
        Auth.auth().signIn(withEmail: user, password: password){[weak self] resultAuth, error in
            if error == nil{
                
                self?.tfPassword.text = ""
                self?.tfEmail.text = ""
                
                let vc = HomeViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            }else{
                print("::: Falló el inicio de sesión")
            }
        }
    }
    
    
    @IBAction func launchRegister(_ sender: Any) {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func loginEmail(_ sender: Any) {
        
        guard let user =  tfEmail.text,
              let password = tfPassword.text else { return }
        
        loginWithEmail(user: user, password: password)
        
    }
}

