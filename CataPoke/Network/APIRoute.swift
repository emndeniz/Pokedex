import Foundation

/// Enum that encodes the endpoints of the poke-api, required for the assignment. Can be fed into the RequestHandler.
///
/// It makes sure you don't have to worry too much about writing down the requests, and instead focus on the request manager.
/// In the RequestManager, simply use `APIRoute.asRequest()` to get the URLRequest to perform.
enum APIRoute {
    case getSpeciesList(limit: Int, offset: Int)
    case getSpecies(URL)
    case getEvolutionChain(URL)
    case getPokemonDetails(id:Int)

    private var baseURLString: String { "https://pokeapi.co/api/v2/" }

    private var url: URL? {
        switch self {
        case .getSpecies(let url),
             .getEvolutionChain(let url):
            return url
        case .getSpeciesList:
            return URL(string: baseURLString + "pokemon-species")
        case .getPokemonDetails(id: let id):
            return URL(string: baseURLString + "pokemon/\(id)")
        }
    }

    private var parameters: [URLQueryItem] {
        switch self {
        case .getSpeciesList(let limit, let offset):
            return [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "offset", value: String(offset))
            ]
        default:
            return []
        }
    }

    func asRequest() -> URLRequest? {
        guard let url = url else {
            Logger.log.error("Missing URL for route: \(self)")
            return nil
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters

        guard let parametrizedURL = components?.url else {
            Logger.log.error("Missing URL with parameters for url: \(url)")
            return nil
        }

        return URLRequest(url: parametrizedURL)
    }
}
