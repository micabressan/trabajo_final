#include <iostream>
#include <Poco/URI.h>
#include <Poco/Net/HTTPRequest.h>
#include <Poco/Net/HTTPSClientSession.h>
#include <Poco/Net/HTTPResponse.h>
#include <Poco/StreamCopier.h>
#include <Poco/Net/SSLManager.h>
#include <Poco/Net/AcceptCertificateHandler.h>

#include <sstream>

void get() {
    Poco::URI uri("https://api.telegram.org/bot342920362:AAGjyCFpFB1nl_UC5ZiRwmiS7HLIKNNsHLg/getUpdates");

    Poco::Net::HTTPSClientSession session(uri.getHost(), uri.getPort());

    std::string path(uri.getPathAndQuery());
    if (path.empty()) path = "/";


    Poco::Net::HTTPRequest req(Poco::Net::HTTPRequest::HTTP_GET, path, Poco::Net::HTTPMessage::HTTP_1_1);

    session.sendRequest(req);

    Poco::Net::HTTPResponse res;

    std::istream &is = session.receiveResponse(res);
    res.write(std::cout);
    std::cout << res.getStatus() << " " << res.getReason() << std::endl;
    Poco::StreamCopier::copyStream(is, std::cout);
}


void post(){

    Poco::URI uri("https://api.telegram.org/bot342920362:AAGjyCFpFB1nl_UC5ZiRwmiS7HLIKNNsHLg/sendSticker");
    Poco::Net::HTTPSClientSession session(uri.getHost(), uri.getPort());

    // prepare path
    std::string path(uri.getPathAndQuery());
    if (path.empty()) path = "/";

    // send request
    Poco::Net::HTTPRequest req(Poco::Net::HTTPRequest::HTTP_POST, path, Poco::Net::HTTPMessage::HTTP_1_1);

    std::string test = "{\"chat_id\": 402292993, \"sticker\": \"CAADAgADnAAD0MeAAySZq2t1_sSyAg\"}";

    req.setContentType("application/json");
    req.setKeepAlive(true);
    req.setContentLength( test.length() );

    session.sendRequest(req) << test;


    // get response
    Poco::Net::HTTPResponse res;
    std::cout << res.getStatus() << " " << res.getReason() << std::endl;

    std::istream &is = session.receiveResponse(res);
    std::stringstream ss;
    Poco::StreamCopier::copyStream(is, std::cout);


}

int main(int argc, char* argv[]) {

    post();
    return 0;
}