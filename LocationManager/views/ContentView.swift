//
//  ContentView.swift
//  LocationManager
//
//  Created by นางสาวชลิศา ธรรมราช on 23/2/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await
                                WeatherManager.getCurrentWeather(latitude: location.latitude, longtitude: location.longitude)
                            } catch {
                                print("error getting weather", \(error))
                            }
                        }
                }
                Text("lat: \(location.latitude), long: \(location.longitude)")
            }
            else {
                if locationManager.isLoading {
                    LoadingView()
                }
                else{
                    WelcomeView()
                        .environmentObject(locationManager)
                    
                }
            }
        }
        .background(Color(hue: 0.755, saturation: 0.42, brightness: 0.642))
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
