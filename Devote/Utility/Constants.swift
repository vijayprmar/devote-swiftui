//
//  Constants.swift
//  Devote
//
//  Created by Vijay Parmar on 29/07/22.
//

import Foundation
import SwiftUI

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//MARK: - UI

var backgroundGradient : LinearGradient{
    return LinearGradient(gradient: Gradient(colors: [Color.pink,Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
}
