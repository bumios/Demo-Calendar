//
//  MyDemoCell.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 8/27/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import UIKit

final class MyDemoCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    func update(title: String) {
        titleLabel.text = title
    }
}
