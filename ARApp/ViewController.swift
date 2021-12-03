//
//  ViewController.swift
//  ARApp
//
//  Created by FPrimeC on 2021-10-22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,CustomTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var customTableViewCell = CustomTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customTableViewCell.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 211/255, green: 86/255, blue: 50/255, alpha: 1.0)
    }
    
    //Delegate method
    func passTheCurrent(tableIndex: Int, collectionViewIndex: Int) {
        print("collectionViewIndex \(collectionViewIndex)")
        let objSceneViewCtrl = ObjectSceneViewCtrl()
        self.navigationController?.pushViewController(objSceneViewCtrl, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        customCell.delegate = self
        return customCell
    }

}
