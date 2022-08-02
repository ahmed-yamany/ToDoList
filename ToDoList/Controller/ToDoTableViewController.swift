//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Ahmed Yamany on 01/08/2022.
//

import UIKit


protocol ToDoCellDelegate: AnyObject {
    func checkmarkTapped(sender: ToDoTableViewCell)
}

class ToDoTableViewController: UITableViewController {
    var toDos = [ToDo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let savedTodos = ToDo.loadToDos(){
            toDos += savedTodos
        }else{
            toDos += ToDo.loadSampleToDos()
        }

  
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else {
            if let indexPath = tableView.indexPathForSelectedRow{
                tableView.deselectRow(at: indexPath, animated: true)
            }
            return
            
        }
        let sourceViewController = segue.source as!
               AddEditToDoTableViewController
        
        if let toDo = sourceViewController.toDo {
            
            if let indexPath = tableView.indexPathForSelectedRow{
                toDos[indexPath.row] = toDo
                tableView.deselectRow(at: indexPath, animated: true)
                tableView.reloadData()
            }else{
            
            let newIndexPath = IndexPath(row: toDos.count, section: 0)
            
                toDos.append(toDo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
        ToDo.saveToDos(toDos)
        
    }
    
    
    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> AddEditToDoTableViewController? {
        let detailController = AddEditToDoTableViewController(coder: coder)
        
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
                // if sender is the add button, return an empty controller
                return detailController
            }
        detailController?.toDo = toDos[indexPath.row]
        
        return detailController
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentefier", for: indexPath) as! ToDoTableViewCell

        let todo = toDos[indexPath.row]
        // Configure the cell...
        cell.titleLbl.text = todo.title
        cell.isComplete = todo.isComplete
        cell.delegate = self
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(toDos)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ToDoTableViewController: ToDoCellDelegate{
    func checkmarkTapped(sender: ToDoTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender){
            var todo = toDos[indexPath.row]
            todo.isComplete.toggle()
            toDos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(toDos)
        }
    }
    
    
}
