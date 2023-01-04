//
//  ImageLogo.swift
//  WeatherApp
//
//  Created by Kanishk Vijaywargiya on 04/01/23.
//

import SwiftUI

struct ImageLogo: View {
    var logo: String
    var action: () -> ()
    var body: some View {
        Image(systemName: logo)
            .font(.title2)
            .frame(width: 20, height: 20)
            .padding()
            .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
            .cornerRadius(50)
            .onTapGesture { action() }
            .foregroundColor(.black)
            .overlay {
                Circle().strokeBorder(Color.white, lineWidth: 1)
            }
    }
}

struct ImageLogo_Previews: PreviewProvider {
    static var previews: some View {
        ImageLogo(logo: "location.fill", action: {})
    }
}
