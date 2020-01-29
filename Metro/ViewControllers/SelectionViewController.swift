//
//  Settings swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit
import Foundation

var cities = ["Vienna", "Athens", "Stockholm", "Prague", "Lisboa", "Warsaw", "Milano", "Roma","Sofia"]
var petDesc = ["Dog is an animal that has four legs", "A cat is an animal that likes to eat fish", "A rabbit is an animal that likes to jump arond"]
var myIndex = 0
var dataFile = "Milano"
var searching = false
var searchedCity = [String]()

class Selection: UITableViewController {
    
    @IBOutlet var SelectionSearchBar: UISearchBar!
    @IBOutlet var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Selection")
        //tableView.register(Selection.self, forCellWithReuseIdentifier: )
        BaseViewController().addSlideMenuButton()
        // Do any additional setup after loading the view.
    }
    //self.tableView.register(Selection.self, forCellWithReuseIdentifier: "Selection")

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            if searching {
                 return searchedCity.count
            } else{
                return cities.count
        }
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Selection", for: indexPath)
            
            if searching {
                cell.textLabel?.text = searchedCity[indexPath.row]
            } else {
                cell.textLabel?.text = cities[indexPath.row]
            }
            //tblView.reloadData()

            return cell
        }
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            myIndex = indexPath.row
            dataFile = cities[indexPath.row]

            performSegue(withIdentifier: "segue", sender: self)
        }
    
}
extension Selection: UISearchBarDelegate {

func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    searchedCity = cities.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
    searching = true
    tblView.reloadData()
}

func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searching = false
    searchBar.text = ""
    tblView.reloadData()
}
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
