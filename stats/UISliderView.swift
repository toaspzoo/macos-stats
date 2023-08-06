import Foundation

struct UISliderView: UIViewRepresentable {
    @Binding var value: Double
    
    var minValue = 1.0
    var maxValue = 100.0
    var thumbColor: UIColor = .white
    var minTrackColor: UIColor = .blue
    var maxTrackColor: UIColor = .lightGray
    
    class Coordinator: NSObject {
        var value: Binding<Double>
        
        init(value: Binding<Double>) {
            self.value = value
        }
