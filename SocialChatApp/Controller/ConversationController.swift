//
//  ConversationController.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/22.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit
import Firebase


class ConversationController: UIViewController
{
    static let CELL_IDENTIFIER = "ConversationController"
    
    fileprivate var chatTableView: UITableView =
    {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFIER)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIView()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        checkifuserloggedIn()
        view.addSubview(chatTableView)
        chatTableView.tableFooterView = UIView()
        view.backgroundColor = .white
    }
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        chatTableView.frame = view.bounds
    }
    
    func configureUIView()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style:.plain, target: self, action: #selector(handleProfile))
        configurationHeaderTitleView(title: "Messages", mybackgroundColor: .systemBlue)
        
    }
    
    @objc func handleProfile()
    {
        print("DEBUG: HABDLE PROFILE")
        logout()
    }
    
    
    @objc func handleLogin()
    {
        print("DEBUG: LOGOUT")
    }
    
    func logout()
    {
        do
        {
            try Auth.auth().signOut()
        }catch
        {
            print("DEBUG: there was an error while loggin Out")
        }
    }
    
    
    func checkifuserloggedIn()
    {
        if Auth.auth().currentUser?.uid == nil
        {
            print("DEBUG: USER IS NOT LOGGED IN")
            DispatchQueue.main.async {
                let loginviewcontroller = LoginViewController()
                loginviewcontroller.modalPresentationStyle = .fullScreen
                self.navigationController?.present(loginviewcontroller, animated: true, completion: nil)
            }
        }else
        {
            print("DEBUG USER IS ALREADY LOGGED IN ")
        }
    }
}

extension ConversationController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:ConversationController.CELL_IDENTIFIER, for: indexPath)
        cell.textLabel?.text = " cell test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
