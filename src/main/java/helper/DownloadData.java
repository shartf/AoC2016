package helper;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

public class DownloadData {
    public void downloadFile (String filename, int year, int day) throws IOException, InterruptedException {
        // read the locally stored session cookie
        var fileReader = new FileReader();
        var sessionPath = "src/main/java/helper/Session";
        String sessionCookie;
        sessionCookie = fileReader.readFile(sessionPath);

        // request the data from AoC
        //URL url = new URL("https://adventofcode.com/" + year + "/" + day + "/input");

        HttpRequest httpRequest = HttpRequest.newBuilder()
                .GET()
                .uri(URI.create("https://adventofcode.com/" + year + "/day/" + day + "/input"))
                .setHeader("Cookie", "session=" + sessionCookie)
                .build();

        HttpResponse<String> response = httpClient.send(httpRequest, HttpResponse.BodyHandlers.ofString());
        System.out.println(response.body());

        // Write a file with provided name and url
        /*
        var fWriter = new FWriter();
        var dir = "src/main/resources/";
        fWriter.fWriter("test test\n test", dir, filename);
        */
    }


    private static final HttpClient httpClient = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_2)
            .connectTimeout(Duration.ofSeconds(5))
            .build();
}
