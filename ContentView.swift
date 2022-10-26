import SwiftUI

struct ContentView: View {
    
    let tempOp = ["°C", "°F", "K"]
    
    @State private var tempInpSelected = "°C"
    @State private var tempOutSelected = "°F"
    @State private var value = ""
    @FocusState private var inputIsFocused: Bool
    
    var tempConverter: Double{
        guard let value = Double(value) else {
            return 0.0
        }  // Double(value) returns an optional
        
        if tempInpSelected == "°C" && tempOutSelected == "°F"{ // Celsius to Farenheit
            return (value * 9/5) + 32
        } else if tempInpSelected == "°F" && tempOutSelected == "°C"{ // Farenheit to Celsius
            return (value - 32) * 5/9
        } else if tempInpSelected == "°F" && tempOutSelected == "K"{  // Farenheit to Kelvin
            return (value - 32) * 5/9 + 273.15
        }  else if tempInpSelected == "°C" && tempOutSelected == "K"{  // Celsius to Kelvin
            return (value * 9/5) + 32
        } else if tempInpSelected == "K" && tempOutSelected == "°C"{  // Kelvin to Celsius
            return value - 273.15
        } else if tempInpSelected == "K" && tempOutSelected == "°F"{  // Kelvin to Farenheit
            return (value - 273.15) * 9/5 + 32
        }
        return 0.0
    }
    
    var body: some View {
        VStack{
            NavigationStack{
                Form{
                    Section{
                        Picker("Input Temp:", selection: $tempInpSelected){
                            ForEach(tempOp, id: \.self){
                                Text($0)
                            }
                        }
                    
                        Picker("Output Temp:", selection: $tempOutSelected){
                            ForEach(tempOp, id: \.self){
                                Text($0)
                            }
                        }
                    }
                    
                    Section{
                        TextField("Enter your value here", text: $value)
                            .keyboardType(.decimalPad)
                            .focused($inputIsFocused)
                    }
                    
                    Section{
                        Text("\(tempConverter.formatted()) \(tempOutSelected)")
                    } header: {
                        Text("\(tempInpSelected) to \(tempOutSelected):")
                    }
                }
                .navigationTitle("Tempture Converter")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItemGroup(placement: .keyboard){
                        Spacer()
                        Button("Done"){
                            inputIsFocused = false
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
