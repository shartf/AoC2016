package helper;

public class DownloadData {
    public static void main(String[] args) {
        var fileReader = new FileReader();
        var sessionPath = "src/main/java/helper/Session";
        String sessionCookie;
        sessionCookie = fileReader.readFile(sessionPath);

        var fWriter = new FWriter();
        var dir = "src/main/resources/";
        var filename = "test";
        fWriter.fWriter("test test\n test", dir, filename);


    }
}
