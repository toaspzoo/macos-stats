import SwiftUI
import IOKit

@main
struct statsApp: App {
    @State var visible = true;
    @State var cpuTemp: Int32 = 55;
    @State var tteVisible: Bool = true;
    @State var currentNumber: Bool = true;
    @State private var speed = 50.0
    @State private var isEditing = false;
    
    var body: some Scene {
        let _ = NSApplication.shared.setActivationPolicy(.prohibited)
        let power = Power();
        
        MenuBarExtra(isInserted: $visible, content: {
            PowerView(power: power, short: false)
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("Q")
        }) {
            PowerView(power: power, short: true);
        }.menuBarExtraStyle(.menu)
    }
}
