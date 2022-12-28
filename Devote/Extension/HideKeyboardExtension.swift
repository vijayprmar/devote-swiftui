//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Vijay Parmar on 14/10/22.
//

import Foundation
import SwiftUI

#if canImport(UIKit)

extension View{
    
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}


#endif


