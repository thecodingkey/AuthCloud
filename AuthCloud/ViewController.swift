//
//  ViewController.swift
//  AuthCloud
//
//  Created by Rosendo Vazquez on 01/11/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class ViewController: UIViewController {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfPassword.isSecureTextEntry = true
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
    
    
    func loginWGoogle(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self){
            user, error in
            
            guard let authentication = user?.authentication,
                  let token = authentication.idToken else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: token, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential){ [weak self] authResult, error in
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
    
    
    @IBAction func signInWithGoogle(_ sender: Any) {
        loginWGoogle()
    }
    
    
    
}

