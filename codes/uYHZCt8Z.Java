public class 主要 {
    public static void 主要(String[] args) throws Exception {
        StringBuilder 變量 = new StringBuilder();
        InputStream 是 = System.in;
        int 標誌;
        while((標誌 = is.read()) != Character.LINE_SEPARATOR)
            變量.append((char) 標誌);
        System.out.println();
        System.out.println("閱讀線: " + 變量);
        System.out.println();
        System.out.println("迪克，下班後，我正在飛布魯克");
    }
}