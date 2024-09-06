//
//  StatementScreenViewController.swift
//  Cora
//
//  Created by Fabricio Pujol on 06/09/24.
//

import UIKit

class StatementScreenViewController: UIViewController {
    
    let userDefaultsManager = UserDefaultsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .coraPink
        // Do any additional setup after loading the view.
        
        print(userDefaultsManager.getCPF())
        print(userDefaultsManager.getPassword())
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
