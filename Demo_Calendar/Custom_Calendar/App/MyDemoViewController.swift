//
//  MyDemoViewController.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 8/27/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import UIKit

final class MyDemoViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var insertTopRowButton: UIButton!
    @IBOutlet private weak var insertBottomRowButton: UIButton!

    // MARK: - Properties
    var datas: [Int] = [1,2,3,4,5,6,7,8,9]

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.register(nibWithCellClass: MyDemoCell.self)
    }

    // MARK: - IBAction
    @IBAction private func insertRowButtonTouchUpInside(_ button: UIButton) {
        switch button {
        case insertTopRowButton:
            print("Inserted 6 rows at top")
            datas.insert(contentsOf: [0,0,0,0,0,0], at: 0)
            tableView.reloadData()
        case insertBottomRowButton:
            print("Inserted 6 rows at bottom")
            datas.insert(contentsOf: [10,10,10,10,10,10], at: datas.count)
            tableView.reloadData()
        default: break
        }
    }
}

// MARK: - Extension UITableViewDataSource
extension MyDemoViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(MyDemoCell.self, indexPath: indexPath)
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .orange
        } else {
            cell.backgroundColor = .green
        }

        cell.update(title: "\(datas[indexPath.row])")
        return cell
    }
}

extension MyDemoViewController: UITableViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("--> did end decele with")
        print("offset y: \(scrollView.contentOffset.y)")
    }
}
