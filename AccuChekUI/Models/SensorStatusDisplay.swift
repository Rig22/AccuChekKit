enum SensorStatusSeverity {
    case neutral
    case good
    case warning
    case critical
}

enum SensorStatusDisplay: CaseIterable, Hashable {
    case connecting
    case expired
    case malfunction
    case readingsUnavailable
    case batteryLow
    case temperature
    case trendMode(calibrationDue: Bool)
    case therapyMode(calibrationDue: Bool)
    case ok

    static var allCases: [SensorStatusDisplay] {
        [
            .connecting, .expired, .malfunction, .readingsUnavailable, .batteryLow, .temperature,
            .trendMode(calibrationDue: false), .trendMode(calibrationDue: true),
            .therapyMode(calibrationDue: false), .therapyMode(calibrationDue: true),
            .ok
        ]
    }

    var severity: SensorStatusSeverity {
        switch self {
        case .connecting,
             .trendMode(calibrationDue: false): return .neutral
        case .ok: return .good
        case .temperature,
             .therapyMode(calibrationDue: false),
             .trendMode(calibrationDue: true): return .warning
        case .batteryLow,
             .expired,
             .malfunction,
             .readingsUnavailable,
             .therapyMode(calibrationDue: true): return .critical
        }
    }

    var showsCalibrationButton: Bool {
        switch self {
        case .therapyMode(calibrationDue: true),
             .trendMode(calibrationDue: true): return true
        default: return false
        }
    }
}
