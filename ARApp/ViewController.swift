//
//  ViewController.swift
//  ARApp
//
//  Created by FPrimeC on 2021-10-22.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,CustomTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var customTableViewCell = CustomTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Solar AR"
        customTableViewCell.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
//        fetchImages()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 211/255, green: 86/255, blue: 50/255, alpha: 1.0)
    }
    
    func fetchImages() {
      let request = AF.request("http://13.233.31.228/thumbnail/service.php")
      request.responseJSON { (data) in
        print(data)
      }
    }

    //Delegate method
    func passTheCurrent(tableIndex: Int, collectionViewIndex: Int) {
        print("collectionViewIndex \(collectionViewIndex)")
        let objSceneViewCtrl = ObjectSceneViewCtrl()
        self.navigationController?.pushViewController(objSceneViewCtrl, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = 1
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var rowHeight : CGFloat = 0
        switch indexPath.section {
        case 0:
            rowHeight = 110
        case 1:
            rowHeight = 220
        case 2:
            rowHeight = 330
        default:
            break
        }
        return rowHeight
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        customTableViewCell.delegate = self
        customTableViewCell.collectionView.tag = indexPath.section
        return customTableViewCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        let sectionName: String
        switch section {
            case 0:
                sectionName = NSLocalizedString("Section 1", comment: "Section 1")
            case 1:
                sectionName = NSLocalizedString("Section 2", comment: "Section 2")
            case 2:
                sectionName = NSLocalizedString("Section 3", comment: "Section 3")

            default:
                sectionName = ""
        }
        return sectionName
    }

}
