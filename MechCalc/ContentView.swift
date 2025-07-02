import SwiftUI

struct ContentView: View {
    enum Equation: String, CaseIterable, Identifiable {
        case newton = "F = m × a"
        case torque = "τ = F × r"
        case pressure = "P = F / A"
        var id: String { rawValue }
    }

    @State private var equation: Equation = .newton

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Equation")) {
                    Picker("Equation", selection: $equation) {
                        ForEach(Equation.allCases) { eq in
                            Text(eq.rawValue).tag(eq)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Group {
                    if equation == .newton {
                        NewtonCalculatorView()
                    } else if equation == .torque {
                        TorqueCalculatorView()
                    } else {
                        PressureCalculatorView()
                    }
                }
            }
            .navigationTitle("Mechanical Calc")
        }
    }
}

// MARK: - Newton's Second Law
struct NewtonCalculatorView: View {
    enum SolveFor: String, CaseIterable, Identifiable {
        case force = "Force (N)"
        case mass = "Mass (kg)"
        case acceleration = "Acceleration (m/s²)"
        var id: String { rawValue }
    }

    @State private var solveFor: SolveFor = .force
    @State private var force: String = ""
    @State private var mass: String = ""
    @State private var acceleration: String = ""
    @State private var result: String = ""

    var body: some View {
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
                TextField("Acceleration (m/s²)", text: $acceleration)
                    .keyboardType(.decimalPad)
            }
        }
        Button("Calculate") { calculate() }
        if !result.isEmpty {
            Section(header: Text("Result")) { Text(result) }
        }
    }

    private func calculate() {
        switch solveFor {
        case .force:
            guard let m = Double(mass), let a = Double(acceleration) else {
                result = "Invalid input"
                return
            }
            result = String(format: "Force = %.2f N", m * a)
        case .mass:
            guard let f = Double(force), let a = Double(acceleration), a != 0 else {
                result = "Invalid input"
                return
            }
            result = String(format: "Mass = %.2f kg", f / a)
        case .acceleration:
            guard let f = Double(force), let m = Double(mass), m != 0 else {
                result = "Invalid input"
                return
            }
            result = String(format: "Acceleration = %.2f m/s²", f / m)
        }
    }
}

// MARK: - Torque
struct TorqueCalculatorView: View {
    enum SolveFor: String, CaseIterable, Identifiable {
        case torque = "Torque (Nm)"
        case force = "Force (N)"
        case radius = "Radius (m)"
        var id: String { rawValue }
    }

    @State private var solveFor: SolveFor = .torque
    @State private var torque: String = ""
    @State private var force: String = ""
    @State private var radius: String = ""
    @State private var result: String = ""

    var body: some View {
        Section(header: Text("Solve for")) {
            Picker("Variable", selection: $solveFor) {
                ForEach(SolveFor.allCases) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }

        Section(header: Text("Inputs")) {
            if solveFor != .torque {
                TextField("Torque (Nm)", text: $torque)
                    .keyboardType(.decimalPad)
            }
            if solveFor != .force {
                TextField("Force (N)", text: $force)
                    .keyboardType(.decimalPad)
            }
            if solveFor != .radius {
                TextField("Radius (m)", text: $radius)
                    .keyboardType(.decimalPad)
            }
        }
        Button("Calculate") { calculate() }
        if !result.isEmpty {
            Section(header: Text("Result")) { Text(result) }
        }
    }

    private func calculate() {
        switch solveFor {
        case .torque:
            guard let f = Double(force), let r = Double(radius) else {
                result = "Invalid input"
                return
            }
            result = String(format: "Torque = %.2f Nm", f * r)
        case .force:
            guard let t = Double(torque), let r = Double(radius), r != 0 else {
                result = "Invalid input"
                return
            }
            result = String(format: "Force = %.2f N", t / r)
        case .radius:
            guard let t = Double(torque), let f = Double(force), f != 0 else {
                result = "Invalid input"
                return
            }
            result = String(format: "Radius = %.2f m", t / f)
        }
    }
}

// MARK: - Pressure
struct PressureCalculatorView: View {
    enum SolveFor: String, CaseIterable, Identifiable {
        case pressure = "Pressure (Pa)"
        case force = "Force (N)"
        case area = "Area (m²)"
        var id: String { rawValue }
    }

    @State private var solveFor: SolveFor = .pressure
    @State private var pressure: String = ""
    @State private var force: String = ""
    @State private var area: String = ""
    @State private var result: String = ""

    var body: some View {
        Section(header: Text("Solve for")) {
            Picker("Variable", selection: $solveFor) {
                ForEach(SolveFor.allCases) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }

        Section(header: Text("Inputs")) {
            if solveFor != .pressure {
                TextField("Pressure (Pa)", text: $pressure)
                    .keyboardType(.decimalPad)
            }
            if solveFor != .force {
                TextField("Force (N)", text: $force)
                    .keyboardType(.decimalPad)
            }
            if solveFor != .area {
                TextField("Area (m²)", text: $area)
                    .keyboardType(.decimalPad)
            }
        }
        Button("Calculate") { calculate() }
        if !result.isEmpty {
            Section(header: Text("Result")) { Text(result) }
        }
    }

    private func calculate() {
        switch solveFor {
        case .pressure:
            guard let f = Double(force), let a = Double(area), a != 0 else {
                result = "Invalid input"
                return
            }
            result = String(format: "Pressure = %.2f Pa", f / a)
        case .force:
            guard let p = Double(pressure), let a = Double(area) else {
                result = "Invalid input"
                return
            }
            result = String(format: "Force = %.2f N", p * a)
        case .area:
            guard let f = Double(force), let p = Double(pressure), p != 0 else {
                result = "Invalid input"
                return
            }
            result = String(format: "Area = %.2f m²", f / p)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
