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

    private enum Directions {
        N, E, S, W;
    }

    private enum Turns {
        L, R;
    }

    private Directions turnTo (Directions direction, Turns turn) {
        int currentDirection, newDirection;
        switch (direction) {
            case N -> currentDirection = 0;
            case E -> currentDirection = 1;
            case S -> currentDirection = 2;
            case W -> currentDirection = 3;
            default -> throw new IllegalStateException("Unexpected value: " + direction);
        }
        if (turn.equals(Turns.R)) {
            currentDirection += 1;
        } else {
            currentDirection -= 1;
        }
        newDirection = currentDirection % 4;
        switch (newDirection) {
            case 0 -> {
                return Directions.N;
            }
            case 1 -> {
                return Directions.E;
            }
            case 2 -> {
                return Directions.S;
            }
            case 3 -> {
                return Directions.W;
            }
        }
    }


}
