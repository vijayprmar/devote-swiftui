//
//  ImageBackgroundView.swift
//  Devote
//
//  Created by Vijay Parmar on 18/10/22.
//

import SwiftUI

struct ImageBackgroundView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

struct ImageBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        ImageBackgroundView()
    }
}
