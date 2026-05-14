import Combine
import HealthKit
import LoopKit
import SwiftUI

enum CGMState {
    case warmingup
    case active
    case expired
}

class SettingsViewModel: ObservableObject {
    @Published var cgmState = CGMState.warmingup
    @Published var connected: Bool = false
    @Published var deviceName: String = ""
    @Published var lastMeasurement = HKQuantity(unit: .milligramsPerDeciliter, doubleValue: 0)
    @Published var lastMeasurementDatetime: String = ""
    @Published var nextCalibrationDate: String? = nil
    @Published var nextCalibrationTime: String = ""
    @Published var nextCalibrationTimeEnd: String = ""
    @Published var sensorStartedAtDate: String = ""
    @Published var sensorStartedAtTime: String = ""
    @Published var sensorEndsAtDate: String = ""
    @Published var sensorEndsAtTime: String = ""
    @Published var sensorAgeProcess: Double = 0
    @Published var sensorAgeDays: Double = 0
    @Published var sensorAgeHours: Double = 0
    @Published var sensorAgeMinutes: Double = 0
    @Published var sensorWarmupProgress: Double = 0
    @Published var sensorWarmupMinutes: Double = 0
    @Published var notifications: [NotificationContent] = []

    @Published var calibrationPhase: CalibrationPhase = .done

    @Published var isSharePresented = false
    @Published var showingDeleteConfirmation = false
    @Published var showingRepairConfirmation = false

    private let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    private let timeFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

    private let logger = AccuChekLogger(category: "SettingsViewModel")
    private let cgmManager: AccuChekCgmManager
    let doCalibration: () -> Void
    private let doPairing: () -> Void
    let deleteCGM: () -> Void
    init(
        _ cgmManager: AccuChekCgmManager,
        doCalibration: @escaping () -> Void,
        doPairing: @escaping () -> Void,
        deleteCGM: @escaping () -> Void
    ) {
        self.cgmManager = cgmManager
        self.doCalibration = doCalibration
        self.doPairing = doPairing
        self.deleteCGM = deleteCGM

        stateDidUpdate(cgmManager.state)
        cgmManager.addStateObserver(state: self, queue: DispatchQueue.main)
    }

    deinit {
        cgmManager.removeStateObserver(state: self)
    }

    func getLogs() -> [URL] {
        logger.info(cgmManager.state.debugDescription)
        return logger.getDebugLogs()
    }

    func pairNewCGM() {
        cgmManager.cleanup()
        doPairing()
    }
}

extension SettingsViewModel: StateObserver {
    func stateDidUpdate(_ state: AccuChekState) {
        connected = state.isConnected
        deviceName = state.deviceName ?? ""
        notifications = state.cgmStatus.compactMap(\.notification)
        calibrationPhase = state.calibrationPhase

        if let glucose = state.lastGlucoseValue {
            lastMeasurement = HKQuantity(unit: .milligramsPerDeciliter, doubleValue: Double(glucose))
        }

        if let date = state.lastGlucoseDate {
            lastMeasurementDatetime = timeFormatter.string(from: date)
        }

        if let nextCalibrationAt = state.nextCalibrationAt {
            nextCalibrationDate = dateFormatter.string(from: nextCalibrationAt)
            nextCalibrationTime = timeFormatter.string(from: nextCalibrationAt)
            nextCalibrationTimeEnd = timeFormatter.string(from: nextCalibrationAt.addingTimeInterval(.hours(2)))
        } else {
            nextCalibrationDate = nil
            nextCalibrationTime = ""
        }

        guard let cgmStartTime = state.cgmStartTime, let cgmEndTime = state.cgmEndTime else {
            return
        }

        let warmupEnd = cgmStartTime.addingTimeInterval(.hours(1))
        sensorStartedAtDate = dateFormatter.string(from: cgmStartTime)
        sensorStartedAtTime = timeFormatter.string(from: cgmStartTime)
        sensorEndsAtDate = dateFormatter.string(from: cgmEndTime)
        sensorEndsAtTime = timeFormatter.string(from: cgmEndTime)

        if cgmEndTime < Date.now {
            cgmState = .expired

        } else if warmupEnd > Date.now {
            let warmupAge = warmupEnd.timeIntervalSinceNow

            cgmState = .warmingup
            sensorWarmupProgress = min(cgmStartTime.timeIntervalSinceNow * -1 / .hours(1), 1)
            sensorWarmupMinutes = max(warmupAge / .minutes(1), 0)

        } else {
            cgmState = .active
            sensorAgeProcess = min(cgmStartTime.timeIntervalSinceNow * -1 / .days(14), 1)

            let sensorAge = cgmEndTime.timeIntervalSinceNow
            sensorAgeDays = max(floor(sensorAge / .days(1)), 0)
            sensorAgeHours = max(sensorAge.truncatingRemainder(dividingBy: .days(1)) / .hours(1), 0)
            sensorAgeMinutes = max(sensorAge.truncatingRemainder(dividingBy: .hours(1)) / .minutes(1), 0)
        }
    }
}
