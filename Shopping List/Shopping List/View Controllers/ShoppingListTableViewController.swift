//
//  ShoppingListTableViewController.swift
//  Shopping List
//
//  Created by winston salcedo on 5/12/19.
//  Copyright © 2019 Evolve Technologies. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListTableViewController: UITableViewController, UITextFieldDelegate {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShoppingListController.shared.fetchedResultsController.delegate = self

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ShoppingListController.shared.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ShoppingListTableViewCell
        cell.delegate = self
        let shoppingList = ShoppingListController.shared.fetchedResultsController.fetchedObjects?[indexPath.row]
        cell.shoppingList = shoppingList
        if cell.isSelected && cell.contains(ShoppingListController.shared.fetchedResultsController.fetchedObjects?[indexPath.row] as! UIFocusEnvironment){
            cell.accessoryType = .checkmark
            
            if (shoppingList?.isComplete == true){
                cell.accessoryType = .checkmark
            }else {
                shoppingList?.isComplete = false
                cell.accessoryType = .none
            }
        }
        // I am trying to use the checkmark accessory type instead but cant figure it out yet.
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let shoppingList = ShoppingListController.shared.fetchedResultsController.fetchedObjects?[indexPath.row] else {return}
            ShoppingListController.shared.deleteItem(shoppingList: shoppingList )
            
        }
    }
    //MARK: Actions add item button
    @IBAction func addItemBtnTapped(_ sender: Any) {
        ShoppingListAlert()
    }
}
//MARK: fetchController Delegate
extension ShoppingListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
}
// MARK: extension for alert Actions
extension ShoppingListTableViewController {
    func ShoppingListAlert() {
        
        let alertController = UIAlertController(title: "Shopping List", message: "Ass your Items to buy", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter the items to buy ..."
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let textfield = alertController.textFields?.first else { return }
            ShoppingListController.shared.addItem(name: textfield.text ?? "")
            print("Textfield: \(String(describing: textfield.text))")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated:  true)
    }
}

