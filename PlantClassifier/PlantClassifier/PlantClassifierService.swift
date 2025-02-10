import Foundation
import Vision
import CoreML
import SwiftUI

public class PlantClassifierService: ObservableObject {
    @Published var selectedImage: UIImage? = nil

    private let initialModel = try? PlantClassifierModel(configuration: MLModelConfiguration())
    private var vnCoreMLModel: VNCoreMLModel?
    private var request: VNCoreMLRequest?


    init() {
        guard let initialModel = initialModel else { return }
        vnCoreMLModel = try? VNCoreMLModel(for: initialModel.model)
        request = VNCoreMLRequest(model: vnCoreMLModel!, completionHandler: response)
    }

    func tryImage() {
        guard let image = selectedImage else { return }

        let handler = VNImageRequestHandler(cgImage: image.cgImage!)
        try? handler.perform([request!])
    }

    func response(request: VNRequest, error: Error?) {
        guard error == nil else {
            print("Error")
            return
        }

        guard var observations = request.results as? [VNClassificationObservation] else {
            print("Error")
            return
        }

        observations.forEach { print("id: \($0.identifier) : \($0.confidence)") }
    }
}
