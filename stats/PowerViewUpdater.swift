import Foundation


class PowerViewUpdater: ObservableObject {
    @Published var power: Power;
    var timer: Timer?
    
    init(_ power:Power) {
        self.power = power;
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            power.update();
            self.objectWillChange.send();
        });
    }
    
    deinit {
        timer?.invalidate()
    }
}
