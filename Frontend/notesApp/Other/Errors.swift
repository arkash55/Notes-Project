//
//  Errors.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 14/01/2022.
//

import Foundation

enum AuthError: Error {
    case access_token_expired
    case refresh_token_expired
    case user_not_exist
    case incorrect_password
    case account_exists
}


enum DataError: Error {
    case decode_failed
    case encode_failed
}



enum MiscError: Error {
    case guardFailed
    case task_failed
    case missing_cache
    case faulty_url
}




enum ResponseError: Error {
    case bad_request
    case unknown_code
}


