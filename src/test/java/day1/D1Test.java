package day1;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;

import static org.junit.jupiter.api.Assertions.*;

class D1Test {

    @Test
    void turnToTest() {
        assertEquals(D1.Directions.E, D1.turnTo(D1.Directions.N, D1.Turns.R));
        assertEquals(D1.Directions.N, D1.turnTo(D1.Directions.W, D1.Turns.R));
        assertEquals(D1.Directions.W, D1.turnTo(D1.Directions.N, D1.Turns.L));
        assertEquals(D1.Directions.S, D1.turnTo(D1.Directions.E, D1.Turns.R));
    }

    @Test
    void calculateDistance() {

    }

    @BeforeEach
    void setUp() {
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void testCalculateDistance() {
        // test E
        ArrayList<D1.Cartesian> testCoordinatesE = new ArrayList<>();
        testCoordinatesE.add(new D1.Cartesian(1, 0, D1.Directions.E));
        testCoordinatesE.add(new D1.Cartesian(2, 0, D1.Directions.E));
        testCoordinatesE.add(new D1.Cartesian(3, 0, D1.Directions.E));
        testCoordinatesE.add(new D1.Cartesian(4, 0, D1.Directions.E));
        assertEquals(testCoordinatesE, D1.calculateDistance("R4", new D1.Cartesian(0, 0, D1.Directions.N)));
        // test S
        ArrayList<D1.Cartesian> testCoordinatesS = new ArrayList<>();
        testCoordinatesS.add(new D1.Cartesian(-3, -3, D1.Directions.S));
        testCoordinatesS.add(new D1.Cartesian(-3, -4, D1.Directions.S));
        testCoordinatesS.add(new D1.Cartesian(-3, -5, D1.Directions.S));
        assertEquals(testCoordinatesS, D1.calculateDistance("L3", new D1.Cartesian(-3, -2, D1.Directions.W)));
        // test W
        ArrayList<D1.Cartesian> testCoordinatesW = new ArrayList<>();
        testCoordinatesW.add(new D1.Cartesian(0, 1, D1.Directions.W));
        testCoordinatesW.add(new D1.Cartesian(-1, 1, D1.Directions.W));
        assertEquals(testCoordinatesW, D1.calculateDistance("L2", new D1.Cartesian(1, 1, D1.Directions.N)));
        // test N
        ArrayList<D1.Cartesian> testCoordinatesN = new ArrayList<>();
        testCoordinatesN.add(new D1.Cartesian(3, 3, D1.Directions.N));
        testCoordinatesN.add(new D1.Cartesian(3, 4, D1.Directions.N));
        assertEquals(testCoordinatesN, D1.calculateDistance("L2", new D1.Cartesian(3, 2, D1.Directions.E)));
    }
}