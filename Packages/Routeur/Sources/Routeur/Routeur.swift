import Foundation
import SwiftUI
import Models

public enum RouteurDestinations: Hashable {
  case accountDetail(id: String)
  case accountDetailWithAccount(account: Account)
  case statusDetail(id: String)
}

public enum SheetDestinations: Identifiable {
  public var id: String {
    switch self {
    case .imageDetail:
      return "imageDetail"
    }
  }
  
  case imageDetail(url: URL)
}

public class RouterPath: ObservableObject {
  @Published public var path: [RouteurDestinations] = []
  @Published public var presentedSheet: SheetDestinations?
  
  public init() {}
  
  public func navigate(to: RouteurDestinations) {
    path.append(to)
  }
  
  public func handleStatus(status: AnyStatus, url: URL) -> OpenURLAction.Result {
    if let mention = status.mentions.first(where: { $0.url == url }) {
      navigate(to: .accountDetail(id: mention.id))
      return .handled
    }
    return .systemAction
  }
}
