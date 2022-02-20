package day2;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class D2Test {

    @Test
    void calculateNextPin() {
    assertEquals(6, D2.calculateNextPin(D2.Directions.R, 6));
    assertEquals(8, D2.calculateNextPin(D2.Directions.R, 7));
    assertEquals(5, D2.calculateNextPin(D2.Directions.D, 2));
    assertEquals(7, D2.calculateNextPin(D2.Directions.D, 7));
    assertEquals(2, D2.calculateNextPin(D2.Directions.L, 3));
    assertEquals(1, D2.calculateNextPin(D2.Directions.L, 1));
    assertEquals(3, D2.calculateNextPin(D2.Directions.U, 6));
    assertEquals(2, D2.calculateNextPin(D2.Directions.U, 2));
    assertEquals(2, D2.calculateNextPin(D2.Directions.U, 5));
    assertEquals(6, D2.calculateNextPin(D2.Directions.R, 5));
    assertEquals(4, D2.calculateNextPin(D2.Directions.L, 5));
    assertEquals(8, D2.calculateNextPin(D2.Directions.D, 5));
    }
}