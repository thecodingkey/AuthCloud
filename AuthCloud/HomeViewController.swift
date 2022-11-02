//
//  HomeViewController.swift
//  AuthCloud
//
//  Created by Rosendo Vazquez on 01/11/22.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true)
            
        } catch  {
            print("Falló al cerrar la sesión")
        }
    }
    
}
