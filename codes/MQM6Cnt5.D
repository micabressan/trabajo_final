ubyte[] encryptRsa(ubyte[] data, ubyte[] crtData) {
    import flow.core.error : CryptoException;
    import std.conv : to;

    RSA* crt = this.loadCrt(crtData);
    scope(exit) RSA_free(crt);
    if(crt !is null) {
        auto bs = RSA_size(crt);
        auto ds = data.length;
        auto cnt = ds%bs==0 ? ds/bs : (ds/bs)+1;

        ubyte[] crypt = new ubyte[bs*cnt];
        for(size_t i; i < cnt; i++) {
            auto begin = i*bs;
            auto end = begin+bs < data.length ? begin+bs : data.length;
            if(RSA_public_encrypt((end-begin).to!int, data[begin..end].ptr, crypt[begin..begin+bs].ptr, crt, RSA_NO_PADDING) == -1)
                throw new CryptoException("couldn't encrypt cipher");
        }

        return crypt;
    } else throw new CryptoException("couldn't load receivers certificate");
}