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
    var fetchedImageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Solar AR"
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor(red: 211/255, green: 86/255, blue: 50/255, alpha: 1.0)
        fetchedImageArray = fetchImages()
    }
    
    func fetchImages() -> [String] {
      fetchedImageArray.removeAll()
      
      let request = AF.request("http://13.233.31.228/thumbnail/service.php")
      request.responseJSON { (data) in

          switch data.result {
          case .success(let value):
              if let jsonResponce = value as? [String: Any] {
                  let status = jsonResponce["success"] as? Int
                  
                  if status == 1 {
                      let titleArray = jsonResponce["name"] as? NSArray
                  
                        for i in 0..<titleArray!.count {
                            let eachTitleDic = titleArray![i] as! NSDictionary
                            let eachTitle = eachTitleDic["title"] as! String
                            self.fetchedImageArray.append(eachTitle)
                        }
                      self.setupTableView()
                  }
              }
          case .failure(let error):
              print(error)
          }
      }
        return fetchedImageArray
    }

    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.customTableViewCell.delegate = self
        self.tableView.reloadData()
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    //Delegate method
    func passTheCurrent(tableIndex: Int, collectionViewIndex: Int) {
        print("collectionViewIndex \(collectionViewIndex)")
        let objSceneViewCtrl = ObjectSceneViewCtrl()
        self.navigationController?.pushViewController(objSceneViewCtrl, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = 3
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        customTableViewCell.delegate = self
        customTableViewCell.collectionView.tag = indexPath.item

        if indexPath.row == 0 {
            customTableViewCell.imagesArray = fetchedImageArray
        }
        return customTableViewCell
    }

}
