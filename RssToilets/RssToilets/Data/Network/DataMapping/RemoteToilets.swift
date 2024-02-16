//
//  ToiletsResponseDTO.swift
//  RssToilets
//
//  Created by Ha Kevin on 16/02/2024.
//

import Foundation

// MARK: - RemoteToilets
struct RemoteToilets: Decodable {
    let nhits: Int
    let parameters: RemoteParameters
    let records: [RemoteRecord]
}

// MARK: - RemoteParameters
struct RemoteParameters: Decodable {
    let dataset: RemoteDataset
    let rows, start: Int
    let format, timezone: String
}

enum RemoteDataset: String, Codable {
    case sanisettesparis2011 = "sanisettesparis2011"
}

// MARK: - RemoteRecord
struct RemoteRecord: Decodable {
    let datasetid: String
    let recordid: String
    let fields: RemoteToilet
    let geometry: RemoteGeometry
    let recordTimestamp: RemoteRecordTimestamp

    enum CodingKeys: String, CodingKey {
        case datasetid, recordid, fields, geometry
        case recordTimestamp = "record_timestamp"
    }
}

// MARK: - RemoteToilet
struct RemoteToilet: Decodable {
    let complementAdresse: RemoteComplementAdresse
    let geoShape: RemoteGeoShape
    let horaire: RemoteHoraire?
    let accesPmr: RemoteAccesPmr?
    let arrondissement: Int?
    let geoPoint2D: [Double]
    let source: String
    let gestionnaire: RemoteGestionnaire
    let adresse: String?
    let type: RemoteFieldsType
    let urlFicheEquipement: String?
    let relaisBebe: RemoteAccesPmr?

    enum CodingKeys: String, CodingKey {
        case complementAdresse = "complement_adresse"
        case geoShape = "geo_shape"
        case horaire
        case accesPmr = "acces_pmr"
        case arrondissement
        case geoPoint2D = "geo_point_2d"
        case source, gestionnaire, adresse, type
        case urlFicheEquipement = "url_fiche_equipement"
        case relaisBebe = "relais_bebe"
    }
}

enum RemoteAccesPmr: String, Decodable {
    case non = "Non"
    case oui = "Oui"

    var boolean: Bool {
        switch self {
        case .non: return false
        case .oui: return true
        }
    }
}

enum RemoteComplementAdresse: String, Decodable {
    case numeroDeVoieNomDeVoie = "numero_de_voie nom_de_voie"
}

// MARK: - GeoShape
struct RemoteGeoShape: Decodable {
    let coordinates: [[Double]]
    let type: RemoteGeoShapeType
}

enum RemoteGeoShapeType: String, Decodable {
    case multiPoint = "MultiPoint"
}

enum RemoteGestionnaire: String, Decodable {
    case toilettePubliqueDeLaVilleDeParis = "Toilette publique de la Ville de Paris"
}

enum RemoteHoraire: String, Decodable {
    case the10H18H = "10h/18h"
    case the10HA22H = "10h à 22h"
    case the19H7H = "19 h - 7 h"
    case the24H24 = "24 h / 24"
    case the6H1H = "6 h - 1 h"
    case the6H22H = "6 h - 22 h"
    case voirFicheÉquipement = "Voir fiche équipement"
}

enum RemoteFieldsType: String, Decodable {
    case lavatory = "LAVATORY"
    case sanisette = "SANISETTE"
    case toilettes = "TOILETTES"
    case urinoir = "URINOIR"
    case urinoirFemme = "URINOIR FEMME"
    case wcPublicsPermanents = "WC PUBLICS PERMANENTS"
}

// MARK: - Geometry
struct RemoteGeometry: Decodable {
    let type: RemoteGeometryType
    let coordinates: [Double]
}

enum RemoteGeometryType: String, Decodable {
    case point = "Point"
}

enum RemoteRecordTimestamp: String, Codable {
    case the20240204T051200494Z = "2024-02-04T05:12:00.494Z"
}
