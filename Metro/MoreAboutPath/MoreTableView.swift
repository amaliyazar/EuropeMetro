//
//  MoreTableView.swift
//  EuropeMetro
//
//  Created by Амалия Зарывных on 29.01.2020.
//  Copyright © 2020 Amaliya Zaryvnykh. All rights reserved.
//

import UIKit


class MoreTableView: UITableViewController {
    
    var presenter: MoreTableViewPresenterProtocol!
    var configurator = MoreTableViewConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        
        self.tableView.rowHeight = 40
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.register(StationInfoCell.self, forCellReuseIdentifier: String(describing: StationInfoCell.self))
        self.tableView.register(TransferCell.self, forHeaderFooterViewReuseIdentifier: String(describing: TransferCell.self))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return presenter.stationPath.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter.stationPath[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 1.0 : 80
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: StationInfoCell.self),for: indexPath) as? StationInfoCell else { return UITableViewCell() }
        cell.setup(data: presenter.stationPath, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: TransferCell.self)) as? TransferCell else { return UIView() }
        if section > 0 {
            cell.setupTransfer(data: presenter.stationPath, section: section)
            return cell
        }else{
            return UIView()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: TransferCell.self)) as? TransferCell else { return UIView() }
        if section == presenter.stationPath.count - 1 && !presenter.stationPath.isEmpty{
            cell.setupFullPath(data: presenter.stationPath)
            return cell
        }else{
            return UIView()
        }
    }


}
