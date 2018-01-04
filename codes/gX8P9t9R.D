import std.datetime;
import std.exception;
import std.format;
import std.json;

enum {
    apiUrl = "http://codeforces.com/api/%s",
    callLimit = 5,
    callLimitInterval = 1010.msecs,
}

enum {
    minRelativeTime = Duration.zero,
    maxRelativeTime = (6 * 4).weeks,
}

class CfApiBaseException: Exception {
    mixin basicExceptionCtors;
}

class CfApiException: CfApiBaseException {
    mixin basicExceptionCtors;
}

JSONValue cfCall(Args...)(in char[ ] method, in auto ref Args args) {
    import core.thread;
    import requests;

    static SysTime[callLimit] queue;
    static int qpos = 0;

    auto now = Clock.currTime();
    const elapsed = now - queue[qpos];
    if (elapsed < callLimitInterval) {
        Thread.sleep(callLimitInterval - elapsed);
        now = Clock.currTime();
    }
    queue[qpos++] = now;
    qpos %= callLimit;

    const response = getContent(format!apiUrl(method), args).data!string.parseJSON();
    const status = response["status"];
    if (status != JSONValue("OK")) {
        if (status == JSONValue("FAILED"))
            throw new CfApiException(response["comment"].str);
        else
            throw new CfApiBaseException(format!"%s: %s"(status, response["comment"]));
    }
    return response["result"];
}

void main() {
    import std.algorithm.sorting;
    import std.array;
    import std.stdio;

    int[string] users;
    writeln("Getting contest list...");
    stdout.flush();
    foreach (contest; cfCall("contest.list").array) {
        const relativeTime = contest["relativeTimeSeconds"].integer.seconds;
        if (relativeTime < minRelativeTime)
            continue;
        if (relativeTime > maxRelativeTime)
            break;

        const id = contest["id"].integer;
        writefln!"%s (%s)..."(contest["name"], id);
        stdout.flush();
        try
            foreach (submission; cfCall("contest.status", "contestId", id).array)
                if (submission["programmingLanguage"].str == "D")
                    foreach (member; submission["author"]["members"].array)
                        users[member["handle"].str]++;
        catch (CfApiException e) {
            //`contest.list` may return contests unavailable for inspection. Yes, that's weird.
            if (e.msg != format!"contestId: Contest with id %s not found"(id))
                throw e;
            writeln("[Not found]");
        }
    }
    writefln!"{%(%(\"%s\": %s%),\n %)}"(
        users.byPair().array().multiSort!(`a[1] > b[1]`, `a[0] < b[0]`));
}