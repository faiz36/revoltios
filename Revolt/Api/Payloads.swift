//
//  Payloads.swift
//  Revolt
//
//  Created by Tom on 2023-11-13.
//

import Foundation

struct AccountCreatePayload: Encodable {
    var email: String
    var password: String
    var invite: String?
    var captcha: String?
}


struct EmptyResponse {
    
}

struct FetchHistory: Decodable {
    var messages: [Message]
    var users: [User]
    var members: [Member]?
}

struct ApiReply: Encodable {
    var id: String
    var mention: Bool
}

struct SendMessage: Encodable {
    var replies: [ApiReply]
    var content: String
    var attachments: [String]
}


struct ContentReportPayload: Encodable {
    enum ContentReportReason: String, Encodable, CaseIterable {
        /// No reason has been specified
        case NoneSpecified = "No reason specified"
        /// Illegal content catch-all reason
        case Illegal = "Illegal Activity"
        /// Selling or facilitating use of drugs or other illegal goods
        case IllegalGoods = "Illegal Goods"
        /// Extortion or blackmail
        case IllegalExtortion = "Extortion"
        /// Revenge or child pornography
        case IllegalPornography = "Child/Revenge Pornography"
        /// Illegal hacking activity
        case IllegalHacking = "Hacking"
        /// Extreme violence, gore, or animal cruelty
        /// With exception to violence potrayed in media / creative arts
        case ExtremeViolence = "Extreme Violence"
        /// Content that promotes harm to others / self
        case PromotesHarm = "Promoting Harm"
        /// Unsolicited advertisements
        case UnsolicitedSpam = "Spam"
        /// This is a raid
        case Raid = "Raid"
        /// Spam or platform abuse
        case SpamAbuse = "Platform Abuse"
        /// Scams or fraud
        case ScamsFraud = "Scam/Fraud"
        /// Distribution of malware or malicious links
        case Malware = "Malware"
        /// Harassment or abuse targeted at another user
        case Harassment = "Harassment"
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(String(describing: self))
        }
    }
    
    enum ContentReportType: String, Encodable {
        case Message = "Message"
        case Server = "Server"
        case User = "User"
    }
    
    struct NestedContentReportPayload: Encodable {
        var type: ContentReportType
        var id: String
        var report_reason: ContentReportReason
    }
    
    var content: NestedContentReportPayload
    var additional_context: String
    
    init(type: ContentReportType, contentId: String, reason: ContentReportReason, userContext: String) {
        self.content = NestedContentReportPayload(type: type, id: contentId, report_reason: reason)
        self.additional_context = userContext
    }
}

struct AutumnPayload: Encodable {
    var file: Data
}
