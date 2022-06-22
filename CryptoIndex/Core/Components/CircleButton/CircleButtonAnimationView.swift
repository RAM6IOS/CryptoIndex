//
//  CircleButtonAnimationView.swift
//  CryptoIndex
//
//  Created by Bouchedoub Rmazi on 10/5/2022.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var amiate : Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(amiate ? 1.0 : 0.0)
            .opacity(amiate ? 0.0 :1.0)
            .animation(amiate ? Animation.easeOut(duration: 1.0) : .none, value: amiate)
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(amiate: .constant(false))
            .foregroundColor(.red)
            .frame(width: 300, height: 300)
    }
}
