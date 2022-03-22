//
//  CalendarViewController.swift
//  Custom_Calendar
//
//  Created by Duy Tran N. on 5/10/19.
//  Copyright © 2019 MBA0204. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController {

    typealias WeekDay = CalendarViewModel.DaysOfWeek

    var magicWidth: CGFloat = .leastNonzeroMagnitude

    // MARK: - IBOutlet
    @IBOutlet private weak var monthYearLabel: UILabel!
    @IBOutlet private weak var sundayLabel: UILabel!
    @IBOutlet private weak var mondayLabel: UILabel!
    @IBOutlet private weak var tuesdayLabel: UILabel!
    @IBOutlet private weak var wednesdayLabel: UILabel!
    @IBOutlet private weak var thursdayLabel: UILabel!
    @IBOutlet private weak var fridayLabel: UILabel!
    @IBOutlet private weak var saturdayLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!

    // MARK: - Properties
    private let viewModel = CalendarViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    @IBAction private func previousButtonTapped(_ button: UIButton) {
        viewModel.decreaseMonth()
        updateView()
    }//

    @IBAction private func nextButtonTapped(_ button: UIButton) {
        viewModel.increaseMonth()
        updateView()
    }
}

// MARK: - Extension UICollectionViewDataSource
extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CalendarCollectionCell.self, indexPath: indexPath)
        let cellVM = viewModel.viewModelForItem(at: indexPath)
        let cellBackgroundColor = viewModel.isValidCell(indexPath) ? .white : Color.calendarClearBackground
        cell.updateView(with: cellVM)
        cell.backgroundColor = cellBackgroundColor
        return cell
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout
extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard viewModel.isValidCell(indexPath) else { return }
        viewModel.didSelect(at: indexPath)
        collectionView.reloadData()
    }
}

// MARK: - Private functions
extension CalendarViewController {
    private func configureUI() {
        /// Header of calendar
        let headerLabels: [UILabel] = [sundayLabel, mondayLabel, tuesdayLabel, wednesdayLabel, thursdayLabel, fridayLabel, saturdayLabel]
        for index in 0 ..< WeekDay.count {
            headerLabels[index].text = WeekDay(rawValue: index + 1)?.displayName
        }
        /// Collection view
        collectionView.register(nibWithCellClass: CalendarCollectionCell.self)
        updateView()
    }

    private func updateView() {
        collectionView.reloadData()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        ///
        DispatchQueue.main.async { [weak self] in
            guard let this = self else { return }
            let width = this.collectionView.bounds.width / 7
            let roundedWidth = width.rounded()//.scaling
            print("Dispatch block: \(width), rounded: \(roundedWidth))")
            let height = width + 10         // 10 is random number, change if you want
            let extraSpace = this.collectionView.bounds.width - roundedWidth * 7
            this.collectionView.contentInset = UIEdgeInsets(top: 0,
                                                            left: extraSpace / 2,
                                                            bottom: 0,
                                                            right: extraSpace / 2)
            layout.itemSize = CGSize(width: roundedWidth, height: height)
            layout.minimumInteritemSpacing = 0.0
            layout.minimumLineSpacing = 0.0
            this.collectionView.collectionViewLayout = layout
            this.collectionViewHeightConstraint.constant = this.viewModel.numberOfColumns.cgFloat * height
        }
        ///
//        let width = (collectionView.bounds.width / 7).scaling
//        let height = width + 10         // 10 is random number, change if you want
//        layout.itemSize = CGSize(width: width, height: height)
//        layout.minimumInteritemSpacing = 0.0
//        layout.minimumLineSpacing = 0.0
//        collectionView.collectionViewLayout = layout
//        collectionViewHeightConstraint.constant = viewModel.numberOfColumns.cgFloat * height
        monthYearLabel.text = "\(viewModel.year)年\(viewModel.month)月"
    }
}

// MARK: - Extension UICollectionViewFlowLayout
//extension CalendarViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row % 6 == 0 {
//            return CGSize()
//        }
//    }
//}
