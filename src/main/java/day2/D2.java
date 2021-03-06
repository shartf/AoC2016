package day2;

import helper.DownloadData;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

public class D2 {
    public static void main(String[] args) throws IOException, InterruptedException {
        // download file
        DownloadData downloadData = new DownloadData();
        downloadData.downloadFile("day2", 2016, 2);

        Path path = Path.of("src/main/resources", "day2.txt");
        List<String[]> parsedList = null;
        if (Files.exists(path)) {
            List<String> lines = Files.readAllLines(path);
            parsedList = lines.stream().map(s -> s.split("\n")).toList();
        }

        // Calculate pins
        for (String[] line: parsedList) {
            int pin = 5;
            for (int i = 0; i < line[0].length() - 1; i++) {
                if (i < line[0].length() - 2) {
                    pin = calculateNextPin(Directions.valueOf(String.valueOf(line[0].charAt(i))), pin);
                    System.out.println("Intermediate Step is: " + line[0].charAt(i) + " resulting in pin " + pin);
                } else {
                    pin = calculateNextPin(Directions.valueOf(String.valueOf(line[0].charAt(i))), pin);
                    System.out.println(pin);
                }
            }

        }
    }

    protected enum Directions {
        D, L, R, U,
    }

    protected static int calculateNextPin (Directions direction, int lastPin) {
        int newPin = 0;
        switch (direction) {
            case R -> {
                if (lastPin % 3 == 0) {
                    newPin = lastPin;
                } else {
                    newPin = lastPin + 1;
                }
            }
            case D -> {
                if (lastPin == 7 || lastPin == 8 || lastPin == 9) {
                    newPin = lastPin;
                } else {
                    newPin = lastPin + 3;
                }
            }
            case L -> {
                if (lastPin == 1 || lastPin == 4 || lastPin == 7) {
                    newPin = lastPin;
                } else {
                    newPin = lastPin -1;
                }
            }
            case U -> {
                if (lastPin >=1 && lastPin < 4) {
                    newPin = lastPin;
                } else {
                    newPin = lastPin - 3;
                }
            }
        }
        return newPin;
    }
}


