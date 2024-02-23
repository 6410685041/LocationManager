//
//  LoadingView.swift
//  LocationManager
//
//  Created by นางสาวชลิศา ธรรมราช on 23/2/2567 BE.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity) // max screen
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
