//
//  ApiUrls.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 14/01/2022.
//

import Foundation


struct ApiUrls {

    //AUTH URLS
    static let loginUrl = UrlUtil.shared.convertToUrl("http://localhost:3000/user/login")
    static let registrationUrl = UrlUtil.shared.convertToUrl("http://localhost:3000/user/register")
    static let logOutUrl = UrlUtil.shared.convertToUrl("http://localhost:3000/user/logout")

    //TOKEN URLS
    static let newAcccessTokenUrl = UrlUtil.shared.convertToUrl("http://localhost:3000/user/new-token")
    
    //NOTES URLS
    static let getNotesUrl = UrlUtil.shared.convertToUrl("http://localhost:3000/note/get-notes")
    static let getUrgentNotesUrl = UrlUtil.shared.convertToUrl("http://localhost:3000/note/get-urgent-notes")
    static let updateNoteURL = UrlUtil.shared.convertToUrl("http://localhost:3000/note/update-note")
    static let createNoteURL = UrlUtil.shared.convertToUrl("http://localhost:3000/note/create-note")
    
}
