//
//  HomeViewController.swift
//  ThinkNotes
//
//  Created by DianApps on 23/03/22.
//

import Foundation
import UIKit

class HomeViewcontroller: UIViewController,UITableViewDelegate,UITableViewDataSource{
 
    private var viewModel = HomeViewModel()
 
    @IBOutlet weak var noNOtes: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.currentUser()
        self.tblView.delegate = self
        self.tblView.dataSource = self
        viewModel.delegate = self
        navigationItem.hidesBackButton  = true
        viewModel.startObservingDatabase()
    }
    
    // MARK: UITableView Delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath)
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.note
        toggleCellCheckbox(cell, isCompleted: model.completed ?? false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return nil }
        let model = viewModel.items[indexPath.row]
        let completeTitleAction = model.completed! ? "Mark Not Complete" : "Mark Complete"
        
        viewModel.items[indexPath.row].completed?.toggle()
        
        let completeAction = UITableViewRowAction(style: .normal, title: completeTitleAction){ [self]_, indexPath in
            
            let item = viewModel.items[indexPath.row]
            let toggledCompletion = item.completed!
            self.toggleCellCheckbox(cell, isCompleted: toggledCompletion)
            
            viewModel.update(toggledCompletion,indexPath.row)
        }
        completeAction.backgroundColor = .cyan
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){ [self]  _,indexPath in
            
            viewModel.delete(indexPath.row)
        }
        return [deleteAction, completeAction]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = viewModel.items[indexPath.row]

     // Show note controller
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else {
            return
        }
        
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Note"
        
        vc.noteTitle = model.title!
        vc.note = model.note!
        
        navigationController?.pushViewController(vc, animated: true)
        
        //       it catches the update data
        
        vc.completionHandler = { [self] noteTitlee, notee, completedd in
            
            viewModel.updateItem(noteTitlee,notee,completedd,indexPath.row)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: Add Item
    @IBAction func newNOte(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "new") as? EntryViewController else {
            return
        }
        vc.title = viewModel.title
        
        vc.completion = { [self] noteTitle, note, completed in
            viewModel.newNote(noteTitle, note, completed)
            
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signout(_ sender: Any) {
        viewModel.signOut()
    }
    
    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
        if !isCompleted {
            cell.accessoryType = .none
            cell.textLabel?.textColor = .black
            cell.detailTextLabel?.textColor = .black
        } else {
            cell.accessoryType = .checkmark
            cell.textLabel?.textColor = .gray
            cell.detailTextLabel?.textColor = .gray
        }
    }
}

extension HomeViewcontroller:HomeViewModelDelegate{
    func navigationpop() {
        self.navigationController?.popViewController(animated: true)
    }
    func navigationRootPop(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func showTable() {
        self.tblView.isHidden = false
        self.noNOtes.isHidden = true
    }
    
    
    func reloadTable(){
        self.tblView.reloadData()
    }
    
    
}













































//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//                    let item = items[indexPath.row]
//                    item.ref?.removeValue()
//        }

//    }
