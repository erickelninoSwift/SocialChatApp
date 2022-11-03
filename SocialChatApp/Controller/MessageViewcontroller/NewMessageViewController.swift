//
//  NewMessageViewController.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/27.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

protocol  selectedUsertochatwith: AnyObject {
    
    func ChosenUsertochatwith(UserselectedViewcontroller: NewMessageViewController , selectedUser: User)
}

class NewMessageViewController: UITableViewController
{
    let identifier = "NEW_MESSAGE_CELL"
    
    
    weak var delegate:selectedUsertochatwith?
    
    private var isinSearchMode: Bool
    {
        return searchController.isActive &&
            !searchController.searchBar.text!.isEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var Allmyusers = [User]()
    private var filteredUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuremyUI()
        getAllUsers()
        configuresearchController()
    }
    
    func configuremyUI()
    {
        configureNavigationBar(withTitle: "New Message", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelButton))
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
        tableView.register(UserCell.self, forCellReuseIdentifier: identifier)
    }
    
    @objc func handleCancelButton()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    //    Get all the users from thre database
    
    func getAllUsers()
    {
        Services.shared.fetchAllusers { (Results) in
            switch Results
            {
            case .success(let AllUsers):
                DispatchQueue.main.async {
                    self.Allmyusers.append(AllUsers)
                    self.tableView.reloadData()
                }
            case .failure(let Error):
                print(Error.localizedDescription)
            }
        }
    }
}

extension NewMessageViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isinSearchMode ? filteredUsers.count : Allmyusers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        cell.currentUser = isinSearchMode ? filteredUsers[indexPath.row] : Allmyusers[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = isinSearchMode ? filteredUsers[indexPath.row] : Allmyusers[indexPath.row]
        
        delegate?.ChosenUsertochatwith(UserselectedViewcontroller: self, selectedUser: user)
    }
}

// Sesrch Controller configuration

extension NewMessageViewController: UISearchResultsUpdating
{
    
    
    func configuresearchController()
    {
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for user"
        
        searchController.searchResultsUpdater = self
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField
        {
            textfield.textColor = .white
            textfield.backgroundColor = .systemBackground
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchtext  = searchController.searchBar.text?.lowercased() else { return}
        
        filteredUsers = Allmyusers.filter({ (users) -> Bool in
            return users.username.contains(searchtext) || users.fullname.contains(searchtext)
        })
        self.tableView.reloadData()
    }
}
