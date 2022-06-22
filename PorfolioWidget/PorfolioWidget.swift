//
//  PorfolioWidget.swift
//  PorfolioWidget
//
//  Created by Bouchedoub Rmazi on 21/6/2022.
//

import WidgetKit
import SwiftUI
import Intents




struct PorfolioWidgetEntryView : View {
    //@EnvironmentObject private var vm : HomeViewModel
    

    var body: some View {
        Text("Profolio WidgetEntryView")
    }
}



struct PorfolioWidget_Previews: PreviewProvider {
    static var previews: some View {
        PorfolioWidgetEntryView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
