//
//  PickerCell.swift
//  InlinePickerSample
//
//  Created by hiraya.shingo on 2020/04/13.
//  Copyright © 2020 hiraya.shingo. All rights reserved.
//

import UIKit

class PickerCell: UITableViewCell {
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        prepare()
    }

    @objc func datePickerValueDidChange(sender: UIDatePicker) {
        label.text = PickerCell.formatter.string(from: sender.date)
    }

    func showPicker() {
        guard datePicker.isHidden else { return }

        // セルの高さの制約の値を変更して、Pickerが見えるようにする
        containerViewHeight.constant = PickerCell.expandedHeight
        datePicker.isHidden = false
        UIView.animate(withDuration: 0.25) {
            self.datePicker.alpha = 1
            self.layoutIfNeeded()
        }
    }

    func hidePicker() {
        guard !datePicker.isHidden else { return }

        // セルの高さの制約の値を変更して、Pickerが隠れるようにする
        containerViewHeight.constant = PickerCell.compressedHeight
        UIView.animate(withDuration: 0.25, animations: {
            self.datePicker.alpha = 0
            self.layoutIfNeeded()
        }, completion: { _ in
            self.datePicker.isHidden = true
        })
    }
}

private extension PickerCell {
    static let compressedHeight: CGFloat = 44
    static let expandedHeight: CGFloat = 260
    static let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateStyle = .long
        return dateFormatter
    }()

    func prepare() {
        containerViewHeight.constant = PickerCell.compressedHeight

        let now = Date()
        datePicker.date = now
        datePicker.addTarget(self, action: #selector(datePickerValueDidChange), for: .valueChanged)
        datePicker.isHidden = true
        datePicker.alpha = 0
        label.text = PickerCell.formatter.string(from: now)
    }
}
