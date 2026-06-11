import Foundation

struct SensorInfo: RawRepresentable, Equatable {
    public typealias RawValue = [String: String]

    let manufacturer: String
    let model: String
    let serialNumber: String
    let firmwareRevision: String
    let hardwareRevision: String
    let softwareRevision: String

    init(
        manufacturer: String,
        model: String,
        serialNumber: String,
        firmwareRevision: String,
        hardwareRevision: String,
        softwareRevision: String
    ) {
        self.manufacturer = manufacturer
        self.model = model
        self.serialNumber = serialNumber
        self.firmwareRevision = firmwareRevision
        self.hardwareRevision = hardwareRevision
        self.softwareRevision = softwareRevision
    }

    init?(rawValue: [String: String]) {
        guard
            let manufacturer = rawValue["manufacturer"],
            let model = rawValue["model"],
            let serialNumber = rawValue["serialNumber"],
            let firmwareRevision = rawValue["firmwareRevision"],
            let hardwareRevision = rawValue["hardwareRevision"],
            let softwareRevision = rawValue["softwareRevision"]
        else {
            return nil
        }

        self.manufacturer = manufacturer
        self.model = model
        self.serialNumber = serialNumber
        self.firmwareRevision = firmwareRevision
        self.hardwareRevision = hardwareRevision
        self.softwareRevision = softwareRevision
    }

    var rawValue: [String: String] {
        var raw: [String: String] = [:]
        raw["manufacturer"] = manufacturer
        raw["model"] = model
        raw["serialNumber"] = serialNumber
        raw["firmwareRevision"] = firmwareRevision
        raw["hardwareRevision"] = hardwareRevision
        raw["softwareRevision"] = softwareRevision

        return raw
    }

    var describe: String {
        "[SensorInfo] manufacturer: \(manufacturer), model: \(model), serialNumber: \(serialNumber), firmwareRevision: \(firmwareRevision), hardwareRevision: \(hardwareRevision), softwareRevision: \(softwareRevision)"
    }
}
