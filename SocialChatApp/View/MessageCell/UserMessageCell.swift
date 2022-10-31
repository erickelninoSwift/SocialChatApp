//
//  UserMessageCell.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/29.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class UserMessageCell: UICollectionViewCell
{
    
//     MARK: - properties
    var myUser: User?
    {
        didSet{
            setUser()
        }
    }
    
    var myMessage: Message?
    {
        didSet{configure()}
    }
    
    var bubleLeftAnchor: NSLayoutConstraint!
    var bublerightAnchor: NSLayoutConstraint!
    
    
    private let profileImage: UIImageView =
    {
        let Imageprofile = UIImageView()
        Imageprofile.clipsToBounds = true
        Imageprofile.contentMode = .scaleAspectFill
        return Imageprofile
    }()
    
    
    private let currentUserProfileImage: UIImageView =
      {
          let Imageprofile = UIImageView()
          Imageprofile.clipsToBounds = true
          Imageprofile.contentMode = .scaleAspectFill
          Imageprofile.backgroundColor = .lightGray
          return Imageprofile
      }()
      
    
     let messageInputtextview: UITextView =
    {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.backgroundColor = .clear
        tv.isEditable = false
        tv.textColor = .white
        return tv
    }()
    
    private let bubbleConainer: UIView =
    {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius  = 10
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(profileImage)
         
        profileImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        
        profileImage.setDimensions(height: 35, width: 35)
        profileImage.layer.cornerRadius = 35 / 2
        
        
        self.addSubview(bubbleConainer)
        bubbleConainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        bubbleConainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        bubbleConainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        bublerightAnchor = bubbleConainer.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -5)
        bublerightAnchor.isActive = false
        
        bubleLeftAnchor = bubbleConainer.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 12)
        bubleLeftAnchor.isActive = false
        
        
        bubbleConainer.addSubview(messageInputtextview)
        
        messageInputtextview.topAnchor.constraint(equalTo: bubbleConainer.topAnchor, constant: 3).isActive = true
        messageInputtextview.leadingAnchor.constraint(equalTo: bubbleConainer.leadingAnchor, constant: 5).isActive = true
        messageInputtextview.trailingAnchor.constraint(equalTo: bubbleConainer.trailingAnchor, constant: -5).isActive = true
        messageInputtextview.centerYAnchor.constraint(equalTo: bubbleConainer.centerYAnchor).isActive = true
        messageInputtextview.bottomAnchor.constraint(equalTo: bubbleConainer.bottomAnchor, constant: -3).isActive = true
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure()
    {
        guard let currentMessage = myMessage else { return }
        let myviewmodelMessage = MessageViewModel(myMessage: currentMessage)
        bubleLeftAnchor.isActive = myviewmodelMessage.profileleftanchor
        bublerightAnchor.isActive = myviewmodelMessage.profilerightAnchor
        bubbleConainer.backgroundColor = myviewmodelMessage.MessageCellBackgroundColor
        profileImage.isHidden = myviewmodelMessage.shouldHidprofileImage
        messageInputtextview.textColor = myviewmodelMessage.messageTetxColor
        messageInputtextview.text = currentMessage.text
        profileImage.sd_setImage(with: myviewmodelMessage.profileImageURL)
    }
    
    func setUser()
    {
        guard let profileImagesURl = URL(string: myUser?.profileImageUrl ?? "") else {return}
        profileImage.sd_setImage(with: profileImagesURl, completed: nil)
    }
}
