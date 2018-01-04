import vibe.d;
import vibe.db.postgresql;

void main() {
    listenHTTP(":8080", &hello);

    runApplication();
}

void hello(HTTPServerRequest request, HTTPServerResponse response) {
    shared PostgresClient client = new shared PostgresClient("host=localhost dbname=varna user=varna password=varna", 4);
    Answer result;
    {
        auto conn = client.lockConnection();
        result = conn.execStatement("SELECT 2 + 2 AS four", ValueFormat.BINARY);
    }

    logInfo("Result: %d", result[0]["four"].as!PGinteger);

    response.writeBody("Hello, World: " ~ request.path);
}