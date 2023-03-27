import SwiftUI
import SceneKit
import ARKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}


struct ARViewContainer: UIViewRepresentable {
    @State private var currentAngle: Float = 0
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        let scene = SCNScene(named: "Earth.usdz")!
        let earthNode = scene.rootNode.childNodes.first!
        earthNode.position = SCNVector3(0, 0, -300) // 移动到相机前方
        
        sceneView.contentMode = .scaleAspectFit
        sceneView.scene = scene
        sceneView.allowsCameraControl = true

        sceneView.backgroundColor = UIColor.white
        
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
    
    typealias UIViewType = SCNView
    
    
    func panGesture(_ recognizer: UIPanGestureRecognizer) {
        // Get the translation of the gesture
        let translation = recognizer.translation(in: recognizer.view)
            
        // Convert the translation to a rotation angle
        let rotationAngle = Float(translation.x) * (-5)
            
        // Update the current rotation angle
        currentAngle += rotationAngle
            
        // Reset the translation to zero to prevent cumulative rotation
        recognizer.setTranslation(.zero, in: recognizer.view)
    }

    
    
}


struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
