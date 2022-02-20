package day1;

import helper.DownloadData;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class D1 {

    public static void main(String[] args) throws IOException, InterruptedException {
        // download input
        DownloadData downloadData = new DownloadData();
        downloadData.downloadFile("day1", 2016, 1);

        // split the input
        Path path = Path.of("src/main/resources/", "day1.txt");
        List<String[]> parsedList = null;
        if (Files.exists(path)) {
                List<String> lines = Files.readAllLines(path);
                parsedList = lines.stream().map(s -> s.replaceAll("\\s", ""))
                        .map(s -> s.split(","))
                        .toList();
        }
        assert parsedList != null;
        String[] parsed =  parsedList.get(0);
        // init arrayList
        ArrayList<Cartesian> cartesianPath = new ArrayList<>();
        cartesianPath.add(new Cartesian(0, 0, Directions.N));
        // iterate over way description
        assert parsed != null;
        for (String strings : parsed) {
            // get the next way description as string and the last Cartesian object as annealing point
            cartesianPath.addAll(calculateDistance(strings, cartesianPath.get(cartesianPath.size() - 1)));
        }
        // end point
        System.out.println(cartesianPath.get(cartesianPath.size()-1).toString());

        for (int i = 1; i < cartesianPath.size() - 1; i++) {
            Cartesian newCoord = cartesianPath.get(i);
            // run through entries before the dumb way and search for same coordinates
            for (int j = i - 1; j > 0; j--) {
                Cartesian prevCoord = cartesianPath.get(j);
                if (newCoord.x == prevCoord.x && newCoord.y == prevCoord.y) {
                    System.out.println("Found ya! " + newCoord.toString());
                    System.out.println("Number of blocks of path intersection is " + (
                            Math.abs(newCoord.x) + Math.abs(newCoord.y)));
                    break;
                }
            }
        }



    }

    protected enum Directions {
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

    protected enum Turns {
        L, R
    }

    protected record Cartesian (int x, int y, Directions dir) {

    }

    /*Takes current Direction and Side to turn and returns a new Direction */
    protected static Directions turnTo(Directions direction, Turns turn) {
        int currentDirection;
        if (turn.equals(Turns.R)) {
            currentDirection = direction.label + 1;
        } else {
            currentDirection = direction.label - 1;
        }
        return Directions.valueOfLabel((currentDirection + 4) % 4);
    }

    /* Returns the last direction and list of all intermediate coordinates for an path*/
    protected static ArrayList<Cartesian> calculateDistance (String directionString,
                                                          Cartesian lastCoordinate) {
        // instantiate list of cartesians
        var cartList = new ArrayList<Cartesian>();

        Turns turn;
        turn = Turns.valueOf(String.valueOf(directionString.charAt(0)));
        int distance;
        distance = Integer.parseInt(directionString.substring(1));
        Directions newDirection = turnTo(lastCoordinate.dir, turn);

        switch (newDirection) {
            case N -> {
                for (int i = lastCoordinate.y + 1; i <= lastCoordinate.y + distance ; i++) {
                    cartList.add(new Cartesian(lastCoordinate.x, i, newDirection));
                }
            }
            case E -> {
                for (int i = lastCoordinate.x + 1; i <= lastCoordinate.x + distance; i++) {
                    cartList.add(new Cartesian(i, lastCoordinate.y, newDirection));
                }
            }
            case S -> {
                for (int i = lastCoordinate.y - 1; i >= (lastCoordinate.y - distance)  ; i--) {
                    cartList.add(new Cartesian(lastCoordinate.x, i, newDirection));
                }
            }
            case W -> {
                for (int i = lastCoordinate.x - 1; i >= (lastCoordinate.x - distance) ; i--) {
                    cartList.add(new Cartesian(i, lastCoordinate.y, newDirection));
                }
            }
        }
        return cartList;
    }


}
