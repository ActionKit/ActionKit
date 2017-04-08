//
//  TableViewController.swift
//  ActionKitDemo
//
//  Created by Benjamin Hendricks on 4/8/17.
//  Copyright © 2017 ActionKit. All rights reserved.
//

import UIKit
import ActionKit

class TableViewController: UITableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: ActionKitTableViewCell = tableView.dequeueReusableCell(withIdentifier: ActionKitTableViewCell.kReuseID, for: indexPath) as? ActionKitTableViewCell {
            cell.cellForRowAtIndexPathCalledDemo()
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: ActionKitTableViewCell.kReuseID, for: indexPath)
        }
    }
}
