package helper;

public class DownloadData {
    public static void main(String[] args) {
        var fileReader = new FileReader();
        var sessionPath = "src/main/java/helper/Session";
        String sessionCookie;
        sessionCookie = fileReader.readFile(sessionPath);

    }
}
