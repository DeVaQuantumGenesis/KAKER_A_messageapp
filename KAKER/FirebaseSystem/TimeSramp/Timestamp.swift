//
//  Timestamp.swift
//  KAKER 2
//
//  Created by High Speed on 2024/11/05.
//

import Foundation
import FirebaseFirestore
import Firebase

extension Timestamp{
    func timestampString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute ,.hour ,.day, .month, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: self.dateValue(), to: Date()) ?? ""
    }
}
