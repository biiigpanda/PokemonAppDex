//
//  NetworkUtils.swift
//  PokemonAppDex
//
//  Created by Marc Gallardo on 12/1/25.
//

import Foundation

class NetworkUtils {
    static let shared = NetworkUtils()
    
    func fetch<T: Codable>(from url: URL) async throws -> T {
        /*  T: Codable: Indica que el tipo genérico T debe conformar al protocolo Codable. Esto asegura que los datos recibidos puedan decodificarse automáticamente desde formato JSON (u otros formatos soportados por Codable).
         async: La función es asíncrona, lo que significa que se puede usar con await y no bloqueará el hilo en el que se ejecuta.
         throws: Declara que la función puede lanzar errores que deben ser manejados por el llamador mediante do-catch o propagándolos con throws. */
        
        var request = URLRequest(url: url)
        request.timeoutInterval = Constants.pokeApiTimeoutInterval
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        /*Usa URLSession.shared.data(for:) para realizar la solicitud de red. Este método devuelve una tupla:
         data: Los datos recibidos del servidor (probablemente en formato JSON).
         response: La respuesta HTTP asociada (por ejemplo, códigos de estado como 200, 404, etc.).
         await asegura que la función espere a que la solicitud se complete sin bloquear el hilo actual.
         try lanza un error si la solicitud falla.*/
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        /* response as? HTTPURLResponse: Verifica que la respuesta sea una instancia de HTTPURLResponse, que contiene información específica del protocolo HTTP (como el código de estado).
         200..<300 ~= httpResponse.statusCode: Comprueba si el código de estado de la respuesta está en el rango 200-299 (lo que indica éxito). Si no es así, lanza un error URLError(.badServerResponse).*/
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        
        /* Usa un JSONDecoder para decodificar los datos en un objeto del tipo T.
         T.self: Se refiere al tipo genérico T en tiempo de ejecución.
         Si los datos no coinciden con la estructura del tipo T esperado, se lanza un error de decodificación.*/
        
        return decodedData
    }
}
