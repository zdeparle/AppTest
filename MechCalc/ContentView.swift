import SwiftUI

struct ContentView: View {
    enum SolveFor: String, CaseIterable, Identifiable {
        case force = "Force (F)"
        case mass = "Mass (m)"
        case acceleration = "Acceleration (a)"
        var id: String { self.rawValue }
    }

    @State private var solveFor: SolveFor = .force
    @State private var force: String = ""
    @State private var mass: String = ""
    @State private var acceleration: String = ""
    @State private var result: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Solve for")) {
                    Picker("Variable", selection: $solveFor) {
                        ForEach(SolveFor.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Inputs")) {
                    if solveFor != .force {
                        TextField("Force (N)", text: $force)
                            .keyboardType(.decimalPad)
                    }
                    if solveFor != .mass {
                        TextField("Mass (kg)", text: $mass)
                            .keyboardType(.decimalPad)
                    }
                    if solveFor != .acceleration {
                        TextField("Acceleration (m/s^2)", text: $acceleration)
                            .keyboardType(.decimalPad)
                    }
                }

                Button("Calculate") {
                    calculate()
                }
                if !result.isEmpty {
                    Section(header: Text("Result")) {
                        Text(result)
                    }
                }
            }
            .navigationTitle("Mechanical Calc")
        }
    }

    func calculate() {
        switch solveFor {
        case .force:
            guard let m = Double(mass), let a = Double(acceleration) else {
                result = "Invalid input"
                return
            }
            let f = m * a
            result = String(format: "Force = %.2f N", f)
        case .mass:
            guard let f = Double(force), let a = Double(acceleration), a != 0 else {
                result = "Invalid input"
                return
            }
            let m = f / a
            result = String(format: "Mass = %.2f kg", m)
        case .acceleration:
            guard let f = Double(force), let m = Double(mass), m != 0 else {
                result = "Invalid input"
                return
            }
            let a = f / m
            result = String(format: "Acceleration = %.2f m/s^2", a)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
