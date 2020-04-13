//
//  ViewController.swift
//  InlinePickerSample
//
//  Created by hiraya.shingo on 2020/04/13.
//  Copyright © 2020 hiraya.shingo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    private var showingDatePicker = false
    private var pickerCell: PickerCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemGroupedBackground
    }
}

extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 1) ? 1 : 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath)
            pickerCell = cell as? PickerCell
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "NormalCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section)-\(indexPath.row)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 1 else { return }

        tableView.performBatchUpdates({
            if self.showingDatePicker {
                pickerCell?.hidePicker()
            } else {
                pickerCell?.showPicker()
            }
        }, completion: { _ in
            self.showingDatePicker.toggle()
        })
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
}
