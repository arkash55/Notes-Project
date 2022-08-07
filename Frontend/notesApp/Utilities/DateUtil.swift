//
//  Codec.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 14/01/2022.
//

import Foundation




class DateUtil {
    
    static let shared = DateUtil()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = .current
        return dateFormatter
    }()
    
//    public func formatNoteDate(noteDate: String) -> String {
////        let finalDateIndex = noteDate.firstIndex(of: "T")
////        let finalDate = noteDate[..<finalDateIndex!]
//        Self.dateFormatter.dateFormat = "yyyy-MM-dd"
//        guard let date = Self.dateFormatter.date(from: noteDate) else {
//            return "Date Error"
//        }
//        let dateString = Self.dateFormatter.string(from: date)
//        return dateString
//    }

    
    public func formatNoteDate(noteDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let altered_date = dateFormatter.date(from: noteDate) else {
            print("failed to format")
            return "date error"
        }
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = dateFormatter.string(from: altered_date)
        return resultString
    }
    
    
}
