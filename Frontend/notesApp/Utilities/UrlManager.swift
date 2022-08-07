//
//  URLS.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 12/01/2022.
//

import Foundation


class UrlUtil {
    
    static let shared = UrlUtil()
    
    public func convertToUrl(_ urlString: String) -> URL? {
        guard let apiUrl = URL(string: urlString) else {
            print("Error creating url")
            return nil
        }
        return apiUrl
    }
    

}

