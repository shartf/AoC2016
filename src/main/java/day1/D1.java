package day1;

import helper.DownloadData;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
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

    enum Directions {
        N(0), E(1), S(2), W(3);

        public final int label;
        Directions(int label) {
            this.label = label;
        }

        public static Directions valueOfLabel(int label) {
            for (Directions d : values()) {
                if (d.label == label) {
                    return d;
                }
            }
            return null;
        }
    }

    enum Turns {
        L, R
    }

    public record Cartesian (int x, int y, Directions dir) {

    }

    /*Takes current Direction and Side to turn and returns a new Direction */
    public static Directions turnTo(Directions direction, Turns turn) {
        int currentDirection;
        if (turn.equals(Turns.R)) {
            currentDirection = direction.label + 1;
        } else {
            currentDirection = direction.label - 1;
        }
        return Directions.valueOfLabel((currentDirection + 4) % 4);
    }

    /* Returns the last direction and list of all intermediate coordinates for an path*/
    public static ArrayList<Cartesian> calculateDistance (String directionString,
                                                          Cartesian lastCoordinate) {
        // instantiate list of cartesians
        var cartList = new ArrayList<Cartesian>();

        Turns turn = null;
        turn = turn.valueOf(String.valueOf(directionString.charAt(0)));
        int distance;
        distance = Integer.parseInt(String.valueOf(directionString.charAt(1)));
        Directions newDirection = turnTo(lastCoordinate.dir, turn);

        switch (newDirection) {
            case N -> {
                for (int i = lastCoordinate.y; i <= distance ; i++) {
                    cartList.add(new Cartesian(lastCoordinate.x, i, newDirection));
                }
                break;
            }
            case E -> {
                for (int i = lastCoordinate.x; i <= distance; i++) {
                    cartList.add(new Cartesian(i, lastCoordinate.y, newDirection));
                }
                break;
            }
            case S -> {
                for (int i = lastCoordinate.y; i <= (lastCoordinate.y - distance)  ; i--) {
                    cartList.add(new Cartesian(lastCoordinate.x, i, newDirection));
                }
                break;
            }
            case W -> {
                for (int i = lastCoordinate.x; i <= (lastCoordinate.x - distance) ; i--) {
                    cartList.add(new Cartesian(i, lastCoordinate.y, newDirection));
                }
                break;
            }
        }
        return cartList;
    }


}
