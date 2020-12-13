//
//  ViewController.swift
//  WeatherForecast
//
//  Created by MacBook Pro on 12/7/20.
//  Copyright © 2020 MailMedia. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    // IB Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placelb: UILabel!
    @IBOutlet weak var refreshSwitch: UISwitch!
    // ViewModel to call api and get data
    let vm =  MainViewModel()
    // table data source array for the tableView
    var tableSourceArr = [Main]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // set table delegate & dataSource to the vc then register the cell
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "MainTableCell", bundle: nil), forCellReuseIdentifier: "cell")
        // set current city to retieve it's data
        setCity()
 
    }
    // start getting data inside viewDidAppear so alert can be presented in case no internet
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // start getting the data from the Api
        startCall()
    }
    // set current city
    func setCity() {
        self.placelb.text = city
    }
    // call api to get data
    func startCall() {
        if refreshSwitch.isOn {
            // remote server call
            if noNetwork() {
                 self.showAlert("No internet connection")
            }
            else {
                self.getData()
            }
        }
        else {
            // local file call
            self.getData()
        }
    }
    // start getting the data
    func getData() {
        vm.getData(fromLocal:!refreshSwitch.isOn) { res in
            if let res = res {
                self.tableSourceArr = res
                self.tableView.reloadData()
            }
            else {
                self.showAlert("Problem getting data")
            }
        }
    }
    // handle fail + no network parts
    func showAlert(_ message:String) {
        let alert = UIAlertController(title: "Error Message", message:message, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "ReTry", style: .default, handler: { (act) in
            self.startCall()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    // switch change action
    @IBAction func switchChanged(_ sender: Any) {
         startCall()
    }
}

// implement dataSource & delegate of the collection
extension MainVC :  UITableViewDelegate  , UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableSourceArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableSourceArr[section].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainTableCell
        let item = tableSourceArr[indexPath.section].list[indexPath.row]
        cell.configure(item)
        cell.sepView.isHidden = indexPath.row == tableSourceArr[indexPath.section].list.count - 1
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = tableSourceArr[section].list.first!
        let lbl = UILabel()
        lbl.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 16)
        lbl.text = "   " + getDateFromTimeStamp(Double(item.dt))
        lbl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        return lbl
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
}

 
