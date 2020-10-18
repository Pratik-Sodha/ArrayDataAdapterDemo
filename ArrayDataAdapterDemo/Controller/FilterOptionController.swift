//
//  FilterOptionController.swift
//  ArrayDataAdapterDemo
//
//  Created by Pratik Sodha on 04/10/20.
//

import UIKit
protocol FilterDataDelegate : class {
    func filterOptionController(_ controller : FilterOptionController, didSelect text : String)
    func filterOptionControllerClearFilter(_ controller : FilterOptionController)
}
class FilterOptionController: UIViewController {
    
    lazy var tableView : UITableView = {
       let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView(frame: .zero)
        table.register(SubtitleTableCell.self, forCellReuseIdentifier: SubtitleTableCell.reuseIdentifier)
        return table
    }()
    
    lazy var rightBarClearButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(rightBarClearButtonItemClicked(_:)))
    }()
    
    lazy var stringDataAdapter : ArrayDataAdapter<String> = {
        
        let genres = Set(WebSeires.loadUsingJSON().reduce([]) { (result, series) -> [String] in
            return result + series.genre
        })
        
        let adapter = ArrayDataAdapter(items: Array(genres))
        adapter.sortComparator = { (lhs,rhs) in
            return lhs < rhs
        }
        return adapter
    }()
    
    weak var delegateFilterData : FilterDataDelegate?
    
    //MARK:- Custom Methods
    func setupView() {
        navigationItem.title = "Filter Options"
        navigationItem.rightBarButtonItems = [rightBarClearButtonItem]
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
    @objc func rightBarClearButtonItemClicked(_ sender : UIBarButtonItem) {
        delegateFilterData?.filterOptionControllerClearFilter(self)
    }
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    static func loadController() -> FilterOptionController {
        return FilterOptionController()
    }
}
//MARK:-
extension FilterOptionController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringDataAdapter.operationalItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemAtIndex = stringDataAdapter.operationalItems[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: SubtitleTableCell.reuseIdentifier) as! SubtitleTableCell
        cell.filterOptionText = itemAtIndex

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemAtIndex = stringDataAdapter.operationalItems[indexPath.row]
        delegateFilterData?.filterOptionController(self, didSelect: itemAtIndex)
    }
}
