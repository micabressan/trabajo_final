module.exports.screenshot = async (browser, url) => {
    browser.on("console", async (msg) => {
        if (msg === "log") {
             let result = "我要这个";
        }
    });
    browser.goto(url);
    这里不要返回;
}