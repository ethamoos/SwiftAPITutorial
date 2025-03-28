//
//  ComputerDetailed.swift
//  JamfList
//
//  Created by Amos Deane on 28/03/2025.
//




import Foundation

// MARK: - ComputerDetailedResponse
struct ComputerDetailedResponse: Codable {
    let computer: ComputerDetailed
}

// MARK: - ComputerDetailed
struct ComputerDetailed: JamfObject, Hashable  {
    
    var id: String
    
    static var getAllEndpoint = "/JSSResource/computers/id/"
    
    //}
    //
//    let general: General
    ////    let location: Location
    //    let purchasing: Purchasing
    //    let peripherals: Iphones
    //    let hardware: Hardware
    //    let certificates: Certificates
    //    let security: Security
    //    let software: Software
    //    let extensionAttributes: ExtensionAttributes
    //    let groupsAccounts: GroupsAccounts
    //    let iphones: Iphones
    //    let configurationProfiles: ConfigurationProfiles
    //    }
    //
    
    // MARK: - General
    struct General {
        let id, name, networkAdapterType, macAddress: String
        //        let altNetworkAdapterType, altMACAddress, ipAddress, lastReportedIP: String
        //        let serialNumber, udid, jamfVersion, platform: String
        //        let barcode1, barcode2, assetTag: String
        //        //    let remoteManagement: RemoteManagement
        //        let supervised, mdmCapable: String
        //        //    let mdmCapableUsers: MdmCapableUsers
        //        //    let managementStatus: ManagementStatus
        //        let reportDate, reportDateEpoch, reportDateUTC, lastContactTime: String
        //        let lastContactTimeEpoch, lastContactTimeUTC, initialEntryDate, initialEntryDateEpoch: String
        //        let initialEntryDateUTC, lastCloudBackupDateEpoch, lastCloudBackupDateUTC, lastEnrolledDateEpoch: String
        //        let lastEnrolledDateUTC, mdmProfileExpirationEpoch, mdmProfileExpirationUTC, distributionPoint: String
        //        let sus: String
        //        //    let site: Site
        //        let itunesStoreAccountIsActive: String
    }
}




    //// MARK: - Certificates
    //struct Certificates {
    //    let certificate: [Certificate]
    //}
    //
    //// MARK: - Certificate
    //struct Certificate {
    //    let commonName, identity, expiresUTC, expiresEpoch: String
    //    let name: Name
    //}
    //
    //enum Name {
    //    case adeane
    //    case empty
    //}
    //
    //// MARK: - ConfigurationProfiles
    //struct ConfigurationProfiles {
    //    let size: String
    //    let configurationProfile: [ConfigurationProfile]
    //}
    //
    //// MARK: - ConfigurationProfile
    //struct ConfigurationProfile {
    //    let id: String
    //    let name: Name
    //    let uuid: String
    //    let isRemovable: UserApprovedMdm
    //}
    //
    //// MARK: - UserApprovedMdm
    //struct UserApprovedMdm {
    //    let since: Since
    //    let text: String
    //}
    //
    //enum Since {
    //    case the1040
    //    case the973
    //}
    //
    //// MARK: - ExtensionAttributes
    //struct ExtensionAttributes {
    //    let extensionAttribute: [ExtensionAttribute]
    //}
    //
    //// MARK: - ExtensionAttribute
    //struct ExtensionAttribute {
    //    let id, name: String
    //    let type: ExtensionAttributeType
    //    let multiValue: String
    //    let value: String
    //}
    //
    //enum ExtensionAttributeType {
    //    case date
    //    case number
    //    case string
    //}
    //
 

//}
//// MARK: - ManagementStatus
//struct ManagementStatus {
//    let enrolledViaDep: String
//    let userApprovedEnrollment: UserApprovedEnrollment
//    let userApprovedMdm: UserApprovedMdm
//}
//
//// MARK: - UserApprovedEnrollment
//struct UserApprovedEnrollment {
//    let deprecated, text: String
//}
//
//// MARK: - MdmCapableUsers
//struct MdmCapableUsers {
//    let mdmCapableUser: [String]
//}
//
//// MARK: - RemoteManagement
//struct RemoteManagement {
//    let managed: String
//    let managementUsername, managementPasswordSha256: UserApprovedEnrollment
//}
//
//// MARK: - Site
//struct Site {
//    let id, name: String
//}
//
//// MARK: - GroupsAccounts
//struct GroupsAccounts {
//    let computerGroupMemberships: ComputerGroupMemberships
//    let localAccounts: LocalAccounts
//    let userInventories: UserInventories
//}
//
//// MARK: - ComputerGroupMemberships
//struct ComputerGroupMemberships {
//    let group: [String]
//}
//
//// MARK: - LocalAccounts
//struct LocalAccounts {
//    let user: [LocalAccountsUser]
//}
//
//// MARK: - LocalAccountsUser
//struct LocalAccountsUser {
//    let name, realname, uid, home: String
//    let homeSize: HomeSize
//    let homeSizeMB, administrator, filevaultEnabled: String
//}
//
//enum HomeSize {
//    case the1MB
//}
//
//// MARK: - UserInventories
//struct UserInventories {
//    let disableAutomaticLogin: String
//    let user: [UserInventoriesUser]
//}
//
//// MARK: - UserInventoriesUser
//struct UserInventoriesUser {
//    let username, passwordHistoryDepth, passwordMinLength, passwordMaxAge: String
//    let passwordMinComplexCharacters, passwordRequireAlphanumeric: String
//}
//
//// MARK: - Hardware
//struct Hardware {
//    let make, model, modelIdentifier, osName: String
//    let osVersion, osBuild, softwareUpdateDeviceID, activeDirectoryStatus: String
//    let servicePack, processorType, isAppleSilicon, processorArchitecture: String
//    let processorSpeed, processorSpeedMhz, numberProcessors, numberCores: String
//    let totalRAM, totalRAMMB, bootROM, busSpeed: String
//    let busSpeedMhz, batteryCapacity, cacheSize, cacheSizeKB: String
//    let availableRAMSlots, opticalDrive, nicSpeed, smcVersion: String
//    let bleCapable, supportsIosAppInstalls, sipStatus, gatekeeperStatus: String
//    let xprotectVersion, institutionalRecoveryKey, diskEncryptionConfiguration: String
//    let filevault2Users: Filevault2Users
//    let storage: Storage
//    let mappedPrinters: String
//}
//
//// MARK: - Filevault2Users
//struct Filevault2Users {
//    let user: [String]
//}
//
//// MARK: - Storage
//struct Storage {
//    let device: [Device]
//}
//
//// MARK: - Device
//struct Device {
//    let disk, model, revision, serialNumber: String
//    let size, driveCapacityMB, connectionType, smartStatus: String
//    let partitions: Partitions
//}
//
//// MARK: - Partitions
//struct Partitions {
//    let partition: PartitionUnion
//}
//
//enum PartitionUnion {
//    case partitionElementArray([PartitionElement])
//    case purplePartition(PurplePartition)
//}
//
//// MARK: - PartitionElement
//struct PartitionElement {
//    let name, size: String
//    let type: PartitionType
//    let partitionCapacityMB, percentageFull, availableMB: String
//    let filevaultStatus: FilevaultStatus
//    let filevaultPercent: String
//    let filevault2Status: FilevaultStatus
//    let filevault2Percent: String
//    let bootDriveAvailableMB, lvgUUID, lvUUID, pvUUID: String?
//}
//
//enum FilevaultStatus {
//    case notEncrypted
//}
//
//enum PartitionType {
//    case boot
//    case other
//}
//
//// MARK: - PurplePartition
//struct PurplePartition {
//    let name, size: String
//    let type: PartitionType
//    let partitionCapacityMB, percentageFull, availableMB: String
//    let filevaultStatus: FilevaultStatus
//    let filevaultPercent: String
//    let filevault2Status: FilevaultStatus
//    let filevault2Percent: String
//}
//
//// MARK: - Iphones
//struct Iphones {
//    let size: String
//}
//
//// MARK: - Location
//struct Location {
//    let username: Name
//    let realname, realName, emailAddress, position: String
//    let phone, phoneNumber, department, building: String
//    let room: String
//}
//
//// MARK: - Purchasing
//struct Purchasing {
//    let isPurchased, isLeased, poNumber, vendor: String
//    let applecareID, purchasePrice, purchasingAccount, poDate: String
//    let poDateEpoch, poDateUTC, warrantyExpires, warrantyExpiresEpoch: String
//    let warrantyExpiresUTC, leaseExpires, leaseExpiresEpoch, leaseExpiresUTC: String
//    let lifeExpectancy, purchasingContact, osApplecareID, osMaintenanceExpires: String
//    let attachments: String
//}
//
//// MARK: - Security
//struct Security {
//    let activationLock, recoveryLockEnabled, secureBootLevel, externalBootLevel: String
//    let firewallEnabled: String
//}
//
//// MARK: - Software
//struct Software {
//    let unixExecutables, licensedSoftware: String
//    let installedByCasper, installedByInstallerSwu: InstalledBy
//    let cachedByCasper: CachedByCasper
//    let availableSoftwareUpdates, availableUpdates, runningServices: String
//    let applications: Applications
//    let fonts, plugins: Iphones
//}
//
//// MARK: - Applications
//struct Applications {
//    let size: String
//    let application: [Application]
//}
//
//// MARK: - Application
//struct Application {
//    let name, path, version, bundleID: String
//}
//
//// MARK: - CachedByCasper
//struct CachedByCasper {
//    let package: String
//}
//
//// MARK: - InstalledBy
//struct InstalledBy {
//    let package: [String]
//}
//
//
//
//
//
