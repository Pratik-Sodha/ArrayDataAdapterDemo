//
//  SortOptionController.swift
//  ArrayDataAdapterDemo
//
//  Created by Pratik Sodha on 04/10/20.
//

import UIKit
protocol SortOptionSelectionDelegate : class {
    func sortOptionController(_ controller : SortOptionController, didSelect option : SortOption)
}

class SortOptionController: UIViewController {

    //MARK:- Outlets
    lazy var tableView : UITableView = {
       let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView(frame: .zero)
        table.register(SubtitleTableCell.self, forCellReuseIdentifier: SubtitleTableCell.reuseIdentifier)
        return table
    }()
    
    let sortOptionDataSource : [SortOption] = SortOption.allCases
    weak var delegateSortOptionSelection : SortOptionSelectionDelegate?
    
    //MARK:- Custom Methods
    func setupView() {
        navigationItem.title = "Sort Options"
        setupSubviews()
    }
    
    func setupSubviews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    static func loadController() -> SortOptionController {
        return SortOptionController()
    }
}
//MARK:-
extension SortOptionController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptionDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemAtIndex = sortOptionDataSource[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: SubtitleTableCell.reuseIdentifier) as! SubtitleTableCell
        cell.sortOption = itemAtIndex

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemAtIndex = sortOptionDataSource[indexPath.row]
        delegateSortOptionSelection?.sortOptionController(self, didSelect: itemAtIndex)
    }
}
