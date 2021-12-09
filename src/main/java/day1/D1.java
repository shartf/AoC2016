package day1;

import helper.DownloadData;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static java.util.stream.Collectors.toList;

public class D1 {

    public static void main(String[] args) throws IOException, InterruptedException {
        // download input
        DownloadData downloadData = new DownloadData();
        downloadData.downloadFile("day1", 2016, 1);

        // split the input
        Path path = Path.of("/src/main/resources/", "day1.txt");
        if (Files.exists(path)) {
                List<String> lines = Files.readAllLines(path);

        }
    }


}
