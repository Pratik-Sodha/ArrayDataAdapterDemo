//
//  ListController.swift
//  ArrayDataAdapterDemo
//
//  Created by Pratik Sodha on 04/10/20.
//

import UIKit

class ListController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tableView : UITableView!

    //MARK:- Class Variable
    lazy var leftBarSortButtomItem : UIBarButtonItem = {
        return UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(leftBarSortButtonClicked(_:)))
    }()
    
    lazy var rightBarFilterButtomItem : UIBarButtonItem = {
        return UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(rightBarFilterButtonClicked(_:)))
    }()
    
    let adapter = ArrayDataAdapter(items: WebSeires.loadUsingJSON())
    

    //MARK:- Custom Methods
    func setupView() {
        navigationItem.leftBarButtonItems = [leftBarSortButtomItem]
        navigationItem.rightBarButtonItems = [rightBarFilterButtomItem]
    }
    
    //MARK:- IBAction
    @objc func rightBarFilterButtonClicked(_ sender : UIBarButtonItem) {
        let controller = FilterOptionController.loadController()
        controller.delegateFilterData = self
        present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
    
    @objc func leftBarSortButtonClicked(_ sender : UIBarButtonItem) {
        let controller = SortOptionController.loadController()
        controller.delegateSortOptionSelection = self
        present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }


}
//MARK:
extension ListController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adapter.operationalItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let itemAtIndex = adapter.operationalItems[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableCell.cellReusableIdentifer) as! DetailTableCell

        cell.series = itemAtIndex

        return cell
    }
}

//MARK:-
extension ListController : SortOptionSelectionDelegate {
    
    func sortOptionController(_ controller: SortOptionController, didSelect option: SortOption) {
        
        adapter.sortComparator = option.sortDescriptor
        tableView.reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
}

//MARK:-
extension ListController : FilterDataDelegate {

    func filterOptionController(_ controller: FilterOptionController, didSelect text: String) {
        
        adapter.filterBlock = {
            items in
            return items.filter { (series) -> Bool in
                return series.genre.contains(text)
            }
        }
        tableView.reloadData()
     
        controller.dismiss(animated: true, completion: nil)
    }
    
    func filterOptionControllerClearFilter(_ controller: FilterOptionController) {
        adapter.filterBlock = nil
        tableView.reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
}
