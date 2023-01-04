//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by Kanishk Vijaywargiya on 04/01/23.
//

import SwiftUI

struct WeatherRow: View {
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack (spacing: 20) {
            ImageLogo(logo: logo, action: {})
            
            VStack (alignment: .leading, spacing: 8) {
                Text(name).font(.caption)
                
                Text(value).font(.title.bold())
            }
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8°C")
    }
}
