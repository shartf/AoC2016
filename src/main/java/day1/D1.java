package day1;

import helper.DownloadData;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.Collectors;

public class D1 {

    public static void main(String[] args) throws IOException, InterruptedException {
        // download input
        DownloadData downloadData = new DownloadData();
        downloadData.downloadFile("day1", 2016, 1);

        // split the input
        Path path = Path.of("src/main/resources/", "day1.txt");
        if (Files.exists(path)) {
                List<String> lines = Files.readAllLines(path);
                List<String[]> parsed = lines.stream().map(s -> s.split(","))
                        .collect(Collectors.toList());
                System.out.println(parsed);

        }
    }


}
