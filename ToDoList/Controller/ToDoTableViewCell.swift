//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Ahmed Yamany on 01/08/2022.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var isCompleteBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    var isComplete = false{
        didSet{
            if isComplete{
                isCompleteBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                
            }else{
                isCompleteBtn.setImage(UIImage(systemName: "circle"), for: .normal)
            }
            
        }
    }

    
    var delegate: ToDoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func isCompleteBtnPressed(_ sender: UIButton) {
        delegate?.checkmarkTapped(sender: self)
        
    }
}
