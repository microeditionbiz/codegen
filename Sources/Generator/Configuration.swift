//
//  Configuration.swift
//  
//
//  Created by Pablo Ezequiel Romero Giovannoni on 30/08/2022.
//

import Foundation


public enum ViewModelType {
    case `struct`
    case `enum`
}

public struct MobilePresentationInterface {
    public let viewModelPrefixName: String
    public let viewModelType: ViewModelType
    public let updateValues: [String]
    public let actionValues: [String]
    public let scenePrefixName: String
    public let presenterPrefixName: String

    public init(viewModelPrefixName: String, viewModelType: ViewModelType, updateValues: [String], actionValues: [String], scenePrefixName: String, presenterPrefixName: String) {
        self.viewModelPrefixName = viewModelPrefixName
        self.viewModelType = viewModelType
        self.updateValues = updateValues
        self.actionValues = actionValues
        self.scenePrefixName = scenePrefixName
        self.presenterPrefixName = presenterPrefixName
    }
}

public struct Presentation {
    public let scenePrefixName: String
    public let presenterPrefixName: String

    public init(scenePrefixName: String, presenterPrefixName: String) {
        self.scenePrefixName = scenePrefixName
        self.presenterPrefixName = presenterPrefixName
    }
}

public struct MobileUI {
    public let observableObjectPrefixName: String
    public let viewPrefixName: String
    public let viewIncludesPreview: Bool

    public init(observableObjectPrefixName: String, viewPrefixName: String, viewIncludesPreview: Bool) {
        self.observableObjectPrefixName = observableObjectPrefixName
        self.viewPrefixName = viewPrefixName
        self.viewIncludesPreview = viewIncludesPreview
    }
}

public struct MobileUITestHarnes {
    public let fakePresenterPrefixName: String
    public let sceneConfigurationPrefixName: String

    public init(fakePresenterPrefixName: String, sceneConfigurationPrefixName: String) {
        self.fakePresenterPrefixName = fakePresenterPrefixName
        self.sceneConfigurationPrefixName = sceneConfigurationPrefixName
    }
}

public struct Configuration {
    public let basePrefixName: String
    public let servicesPrefixName: [String]
    public let mobilePresentationInterface: MobilePresentationInterface
    public let presentation: Presentation
    public let mobileUI: MobileUI
    public let mobileUITestHarnes: MobileUITestHarnes

    public init(basePrefixName: String, servicesPrefixName: [String], mobilePresentationInterface: MobilePresentationInterface, presentation: Presentation, mobileUI: MobileUI, mobileUITestHarnes: MobileUITestHarnes) {
        self.basePrefixName = basePrefixName
        self.servicesPrefixName = servicesPrefixName
        self.mobilePresentationInterface = mobilePresentationInterface
        self.presentation = presentation
        self.mobileUI = mobileUI
        self.mobileUITestHarnes = mobileUITestHarnes
    }
}
