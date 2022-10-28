//
//  ChatController.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/28.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class ChatController: UICollectionViewController
{
    //    MARK:- Properties
    
    private let user: User
    
    private lazy var MyinputView : CustomInputView =
    {
        let myView = CustomInputView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOpacity = 0.6
        myView.layer.shadowOffset = .init(width: 0, height: -8)
        myView.layer.shadowRadius  = 10
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
    }
    //    MARK:- Functions
    
    override var inputAccessoryView: UIView?
    {
        get{return MyinputView}
    }
    
    override var canBecomeFirstResponder: Bool
    {return true}
    
    func configureCollectionUI()
    {
        collectionView.backgroundColor = .white
        configureNavigationBar(withTitle: user.username, prefersLargeTitles: false)
    }
}
