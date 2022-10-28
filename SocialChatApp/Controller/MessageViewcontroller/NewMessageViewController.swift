//
//  NewMessageViewController.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/27.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class NewMessageViewController: UITableViewController
{
     let identifier = "NEW_MESSAGE_CELL"
    
    private var Allmyusers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuremyUI()
        getAllUsers()
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
        return Allmyusers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        cell.currentUser = Allmyusers[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
}
