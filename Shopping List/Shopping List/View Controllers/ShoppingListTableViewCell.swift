//
//  ShoppingListTableViewCell.swift
//  Shopping List
//
//  Created by winston salcedo on 5/12/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import UIKit

protocol ShoppingListTableViewCellDelegate: class {
    func shoppingListButonTapped(_ cell: ShoppingListTableViewCell)
    
}



class ShoppingListTableViewCell: UITableViewCell {


    @IBOutlet weak var shoppingListCellLbl: UILabel!
    //MARK: Properties
    
    weak var delegate: ShoppingListTableViewCellDelegate?
    
    var shoppingList: ShoppingList? {
        didSet {
            updateViews()
        }
  
}
   
func updateViews() {
    if let shoppingList = shoppingList {
         shoppingListCellLbl.text = shoppingList.name
        
        }
    }
    func addItemBtnTapped(_ sender: Any) {
        delegate?.shoppingListButonTapped(self)
    }
 }
//MARK: extension to get the indexpath and update the cell as needed.
    extension ShoppingListTableViewController: ShoppingListTableViewCellDelegate {
        
        func shoppingListButonTapped(_ cell: ShoppingListTableViewCell) {
            if let indexPath = tableView.indexPath(for: cell) {
                guard let shoppingList = ShoppingListController.shared.fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
                ShoppingListController.shared.markComplete(shoppingList: shoppingList)
                
            }
        }
        //MARK: function to update the cells in the section.
        private func reloadCellAtRow(row: Int) {
            let indexPath = NSIndexPath(row: row, section: 0)
            
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath as IndexPath], with: .automatic)
            tableView.endUpdates()
        }
    }

