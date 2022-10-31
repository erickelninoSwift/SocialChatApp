//
//  MessageViewMidel.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/30.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit
import Firebase

struct MessageViewModel
{
    
    private let message: Message
    
    var MessageCellBackgroundColor: UIColor
    {
        return message.isfromCurrentUser ? #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1) : #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
    }
    
    var messageTetxColor: UIColor
    {
        return message.isfromCurrentUser ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : .white
    }
    
    var profilerightAnchor: Bool
    {
        return message.isfromCurrentUser
    }
    
    var profileleftanchor: Bool
    {
        return !message.isfromCurrentUser
    }
    
    var shouldHidprofileImage: Bool
    {
        return message.isfromCurrentUser
    }

    var profileImageURL: URL?
    {
        guard let urlString = message.user?.profileImageUrl  else {return nil}
        return URL(string: urlString)
    }
    
    
    init(myMessage: Message) {
        self.message = myMessage
    }
}
