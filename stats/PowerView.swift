import Foundation
import SwiftUI
import IOKit.ps
import IOKit.pwr_mgt
import IOKit.hid
import UniformTypeIdentifiers


struct PowerView: View {
    private var power:Power;
    private var cycles:NSString;
    private var timeToEmpty:hoursMinutes = (0,0);
    private let isCharging = false;
    private var short:Bool; //used to determine icon/menu presence
    private let pastboard = NSPasteboard.general;
    private var cyclesCmd = "system_profiler SPPowerDataType | grep \"Cycle Count\" | awk '{print $3}'";

    @State var sn:String = "";
    @StateObject var updaterViewModel:PowerViewUpdater;
    
    init(power: Power, short: Bool) {
        self.power = power;
        self.short = short;
        self.power.update();
        self.cycles = Utils().runCommand(cyclesCmd) as NSString;
        self._updaterViewModel = StateObject(wrappedValue: PowerViewUpdater(power));
    }
    
    var body: some View {
        VStack() {
            Button(action: {
            }, label: {
                timeRemainingRow
            })
            Button(action: {
            }, label: {
                cyclesRow
            })
            Button(action: {
            }, label: {
                healthRow
            })
            Button(action: {
                pastboard.clearContents();
                pastboard.setString(sn, forType: .string);
                notification("Stats", "Serial number has been copied to your clipboard");
            }, label: {
                serialNumberRow
            }).keyboardShortcut("C")
        }.padding()
    }
    
    var timeRemainingRow: some View {
        let isCharging = updaterViewModel.power.isCharging();
        let chargeLvl:Int = (updaterViewModel.power.getChargeLevel() as NSString).integerValue;
        var tteTtf = isCharging ?
        (updaterViewModel.power.getTimeToFull() as NSString).integerValue :
        (updaterViewModel.power.getTimeToEmpty() as NSString).integerValue;
        
        tteTtf = tteTtf == -1 ? 0 : tteTtf;
        let tte:hoursMinutes = minutesToHoursAndMinutes(tteTtf);
        
        let hLeft = tte.hours;
        let mLeft = tte.minutes;
        
        let eta: String = tteTtf <= 0 ? "" : hLeft > 0 ? "\(hLeft)h \(mLeft)m" : "\(mLeft)m"
        let total = "\(chargeLvl)% " + eta;
        
        let battIconFrac = chargeLvl == 100 ? 100 : chargeLvl >= 75 ? 75: chargeLvl >= 50 ? 50: chargeLvl >= 25 ? 25 : 0;
        
        let icon =
        isCharging ?
        Image(systemName: "bolt.fill").renderingMode(.template).foregroundStyle(.green, .green):
        Image(systemName: "battery.\(battIconFrac)percent").renderingMode(.template).foregroundStyle(.white, .white);
        
        let txt = (isCharging && !short ?
                   ("Charging" + (tteTtf > 0 ? ", \(eta) to full" : "")) :
                    "\(total) " + (tteTtf > 0 ? (!short ? isCharging ? "until full" : "until dead" : "") : ""))
        
        let barTxt = Text(txt)
        let label = Label(
            title: { barTxt },
            icon: { icon }
        )
        .labelStyle(.titleAndIcon)
        
        return label;
        //          // For font scaling in menu bar
        //          let renderer = ImageRenderer(content: label)
        //          let cgImage = renderer.cgImage
        //          return Image(cgImage!, scale: 1, label: Text("elo"))
    }
    
    var serialNumberRow: some View {
        return Label(
            title: { Text(sn) },
            icon: { Image(systemName: "barcode") }
        )
        .labelStyle(.titleAndIcon)
        .onAppear {
            sn = updaterViewModel.power.getSN() as String;
        }
    }
    
    var cyclesRow: some View {
        return Label(
            title: { Text("\(cycles)cycles") },
            icon: { Image(systemName: "arrow.clockwise") }
        )
        .labelStyle(.titleAndIcon)
    }
    
    var healthRow: some View {
        let health = updaterViewModel.power.getHealth() as NSString;
        
        return Label(
            title: { Text("\(health)% capacity") },
            icon: { Image(systemName: "heart") }
        )
        .labelStyle(.titleAndIcon)
    }
}
