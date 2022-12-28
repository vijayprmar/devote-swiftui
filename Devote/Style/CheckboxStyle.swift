//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Vijay Parmar on 04/11/22.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration:Configuration)-> some View{
        return HStack{
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30,weight: .semibold,design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    playSound(sound: "sound-tap", type: "mp3")
                }
            configuration.label
        }//: Hstack
    }
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder label",isOn: .constant(false))
            .toggleStyle(CheckboxStyle())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
