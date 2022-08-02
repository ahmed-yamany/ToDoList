//
//  AddEditToDoTableViewController.swift
//  ToDoList
//
//  Created by Ahmed Yamany on 01/08/2022.
//

import UIKit

class AddEditToDoTableViewController: UITableViewController {
    // MARK: - IBOutlets

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var iscompleteBtn: UIButton!
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var notesTV: UITextView!
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    
    var toDo: ToDo?
    var isComplete = false{
        didSet{
            if isComplete{
                iscompleteBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                
            }else{
                iscompleteBtn.setImage(UIImage(systemName: "circle"), for: .normal)
            }
            
        }
    }
    
    var isDatePickerVisible = false{
        didSet{
            dueDatePicker.isHidden = !isDatePickerVisible
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDueDate: Date
        if let toDo = toDo {
          navigationItem.title = "To-Do"
          titleTF.text = toDo.title
          isComplete = toDo.isComplete
          currentDueDate = toDo.dueDate
          notesTV.text = toDo.notes
        } else {
          currentDueDate = Date().addingTimeInterval(24*60*60)
        }
        
        dueDatePicker.date = currentDueDate
    
        updateDueDateLabel()
        updateSaveBtn()

    }

    // MARK: - IBActions
    
    @IBAction func titleTFUpdated(_ sender: UITextField) {
        updateSaveBtn()
    }
    
    @IBAction func returnTapped(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func isCompleteBtnTapped(_ sender: UIButton) {
        isComplete.toggle()
    }
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTF.text!
        let isComplete = self.isComplete
        let dueDate = dueDatePicker.date
        let notes = notesTV.text
        
        if toDo != nil {
            toDo?.title = title
                toDo?.isComplete = isComplete
                toDo?.dueDate = dueDate
                toDo?.notes = notes
            } else {
                toDo = ToDo(title: title, isComplete: isComplete,
                   dueDate: dueDate, notes: notes)
            }
    }
    
    
    // MARK: - Helper Functions
    func updateSaveBtn(){
        saveBtn.isEnabled = titleTF.text?.isEmpty == false
    }
    
    func updateDueDateLabel() {
        dueDateLbl.text = dueDatePicker.date.formatted(.dateTime.month(.defaultDigits)
           .day().year(.twoDigits).hour().minute())
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
        case IndexPath(row: 0, section: 0):
            return 50
        case IndexPath(row: 0, section: 2):
            return 200
        case IndexPath(row: 1, section: 1) where isDatePickerVisible == false:
            return 0
            
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath{
        case IndexPath(row: 0, section: 1):
            isDatePickerVisible.toggle()
        default:
            print("")
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
