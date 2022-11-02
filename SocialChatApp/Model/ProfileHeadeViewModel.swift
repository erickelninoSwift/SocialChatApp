//
//  ProfileHeadeViewModel.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/11/01.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import Foundation
import Firebase


enum ProfileHeadeViewModel: Int, CaseIterable
{
    case useracoountInfo
    case settings
    
    var description: String
    {
        switch self
        {
        case .useracoountInfo: return "Account info"
        case .settings: return "Setting"
        }
    }
    
    var iconeImage: String
    {
        switch self
        {
        case .useracoountInfo: return "person.circle"
        case .settings: return "gear"
        }
    }
}
