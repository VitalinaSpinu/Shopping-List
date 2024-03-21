//
//  ViewController.swift
//  Projects 4-6
//
//  Created by Dmitrii Vrabie on 19.01.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shoping List"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAddProducts))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeList))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareItems))
        navigationItem.rightBarButtonItems = [shareButton, addButton]
        
        removeList()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func removeList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    @objc func buttonAddProducts() {
        let ac = UIAlertController(title: "Add products", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let addAction = UIAlertAction(title: "Add", style: .default) { [unowned self, ac] action in
            let products = ac.textFields![0]
            self.add(product: products.text!)
        }
        ac.addAction(addAction)
        present(ac, animated: true)
    }
    
    func add(product: String) {
        shoppingList.insert(product, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    @objc func shareItems() {
        let text = "List to buy:"
        let list = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [text, list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![0]
        present(vc, animated: true)
    }
}

