//
//  CustomInputView.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/28.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

protocol  CustominputViewDelgate: AnyObject {
    func sendbuttonCustomView(currentView:CustomInputView, messagesent: String)
}

class CustomInputView: UIView
{
//    MARK: = Properties
    
    weak var delegate : CustominputViewDelgate?
    
    let messageInputtextview: UITextView =
    {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.setHeight(height: 30)
        tv.textColor = .systemGray
        return tv
    }()
    
    private let sendButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(handlesendMessages), for: .touchUpInside)
        return button
    }()
    
    
    private let placeholder: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter Message"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleHeight
        self.backgroundColor = .white
        self.addSubview(sendButton)
        sendButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        sendButton.setDimensions(height: 30, width: 50)
        self.addSubview(messageInputtextview)
        messageInputtextview.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        messageInputtextview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        messageInputtextview.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -5).isActive = true
        messageInputtextview.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        
        self.addSubview(placeholder)
        placeholder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        placeholder.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(handletextfieldDidchange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize
    {
        return .zero
    }
    
    @objc func handletextfieldDidchange()
    {
      checkshit()
    }
    
    
    @objc func handlesendMessages()
    {
        guard let messagetosend = messageInputtextview.text else {return}
        delegate?.sendbuttonCustomView(currentView: self, messagesent: messagetosend)
         messageInputtextview.text = ""
         checkshit()
    }
    
    func checkshit()
    {
       
        placeholder.isHidden = !messageInputtextview.text.isEmpty
    }
}
