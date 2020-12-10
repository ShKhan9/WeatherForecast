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
        tableView.bounces = false
        tableView.register(UINib.init(nibName: "MainTableCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        // set current city to retieve it's data
        setCity()
        // start getting the data from the Api
        startCall()
        
    }
    // set current city
    func setCity() {
        self.placelb.text = city
    }
    // call api to get data
    func startCall() {
        vm.getData(fromLocal:!refreshSwitch.isOn) { res in
            if let res = res { 
                self.tableSourceArr = res
                self.tableView.reloadData()
            }
            else {
                
            }
        }
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
        cell.timelb.text = getTimeFromTimeStamp(item.dt)
        cell.windlb.text = "\(item.wind.speed)"
        cell.templb.text = fromKelvinToCelsius(item.main.temp)
        let imgUrl = URL(string:"https://openweathermap.org/img/wn/" + item.weather.first!.icon + "@2x.png")!
        cell.img.loadImageWithUrl(imgUrl)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = tableSourceArr[section].list.first!
        let lbl = UILabel()
        lbl.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 16)
        lbl.text = "   " + getDateFromTimeStamp(Double(item.dt))
        return lbl
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
}

 
