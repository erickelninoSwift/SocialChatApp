//
//  ChatController.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/28.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

private let resuableIdentifier = "MESSAGE_CELL"

class ChatController: UICollectionViewController
{
    //    MARK:- Properties
    
    let user: User
    private var userMessage = [Message]()
    
    var isCurrentUser: Bool = false
    
    private lazy var MyinputView : CustomInputView =
    {
        let myView = CustomInputView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOpacity = 0.6
        myView.layer.shadowOffset = .init(width: 0, height: -8)
        myView.layer.shadowRadius  = 10
        myView.delegate = self
        return myView
    }()
    
    
    init(user:User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionUI()
        collectionView.register(UserMessageCell.self, forCellWithReuseIdentifier: resuableIdentifier)
        collectionView.alwaysBounceVertical = true
        retreiveMessage()
        collectionView.keyboardDismissMode = .interactive
    }
    
    
    //    MARK:- Functions
    
    override var inputAccessoryView: UIView?
        {get{return MyinputView}}
    
    
    
    override var canBecomeFirstResponder: Bool
    {return true}
    
    
    func configureCollectionUI()
    {
        collectionView.backgroundColor = .white
        configureNavigationBar(withTitle: user.username, prefersLargeTitles: false)
    }
}
extension ChatController
{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userMessage.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier:resuableIdentifier , for: indexPath) as? UserMessageCell
            else { return UICollectionViewCell()}
        cell.myMessage = userMessage[indexPath.row]
        cell.myUser = user
        return cell
    }
}

//configuraing the UICollectionviewCell

extension ChatController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//         create a dummycell
        let frame  = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let estimatedCell = UserMessageCell(frame: frame)
        estimatedCell.myMessage = userMessage[indexPath.row]
        estimatedCell.layoutIfNeeded()
        
//
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimatedCell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
}

extension ChatController: CustominputViewDelgate
{
    func sendbuttonCustomView(currentView: CustomInputView, messagesent: String) {
        
        Services.shared.uploadMessage(message: messagesent, toUser: user) { (Error) in
            if let error  = Error
            {
                print("DEBUG: Failed to upload messages with error \(error.localizedDescription)")
                
            }else
            {
                currentView.checkshit()
                self.collectionView.reloadData()
            }
        }
        
    }
    
    
    func retreiveMessage()
    {
        print(user)
        Services.shared.retreiveMessagesFromDatabase(forUser: user) { Result in
            switch Result
            {
            case .success(let Messages):
                self.userMessage = Messages
                print(Messages)
                self.collectionView.reloadData()
                self.collectionView.scrollToItem(at: [0 , self.userMessage.count - 1], at: .bottom, animated: true)
            case .failure(let Error):
                print("There was an error while fetching data \(Error.localizedDescription)")
            }
        }
    }
}
